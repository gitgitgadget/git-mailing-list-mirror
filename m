From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proper way to checkout a tag?
Date: Wed, 1 Dec 2010 13:51:25 -0600
Message-ID: <20101201195125.GC27347@burratino>
References: <AANLkTi=b12n0J+Qg4S7i9dnbMHoWvPS3OXP0CDZevT_4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:51:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsiL-0005FM-DN
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab0LATvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:51:35 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:58272 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab0LATve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:51:34 -0500
Received: by wwb39 with SMTP id 39so151153wwb.1
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FE/P+2/CD0LqiObATFb7Go6djMCrCwD7SDc9kZpNGSg=;
        b=J4yBGexkGli0YuGt9iJIUeyq8awjfFAuxd9YjZflzpH9s1UvbDZpOZec4qxUe3zw65
         pSzVZGSOG9c0xBAetQkogsAID/zjCv5TTEW0mmXz0HmohkhCMcNVO6t3O76UI9uGFD+Z
         Rqin97UrJ1z0xdFERf1RPThfne97YIgI2hQTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FArHS77saa9Lkk6arI6ozr0WyUN0VNz7LD5mrMaASHP2hudqUElv5VD/ohBC0O1lbF
         y7dQnChMJuIFFtfgwOG6lUSRzS2/x+rkDnISyDRAmjBSA8jKWVyPBMzmnxYq/b9aXrc8
         /an3oD2UunscOoiDuGLFiSm3EwmqVjyCvjBpM=
Received: by 10.227.137.197 with SMTP id x5mr10020148wbt.198.1291233093157;
        Wed, 01 Dec 2010 11:51:33 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id 11sm246019wbj.1.2010.12.01.11.51.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 11:51:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=b12n0J+Qg4S7i9dnbMHoWvPS3OXP0CDZevT_4@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162589>

Hi,

Dun Peal wrote:

> The problem is that since there's no head pointing to each release, if
> our users just:
> 
> $ git checkout release-1
> 
> When they want to build that release, they get into a detached HEAD
> state. I've always construed detached HEAD as a non-standard state,
> and it doesn't seem proper to reach it regularly in the course of a
> standard operation like checking out past releases.
> 
> It's particularly confusing for our users who are new to Git.

Any ideas for making the detached state more friendly?

The idea is this: when you check out a tag or a remote-tracking
branch, it is not to make changes to it.  Tags are unchanging,
remote-tracking branches track remote state that the user does not
directly control.  So what does it mean to check out such a thing?

There are two possibilities:

If you are checking out that commit to examine it, test it, maybe
write a few one-off patches, then any work built from there does not
need to be remembered (except in the HEAD reflog, to avoid expensive
accidents).  You can make an experiment permanent with

	git checkout -b newbranch

If you are starting a new line of development, it needs to get a name.
Long ago this was the only use case supported.  Even today it is often
a good way to go:

	git checkout -b newbranch release-1

Hope that helps.
Jonathan
