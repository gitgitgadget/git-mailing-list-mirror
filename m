Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AF6E95A9F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377134AbjJIQGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377122AbjJIQGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:06:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753692
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:06:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c131ddfeb8so53272341fa.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696867606; x=1697472406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyGYLuFukAPzdIjZveYEYl1mbX1qRmowPHlC5+v4IaM=;
        b=SduLe18SvDayE0wQoZI+kSyNVC/Mpf+Jp4MTk4cumgXKLmRdR2HecFZm29HhhTQMe0
         y5H5AHGQiVmZtw+ZNCESaYHQguIbPr+tbH3MrFv8ml/jRWTnkgo7ycSMhtUOXHP38+fo
         3XOSfBsStoJcNtCwGa9NpxNoPJs/AwwDXAKz88QYfLslR+EswDqYh9qQhlwdOa+ICY7Q
         Do3sM3w7EguebDhXq0l9+JRIwqnp3PCtqvcAEjvurvuXAXzyQvATv/IKvPSTJiDmKCyT
         fByfJlNVTxwFeN8g2nJ1HMmTxKPZ7EE/yeeGPWkxHKYEoqT0HGu4HgoPyVnZBUnhMdNG
         AxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867606; x=1697472406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyGYLuFukAPzdIjZveYEYl1mbX1qRmowPHlC5+v4IaM=;
        b=LvdGSwSxDNRnxO3fAjj+Wr0c2oFxZS85JbYaGuvLTZjbGyn+EZTEZFwHl9LygrRW8W
         rQ+QAwVrJC+OjU4QLdPMEwFxB9d9O9FGtX6FUhwG+fLOkqpIX1mtjXppnUndtdP8Uws+
         fIXpGBJerk8CywSV2o3xPiix9soCdAFOgtrxyXW1GE6H8cLSNRHIVP6YvsbAj+G1ZTAx
         OaXFEcc28eBFou2eGeWfsq6vGQHJygIc0t7xkhdjvmNprbEETelsQW/IV7GX/+blTyZX
         ov/1f6a/LvOo+FxZRunZjeaTb6YdiRhdCma3Y7icA7RCKhhWL0Q0q3L3rOiK2rVkYLqq
         kQcA==
X-Gm-Message-State: AOJu0YzisFLRmWyT3Xi+rAYOcCTn6el7DMb7jyKI3UGYbz8t7khfyE8l
        H1kxyQ/7Si9xEVTBFccSd23h2tpYTp4=
X-Google-Smtp-Source: AGHT+IFv/vUBMCgOmjpn9+r+FrbtLDk+7V3Cz9Kap55Gxe0SgeXW0kz80Vf2XkiTaJz5+8M+aT6A+w==
X-Received: by 2002:a2e:95d0:0:b0:2bf:7dac:a51 with SMTP id y16-20020a2e95d0000000b002bf7dac0a51mr13775962ljh.51.1696867605836;
        Mon, 09 Oct 2023 09:06:45 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j22-20020a2e8256000000b002b6daa3fa2csm2019715ljh.69.2023.10.09.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:06:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v4 2/3] diff-merges: introduce '--dd' option
Date:   Mon,  9 Oct 2023 19:05:34 +0300
Message-Id: <20231009160535.236523-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231009160535.236523-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20231009160535.236523-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option provides a shortcut to request diff with respect to first
parent for any kind of commit, universally. It's implemented as pure
synonym for "--diff-merges=first-parent --patch".

Gives user quick and universal way to see what changes, exactly, were
brought to a branch by merges as well as by regular commits.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 5 +++++
 Documentation/git-log.txt      | 2 +-
 diff-merges.c                  | 3 +++
 t/t4013-diff-various.sh        | 8 ++++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 69065c0e90a8..23f95e6172b9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -56,6 +56,11 @@ ifdef::git-log[]
 	Produce dense combined diff output for merge commits.
 	Shortcut for '--diff-merges=dense-combined -p'.
 
+--dd::
+	Produce diff with respect to first parent for both merge and
+	regular commits.
+	Shortcut for '--diff-merges=first-parent -p'.
+
 --remerge-diff::
 	Produce remerge-diff output for merge commits.
 	Shortcut for '--diff-merges=remerge -p'.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9b7ec96e767a..579682172fe4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,7 +120,7 @@ By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
 Note that unless one of `--diff-merges` variants (including short
-`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+`-m`, `-c`, `--cc`, and `--dd` options) is explicitly given, merge commits
 will not show a diff, even if a diff format like `--patch` is
 selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
diff --git a/diff-merges.c b/diff-merges.c
index ec97616db1df..45507588a279 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -131,6 +131,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
 		revs->merges_imply_patch = 1;
+	} else if (!strcmp(arg, "--dd")) {
+		set_first_parent(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--remerge-diff")) {
 		set_remerge_diff(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759f..4b474808311e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -473,6 +473,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'log --dd matches --diff-merges=1 -p' '
+	git log --diff-merges=1 -p master >result &&
+	process_diffs result >expected &&
+	git log --dd master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'deny wrong log.diffMerges config' '
 	test_config log.diffMerges wrong-value &&
 	test_expect_code 128 git log
-- 
2.25.1

