Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F6C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 12:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjFAMQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjFAMQS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 08:16:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34ADE73
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 05:15:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4EAFC1F390;
        Thu,  1 Jun 2023 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685621740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbO/dSb1x9tFR53SHNtAGQX6GnS1dDERXp1VAoLaJxI=;
        b=eI6l4kKMrmU7cZSxY84kv/icb/BBroFIIjCobMmVLORwSbL8sEHAjsWC9aWgwtahhGOg5M
        iDtNy1uvLocu+psQ9PsvKFssAH1FvqRv6fN4SRL6s78gBohi0/4+cfkAQNdOgtIjkwugQd
        75TS4pTwZGdkHJjTuN/xpfy/PFBHycw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685621740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbO/dSb1x9tFR53SHNtAGQX6GnS1dDERXp1VAoLaJxI=;
        b=lCyXvm6V9UUd23z04SR3qEGwIzoS2eycCCS1EHj14RoJVFCj0ta7FVwl06if4G18obuUix
        Gl595pjtb4bNqdBg==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 410ED2C141;
        Thu,  1 Jun 2023 12:15:40 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id D92904A0785; Thu,  1 Jun 2023 14:15:39 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
In-Reply-To: <Y/hxW9i9GyKblNV4@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Feb 2023 03:12:11 -0500")
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
        <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
X-Yow:  .. If I cover this entire WALL with MAZOLA, who I have to give my
 AGENT ten per cent??
Date:   Thu, 01 Jun 2023 14:15:39 +0200
Message-ID: <mvmzg5j8jkk.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 24 2023, Jeff King wrote:

> If we encounter an error in an index file, we may say something like:
>
>   error: 1234abcd: invalid sha1 pointer in resolve-undo
>
> But if you have multiple worktrees, each with its own index, it can be
> very helpful to know which file had the problem. So let's pass that path
> down through the various index-fsck functions and use it where
> appropriate. After this patch you should get something like:
>
>   error: 1234abcd: invalid sha1 pointer in resolve-undo of .git/worktrees/wt/index

That is still suboptimal, because there is no obvious mapping from the
internal worktree name to the directory where it lives (git worktree
list doesn't mention the internal name).  If you have several worktrees
with the same base name in different places, the name under
.git/worktrees is just made unique by appending a number.  Normally you
would want to change to the affected worktree directory to repair it.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
