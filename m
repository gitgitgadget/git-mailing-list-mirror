Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4513C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiGSOKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiGSOKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B14A558DF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g126so13542460pfb.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UScBClZnkEceahuoH1MI9Ww5n76d07CQMztc0SOra9Y=;
        b=SltP4f+J3qXjxiTppId9J59+kMWeiirQBM50AB8H0597bJO5sb+OI/bKbV8YT5Tcai
         T7l32srLb15QdTT5TWPjyiIX6+BOPvJwVMUu7YBR04yiLvFcZ+HQbo0WGNjmIuVVaEUV
         PxOm1GBEAKZaePjR+aLV3E550kKwknbVeoy8nEAUkyYj71MU7evJwiz9pVjJzERKG64y
         fa1XaJk7LAcx7xc9Be7DQYEg5jpFeMgnwhD9mBNcULfuTqgzmWegBefbKD1MvfVr/qSd
         DvpIvJ6A77HolnXqA7NFytpXJ/7pRV1PT4vZoC9kSFwjOOeLYHR9aNy9gNTtqvSGyDjZ
         YnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UScBClZnkEceahuoH1MI9Ww5n76d07CQMztc0SOra9Y=;
        b=UDL1k68RFgymGphGaJadUslAuVX0G9ysRz3G2CTT37G+IsBZjZ2oHhy0/yBD0gc4N4
         ZQGzwKWB29UjzbYJO3QytrFuf6atmfS2HvOJNTv6Pd3NPXbKhCiS3N8os3BGSxuqI/sL
         JkFUHPzD0/X1lDzIqtQ3Np+gS534P+LNEBTmHI5H+HjqLuAiBfkwmGM5TIiVreKIuGfp
         29URIej6r8ODOFUM2NJxsReXi2VB/sznKgITE68GwRYddFuEGpijocQz+VL5by29bpwU
         I0k+IgD4wzCq76em+QZreds6P8Iy/bfU2uJLchrHNRaTRXE9D+HM++EbD6YxrnTXDXJ7
         iOyw==
X-Gm-Message-State: AJIora/9MMZC5aEkI2AcUG/1O7PgGs6gr6RP5SaHE/tCAf4+idMElh2y
        QNUxnq8g206Y4GbUOWRmOfz2HYI8skUZdpBd
X-Google-Smtp-Source: AGRyM1sj6TtSZKqyiLGli6UjSTX83NnqOLGVYyTZqS7NUaaVYeIWBuJS7oN2h77WjyIiaHIOHLP4bw==
X-Received: by 2002:a05:6a00:815:b0:52a:dea8:269b with SMTP id m21-20020a056a00081500b0052adea8269bmr33716797pfk.66.1658237346979;
        Tue, 19 Jul 2022 06:29:06 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:29:06 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 7/7] mv: check overwrite for in-to-out move
Date:   Tue, 19 Jul 2022 21:28:09 +0800
Message-Id: <20220719132809.409247-8-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add checking logic for overwritng when moving from in-cone to
out-of-cone. It is the index version of the original overwrite logic.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 12 ++++++++++++
 t/t7002-mv-sparse-checkout.sh |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index d35994c443..5ed3bd3431 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -365,6 +365,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			goto act_on_entry;
 		}
 
+		if (ignore_sparse &&
+		    (dst_mode & SKIP_WORKTREE_DIR) &&
+		    index_entry_exists(&the_index, dst, strlen(dst))) {
+			bad = _("destination exists in the index");
+			if (force) {
+				if (verbose)
+					warning(_("overwriting '%s'"), dst);
+				bad = NULL;
+			} else {
+				goto act_on_entry;
+			}
+		}
 		/*
 		 * We check if the paths are in the sparse-checkout
 		 * definition as a very final check, since that
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index dafe15b9cf..5d810f3af0 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -323,7 +323,7 @@ test_expect_success 'move clean path from in-cone to out-of-cone' '
 	grep -x "S folder1/d" actual
 '
 
-test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
+test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "sub/file1 overwrite" >sub/file1 &&
-- 
2.37.0

