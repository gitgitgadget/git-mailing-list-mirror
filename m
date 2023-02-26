Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DDC64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBZVuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 16:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZVuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 16:50:04 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64467AA1
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 13:50:01 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4PPy3B0yTzz5tl9;
        Sun, 26 Feb 2023 22:49:57 +0100 (CET)
Message-ID: <ed3b6f63-5693-62e4-72a9-715e6c90a681@kdbg.org>
Date:   Sun, 26 Feb 2023 22:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] fsck index files from all worktrees
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
 <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.23 um 09:05 schrieb Jeff King:
> On Sat, Feb 18, 2023 at 10:38:33AM +0100, Johannes Sixt wrote:
> 
>> I see three problems here:
>>
>> - git fsck should detect the problem (if it really is one) in the
>> worktree index. It seems that it is just an index extension that is
>> affected. Perhaps it should be just a warning, not an error.
> 
> We do fsck the resolve-undo extension, but I think fsck just doesn't
> know anything about worktrees. That should be easy enough to fix.
> Patches below.
> 
>> - If the objects mentioned in the index extension are precious, they
>> should not have been garbage-collected in earlier rounds of git gc
>> (which I certainly did at some point).
> 
> Correct, but the gc error you're getting indicates that we _are_ trying
> to treat them as included. I wonder if you ran git-gc long ago with an
> older version of Git, and this breakage was waiting to surface. AFAICT
> this was all fixed by 8a044c7f1d (Merge branch 'nd/prune-in-worktree',
> 2017-09-19).

I don't know how I got into the situation. The worktree is a lot younger
than that and was made with a Git version young enough to include this
commit. I'll see if it happens again.

>> - I can't git gc the repository now, which is particularly annoying when
>> auto-gc is attempted after almost every git command. Of course, I know
>> how to get out of the situation, but it took some time to identify the
>> worktree index as the culprit. Not something that a beginner would be
>> able to do easily.
> 
> I think in general that "oops, there's something corrupt" can be hard to
> get out of, just because there are so many possibilities. But if we can
> at least report the nature of the problem and the offending filename via
> git-fsck, that would help with pointing people in the right direction.

Agreed. Thanks a lot for the patches, they are certainly helpful.

-- Hannes

