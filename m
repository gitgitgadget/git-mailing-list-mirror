From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 07:17:18 +0200
Message-ID: <20090723051717.GA20063@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <20090723031843.GA9152@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907222041341.21520@localhost.localdomain> <alpine.LFD.2.01.0907222050500.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqhe-0006VX-Ru
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZGWFSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbZGWFSi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:18:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47354 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZGWFSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:18:37 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1032638fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ivf2bNjkxR28i1xYrELVRusG4wn9KM6bVoERR3cAii4=;
        b=EJ1bPueRo32IFamCBxj2M6N42AqIo+vRVAMIFQHRU6XP8nzpnO7KygugjPzQVJOK1I
         MQRH32+lFe6JZU8R8DFqxuAZpeoROR3VHYuNTze5mWzGB8d9YnkQA9EvHsymlb26Z3kh
         BeEDI6CAbp4N5Ay/cAiIci+jCmwOp2fiXV5eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=afOO5qBZh2azRpMbX7ksIpqBl0nNQqcsq6oh+lE9s4C+uSXK+GZhicJdLhzVADWhBA
         z0yeVHht5AyTjKcO/AuotR37pakqmSzfSsrNv74b5skInMCLah3DVH/UQjVQd5WikNOJ
         S+2GJSOwmXA4J+xTJPEiabxuNfcW6V3Wp4qzg=
Received: by 10.86.53.11 with SMTP id b11mr1494875fga.12.1248326316732;
        Wed, 22 Jul 2009 22:18:36 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.18])
        by mx.google.com with ESMTPS id l19sm2912102fgb.1.2009.07.22.22.18.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 22:18:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907222050500.21520@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123841>

On Wed 22.Jul'09 at 21:10:49 -0700, Linus Torvalds wrote:
> Enabled with 'GIT_USE_LOOKUP'. But it seems to give worse performance, 
> despite giving me fewer searches: I get 2121 probes with binary searching, 
> but only 1325 with the newton-raphson method (for the non-fixed 'git 
> branch' case).
> 
> Using GIT_USE_LOOKUP actually results in fewer pagefaults (1391 vs 1473), 
> but it's still slower. Interesting. Carlos, try it on your machine (just 
> do
> 
> 	export GIT_USE_LOOKUP=1
> 	time git branch
> 
> to try it, and 'unset GIT_USE_LOOKUP' to disable it.


GIT_USE_LOOKUP=1 makes is a bit slower overall. 

Without your patch, I get fewer pagefaults (1254 vs 1404) when
it is set, but it takes ~0.5s longer (it varies a bit).

> With my fix to 'git branch', it doesn't matter. I get the same 
> performance, and same number of page faults (676) regardless. So my patch 
> makes the GIT_USE_LOOKUP=1 thing irrelevant.

With your patch and GIT_USE_LOOKUP=1 I get 751 pagefaults, versus 775
if GIT_USE_LOOKUP is unset, but it is faster when unset.

So your patch without GIT_USE_LOOKUP=1 is the fastest option.
