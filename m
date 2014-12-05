From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Fri, 5 Dec 2014 08:33:55 +0700
Message-ID: <CACsJy8BWv8U6+sujEj8HgMGmgFJR_YgCroYHcG1jsoGtbVCD7Q@mail.gmail.com>
References: <1417390076-2953-1-git-send-email-max@max630.net>
 <547E24E4.7050100@web.de> <20141202221611.GB9128@wheezy.local> <5480BEB9.8070109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 05 02:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwhmw-0004mk-M3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 02:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbaLEBe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 20:34:27 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:51598 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbaLEBe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 20:34:26 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so32392igb.11
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 17:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DfII6eeMSVPUhD2IJpyBzMKY2Sb2mfBuW7rhL4B/xjw=;
        b=Ul3dq46LgZ3pmhxelhQP8x5S8Cc8eLGOcx5y7VYDC+emGp10OTjQOOfBZOMji8Hray
         i44PcvTzWpIBwhE414AYQwbmzwwt+w/R/apfBygDDcXakrgay49AELVc6IxsWO9jBm1V
         9gFZeDQYG4rdCcwL3WAK/iycTfi+wnoJoBMI8KEcL1VycK0rDGMFQQway5XSEig4mZSr
         cZeGfO7gEBL65JA+/hIsHoV+CiDZQ+WLAtOlHzCs5jGl9Fz3HxrboFlImy+wTRtIleaK
         K1HXC8uUY0aRcVA60hXNvbVLBIndSxbuyCydEuQBa4yqQmvAQm1zmfFY2hzBNFobH0JS
         Gsjw==
X-Received: by 10.50.3.106 with SMTP id b10mr231722igb.41.1417743265959; Thu,
 04 Dec 2014 17:34:25 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Thu, 4 Dec 2014 17:33:55 -0800 (PST)
In-Reply-To: <5480BEB9.8070109@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260851>

On Fri, Dec 5, 2014 at 3:06 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Wow, so the .git/config is shared between all worktrees? I
> suspect you have very good reasons for that,

most of config vars are at repo-level, not worktree-level, except
maybe submodule.* and something else. Technically we could use
"include.path" to point to a non-shared file, where we store
worktree-specific config.

> but I believe
> that'll make multiple work trees surprise the user from time
> to time when used with submodules. Because initializing a
> submodule in one worktree initializes it in all other
> worktrees too (I suspect other users regard "git submodule
> init" being a worktree local command too). And setting
> "submodule.<name>.update" to "none" will also affect all
> other worktrees. But I'd need to have separate settings for
> our CI server, e.g. to checkout the sources without the
> largish documentation submodule in one test job (=worktree)
> while checking out the whole documentation for another job
> building the setup in another worktree.
>
> And if I understand the "checkout: reject if the branch is
> already checked out elsewhere" thread correctly, I won't be
> able to build "master" in two jobs at the same time?

If you do "git checkout --to ... master^{}", it should run fine. I'm
still considering doing something better with the read-only refs, but
haven't found time to really think it through yet.

> Thanks. But I changed my mind about the details (now that I
> know about .git/config and multiple worktrees). I think you'd
> have to connect a .git directory in the submodule to the
> common git dir directly, as you cannot use the core.worktree
> setting (which could be different between commits due to
> renames) when putting it into <worktree>/.git/modules. And
> then you couldn't remove or rename a submodule anymore,
> because that fails when it contains a .git directory.
>
> Seems like we should put a "Warning: may do unexpected things
> when used with submodules" (with some examples about what might
> happen) in the multiple worktrees documentation. And I don't
> believe anymore that teaching submodules to use the common git
> dir makes that much sense after I know about the restrictions
> it imposes.

I'm ok with such a warning fwiw.
-- 
Duy
