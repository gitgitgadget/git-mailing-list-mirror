From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] branch: do not attempt to track HEAD implicitly
Date: Wed, 15 Dec 2010 19:30:04 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012151909410.25560@debian>
References: <6ee1f0174b757e25ab873d2d037545ac7db698ee.1292351886.git.trast@student.ethz.ch> <AANLkTi=PPx-pLEeR4gLw0KzV_=ZnuqqH_CGc6L7RzU7M@mail.gmail.com> <201012151626.35366.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 16 01:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT1j0-0002Og-S9
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 01:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab0LPA3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 19:29:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64704 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab0LPA3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 19:29:33 -0500
Received: by vws16 with SMTP id 16so1176120vws.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=ZFsptT8Y0O4Gl/jyYkQ+9bLkwrjwCuGiCI9DO91bPH4=;
        b=VR0pUUoyyRDPjxf+8r3NZm1PKBiigmHJTit29rGRMf8o4PWUDnE+LfCtzcX0pSvBsq
         YJ+kz6DZa5jELgtKJJ15ZX92SCSp97k6lHDhULEKADoDmf7jJ24BDxWq9a3r/2jrK7b3
         Grs1tlSq44C4LNwejLYOo7htDb+q2YU3jOEqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Rs+NjNanXE8GceCBA0NVqJ0BlfgcKn98qG0illtiArL8MAv6AFNAYzm0mrc9Uqe5BJ
         4U5tQwWChgd92poNJtfAnMWexyf09iETnzdtJ21yfIbNaY4F/m6fEqH5SL0DFANOa3+n
         bMt3kRX0QU7csufKzoxDdISyoFu7bFisYtyuk=
Received: by 10.220.201.140 with SMTP id fa12mr2228881vcb.20.1292459372460;
        Wed, 15 Dec 2010 16:29:32 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id k39sm519763vcr.2.2010.12.15.16.29.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 16:29:31 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201012151626.35366.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163797>

On Wed, 15 Dec 2010, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > On Tue, Dec 14, 2010 at 1:38 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> > > Silently drop the HEAD candidate in the implicit (i.e. without -t
> > > flag) case, so that the branch starts out without an upstream.
> > 
> > Thanks. This has been on my todo list for a while.
> > 
> > Should it only check for HEAD? How about ORIG_HEAD and FETCH_HEAD?
> > Simply anything outside of refs/ maybe? Would that make sense?
> 
> Good point.  It seems HEAD wins the dwim_ref() over the rest:
> 
> $ g rev-parse HEAD ORIG_HEAD FETCH_HEAD
> 79f9a226d33659f0e6a69429931d66b5f70c9708
> 79f9a226d33659f0e6a69429931d66b5f70c9708
> 79f9a226d33659f0e6a69429931d66b5f70c9708

Probably a stupid question, but why are all three of them pointing to
the same commit? I guess that is what you want to show, but how did
you get there? If I run the same command (I assume your 'g' alias
simply calls git), I get three different commits (in general, of
course).

> $ g branch test
> $ g config -l | grep branch.test.
> 
> Not sure through which mechanism, however.

The scenario I meant is the following:

$ git config branch.autosetupmerge always
$ git branch test ORIG_HEAD
Branch test set up to track local ref ORIG_HEAD.
$ git config -l | grep branch.test
branch.test.remote=.
branch.test.merge=ORIG_HEAD


/Martin
