Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E473ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiHZHJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiHZHJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:09:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F6D2B0C
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:09:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p18so850195plr.8
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3CYBzQJQ7+6ESVI8Mu0AO4lJPsgQeOD2pbzQ0mwWr/w=;
        b=TI1cnI68PYSbMF1by/vMkSd9L0iSeGuTp1x9003B2/jAaEokGzH09Nree4+oe3l+Sl
         NmnNFRE8L3q4vF4JObwE8MEHa2682ezve89nEYv0a8OTxLczlgL7whL1gBg1X1NOqnlC
         7xzlbajCQW1fViAUC/AtqifpepItGEucZp5EH0TlxCbLJnj83v/uoP12whnBq5uhEKU6
         KHhmERAGHxzo/YR9Q65JeB439nVzMx0tFPdpy+d3Lfofz82U/Kv7pI54AG2ma9h7wlYh
         x6i0BUYjJqtNo6mKpnIq4jPU2uWKzUqtOJtPpM6ZuXWYtB0aJ526CTW30dTkAp1usxjj
         /Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3CYBzQJQ7+6ESVI8Mu0AO4lJPsgQeOD2pbzQ0mwWr/w=;
        b=ZIETFnC4++RcR51j13B0W7lh3v3mvblcu4Z1NHeMZMsZlDBCdk4GaO53g5YhskBcC0
         w1aaU23fn1UcNTkftdpuJyVbebWjYz5Hig9+379en1/eFvy8ZMEk20PwroZnePeh5P4Z
         r4hBYmfwIWCcwBgBFu6NEuxEaJbSsnKXqfxI5e4dLRsjvvvzpIISHq7mcpkz6EQnCM41
         H277Mwfc6bBNSzuNn87b62IA+a0UXq6ABUCVCrPFGU+SJ+7egzbi7tuKtVIBeNp7oHlB
         Rr24gZEA4rLRPo0gq/fX9nbrNqvJTHOz4cPunJskplaHshi+ZJKe81UnLGHfcUk9Qr8A
         T8Qg==
X-Gm-Message-State: ACgBeo1z5ZDejXvtc/X4VtUlGXcuVZTUcovn/9J3yelLvvnTYy7gpHne
        hjCAEUl9eEQjvINzog2+7dtQSLwtN3Z/vhVV
X-Google-Smtp-Source: AA6agR4ZeNRad1XwHFgtMkrXJmU77CIbAoA4lLs9DOwum7p8rgjC3tP6e+H5UAIcpsnYjXQbKFqI2A==
X-Received: by 2002:a17:90b:1d84:b0:1f5:b66:7460 with SMTP id pf4-20020a17090b1d8400b001f50b667460mr3030520pjb.50.1661497763415;
        Fri, 26 Aug 2022 00:09:23 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.43])
        by smtp.gmail.com with ESMTPSA id t12-20020a62d14c000000b0052f3a7bc29fsm866930pfl.202.2022.08.26.00.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:09:23 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, derrickstolee@github.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>,
        XingXin <moweng.xx@antgroup.com>
Subject: [PATCH 1/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Fri, 26 Aug 2022 15:09:12 +0800
Message-Id: <20220826070912.70274-2-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <20220826070912.70274-1-dyroneteng@gmail.com>
References: <20220826070912.70274-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_midx_bitmap_1()" and "open_pack_bitmap_1()", when we find that
there are multiple bitmaps, we will only open the first one and then
leave warnings about the remaining pack information, the information
will contain the absolute path of the repository, for example in a
alternates usage scenario. So let's hide this kind of potentially
sensitive information in this commit.

Found-by: XingXin <moweng.xx@antgroup.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c                 | 8 ++++----
 t/t5310-pack-bitmaps.sh       | 2 +-
 t/t5326-multi-pack-bitmaps.sh | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 36134222d7a..5103d91d18a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -331,8 +331,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		/* ignore extra midx bitmap files; we can only handle one */
+		warning("ignoring extra midx bitmap files");
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -402,8 +402,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		/* ignore extra bitmap files; we can only handle one */
+		warning("ignoring extra bitmap files");
 		close(fd);
 		return -1;
 	}
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce69..7cd6d79a022 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -421,7 +421,7 @@ test_expect_success 'complains about multiple pack bitmaps' '
 		test_line_count = 2 bitmaps &&
 
 		git rev-list --use-bitmap-index HEAD 2>err &&
-		grep "ignoring extra bitmap file" err
+		grep "ignoring extra bitmap files" err
 	)
 '
 
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4fe57414c13..1786f28376a 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -303,7 +303,7 @@ test_expect_success 'graceful fallback when missing reverse index' '
 
 		GIT_TEST_MIDX_READ_RIDX=0 \
 			git rev-list --use-bitmap-index HEAD 2>err &&
-		! grep "ignoring extra bitmap file" err
+		grep "multi-pack bitmap is missing required reverse index" err
 	)
 '
 
-- 
2.37.2.1.g1591e7ee52e

