Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51144C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjEBRYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjEBRYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 13:24:10 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846D1724
        for <git@vger.kernel.org>; Tue,  2 May 2023 10:24:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32951864ad9so10748965ab.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683048244; x=1685640244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ9eziWOuXqFO/FnpNKfWS0Om+KbVvAPW5lyQfujzww=;
        b=LgnnY/UFsPcqgbduxd85E6V2VgIG/upQXPzM2xKXhE74jVhArecJEAnLV/YujiGx++
         utO1Rq2HHNIyoUwrP0hp1ZZ0MxsFGyJ+O5twGp/H07ql6t+H2LQvuOnkFjASe2ayTi4x
         ZWY+5HWl5g9401CJd03LmOzxyEEmHXSCaKr+0qUV0zs/L0adpdmZpa2LEk32invFq9Qs
         /eTUMHUNIQIw0cy23F9g1DdRu+HvO9Oq38I7Y54ZitKLh2otrIUKCGDA4RFWBye9BGqY
         NQTB3dbMeetchWFBKDdE7n04PZz3VyBlGL1hbAWikf7jMLLOAwcAeK+mMYiXsNu6AVlq
         FnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048244; x=1685640244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ9eziWOuXqFO/FnpNKfWS0Om+KbVvAPW5lyQfujzww=;
        b=Wdotf8M4XLtakQDRgCnXoiE+kjdYfZDgbHRbxCOWi9d/jRzAamCYr82S4JijCPKX/H
         OWYxTxtYzSEZ4JLHvhAizH3oQk0MYa9wyixG4tnbxB/qbcfj7Nqrbb2g4unj0IOiLTU+
         V53/byhOGRGuOaR/zkAMySX8JY2joiQzmT4mIO3S8LFYEJiGBf3w+eHNSAf9P5UQ+evP
         78FVmrNwJ5HMSsQ//xOG8DJXWwGMrkuFNy+2Po74xEwB0bEkj3I7rrJuJBxqO+zmnP2z
         VTBtfUcoUOn/IKcwv0RNqj+YjlCb/fy67vxL/9+lMDv+h85EarMWbY+nlQOyhBaqM79a
         ZoUg==
X-Gm-Message-State: AC+VfDydXI7QSvw81KTWuwh50vfN0Jd53wgHzIhfiX8u9Ja7iz+B4CVM
        ravf1+mrhh/KqMjCGXGcne8fATnDuyI/oA==
X-Google-Smtp-Source: ACHHUZ5epnH8ZtMKdbslLe9FKDkVe9X/NX/ZKkozq7FyV4/2cz7OldV2Wd3QWA55UAGc8RVa1D3JHA==
X-Received: by 2002:a92:c088:0:b0:331:3564:7828 with SMTP id h8-20020a92c088000000b0033135647828mr1071281ile.26.1683048244568;
        Tue, 02 May 2023 10:24:04 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q19-20020a927513000000b0032b72b5c1c3sm8128217ilc.9.2023.05.02.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:24:04 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v9 2/2] diff-files: integrate with sparse index
Date:   Tue,  2 May 2023 13:23:35 -0400
Message-Id: <20230502172335.478312-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230502172335.478312-1-cheskaqiqi@gmail.com>
References: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
 <20230502172335.478312-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove full index requirement for `git diff-files`. Refactor the
ensure_expanded and ensure_not_expanded functions by introducing a
common helper function, ensure_index_state. Add test to ensure the index
is no expanded in `git diff-files`.

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
 t/t1092-sparse-checkout-compatibility.sh | 27 ++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

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
index 60d1de0662..29165b3493 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -129,5 +129,7 @@ test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
 test_perf_on_all git write-tree
 test_perf_on_all git describe --dirty
 test_perf_on_all 'echo >>new && git describe --dirty'
+test_perf_on_all git diff-files
+test_perf_on_all git diff-files $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 053435bb0c..333822f322 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1377,7 +1377,7 @@ test_expect_success 'index.sparse disabled inline uses full index' '
 	! test_region index ensure_full_index trace2.txt
 '
 
-ensure_not_expanded () {
+run_sparse_index_trace2 () {
 	rm -f trace2.txt &&
 	if test -z "$WITHOUT_UNTRACKED_TXT"
 	then
@@ -1397,7 +1397,16 @@ ensure_not_expanded () {
 			git -C sparse-index "$@" \
 			>sparse-index-out \
 			2>sparse-index-error || return 1
-	fi &&
+	fi
+}
+
+ensure_expanded () {
+	run_sparse_index_trace2 "$@" &&
+	test_region index ensure_full_index trace2.txt
+}
+
+ensure_not_expanded () {
+	run_sparse_index_trace2 "$@" &&
 	test_region ! index ensure_full_index trace2.txt
 }
 
@@ -2154,4 +2163,18 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_all_match git diff-files "folder*/a"
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
+	ensure_not_expanded diff-files &&
+	ensure_not_expanded diff-files deep/a &&
+	ensure_not_expanded diff-files "deep/*"
+'
+
 test_done
-- 
2.39.0

