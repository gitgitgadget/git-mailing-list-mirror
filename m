Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC60C678D5
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 01:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCIBdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 20:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCIBdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 20:33:37 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C15B42E
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 17:33:34 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i19so234199ila.10
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 17:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678325613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQCJGPv9JHXq4UZUXSy0z4+7pv1CRvwLGMQIMzerrKA=;
        b=HOBLtYCgro7gmdKHOst2OJ44ifa9zlCfWLpI970jBijVgOqTIlh6v2XPcEBKWn/d4l
         R43c9zHfFeZQHyRHHdtn9DlIzAkfncCLE4zeTPJhjDT6XWlKgGP+v1I2IMjQVDSsK8uw
         JMdLVuJmTtC2991EKddW+hmCXgs5KLmljbQPV/3DeaYsqjAjFhh4IqGA0AKbshGKVCDD
         7ifDanfz+c0aMpjC8/8VQXyp4iYHINKbuPTNPlfS7B/0lUnjDFJxqrSoHLX88lgyH6bI
         GwfUWleiyiedHkOqEpLbwwc9Eu/zUqFw5p8HL7RLZLYz48zy8EBCFbQ4f0yDTdj08CRs
         /84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678325613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQCJGPv9JHXq4UZUXSy0z4+7pv1CRvwLGMQIMzerrKA=;
        b=bP0mp7wyCMXHckfcHa0/pc0KDYwHz9dfu/CG8niKo39U73cmWpFnxN7u+VsnFlbZzc
         raaBRClmFcur1GiypEgQHg6t1SMIPqkQA6Jmegv7QI/FoBOvVeMuMBExIEylcIBFgcBN
         SNiEzoSYnbimEQDh8JUvMXFfwalzvuAc+mHIxouUKM3gIAY0H1RJcjvhXztWxGmVyV2V
         3wvj6iA0hvPeuq5Gcu809g+rgTWmM8Tqt8lwAxRm3H9x3f04h+bDaPKyMfAC/LH009q/
         i5b5aTSn5/76Cmo+32GLJ9JbLEUK4Ar5KG56hkpGknubk6sAowhD3kT2UACxLwjO+dpj
         V21g==
X-Gm-Message-State: AO0yUKX8OYNuXsT4fNBNdjPodUMo7HT2SEQ5YSzgXHX15zQ2p1vA5jd2
        VtFjfLCzmQy3LJmWYGFgTTJZKnmNIE4=
X-Google-Smtp-Source: AK7set+yp6ZYw3hLQF7eMB40C0WZi7QjrK+Qas7ww7P93auTPgsCiCojLxMmBeM0wwjlgo0+8VN5jQ==
X-Received: by 2002:a05:6e02:68b:b0:31d:a747:d386 with SMTP id o11-20020a056e02068b00b0031da747d386mr11025125ils.13.1678325613475;
        Wed, 08 Mar 2023 17:33:33 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id j4-20020a056e02124400b003153213c586sm4997828ilq.30.2023.03.08.17.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 17:33:33 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v3 2/2] diff-files: integrate with sparse index
Date:   Wed,  8 Mar 2023 20:33:14 -0500
Message-Id: <20230309013314.119128-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230309013314.119128-1-cheskaqiqi@gmail.com>
References: <20230307065813.77059-1-cheskaqiqi@gmail.com>
 <20230309013314.119128-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove full index requirement for `git diff-files`
and test to ensure the index is not expanded in `git diff-files`.

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
diff-files' and a ~97% execution time reduction for 'git diff-files'
for a file using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git diff-files (full-v3)              0.09    0.08 -11.1%
2000.79: git diff-files (full-v4)              0.09    0.09 +0.0%
2000.80: git diff-files (sparse-v3)            0.52    0.02 -96.2%
2000.81: git diff-files (sparse-v4)            0.51    0.02 -96.1%
2000.82: git diff-files f2/f4/a (full-v3)      0.06    0.07 +16.7%
2000.83: git diff-files f2/f4/a (full-v4)      0.08    0.08 +0.0%
2000.84: git diff-files f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
2000.85: git diff-files f2/f4/a (sparse-v4)    0.51    0.02 -96.1%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/diff-files.c                     |  4 ++++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753b..360464e6ef 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -27,6 +27,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..82751f2ca3 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git diff-files
+test_perf_on_all git diff-files $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index bdf3cf25d4..bc26c2b82a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2095,4 +2095,17 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_file_not_empty sparse-checkout-out
 '
 
+test_expect_success 'sparse index is not expanded: diff-files' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	ensure_not_expanded diff-files  &&
+	ensure_not_expanded diff-files deep/a 
+'
+
 test_done
-- 
2.39.0

