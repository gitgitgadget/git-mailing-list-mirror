Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A8C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiK1OKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiK1OKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:10:09 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5FE3AB
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s196so10020525pgs.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1RYpHYSUKbhu8r3cf8HAvYclchOWchCOjxqlJBnTkM=;
        b=EAumgRZQQkNxQliqFdM3CVIspMN0v6F6dIGLM0XwdKZqlTPKKkGLNRoiI80exkFR57
         vQP4KeU+cQNREb0iSpKQXwIFLbJel/Cwffn3m1tKELPC99jXm2AZm0N/9oz/u/KEP8Fd
         cIG5GpTq0P0xbMSLCNh/nQG4Z80jE74z51XeSNc7ZBb7DCgbF35xpNH/SvFqrLkeOkcP
         eI2en2R9R4Q9JLa+RoQPhHdUCYK+7IOL3gSf1nljo6IYKBcYchxZhqT3vH/6UDvB5gkN
         2/REzXa7AZK20l28sCGhBTirygyIk0F8o6pI18D1lwlMCe2nNO8l10vFHOK1dpErq4r0
         Eirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1RYpHYSUKbhu8r3cf8HAvYclchOWchCOjxqlJBnTkM=;
        b=ch+PS4P92fdw/4P7qCUXTeLjgrIkHzy4nTTWdVhu/6fMM8UmrKaP4VLuNt38xNgGio
         aJqcgPGp3GDIAzOjNAR8Rkke+XmR1m5C/8BTtTwgnh2VNmpJZnVEM6GXoAtG5TSBdpes
         LbVpsxIaXIXfnxnQczomK5yHu20Ufr9Hk0R+JhGRAZIuFIl0frfn1cvjy1SciTldoJCj
         WU6fNvTYEgLvhoWcL4WGK49lpZfYERS2+8zfyefqIwjR4BToJ42nfqaCjmL3ktuJFFWq
         kz/iLFuZSCMd3ZB4n2xODdqC5shcnaMzSZux9TjFMRIMpBOq0rMyt/eav1FOMQFF1Y5Z
         ZOpw==
X-Gm-Message-State: ANoB5plolmzKLMvxks3It0lx7Q3S6yRnuMEiWo3P9PM7SpolzLcQeHyj
        oegX1BQNtX3u9wmJa1O6YmU=
X-Google-Smtp-Source: AA0mqf5FwSZph5UL8QSASEuqqqtRHOsf7s8AdYQpk+31rfREPf1L2HZ3U0lEbMwgUc3OZs6mx7SBXw==
X-Received: by 2002:a65:58ca:0:b0:470:2c91:9579 with SMTP id e10-20020a6558ca000000b004702c919579mr26920965pgu.22.1669644608439;
        Mon, 28 Nov 2022 06:10:08 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0017f64ab80e5sm8842819plg.179.2022.11.28.06.10.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:10:07 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, XingXin <moweng.xx@antgroup.com>
Subject: [PATCH v5 2/4] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 28 Nov 2022 22:09:51 +0800
Message-Id: <9d5a491887b57bbcc30010aa7efb63e316c6d190.1669644101.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1669644101.git.dyroneteng@gmail.com>
References: <cover.1669644101.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In "open_midx_bitmap_1()" and "open_pack_bitmap_1()", when we find that
there are multiple bitmaps, we will only open the first one and then
leave warnings about the remaining pack information, the information
will contain the absolute path of the repository, for example in a
alternates usage scenario. So let's hide this kind of potentially
sensitive information in this commit.

Found-by: XingXin <moweng.xx@antgroup.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c           | 10 ++++++----
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 982e286bac..aaa2d9a104 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -354,8 +354,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -429,8 +429,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra bitmap file", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -455,6 +455,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	trace2_data_string("bitmap", the_repository, "opened bitmap file",
+			   packfile->pack_name);
 	return 0;
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82..7d8dee41b0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -428,8 +428,9 @@ test_bitmap_cases () {
 			test_line_count = 2 packs &&
 			test_line_count = 2 bitmaps &&
 
-			git rev-list --use-bitmap-index HEAD 2>err &&
-			grep "ignoring extra bitmap file" err
+			GIT_TRACE2_EVENT=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
+			grep "opened bitmap" trace2.txt &&
+			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
 }
-- 
2.38.1.385.g28306b7e8d5

