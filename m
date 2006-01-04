From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Strange unable to unlink error with git-prune-packed
Date: Thu, 5 Jan 2006 11:10:20 +1300
Message-ID: <46a038f90601041410m7628adfdr3ec81015d80d0f8e@mail.gmail.com>
References: <46a038f90601032046l31f51742k93f3f9f5a826bef1@mail.gmail.com>
	 <Pine.LNX.4.64.0601040828590.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 04 23:10:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuGpu-0000LT-7S
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 23:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWADWKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWADWKW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 17:10:22 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:40492 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964788AbWADWKU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 17:10:20 -0500
Received: by wproxy.gmail.com with SMTP id 57so2453126wri
        for <git@vger.kernel.org>; Wed, 04 Jan 2006 14:10:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mdIcQJtuO5JxHHeiVsWU7K+fjs2PzH2/bhiGjViopnlqtQBLpNxyqu8Qyu2ymsLfsM0vFcorGYEx1PJz0XUUzUWPrT6RSsEHQMimYj6OJ9FqS4WT+jFIYEoZNzVuHtlmVIke0OaHgpCTeYSIj9I0uoJLDFDOCiKCqoPrXTAfyeo=
Received: by 10.54.126.20 with SMTP id y20mr3061310wrc;
        Wed, 04 Jan 2006 14:10:20 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 4 Jan 2006 14:10:20 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601040828590.3668@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14181>

On 1/5/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Does it happen for all your files? All your repositories? Or just one
> repo?

Good questions -- should have sorted those basic things out before
posting. Apologies. In any case, I haven't seen that before, but I
don't run git-prune-packed that often on the OSX commandline. My main
dev host is a linux machine, and I have a weekly cron that does repack
and prune packed on all my repos.

> Or just one subdirectory in that repo?

It refused to unlink _any_ files within .git/objects

> The code is _literally_ just doing a
>
>         if (unlink(pathname) < 0)
>                 error("unable to unlink %s", pathname);
>
> but maybe you could just make it print out the reason too. So add a "(%s)"
> and a "strerror(errno)" to that error line..

This morning, after a reboot, I patched prune-packed.c as suggested
and ran it... and it all worked.

Initially I suspected the files were locked somehow, but I just did a
new clone && git-repack && git-prune-packed and it just worked...
Grrr.

> I don't see why you couldn't unlink those files. Maybe it's some strange
> HFS issue and you can't just unlink() things that have attributes or
> something? Maybe some crazy file manager has added a default icon
> attribute to your files if you happened to look at the .git objects
> directory?

It is indeed HFS but I'm pretty sure things should be transparent to
the unix side of things. In any case, the (crazy filemanager) Finder
wasn't involved, as this is a newish repo, I haven't looked at any
directory around it with Finder, and it's known to leave hidden files
all over the place.

In any case, I've got my git-prune-packed patched now, and will be
trying to repro the bug.

cheers,


martin
