From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 1 Jun 2007 11:17:01 +0200
Message-ID: <8c5c35580706010217q3eb9384fx2f6d5edd6e92a6e@mail.gmail.com>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <200706011008.38063.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu3Fv-0000Ro-EV
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbXFAJRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 05:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbXFAJRI
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:17:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:61731 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbXFAJRF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:17:05 -0400
Received: by nz-out-0506.google.com with SMTP id n1so455744nzf
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 02:17:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=heeSzO3RbEjzJL1HzUsuEOeQJKNl2N0IPUKSqpyESG1sO09CelcqgMTNSdGkg9XQbyEjqggBtgQOte0gs7AwtM9RH83SvuhFhm9p1ZoWDHMEFpswgC7VIFhiqGDrgsz+AN7BMZKWVp+k+edu7xANV2AX6eiYHZDBUF4vXUkUjAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YgMBUHx2nF2vCKSfW7yl/YkdyZRQtzK4w71LEGi5tyQ1XNsReBVVe2LK6Ojc2MSdzngcks3c0gmoe4n0XFAUhbY5TjbNcahrnISdvCF8cN1l6ocBiI3Vj2sshvYljkuTrVKQNJbUb50P2l5XbGwfM5D4oFiCFwH9kdg0BkSqepo=
Received: by 10.114.136.1 with SMTP id j1mr1538532wad.1180689421046;
        Fri, 01 Jun 2007 02:17:01 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 1 Jun 2007 02:17:01 -0700 (PDT)
In-Reply-To: <200706011008.38063.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48857>

On 6/1/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > On 5/28/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > 3) 'git-submodule push' runs something like 'cd $path && git push
> > origin $branch', where $branch is found in .gitmodules
> > (path.$path.branch).
>
> So if you need superproject related corrections in the submodule,
> you always have to do it on branch "path.$path.branch" in the
> submodule to get it saved?
>
> I would assume that pushing the current branch should be enough.
> If you want to play with multiple different "corrections" on
> different branches in the submodule, you do not want to force
> the branch name to a unique one given in .gitmodules.
>

The current (and planned) implementation of git-submodule detaches
HEAD in the submodules, so there will not be a current branch unless
the user has done 'cd $path && git-checkout somebranch'.

We might take advantage of that fact:
  * try to exec 'git-symbolic-ref HEAD'
  * if it fails, push to path.$path.branch
  * otherwise, push to the ref pointed to by HEAD

But this will still loose any changes on _other_ branches (that has
not been pushed to origin manually). I'm not sure if/how we can avoid
this, except by making $path be a symlink to .git/submodules/$name.git
(which has other issues...)

--
larsh
