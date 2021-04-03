Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA7DC433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CA26121D
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhDCKmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 06:42:32 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:9518 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235604AbhDCKmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 06:42:32 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp1-g21.free.fr (Postfix) with ESMTP id DAF4CB00535
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 12:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1617446548;
        bh=IampWIG1ku8z6KbI+qz2AaO5RrgsuqgVKjYn5Dp6rIU=;
        h=Date:From:To:In-Reply-To:Subject:From;
        b=F2/KI0KhKtC5ojIG/XzC8cc+W6APsu9sS66XPuv1H7mq70fJVyeaX9YVoW+vqxKX4
         sipP0MD6Ph/U82eXC3c4ofQ/t6Yix80uW3ej/vga44mYEXCkTh+1AqctiLXdxTpox4
         xpS1lh5Li9ygYEVMx30yLAU0j3uOjsCKnr3sitLtIZQAN8rWifjxBMUMJgdowclcKr
         UJvQHscFBmb3mWvT0tgvy2xIdNWKl2mR38W+wfcWmjgL/hBv+yJmOx2sR8Nhr0bLL/
         vuR5hGQAPyH0TtfRGM7/JqqKXAUfQMYePjiffv1IkUx5gqlimfiPpx0xTxQ0da3GSZ
         cROFhU3k2YnxQ==
Date:   Sat, 3 Apr 2021 12:42:28 +0200 (CEST)
From:   ydirson@free.fr
To:     git <git@vger.kernel.org>
Message-ID: <1054682599.520899173.1617446548600.JavaMail.root@zimbra39-e7>
In-Reply-To: <1874143044.520636715.1617442122946.JavaMail.root@zimbra39-e7>
Subject: git rebase --rebase-merges information loss (and other woes)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been going through a couple of "rebase -i -r" lately, and would
like to share a couple of thoughts, starting with something looking
like a bug.

1. when a merge has been done with "-s ours", rebase replays it without
any special options, I proceed with the manual resolution, and if I just
--continue, the rebase mechanism believes I want to drop the commit, which
could not be more wrong.  I can still be careful myself, and use "git commit
--allow-empty" before --continue, but this feels awkward.

Is there any compelling reason not record the merge here ?


2. more generally, when a merge has been done with special options, it
would be a useful help in solving conflicts if rebase could use the same
options.  Maybe we could allow the rebase "merge" instruction to use more
merge options.  The user would still have to edit the instruction sheet
manually for those, however, and we could then want "rebase -i" to fill
them automatically, but that would seem to require recording the merge
options somewhere to start with - maybe in a note.


3. while it's made clear that any conflict resolution and amendments
have to be redone, maybe we could provide some support for a common
use case, namely "sink that commit/fixup down".  The conflict
resolution would then be like "checkout $OLD && cherry-pick -n $FIXUP".

Maybe this could be activated by a merge option in rebase-interactive
instructions, like "merge -C$OLD --fixup $F1 --fixup $F2".

Would that seem reasonable ?

-- 
Yann
