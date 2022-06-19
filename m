Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B91DC433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiFSD00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiFSD0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A617BC20
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso7354180pja.2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGCBW8RoEvEiBZAX1k87U81P878nRnAoTUXBjhr/XNQ=;
        b=HjWTyQ2mTNyG3Byx5wMTHGMHmfWbUGK74olNPFx59CwAisuqFy90lYVwyQYVYLHzGZ
         tYqyDrPpKBfErTYUHp/Nf5HI36OhKR307rdLQVxvhSGazl3NmVbhP937PVgZV+f2Wb6I
         o/IzpkGDj0tjn4OFVBe3dH04lRXQyN1FkppHqIYfzNcqDI4z2wlXm4HptbXdGyskA1Bk
         sAC46hRhINqd694kdV+xDx3Ur+SJXrnt8kwEZl0mM0o240N/f9FRAgnhXfmovtVutlzx
         4hAOk0dpKATvRV86iB8NRZ+U0oD4XwBENLSLbVVbD3VFkI3e13Z3N3hwJYivs7oaqrvC
         wx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGCBW8RoEvEiBZAX1k87U81P878nRnAoTUXBjhr/XNQ=;
        b=w8B+HkB2UPetvnF9bJsnOmDf+zzl6wmHz+xtaqDN6lWHkksLKwP6avONenu5G0ktyT
         PkDjE34PISdT0NK4P5vcO5xaKLhCs5L+J34Qfh7GwqOaxJcH+toSIj29+N01HjKaRi0U
         P/+7bTl3pa1I4sUTVObkEzEWrHYnApvDxcoibiseMmfzL0/IxDhJhc56oiMrndY3RapM
         a9LRQ0fnYXSuGmyi8UvkmKSoLk+j5i1sX3jzxU3R+kob4qeu4A1RMgbpiWIVtzrACbFt
         xP7e2VXQCiH2oCMXNuzsmH97uu6OAdbFtVQbgK3hBk7dfVr4AKoYQE/ug3ZUNiqWerb7
         a+fA==
X-Gm-Message-State: AJIora/B8VIlI3U8B/cgQYTwxUDyNNlM4aBP1IXZnRPCHbUmIJdJn2Dj
        zHX3IzIpE0OUnrFJKAVQcz4=
X-Google-Smtp-Source: AGRyM1vzEDUhudsE+wJXex3YFzAu2My9z02Qb1vEnLhO5lGNdnoqnQMhQZWKTTrPxLtFfSoCp+sDFQ==
X-Received: by 2002:a17:903:260d:b0:16a:20a2:374d with SMTP id jd13-20020a170903260d00b0016a20a2374dmr55161plb.127.1655609175721;
        Sat, 18 Jun 2022 20:26:15 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:15 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 4/7] mv: check if <destination> exists in index to handle overwriting
Date:   Sun, 19 Jun 2022 11:25:46 +0800
Message-Id: <20220619032549.156335-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a sparse file into cone can result in unwarned
overwrite of existing entry. The expected behavior is that if the
<destination> exists in the entry, user should be prompted to supply
a [-f|--force] to carry out the operation, or the operation should
fail.

Add a check mechanism to do that.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 15 ++++++++++++---
 t/t7002-mv-sparse-checkout.sh |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 9d8494a2e4..abb90d3266 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -201,11 +201,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				bad = _("bad source");
 				goto act_on_entry;
 			}
-
-			if (!ignore_sparse)
+			if (!ignore_sparse) {
 				string_list_append(&only_match_skip_worktree, src);
-			else
+				goto act_on_entry;
+			}
+			/* Check if dst exists in index */
+			if (cache_name_pos(dst, strlen(dst)) < 0) {
 				modes[i] = SPARSE;
+				goto act_on_entry;
+			}
+			if (!force) {
+				bad = _("destination exists");
+				goto act_on_entry;
+			}
+			modes[i] = SPARSE;
 			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1984cf131d..5b61fbad5f 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -265,7 +265,7 @@ test_expect_success 'can move out-of-cone file with --sparse' '
 	test_path_is_file sub/file1
 '
 
-test_expect_failure 'refuse to move sparse file to existing destination' '
+test_expect_success 'refuse to move sparse file to existing destination' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir folder1 &&
 	touch folder1/file1 &&
-- 
2.35.1

