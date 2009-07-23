From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 05:18:44 +0200
Message-ID: <20090723031843.GA9152@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MToqs-0004KN-S5
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZGWDUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZGWDUF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:20:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:61928 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbZGWDUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 23:20:04 -0400
Received: by fg-out-1718.google.com with SMTP id e21so178108fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0VyQboU26DmUZdXuv4xURGaQyjodxbYObX2DGsAiFDA=;
        b=x4dsZjM8SccOmE9yTdz/bOJ7Yxtch76MD+kOICQzUfL+IM7+AHCNpfZSQD4ZJR8XRr
         ylnAiWF4VTzFLVXSzgzzOVMV1IpQdMdnWJVXFyLxjWaUElSd5ad2sS5ztBacQu8vCsrf
         Wa9E9lE90ZJCnrY7IzhDZ2pyLmmms22jbfDFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VqRPJbHKFc1nYghH0jP4DmWGxMZdsifMdOfBJrxilsmQ/nud/K20uPZuSzOyt8D2TO
         +6BKEi/xvYyawm+TOLuwZ1/r675y8WGuAsN8WHGx/l9u/Y8AGmOzvPAd3kxzFG4w1yVI
         tii506l7dyZqbMRZIOnFZj5IqdiFC1pnhZZwc=
Received: by 10.86.61.2 with SMTP id j2mr1369939fga.61.1248319202065;
        Wed, 22 Jul 2009 20:20:02 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.18])
        by mx.google.com with ESMTPS id 4sm2639906fgg.22.2009.07.22.20.19.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 20:20:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123827>

First of all:
      * yes, my VAIO has a slow 4200 rpm disc :-(
      * strace -T indeed showed that lstat() was not guilty
      * GIT_DEBUG_LOOKUP=1 git branch produced ugly 2200+ lines

Now to the patch,

On Wed 22.Jul'09 at 19:23:39 -0700, Linus Torvalds wrote:
> > Ooh yes. That would do it. It's going to peel and look up every single ref 
> > it finds, so it's going to look up _hundreds_ of objects (all the tags, 
> > all the commits they point to, etc etc). Even if it then only shows a 
> > couple of branches.
> > 
> > Junio, any ideas?
> 
> I had one of my own.
> 
> Does this fix it?

Yes!

[mafra@Pilar:linux-2.6]$ time git branch
  27-stable
  28-stable
  29-stable
  30-stable
  dev-private
* master
  option
  sparse
  stern
0.00user 0.01system 0:01.50elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (42major+757minor)pagefaults 0swaps

01.50 is not that good, but it doesn't "feel" terrible as 4 seconds.
[ It is incredible how 4 secs feels really bad while 2 is acceptable... ]

So thank you very much, Linus! A 50% improvement here!

And I am happy to have finally reported it, after quietly suffering for so long 
thinking that "git is as fast as possible, so it is probably my fault".

PS: Out of curiosity, how many femtoseconds does it take in your 
state-of-the-art machine? :-)
