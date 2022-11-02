Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E9C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 12:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKBM4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiKBM4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 08:56:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F3286D1
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 05:56:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so16318689pfh.6
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/J+3fnAIIZaKqhfRtZ776pLL6b0bEsOAEfLHnGA5iU=;
        b=LC8hbZLxEbHVYvc1VOmX0lBvQN09J4uHUUrvl/RheFV1fEid1KJwp18Mj6t/9s4U9c
         ka1VHKbMXJapFHwPAhc82mPeNOPgfN8IkMxaotuDUEKerp+AViLIHgTCKK8qkGYlUF4Y
         fLiKsa7LbVOpyX8351LiAu2ITII838MJdPCAntRueJzHFC/8hLAQuqecyotF6FdoGP3V
         OkPb450ebHjMsloT2s8U8giBVigLAyHgWYfP0tuN95Kd3gUQyr/I/sg8QRrxVIA7IQ+T
         QxH2goyVqftK0l15nZXRWww1l+2ibAfsgpcomRyL6w1qelGX2kZXbT/VecunHLGbAUm7
         ZbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/J+3fnAIIZaKqhfRtZ776pLL6b0bEsOAEfLHnGA5iU=;
        b=bAL3Fi+Zss0igpEl0AYBZj33uU7bNq9tAXrbhOOksv84IlJRVZz+82ZGvk6JFPzwjg
         neK22Efb8puj/1eFmQEQcW3SDW4graBrtq9LVOOHnF/nHjd27xQkv+uLmSW7gK0VKThU
         jAD4yAGmCpFLJm4+NziLGZUQFP4ZjjDuHpB+M7hYRKJ30wP5nCSoA3I+REwowZSD2I5o
         0agZfvULXhSnw6Nv54p1mVYZcTID+4XkKEQ7ZUsx1rALsPa0kZ3knzk7baVzHJ/5GSkd
         Exo0POW7qhTAUsJ/sKQydLt7+4/96tFkSFbXMS/kFgEztTA7RuFZgOI6evsd5yZRg4zo
         uScA==
X-Gm-Message-State: ACrzQf2uMouIxadhi5+5IiiYvIlZPYEbzmtDE65hXG83HXlzC2nSg862
        DI8IZUxdeYPwIdP/lEOLhhI=
X-Google-Smtp-Source: AMsMyM7+03hYmLGG2IKNpBHMeCYZqlf7u2ZDdCDOaSzbX/1CSn+TnS5SMFMc1aBkElMoRX6z3IQlnQ==
X-Received: by 2002:a05:6a00:1149:b0:53e:62c8:10bc with SMTP id b9-20020a056a00114900b0053e62c810bcmr24739966pfm.49.1667393777509;
        Wed, 02 Nov 2022 05:56:17 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a788500b0020ad53b5883sm1428129pjk.14.2022.11.02.05.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 05:56:17 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, XingXin <moweng.xx@antgroup.com>
Subject: [PATCH v2 1/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Wed,  2 Nov 2022 20:56:05 +0800
Message-Id: <87a494e5ac0cc992689944ab13600d097c51e54a.1667393419.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.2.1.g87a494e5ac0
In-Reply-To: <cover.1667393419.git.dyroneteng@gmail.com>
References: <cover.1667393419.git.dyroneteng@gmail.com>
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
 t/t5310-pack-bitmaps.sh | 11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 36134222d7a..a8c76056637 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -331,8 +331,9 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		/* ignore extra midx bitmap files; we can only handle one */
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra midx bitmap file", basename(buf.buf));
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -402,8 +403,9 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		/* ignore extra bitmap files; we can only handle one */
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra bitmap file", basename(packfile->pack_name));
 		close(fd);
 		return -1;
 	}
@@ -428,6 +430,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	trace2_data_string("bitmap", the_repository, "opened bitmap file",
+			   basename(packfile->pack_name));
 	return 0;
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce69..614586b0181 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -397,7 +397,7 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
-test_expect_success 'complains about multiple pack bitmaps' '
+test_expect_success 'complains about multiple pack bitmaps when debugging by trace2' '
 	rm -fr repo &&
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
@@ -420,8 +420,13 @@ test_expect_success 'complains about multiple pack bitmaps' '
 		test_line_count = 2 packs &&
 		test_line_count = 2 bitmaps &&
 
-		git rev-list --use-bitmap-index HEAD 2>err &&
-		grep "ignoring extra bitmap file" err
+		ls -tr .git/objects/pack | grep -e "^pack-.*\.pack$" > sorted-packs &&
+		ignored_pack="$(cat sorted-packs | awk 'NR==1{print}')" &&
+		open_pack="$(cat sorted-packs | awk 'NR==2{print}')" &&
+
+		GIT_TRACE2_PERF=1 git rev-list --use-bitmap-index HEAD 2>err &&
+		grep "opened bitmap file:$opened_pack" err &&
+		grep "ignoring extra bitmap file:$ignored_pack" err
 	)
 '
 
-- 
2.37.2.1.g87a494e5ac0

