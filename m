Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F6C43217
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 03:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKDDTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiKDDSv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 23:18:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808526541
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 20:17:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v3so3331692pgh.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 20:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bK2XwKkP0oCIBF0v3v8jFOgOPsqbk7SKiZW97wIwsw=;
        b=IzlCEEe6q43iPjG1BmEfjyywuJHcXgUBPX+uZIS/NHPoIuHaciXJy+qtk+wwjoF0Ci
         NSme30oIKPQ0rMf/v4DJaXTLOrl2c2GYMH008+Ys5N9wdn39VQgjCN4dcE8mSrJlPP9C
         gMiUFiz4MuzgzR3fITDHVlAaqivzXl3T9aIEwDI9ANEvFMAj+mBTZTTGK9OXez93JX/d
         rj0/5x49ErFodjfQete8nbN5D23cGq5kztsL3HCfS/rgvA6yOP3DHl9rp97P2XfpO7UY
         wli094P7R5maEDTPBkKx1o3VFNL0qrDbsnsPFUAnLV20IYofpmMMTCKHbjwNqC/uZu0p
         kA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bK2XwKkP0oCIBF0v3v8jFOgOPsqbk7SKiZW97wIwsw=;
        b=7ve5OEUeJgUv8nUlPL9VJ2SS+xKwSPi8M4ZZKK7AR0bS25UAia7yPadfA5wklsXQul
         RXOAUGaSNe3r0xLH8Jy1DMrK1VCXQ3xqnw/7T6ChLNtjNGWSjTE6G2Pxcv7x3vZaMevI
         ptKrT2QwbibCWmcia+LmYSUEmpHIUb4ZznU0ozx7X0jkVt/v0uJtZg68cDfnEHc6bTV7
         TUjMwGEx00JdZ+WOu0eaLO5xryiQk6gMAsJw7MPizfgQEL2PCXozi4hPDXZS0wP4YEaG
         8m3Eh6U/w1MwoeY8nnYB67KVw1xTsBKauxU0Ml3LvwlZUhLfxMC6AvIpIdOaPhXe+6WI
         Xw6Q==
X-Gm-Message-State: ACrzQf1kbeNdyuelqMaLL6KS+OUtPg6q8ZIgO81WE9bkaI76lDz9mbEM
        Xvd2JzOUjrtBMVv3YxLjBvs=
X-Google-Smtp-Source: AMsMyM69L5+6Vv9ZF00YMDsuwfakCB28Bo7AZVIH7n1y8tquo/Cbur4s3aRKWIA/T7ZG/NjkD0vwTA==
X-Received: by 2002:aa7:810d:0:b0:563:1fa6:fecc with SMTP id b13-20020aa7810d000000b005631fa6feccmr33508043pfi.24.1667531843656;
        Thu, 03 Nov 2022 20:17:23 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172973d3cd9sm1442908plf.55.2022.11.03.20.17.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 20:17:23 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, XingXin <moweng.xx@antgroup.com>
Subject: [PATCH v3 1/2] pack-bitmap.c: avoid exposing absolute paths
Date:   Fri,  4 Nov 2022 11:17:09 +0800
Message-Id: <de941f58f9eb7d0287fa1f7a5ffd343a22e5e46c.1667470481.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g35840fde1dd
In-Reply-To: <cover.1667470481.git.dyroneteng@gmail.com>
References: <cover.1667470481.git.dyroneteng@gmail.com>
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
 pack-bitmap.c           | 12 ++++++++----
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be..9443b7adca 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -354,8 +354,9 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
+		/* ignore extra midx bitmap files; we can only handle one */
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -432,8 +433,9 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
+		/* ignore extra bitmap files; we can only handle one */
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra bitmap file", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -458,6 +460,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	trace2_data_string("bitmap", the_repository, "opened bitmap file",
+			   packfile->pack_name);
 	return 0;
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82..0b422c8a63 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -428,8 +428,9 @@ test_bitmap_cases () {
 			test_line_count = 2 packs &&
 			test_line_count = 2 bitmaps &&
 
-			git rev-list --use-bitmap-index HEAD 2>err &&
-			grep "ignoring extra bitmap file" err
+			GIT_TRACE2_PERF=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
+			grep "opened bitmap" trace2.txt &&
+			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
 }
-- 
2.38.1.383.g35840fde1dd

