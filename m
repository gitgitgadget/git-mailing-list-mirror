Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397AEC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiK1OKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiK1OKD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:10:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A49267
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so12567315pjt.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hugyZxju/qJXKB9PdSu7OrkBPwT66OcQHYq/zOdRVU=;
        b=FngT1ve0eNbPjzKFWhy8qmJOxkDAUBK7FMNQB7Qkl4/OAMkP1zXJRub7V80Uj8oSKT
         XSCygQRNOUcXZfEfAUYbhcIB9XQH5f2ZdwIPqMxY+USbLVHQyol69M3c7ETWE2rNaAf8
         +UsthY5F4PKEKxxa3Ug9QPW+mdxZL9NxyadMeofYE5N3aJpKXsxDOezaP5TvTte/fyWM
         Uq8nCT60AZh/FLguMe/dM/MkdsVHvMVJCJiLGxc8w7zEjY82mXlKMKfGQXIITS4tZff9
         XzRzse6FyjKsAWq2N984GPx2FUcU7r6qgPRfgJIE9xKFSM4mR1w0jg6EsJi9B9SuR0qb
         fRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hugyZxju/qJXKB9PdSu7OrkBPwT66OcQHYq/zOdRVU=;
        b=7qyhVWIuavXIYK0FmUAUysud/cz5nLHMHXTnLJBYOSGHWte0fvPIQxmkDSUKMkj3rx
         fkuX38SeyEp3kKd58jTwtfB8gf4MzwvMxyYht2O3+4OqIIwXYdbtYIcLB7S1sn9Soluo
         h9xOOq7XzLwqgVqDdNtFTZd4A8ualRVxiBPY/tOiVQdFJLjuKNKY6R3S+tuuQoQnnzVu
         bJlgNC3mcV7k5FXilr2uKyifR2K7ruFFj9rJkO/r1mXAtOzcqF6D2w40Me2wVCbmgvRa
         X4maDAeHIAPja24GtGSt1XB5x4U9VQq/obLxRPIHow+SECh+s6fTYdbmNN/mQQS1Bb9I
         VIzg==
X-Gm-Message-State: ANoB5pn4utHqbaUvaiyfiTqy/IF1nr5fhuOYHaKKEH/K81xBv7DqFPjO
        7Nbc7osX9GCFGstxyz7IGiI+2VDTt5e95w==
X-Google-Smtp-Source: AA0mqf610/pAOpWwd6MAKp5+cnxKbymeWbhG66e4i5ggnerMOW6ldSdR6fASMg1Tz26JbZh9WjCIeA==
X-Received: by 2002:a17:903:2350:b0:189:9004:cf1f with SMTP id c16-20020a170903235000b001899004cf1fmr3373909plh.154.1669644602315;
        Mon, 28 Nov 2022 06:10:02 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0017f64ab80e5sm8842819plg.179.2022.11.28.06.09.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:10:01 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 0/4] pack-bitmap.c: avoid exposing absolute paths 
Date:   Mon, 28 Nov 2022 22:09:49 +0800
Message-Id: <cover.1669644101.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1669032425.git.dyroneteng@gmail.com>
References: <cover.1669032425.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Changes since v4:

* [3/4] Reroll the commit message.
* [4/4] Reroll the commit message and remove the initialization of 'found'.

Besides of 3/4 and 4/4, the 1/4 and 2/4 seem already in 'next' as
8ddc06631b184e6f43051f7ea8ac9bbc86817127 and
2aa84d5f3ea1966a81477ad31bee0136e39d3917 , but I send again here just for
the completeness of the patchset, I think it will be nice to merge Peff's
commits of there are no new suggestions.

Thanks.

Jeff King (2):
  pack-bitmap.c: break out of the bitmap loop early if not tracing
  pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found

Teng Long (2):
  pack-bitmap.c: remove unnecessary "open_pack_index()" calls
  pack-bitmap.c: avoid exposing absolute paths

 pack-bitmap.c           | 39 ++++++++++++++++++++++++++-------------
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 29 insertions(+), 15 deletions(-)

Range-diff against v4:
-:  ---------- > 1:  aaeb021538 pack-bitmap.c: remove unnecessary "open_pack_index()" calls
-:  ---------- > 2:  9d5a491887 pack-bitmap.c: avoid exposing absolute paths
1:  f6c5b45bdc ! 3:  22deec6aab pack-bitmap.c: break out of the bitmap loop early if not tracing
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: break out of the bitmap loop early if not tracing
     
    -    When we successfully open a bitmap, we will continue to try to open
    -    other packs, and when trace2 is enabled, we will report any subsequent
    -    bitmap ignored information in the log. So when we find that trace2 is
    -    not enabled, we can actually terminate the loop early.
    +    After opening a bitmap successfully, we try opening others only
    +    because we want to report that other bitmap files are ignored in
    +    the trace2 log.  When trace2 is not enabled, we do not have to
    +    do any of that.
     
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
2:  2acaa3f097 ! 4:  28306b7e8d pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
     
    -    We retained pack bitmaps as a quick recovery mechanism while
    -    test-deploying midx bitmaps. This is an internal mechanism, and we
    -    want to expose this rule externally through trace2 so that end users,
    -    repo-maintainers, and debuggers know what is happening in the process.
    +    When we find a midx bitmap, we do not bother checking for pack
    +    bitmaps, since we can use only one. But since we will warn of unused
    +    bitmaps via trace2, let's continue looking for pack bitmaps when
    +    tracing is enabled.
     
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
    @@ pack-bitmap.c: static int open_midx_bitmap(struct repository *r,
      static int open_bitmap(struct repository *r,
      		       struct bitmap_index *bitmap_git)
      {
    -+	int found = 0;
    ++	int found;
     +
      	assert(!bitmap_git->map);
      
-- 
2.38.1.385.g28306b7e8d5

