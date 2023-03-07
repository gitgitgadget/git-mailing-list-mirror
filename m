Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7CC678DB
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 06:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCGGpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 01:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 01:45:40 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ECD64A97
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 22:45:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s12so13351498qtq.11
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 22:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678171537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUBFFUBNNYjPzx5KTB0Bd98+/uo68GbIOSs+nmw9LhA=;
        b=DnO47qeYU3Cdt5hc1RvJKtjaG21s2nfo7KdtCam8+LoEan5HuiuX6a2aI46I6iLn+y
         pznwUqP/uWiLs23JZ65jfBwCDn0YCDEiTNJs08K60+hoyrW6T0W0ps1o5kLk3Uz88cTJ
         Jd9LvMqms/TxYNWikxP7hUH1gOsygCz64pgyVUkPM11gQ+mCCT164mj3HUdXNdF+aI3N
         K3pTom1k9RC4NDrFQiaGEXasMdxExJ0eeI4/hQJ1cRoQxeoHxRp9lZZJx/IIHYAZTTBx
         yWQ/72J5NbwSsv3pqyI7BYjlxeE23kKyS11MMme4m6WYORtE76ox1zZ6ic+1a+EBFMqe
         uoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678171537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUBFFUBNNYjPzx5KTB0Bd98+/uo68GbIOSs+nmw9LhA=;
        b=4JvTWkDSzTrkmMyVGKWeVyNHNOKZgqKZVLkU22TJarStew5UJF8GQGymv0G3aDDCxt
         aXTkUjBW6/4wjrc6xVfGDaJgTFEuEblmsBXXVg4RcNaRMCjpgH9QsdK71AlEKCkgot74
         +yIQlbiLr/j3Mvwtzb0H2J+0K4JAjaC2eFkLSQvKNVkGKWFIRf00oLhJnFBlLro6zQ6v
         NbJwkJPAip6EGzbIIl0u/PME4QQ9kl5p1Y7oRBQxcsOvyHgpRkSqyBl6fE9rOUlRD8Wl
         h04BIianLJwHlE/eNTB9hofYtwfpys2CMppe3tCOqth01VhTW3v6xpNERqZezwQti2Xf
         GfgA==
X-Gm-Message-State: AO0yUKVkMAQiG8YrWi5R87vg08pHWVRDrLKCTCCjWO3lfZUIFrN45PcO
        OcLYtDcQlA8e19Y9OoNRkyROACEqhO4=
X-Google-Smtp-Source: AK7set9EDV/Eo4o8WjLlfKLIxcQWrLqktzcemGZrGqEMsGuQw3cje49ptLjisOW8FKNiQLL5Juomuw==
X-Received: by 2002:ac8:570f:0:b0:3bf:b504:d5ec with SMTP id 15-20020ac8570f000000b003bfb504d5ecmr23481030qtw.42.1678171537717;
        Mon, 06 Mar 2023 22:45:37 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id r13-20020a05622a034d00b0039cc0fbdb61sm9452864qtw.53.2023.03.06.22.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:45:37 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [PATCH v2 2/2] diff-files: integrate with sparse index
Date:   Tue,  7 Mar 2023 01:45:06 -0500
Message-Id: <20230307064506.76663-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230307064506.76663-1-cheskaqiqi@gmail.com>
References: <20230307064506.76663-1-cheskaqiqi@gmail.com>
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
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
 3 files changed, 20 insertions(+)

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
index 9382428352..7cc02b882b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2093,4 +2093,18 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile
 '
 
+test_expect_success 'sparse index is not expanded: diff-files' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	ensure_not_expanded diff-files  &&
+	ensure_not_expanded diff-files deep/a &&
+	ensure_not_expanded diff-files --find-object=HEAD:a
+'
+
 test_done
-- 
2.39.0

