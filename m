From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 05:42:03 -0700 (PDT)
Message-ID: <m3prbr371l.fsf@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
	<alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
	<alpine.LFD.2.01.0907221742010.3352@localhost.localdomain>
	<alpine.LFD.2.01.0907221753290.3352@localhost.localdomain>
	<20090723020238.GA8948@Pilar.aei.mpg.de>
	<alpine.LFD.2.01.0907221925100.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 14:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTxcu-0005lc-UW
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 14:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbZGWMmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 08:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbZGWMmH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 08:42:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:9638 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbZGWMmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 08:42:05 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1093711fga.17
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7KL6k83MBn5D/2Z0fLC+VBHMIA35gSrdOjGESSb22MY=;
        b=LCx2jbCZaGZ45fASXteoHywi58LC5AKlalNe/dbXYWsZeQqBasOnFwpCMg3SK7fIWI
         in0cgNegheWxrGfmCm6Bdx34ffUji9xSGYhBYpO1RXSFZ2sBiObleLooUVRd/AxoD4RT
         Cr0c1HnM5oS0CjMHSt/Vs4LBXfHlpEIsFd7E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NNZepZ0I3f9DfycqFOGepfVrjtic+TFKgBbu3sbTYlFcR1QZngiemR1C2qkt6hRaov
         gPw+zgMuudqlY3nz9HxptYOzPKSqeoD+pti3eQXrP81g2n5quzTxVeaHCBycLFG1yp6A
         pJ+FjLIOnaBX5515L7oD7mqRNmWu1J+/jUYK8=
Received: by 10.86.27.7 with SMTP id a7mr1806468fga.67.1248352924940;
        Thu, 23 Jul 2009 05:42:04 -0700 (PDT)
Received: from localhost.localdomain (abvp189.neoplus.adsl.tpnet.pl [83.8.213.189])
        by mx.google.com with ESMTPS id 3sm4249471fge.18.2009.07.23.05.42.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Jul 2009 05:42:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6NCg1n5012467;
	Thu, 23 Jul 2009 14:42:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6NCfwQX012463;
	Thu, 23 Jul 2009 14:41:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.01.0907221925100.3352@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123869>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> > 
> > Is there another way to check what is going on with that anomalous lstat()?
> 
> I really don't think it's the lstat any more. Your directories look small 
> and simple, and clearly the indexing made no difference.
> 
> See earlier email about using "strace -T" instead of "-tt". Also, I sent 
> you a patch to try out just a minute ago, I think that may be it.
> 
> > [ perhaps I will try 'perf' after I read how to use it ]
> 
> I really like 'perf' (it does what oprofile did for me, but without the 
> headaches), but it doesn't help with IO profiling.
> 
> I've actually often wanted to have a 'strace' that shows page faults as 
> special system calls, but it's sadly nontrivial ;(

BTW. Would SystemTap help there?  Among contributed scripts there is
iotimes, so perhaps it would be possible to have iotrace...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
