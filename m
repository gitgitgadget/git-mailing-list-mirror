Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159DC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiF3Cig (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiF3CiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041B326
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so15769707plo.10
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hEn+VekRkx6ZeGrcRSu5mFkG0APhvp1/f8Tq8zI1sI=;
        b=i3Fu4xIdlP2wL3z+TZ/QaGONSG41pwEAWwerk4TxAMRZGTcVJ8eG5YItdQx5w0RuXA
         Hn6J+F4b8/FDZlQ4yCJ825heq5wS/uCZty2nlMXOgpUsCfqvCJrDVEwU29g6thG+DjSH
         TRa95ke+vbg8Eg84/lybcCiqH6LGqtMPgcs9foc/+bHEbPHrImx4BoAjVHcKEE+TQ1g/
         PShcUJNNgvGrdu0bhMwG9ZEoLnNNOH4siaXn/5Xv68ov7KlvUeGDjL8hdt31SBHw5dxY
         lpjRO63Mwkid0Iqowck7ewyrJk3IakW716slPxV11e7ubpjDY7bn1WJ8eq3EqwFin4AN
         Wp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hEn+VekRkx6ZeGrcRSu5mFkG0APhvp1/f8Tq8zI1sI=;
        b=MxqaCwff2diG9auE6kOebmYW0UnDIgLKQBBAP2o2oKFLakNbSfjInnQu+UJT6/M2Ia
         PlpR9yf82QCkZF4EyTkRZfMRxR8RKPohDm38rzNvb3Vb5rn5sLtHxp5d06R+YOdO2Q+p
         iYUZMV1QKeo9VgC3aNEHpGL10aOrkCOY1JBGEvXiooFQQ25uqw6K44+OrE+CTdvT2hPp
         LjDyHg9FQWOmzqtDksh7lY17A++PcKCLwOEfRpPQKsMYU+7jN8YMbrR7ExEeopEddY2o
         RC/WB534SDigpr0IJA2VjvqngODyGZxoo7cWdTquL+qYaPLGybuFO6sHPMV9e6GpcPMZ
         Vfeg==
X-Gm-Message-State: AJIora8H2RDUi26iScg/96SN6fS4+MRNT9RKT0mTapJAF2qAogme+6B6
        QDH3TohRZk+iEAAVX48m1NLg1r5kZMk=
X-Google-Smtp-Source: AGRyM1t3vZj2K687sHL4p8U8PIcodORxaXt+SCGXOkXS7RAKj4ZD9VqFeNElUvLhl7DuvuQvPyg3sQ==
X-Received: by 2002:a17:902:6b41:b0:16a:55f6:95ee with SMTP id g1-20020a1709026b4100b0016a55f695eemr13623717plt.156.1656556684845;
        Wed, 29 Jun 2022 19:38:04 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:38:04 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 6/8] mv: check if <destination> exists in index to handle overwriting
Date:   Thu, 30 Jun 2022 10:37:35 +0800
Message-Id: <20220630023737.473690-7-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
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
 t/t7002-mv-sparse-checkout.sh |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 520be85774..7d9627938a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -202,11 +202,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
index 1510b5ed6a..6d2fb4f8d2 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -262,7 +262,7 @@ test_expect_success 'can move out-of-cone file with --sparse' '
 	test_path_is_file sub/file1
 '
 
-test_expect_failure 'refuse to move sparse file to existing destination' '
+test_expect_success 'refuse to move sparse file to existing destination' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir folder1 &&
 	touch folder1/file1 &&
@@ -275,7 +275,7 @@ test_expect_failure 'refuse to move sparse file to existing destination' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
+test_expect_success 'move sparse file to existing destination with --force and --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir folder1 &&
 	touch folder1/file1 &&
-- 
2.35.1

