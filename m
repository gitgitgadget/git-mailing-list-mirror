Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD6BC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D463214
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhKQSwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhKQSwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 13:52:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11767C061570;
        Wed, 17 Nov 2021 10:49:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so13177404lfv.10;
        Wed, 17 Nov 2021 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5GJT4Hs/HI/FowLComfkTjFmzZeGxKNZxNsulf8xgM=;
        b=jM76WaN0NLgJU5Oxm6XPMObZVCaqjwsRXyMp1tD3EHh59J1SkJDNgu3KRbYHeFt7Np
         A8Mi1BMKnCEnGzr5ilwvJUORDK4xVagxa6zYtZUrXlIQCMp6Q0jmW68b8Q2Yr+xQn2fy
         19ocUZ96CB58ISq0NDerpjdDzODDoKOGSUkiTGz3racqRI4YRVEn0UiJUrAJ1H3nPZUv
         6X9M79MwTZNMkUAOEMUwUpk2l9WheQv9NzvE+K36HqmuqpdXn8VFd5U7ftTFA7fh+b7T
         Ecr0K4qTzgQvVEnXsx4O1gv7xcdH67akhgmIrX6aUtTJ/COV5bMRYJQNFs5up15XpDv6
         0loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5GJT4Hs/HI/FowLComfkTjFmzZeGxKNZxNsulf8xgM=;
        b=BW3ECw6+isP7cVBFpZl3W4yMlNtvhToZlGYfMcwtxldtbmsD9G7j53HBubhPs2voJ7
         SJZyG1oujGZpkJVOJRfzEo6UZUNIf3DNg/M8OpPpavkbQF7/4I/WRFkxJ+5CD8Lreo1q
         f2uPUNOZcE1PDd1WIVjXUpzpe9dX3yJeTWDtVpsQ+cLb/By6rbVibEKUv4NJFjV0SGxU
         U1UQI0U3VP7rSinjKHj6IUImaVY576p/ag/G+pgZd9On4c/ATH4StsJDGkXjRA3OeKRg
         wSb7wwAeRdT7cYfqaJQtIJcxqOCL6B/BagIPVB/4mFCLEzHH5RiJDBZ9hXymWsnF+HlU
         ssmg==
X-Gm-Message-State: AOAM530I0+i/r2ejWkWzuYAxUczRuaLr1AGF9XmDPgzvvyM6+w3xZVQ4
        zQPWUBi3kr9FN3SrzlLgkfgGuW7LwjP6WpZ604A=
X-Google-Smtp-Source: ABdhPJw6mymHjqz0grCP5N1aNDxuQtRnoKixwZE5HkzfHSrWxGkccqjl3ZZojggRe7PfuJwEXxaMkEq0cWVi+OI3hrY=
X-Received: by 2002:ac2:4555:: with SMTP id j21mr18097636lfm.120.1637174971163;
 Wed, 17 Nov 2021 10:49:31 -0800 (PST)
MIME-Version: 1.0
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com> <20211111004724.GA839@neerajsi-x1.localdomain>
 <20211112055421.GA27823@lst.de>
In-Reply-To: <20211112055421.GA27823@lst.de>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 17 Nov 2021 10:49:20 -0800
Message-ID: <CANQDOdedAoOvPHra0e8PuOO68xt+gOSbbV3tHzGxcyJy5nTm_A@mail.gmail.com>
Subject: Re: RFC: A configuration design for future-proofing fsync() configuration
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 9:54 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 10, 2021 at 04:47:24PM -0800, Neeraj Singh wrote:
> > It would be nice to loop in some Linux fs developers to find out what can be
> > done on current implementations to get the durability without terrible
> > performance. From reading the docs and mailing threads it looks like the
> > sync_file_range + bulk fsync approach should actually work on the current XFS
> > implementation.
>
> If you want more than just my advice linux-fsdevel@vger.kernel.org is
> a good place to find a wide range of opinions.
>
> Anyway, I think syncfs is the biggest band for the buck as it will give
> you very efficient syncing with very little overhead in git, but it does
> have a huge noisy neighbor problem that might make it unattractive
> for multi-tenant file systems or git hosting.

To summarize where we are at for linux-fsdevel:
We're working on making Git preserve data added to the repo even if
the system crashes or loses power at some point soon after a Git
command completes. The default behavior of git-for-windows is to set
core.fsyncobjectfiles=true, which at least ensures durability for
loose object files.

The current implementation of core.fsyncobjectfiles inserts an fsync
between writing each new object to a temp name and renaming it to its
final hash-based name. This approach is slow when adding hundreds of
files to the repo [1]. The main cost on the hardware we tested is
actually the CACHE_FLUSH request sent down to
the storage hardware. There is also work in-flight by Patrick
Steinhardt to sync ref files [2].

In a patch series at [3], I implemented a batch mode that issues
pagecache writeback for each object file when it's being written and
then before any of the files are renamed to their final destination we
do an fsync to a dummy file on the same filesystem.  On linux, this is
using the sync_file_range(fd,0,0,  SYNC_FILE_RANGE_WRITE_AND_WAIT) to
do the pagecache writeback.  According to Amir's thread at [4] this
flag combo should actually trigger the desired writeback. The
expectation is that the fsync of the dummy file should trigger a log
writeback and one or more CACHE_FLUSH commands to harden the block
mapping metadata and directory entries such that the data would be
retrievable after the fsync completes.

The equivalent sequence is specified to work on the common Windows
filesystems [5]. The question I have for the Linux community is
whether the same sequence will work on any of the common extant Linux
filesystems such that it can provide value to Git users on Linux. My
understanding from Christoph Hellwig's comments is that on XFS at
least the sync_file_range, fsync, and rename sequence would allow us
to guarantee that the complete written contents of the file would be
visible if the new name is visible.  I also expect that additional
fsync to a dummy file after the renames would also ensure that the log
is forced again, which should ensure that all of the renames are
visible before a ref file could be written that points at one of the
object names.

I wasn't able to find any clear semantics about the ext4 filesystem,
and I gather from what I've read that the btrfs filesystem does not
support the desired semantics.  Christoph mentioned that syncfs would
efficiently provide a batched CACHE_FLUSH with the cost of picking up
dirty cached data unrelated to Git.

Are there any opinions on the Linux side about what APIs we should use
to provide durability across multiple Git files while not completely
tanking performance by adding one CACHE_FLUSH per file modified?  What
are the semantics of the ext4 log (when it is enabled) with regards to
creating a temp file, populating its contents and then renaming it?
Are they similar enough to XFS's 'log force' such that our batch mode
would work there?

Thanks,
Neeraj
Windows Core Filesystem Dev

[1] https://docs.google.com/spreadsheets/d/1uxMBkEXFFnQ1Y3lXKqcKpw6Mq44BzhpCAcPex14T-QQ/edit#gid=1898936117
[2] https://lore.kernel.org/git/cover.1636544377.git.ps@pks.im/
[3] https://lore.kernel.org/git/b9d3d87443266767f00e77c967bd77357fe50484.1633366667.git.gitgitgadget@gmail.com/
[4] https://lore.kernel.org/linux-fsdevel/20190419072938.31320-1-amir73il@gmail.com/
[5] See FLUSH_FLAGS_NO_SYNC -
https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntifs-ntflushbuffersfileex
