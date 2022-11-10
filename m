Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06658C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 07:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiKJHKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 02:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiKJHKX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 02:10:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26B2648
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 23:10:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b29so1093656pfp.13
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 23:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgFXC0gtVdvE5cgUwBGKDqKt1RR11wWLJxt0SB3+AtM=;
        b=Z4uwKyADHlZA/nxx1E+FBeiRk9xlZ5ycUc+h4qwS1PXhxikn8doQKwwL3ROomowJbk
         qG9CErYpmA9BUnStqJ/jV5XMLSfJqkmgpY+URTjHtUZKaHDecM+zdxl7qeyrjF3IZ3Wd
         2XC2vDdsqoX6TQaVEoGtZhC5r6nSnaWp1TfqLLd8xsxkNNNPs6OXdcXKbVkWn5hp61Xl
         4aBzxqeLyT8CV6Y18MygCs0H26cmPbvdq92kBsq2aHiaEU81Kk0wvkb/KbQykp7I5toz
         jmWYyNRwUBbexMrzhk7rYAlLyRHC1hmyqEZKde9TAx14gjh6lkjPGJKKCiLeUHks056U
         Uhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgFXC0gtVdvE5cgUwBGKDqKt1RR11wWLJxt0SB3+AtM=;
        b=ZRmF2SqUO2IxWF0LAij/N+eMqxjXo+THEdHrfAFiJBfbHe9KcCii5hl6jDXHjzrp2x
         GWTZ/NdKgxVYxXXScLgxyiYLiOenzQ5pha7dZR9CxyteYkACktLss+ay952Rx8reuxoC
         WD71wOsOX8KMEIQCTDzIhoAGgLbD/n9KAYebrkeDHRYSU48Lp+yO27ehw0urIc4nE2jn
         Zw9U2ZIcNkS/juQLAqqSo7v5FqYZe/Kc4xL7JZB9TE8Cle3NMxvOcQ/jrw8SFvJcdJDn
         MFr6yCgoaBOMGR8nZCLs8Qlw0UBSutonKr/xyoHmtN4Err70U/ALQ/6G2S2pxb1fGDEk
         LlBw==
X-Gm-Message-State: ACrzQf3Q4OdCN+ca0hMyqd13KS2F438vVjsBOx+PskQLR54nj+LThviR
        DtwIk4QSkUYS3FoRCeAYeoI=
X-Google-Smtp-Source: AMsMyM5swapfRDgOTJIGAvEmnXo69MKRSE+yNlgJidDSA4gPKEmbCGtu9crub4PIi4eUpjenoYN+OQ==
X-Received: by 2002:a63:e211:0:b0:43b:f03e:3cc5 with SMTP id q17-20020a63e211000000b0043bf03e3cc5mr54924214pgh.256.1668064222017;
        Wed, 09 Nov 2022 23:10:22 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0017f778d4543sm10517161plf.241.2022.11.09.23.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 23:10:21 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths  
Date:   Thu, 10 Nov 2022 15:10:10 +0800
Message-Id: <cover.1668063122.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g7ac9b859f31.dirty
In-Reply-To: <cover.1667470481.git.dyroneteng@gmail.com>
References: <cover.1667470481.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v2:

* remove unnecessary comments.
* use "GIT_TRACE2_EVENT" instead of "GIT_TRACE_PERF".
* improve commit message of [1/2].

Thanks.

Teng Long (2):
  pack-bitmap.c: remove unnecessary "open_pack_index()" calls
  pack-bitmap.c: avoid exposing absolute paths

 pack-bitmap.c           | 13 ++++++-------
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 9 insertions(+), 9 deletions(-)

Range-diff against v2:
2:  7ac9b859f3 ! 1:  aaeb021538 pack-bitmap.c: remove unnecessary "open_pack_index()" calls
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: remove unnecessary "open_pack_index()" calls
     
    -    Everytime when calling "open_pack_bitmap_1()", we will firstly call
    -    "open_pack_index(packfile)" to check the index, then further check
    -    again in "is_pack_valid()" before mmap the bitmap file. So, let's
    -    remove the first check here.
    +    When trying to open a pack bitmap, we call open_pack_bitmap_1() in a
    +    loop, during which it tries to open up the pack index corresponding
    +    with each available pack.
     
    -    The relate discussion:
    -    https://public-inbox.org/git/Y2IiSU1L+bJPUioV@coredump.intra.peff.net/#t
    +    It's likely that we'll end up relying on objects in that pack later
    +    in the process (in which case we're doing the work of opening the
    +    pack index optimistically), but not guaranteed.
    +
    +    For instance, consider a repository with a large number of small
    +    packs, and one large pack with a bitmap. If we see that bitmap pack
    +    last in our loop which calls open_pack_bitmap_1(), the current code
    +    will have opened *all* pack index files in the repository. If the
    +    request can be served out of the bitmapped pack alone, then the time
    +    spent opening these idx files was wasted.S
    +
    +    Since open_pack_bitmap_1() calls is_pack_valid() later on (which in
    +    turns calls open_pack_index() itself), we can just drop the earlier
    +    call altogether.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
1:  de941f58f9 ! 2:  9d5a491887 pack-bitmap.c: avoid exposing absolute paths
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      		get_midx_filename(&buf, midx->object_dir);
     -		/* ignore extra bitmap file; we can only handle one */
     -		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
    -+		/* ignore extra midx bitmap files; we can only handle one */
     +		trace2_data_string("bitmap", the_repository,
     +				   "ignoring extra midx bitmap file", buf.buf);
      		close(fd);
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      	if (bitmap_git->pack || bitmap_git->midx) {
     -		/* ignore extra bitmap file; we can only handle one */
     -		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
    -+		/* ignore extra bitmap files; we can only handle one */
     +		trace2_data_string("bitmap", the_repository,
     +				   "ignoring extra bitmap file", packfile->pack_name);
      		close(fd);
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      
     -			git rev-list --use-bitmap-index HEAD 2>err &&
     -			grep "ignoring extra bitmap file" err
    -+			GIT_TRACE2_PERF=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
    ++			GIT_TRACE2_EVENT=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
     +			grep "opened bitmap" trace2.txt &&
     +			grep "ignoring extra bitmap" trace2.txt
      		)
-- 
2.38.1.383.g7ac9b859f31.dirty

