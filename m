Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD6C433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF8E64DBD
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBKCAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhBKB43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:56:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D8C0613D6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j11so3549052wmi.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PJXYj1sH1R0vugeo3ynH4OM6GcLHdOOAnICy4DrwDg=;
        b=QbThB0OYkCGjSm8gJuoP4mudDo4F/zrLxjC+iX0wqNy8X7aAlhzVONw+3SAcX/1X81
         UdsCNouFbYGTQLu/ejsb25kLRCsCzh/cat71bgf+3mfd1QDlhyQo4p+AAjDSpvV5rdPO
         aNW4lIAQMpJvK/Il7HNLFEKJhpgNy+iKAg2+NIrlWmwHz9Ke5lnVQpONGhPt370knzPz
         OZ4VFhDUeT9HwTt1UPF9acu42yR8culUJ1ZTbUFgz8qOcaK3/262SQ4sbb9fKLro/E/K
         yTdAisjNRorpoCdyhFCqHcvwTEUJFH+cwI7nYgSnzd7sw3n7ITrBre3Ye5S9BgyU8IAX
         Hk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PJXYj1sH1R0vugeo3ynH4OM6GcLHdOOAnICy4DrwDg=;
        b=QxGVUrmXkR+H4AjiNJO7ijvcTBiGpqHSpY8kRdetvclCQXHUHCOmZPv1zQ1v7Qxofx
         /QkM4z7LstgVlWybtMgVipLnrdyXyr9vlg/Ezo2UwuahO47GiiJhbqiSJ/X6UCg392Y4
         M3izUpiCtCC1862rUMXOnUzYeBl1SwqCrGzSegptFIpSn2HtjU0ojrew5Q/LTFiwu8YR
         CjtOOw4HV17ZD1M/YJyuKf299BXqQd+5jTPcic/ww/cxc1p4v/uB2y22jAbcXZ4PUwz0
         M7zRewBiXaqTWWxsaPfx8LKGDWa9iJzkDTGgHVeM8mMHxZ/Np3IPPH7yA2bRLdy6mNIA
         gmbQ==
X-Gm-Message-State: AOAM532ZNrvl1glFg1F6QSVFB9IabaxD5odafuxgDkcmkW6eHSd1dT2E
        GvRDRzr0aESqRRURvBoT2qmdIcuZQiO1sw==
X-Google-Smtp-Source: ABdhPJwKh3x68bJaXKfFcGP9jqhAnUHkoQWNI7qsFyobC2KkfhBh+adndKbBVS8qOaoDwRDL7Cqgrg==
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr2156169wmq.47.1613008451256;
        Wed, 10 Feb 2021 17:54:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2sm5362486wml.34.2021.02.10.17.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:54:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] tests: remove most uses of test_i18ncmp
Date:   Thu, 11 Feb 2021 02:53:53 +0100
Message-Id: <20210211015353.28680-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210120182759.31102-1-avarab@gmail.com>
References: <20210120182759.31102-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to d162b25f956 (tests: remove support for
GIT_TEST_GETTEXT_POISON, 2021-01-20) remove most uses of test_i18ncmp
via a simple s/test_i18ncmp/test_cmp/g search-replacement.

I'm leaving t6300-for-each-ref.sh out due to a conflict with in-flight
changes between "master" and "seen", as well as the prerequisite
itself due to other changes between "master" and "next/seen" which add
new test_i18ncmp uses.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-credential.sh                       |   2 +-
 t/lib-log-graph.sh                        |   4 +-
 t/t0006-date.sh                           |   4 +-
 t/t0008-ignores.sh                        |   2 +-
 t/t0012-help.sh                           |   2 +-
 t/t0018-advice.sh                         |   4 +-
 t/t0027-auto-crlf.sh                      |   2 +-
 t/t0040-parse-options.sh                  |   8 +-
 t/t0201-gettext-fallbacks.sh              |  14 +--
 t/t0300-credentials.sh                    |   8 +-
 t/t0500-progress-display.sh               |  22 ++---
 t/t1011-read-tree-sparse-checkout.sh      |   2 +-
 t/t1308-config-set.sh                     |   4 +-
 t/t1400-update-ref.sh                     |   6 +-
 t/t1404-update-ref-errors.sh              |   2 +-
 t/t1450-fsck.sh                           |   6 +-
 t/t1502-rev-parse-parseopt.sh             |  10 +-
 t/t1506-rev-parse-diagnosis.sh            |   2 +-
 t/t1507-rev-parse-upstream.sh             |  10 +-
 t/t1509-root-work-tree.sh                 |   4 +-
 t/t1600-index.sh                          |   6 +-
 t/t2018-checkout-branch.sh                |   2 +-
 t/t2020-checkout-detach.sh                |  20 ++--
 t/t2200-add-update.sh                     |   2 +-
 t/t2401-worktree-prune.sh                 |   4 +-
 t/t2402-worktree-list.sh                  |   2 +-
 t/t3005-ls-files-relative.sh              |   4 +-
 t/t3200-branch.sh                         |  26 ++---
 t/t3201-branch-contains.sh                |   2 +-
 t/t3203-branch-output.sh                  |  28 +++---
 t/t3300-funny-names.sh                    |   2 +-
 t/t3400-rebase.sh                         |   2 +-
 t/t3404-rebase-interactive.sh             |  24 ++---
 t/t3420-rebase-autostash.sh               |   4 +-
 t/t3504-cherry-pick-rerere.sh             |   4 +-
 t/t3507-cherry-pick-conflict.sh           |  12 +--
 t/t3508-cherry-pick-many-commits.sh       |   4 +-
 t/t3510-cherry-pick-sequence.sh           |   8 +-
 t/t3600-rm.sh                             |  16 ++--
 t/t3700-add.sh                            |   8 +-
 t/t3701-add-interactive.sh                |   2 +-
 t/t3903-stash.sh                          |   8 +-
 t/t3905-stash-include-untracked.sh        |   2 +-
 t/t4006-diff-mode.sh                      |   8 +-
 t/t4012-diff-binary.sh                    |   6 +-
 t/t4013-diff-various.sh                   |   2 +-
 t/t4014-format-patch.sh                   |   6 +-
 t/t4016-diff-quote.sh                     |   2 +-
 t/t4030-diff-textconv.sh                  |   2 +-
 t/t4045-diff-relative.sh                  |   2 +-
 t/t4049-diff-stat-count.sh                |   6 +-
 t/t4100-apply-stat.sh                     |   4 +-
 t/t4150-am.sh                             |   2 +-
 t/t4153-am-resume-override-opts.sh        |   2 +-
 t/t4205-log-pretty-formats.sh             |   2 +-
 t/t4254-am-corrupt.sh                     |   2 +-
 t/t5150-request-pull.sh                   |   4 +-
 t/t5316-pack-delta-depth.sh               |   4 +-
 t/t5500-fetch-pack.sh                     |   6 +-
 t/t5505-remote.sh                         |  24 ++---
 t/t5510-fetch.sh                          |   2 +-
 t/t5512-ls-remote.sh                      |   2 +-
 t/t5526-fetch-submodules.sh               |  38 ++++----
 t/t5541-http-push-smart.sh                |   2 +-
 t/t6020-bundle-misc.sh                    |  28 +++---
 t/t6030-bisect-porcelain.sh               |   4 +-
 t/t6040-tracking-info.sh                  |  22 ++---
 t/t6120-describe.sh                       |   2 +-
 t/t6134-pathspec-in-submodule.sh          |   2 +-
 t/t6301-for-each-ref-errors.sh            |  10 +-
 t/t6436-merge-overwrite.sh                |   4 +-
 t/t6439-merge-co-error-msgs.sh            |  12 +--
 t/t7001-mv.sh                             |   2 +-
 t/t7004-tag.sh                            |   8 +-
 t/t7012-skip-worktree-writing.sh          |   4 +-
 t/t7060-wtstatus.sh                       |  14 +--
 t/t7063-status-untracked-cache.sh         |   2 +-
 t/t7102-reset.sh                          |   6 +-
 t/t7400-submodule-basic.sh                |   4 +-
 t/t7401-submodule-summary.sh              |  12 +--
 t/t7406-submodule-update.sh               |  16 ++--
 t/t7407-submodule-foreach.sh              |  10 +-
 t/t7500-commit-template-squash-signoff.sh |   4 +-
 t/t7502-commit-porcelain.sh               |   6 +-
 t/t7508-status.sh                         | 110 +++++++++++-----------
 t/t7512-status-help.sh                    |  74 +++++++--------
 t/t7519-status-fsmonitor.sh               |   4 +-
 t/t7521-ignored-mode.sh                   |  22 ++---
 t/t7600-merge.sh                          |   4 +-
 t/t7602-merge-octopus-many.sh             |   6 +-
 90 files changed, 415 insertions(+), 415 deletions(-)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index dea2cbef517..5ea8bc9f1dc 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -20,7 +20,7 @@ check() {
 		false
 	fi &&
 	test_cmp expect-stdout stdout &&
-	test_i18ncmp expect-stderr stderr
+	test_cmp expect-stderr stderr
 }
 
 read_chunk() {
diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index 1184cceef26..bf952ef9204 100644
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -12,13 +12,13 @@ sanitize_log_output () {
 lib_test_cmp_graph () {
 	git log --graph "$@" >output &&
 	sed 's/ *$//' >output.sanitized <output &&
-	test_i18ncmp expect output.sanitized
+	test_cmp expect output.sanitized
 }
 
 lib_test_cmp_short_graph () {
 	git log --graph --pretty=short "$@" >output &&
 	sanitize_log_output >output.sanitized <output &&
-	test_i18ncmp expect output.sanitized
+	test_cmp expect output.sanitized
 }
 
 lib_test_cmp_colored_graph () {
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 75ee9a96b80..6b757d71692 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -11,7 +11,7 @@ check_relative() {
 	echo "$t -> $2" >expect
 	test_expect_${3:-success} "relative date ($2)" "
 	test-tool date relative $t >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 	"
 }
 
@@ -139,7 +139,7 @@ check_date_format_human() {
 	echo "$t -> $2" >expect
 	test_expect_success "human date $t" '
 		test-tool date human $t >actual &&
-		test_i18ncmp expect actual
+		test_cmp expect actual
 '
 }
 
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 370a389e5c5..f7abde62f63 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -34,7 +34,7 @@ expect_from_stdin () {
 test_stderr () {
 	expected="$1"
 	expect_in stderr "$1" &&
-	test_i18ncmp "$HOME/expected-stderr" "$HOME/stderr"
+	test_cmp "$HOME/expected-stderr" "$HOME/stderr"
 }
 
 broken_c_unquote () {
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index e8ef7300ecb..5679e29c624 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -55,7 +55,7 @@ test_expect_success "--help does not work for guides" "
 		git: 'revisions' is not a git command. See 'git --help'.
 	EOF
 	test_must_fail git revisions --help 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 "
 
 test_expect_success 'git help' '
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index e03554d2f34..39e5e4b34f8 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -10,7 +10,7 @@ test_expect_success 'advice should be printed when config variable is unset' '
 	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	test-tool advise "This is a piece of advice" 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'advice should be printed when config variable is set to true' '
@@ -20,7 +20,7 @@ test_expect_success 'advice should be printed when config variable is set to tru
 	EOF
 	test_config advice.nestedTag true &&
 	test-tool advise "This is a piece of advice" 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'advice should not be printed when config variable is set to false' '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 51f74a3ddf3..d24d5acfbc7 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -83,7 +83,7 @@ check_warning () {
 	*) echo >&2 "Illegal 1": "$1" ; return false ;;
 	esac
 	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" | uniq  >"$2".actual
-	test_i18ncmp "$2".expect "$2".actual
+	test_cmp "$2".expect "$2".actual
 }
 
 commit_check_warn () {
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 14cafc138b7..ad4746d899a 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -61,7 +61,7 @@ EOF
 test_expect_success 'test help' '
 	test_must_fail test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 mv expect expect.err
@@ -84,7 +84,7 @@ check_unknown_i18n() {
 	cat expect.err >>expect &&
 	test_must_fail test-tool parse-options $* >output 2>output.err &&
 	test_must_be_empty output &&
-	test_i18ncmp expect output.err
+	test_cmp expect output.err
 }
 
 test_expect_success 'OPT_BOOL() #1' 'check boolean: 1 --yes'
@@ -250,7 +250,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	test_must_fail test-tool parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
-	test_i18ncmp typo.err output.err
+	test_cmp typo.err output.err
 '
 
 cat >typo.err <<\EOF
@@ -260,7 +260,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	test_must_fail test-tool parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
-	test_i18ncmp typo.err output.err
+	test_cmp typo.err output.err
 '
 
 test_expect_success 'keep some options as arguments' '
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index a7b3e4a2c73..6c74df0dc67 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -27,25 +27,25 @@ test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallthrough' '
 test_expect_success 'gettext: our gettext() fallback has pass-through semantics' '
     printf "test" >expect &&
     gettext "test" >actual &&
-    test_i18ncmp expect actual &&
+    test_cmp expect actual &&
     printf "test more words" >expect &&
     gettext "test more words" >actual &&
-    test_i18ncmp expect actual
+    test_cmp expect actual
 '
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback has pass-through semantics' '
     printf "test" >expect &&
     eval_gettext "test" >actual &&
-    test_i18ncmp expect actual &&
+    test_cmp expect actual &&
     printf "test more words" >expect &&
     eval_gettext "test more words" >actual &&
-    test_i18ncmp expect actual
+    test_cmp expect actual
 '
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables' '
     printf "test YesPlease" >expect &&
     GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=YesPlease eval_gettext "test \$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" >actual &&
-    test_i18ncmp expect actual
+    test_cmp expect actual
 '
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables with spaces' '
@@ -53,7 +53,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
     export cmdline &&
     printf "When you have resolved this problem, run git am --resolved." >expect &&
     eval_gettext "When you have resolved this problem, run \$cmdline --resolved." >actual &&
-    test_i18ncmp expect actual
+    test_cmp expect actual
 '
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables with spaces and quotes' '
@@ -61,7 +61,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
     export cmdline &&
     printf "When you have resolved this problem, run \"git am --resolved\"." >expect &&
     eval_gettext "When you have resolved this problem, run \"\$cmdline --resolved\"." >actual &&
-    test_i18ncmp expect actual
+    test_cmp expect actual
 '
 
 test_done
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index a18f8a473bf..3485c0534e6 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -578,7 +578,7 @@ test_expect_success 'helpers can abort the process' '
 	quit: host=example.com
 	fatal: credential helper '\''quit'\'' told us to quit
 	EOF
-	test_i18ncmp expect stderr
+	test_cmp expect stderr
 '
 
 test_expect_success 'empty helper spec resets helper list' '
@@ -606,7 +606,7 @@ test_expect_success 'url parser rejects embedded newlines' '
 	warning: url contains a newline in its path component: https://one.example.com?%0ahost=two.example.com/
 	fatal: credential url cannot be parsed: https://one.example.com?%0ahost=two.example.com/
 	EOF
-	test_i18ncmp expect stderr
+	test_cmp expect stderr
 '
 
 test_expect_success 'host-less URLs are parsed as empty host' '
@@ -633,7 +633,7 @@ test_expect_success 'credential system refuses to work with missing host' '
 	cat >expect <<-\EOF &&
 	fatal: refusing to work with credential missing host field
 	EOF
-	test_i18ncmp expect stderr
+	test_cmp expect stderr
 '
 
 test_expect_success 'credential system refuses to work with missing protocol' '
@@ -643,7 +643,7 @@ test_expect_success 'credential system refuses to work with missing protocol' '
 	cat >expect <<-\EOF &&
 	fatal: refusing to work with credential missing protocol field
 	EOF
-	test_i18ncmp expect stderr
+	test_cmp expect stderr
 '
 
 # usage: check_host_and_path <url> <expected-host> <expected-path>
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 84cce345e7d..22058b503ac 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -29,7 +29,7 @@ test_expect_success 'simple progress display' '
 	test-tool progress "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display with total' '
@@ -48,7 +48,7 @@ test_expect_success 'progress display with total' '
 	test-tool progress --total=3 "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display breaks long lines #1' '
@@ -72,7 +72,7 @@ EOF
 		<in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display breaks long lines #2' '
@@ -100,7 +100,7 @@ EOF
 		<in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display breaks long lines #3 - even the first is too long' '
@@ -126,7 +126,7 @@ EOF
 		<in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display breaks long lines #4 - title line matches terminal width' '
@@ -150,7 +150,7 @@ EOF
 		<in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 # Progress counter goes backwards, this should not happen in practice.
@@ -172,7 +172,7 @@ test_expect_success 'progress shortens - crazy caller' '
 	test-tool progress --total=1000 "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display with throughput' '
@@ -201,7 +201,7 @@ test_expect_success 'progress display with throughput' '
 	test-tool progress "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress display with throughput and total' '
@@ -226,7 +226,7 @@ test_expect_success 'progress display with throughput and total' '
 	test-tool progress --total=40 "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'cover up after throughput shortens' '
@@ -255,7 +255,7 @@ test_expect_success 'cover up after throughput shortens' '
 	test-tool progress "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'cover up after throughput shortens a lot' '
@@ -280,7 +280,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	test-tool progress "Working hard" <in 2>stderr &&
 
 	show_cr <stderr >out &&
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'progress generates traces' '
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index dfe9794a740..24092c09a95 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -253,7 +253,7 @@ warning: The following paths were already present and thus not updated despite s
 
 After fixing the above paths, you may want to run `git sparse-checkout reapply`.
 EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'checkout without --ignore-skip-worktree-bits' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3a527e3a843..88b119a0a35 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -208,14 +208,14 @@ test_expect_success 'proper error on error in default config files' '
 	echo "[" >>.git/config &&
 	echo "fatal: bad config line 34 in file .git/config" >expect &&
 	test_expect_code 128 test-tool config get_value foo.bar 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'proper error on error in custom config files' '
 	echo "[" >>syntax-error &&
 	echo "fatal: bad config line 1 in file syntax-error" >expect &&
 	test_expect_code 128 test-tool config configset_get_value foo.bar syntax-error 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'check line errors for malformed values' '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 359d8731c8f..e31f65f381c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -374,7 +374,7 @@ test_expect_success 'Query "main@{May 25 2005}" (before history)' '
 	echo "$C" >expect &&
 	test_cmp expect o &&
 	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
-	test_i18ncmp expect e
+	test_cmp expect e
 '
 test_expect_success 'Query main@{2005-05-25} (before history)' '
 	test_when_finished "rm -f o e" &&
@@ -382,7 +382,7 @@ test_expect_success 'Query main@{2005-05-25} (before history)' '
 	echo "$C" >expect &&
 	test_cmp expect o &&
 	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
-	test_i18ncmp expect e
+	test_cmp expect e
 '
 test_expect_success 'Query "main@{May 26 2005 23:31:59}" (1 second before history)' '
 	test_when_finished "rm -f o e" &&
@@ -390,7 +390,7 @@ test_expect_success 'Query "main@{May 26 2005 23:31:59}" (1 second before histor
 	echo "$C" >expect &&
 	test_cmp expect o &&
 	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
-	test_i18ncmp expect e
+	test_cmp expect e
 '
 test_expect_success 'Query "main@{May 26 2005 23:32:00}" (exactly history start)' '
 	test_when_finished "rm -f o e" &&
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 2d142e5535e..8b51c4efc13 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -101,7 +101,7 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_i18ncmp expected-err output.err &&
+	test_cmp expected-err output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
 	test_cmp expected-refs actual-refs
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a30fc5f74a9..f3241e0e7e2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -380,7 +380,7 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	warning in tag $tag: badTagName: invalid '\''tag'\'' name: wrong name format
 	warning in tag $tag: missingTaggerEntry: invalid format - expected '\''tagger'\'' line
 	EOF
-	test_i18ncmp expect out
+	test_cmp expect out
 '
 
 test_expect_success 'tag with bad tagger' '
@@ -806,7 +806,7 @@ test_expect_success 'fsck notices dangling objects' '
 		git fsck >actual &&
 		# the output order is non-deterministic, as it comes from a hash
 		sort <actual >actual.sorted &&
-		test_i18ncmp expect actual.sorted
+		test_cmp expect actual.sorted
 	)
 '
 
@@ -816,7 +816,7 @@ test_expect_success 'fsck --connectivity-only notices dangling objects' '
 		git fsck --connectivity-only >actual &&
 		# the output order is non-deterministic, as it comes from a hash
 		sort <actual >actual.sorted &&
-		test_i18ncmp expect actual.sorted
+		test_cmp expect actual.sorted
 	)
 '
 
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index a859abedf58..b29563fc997 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -95,7 +95,7 @@ test_expect_success 'test --parseopt help output' '
 |EOF
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'test --parseopt help output no switches' '
@@ -108,7 +108,7 @@ test_expect_success 'test --parseopt help output no switches' '
 |EOF
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'test --parseopt help output hidden switches' '
@@ -121,7 +121,7 @@ test_expect_success 'test --parseopt help output hidden switches' '
 |EOF
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'test --parseopt help-all output hidden switches' '
@@ -136,7 +136,7 @@ test_expect_success 'test --parseopt help-all output hidden switches' '
 |EOF
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- --help-all > output < optionspec_only_hidden_switches &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'test --parseopt invalid switch help output' '
@@ -176,7 +176,7 @@ test_expect_success 'test --parseopt invalid switch help output' '
 |
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- --does-not-exist 1>/dev/null 2>output < optionspec &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'setup expect.1' "
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index f6e6f23f7e6..65a154a8a20 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -15,7 +15,7 @@ test_did_you_mean ()
 	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
 	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
 	EOF
-	test_i18ncmp expected error
+	test_cmp expected error
 }
 
 HASH_file=
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 73b4f34c6ee..c34714ffe3f 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -172,7 +172,7 @@ test_expect_success 'branch@{u} error message when no upstream' '
 	fatal: no upstream configured for branch ${SQ}non-tracking${SQ}
 	EOF
 	error_message non-tracking@{u} &&
-	test_i18ncmp expect error
+	test_cmp expect error
 '
 
 test_expect_success '@{u} error message when no upstream' '
@@ -180,7 +180,7 @@ test_expect_success '@{u} error message when no upstream' '
 	fatal: no upstream configured for branch ${SQ}main${SQ}
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'branch@{u} error message with misspelt branch' '
@@ -188,7 +188,7 @@ test_expect_success 'branch@{u} error message with misspelt branch' '
 	fatal: no such branch: ${SQ}no-such-branch${SQ}
 	EOF
 	error_message no-such-branch@{u} &&
-	test_i18ncmp expect error
+	test_cmp expect error
 '
 
 test_expect_success '@{u} error message when not on a branch' '
@@ -197,7 +197,7 @@ test_expect_success '@{u} error message when not on a branch' '
 	EOF
 	git checkout HEAD^0 &&
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'branch@{u} error message if upstream branch not fetched' '
@@ -205,7 +205,7 @@ test_expect_success 'branch@{u} error message if upstream branch not fetched' '
 	fatal: upstream branch ${SQ}refs/heads/side${SQ} not stored as a remote-tracking branch
 	EOF
 	error_message bad-upstream@{u} &&
-	test_i18ncmp expect error
+	test_cmp expect error
 '
 
 test_expect_success 'pull works when tracking a local branch' '
diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
index fd2f7abf1c1..553a3f601ba 100755
--- a/t/t1509-root-work-tree.sh
+++ b/t/t1509-root-work-tree.sh
@@ -221,7 +221,7 @@ test_expect_success 'setup' '
 	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
-	test_i18ncmp expected result
+	test_cmp expected result
 '
 
 test_vars 'auto gitdir, root' ".git" "/" ""
@@ -246,7 +246,7 @@ test_expect_success 'setup' '
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-	test_i18ncmp expected result
+	test_cmp expected result
 '
 
 test_vars 'auto gitdir, root' "." "" ""
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index b7c31aa86a1..c9b9e718b89 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -18,7 +18,7 @@ test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
 			Using version Z
 		EOF
-		test_i18ncmp expect.err actual.err
+		test_cmp expect.err actual.err
 	)
 '
 
@@ -32,7 +32,7 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
 			Using version Z
 		EOF
-		test_i18ncmp expect.err actual.err
+		test_cmp expect.err actual.err
 	)
 '
 
@@ -55,7 +55,7 @@ test_expect_success 'out of bounds index.version issues warning' '
 			warning: index.version set, but the value is invalid.
 			Using version Z
 		EOF
-		test_i18ncmp expect.err actual.err
+		test_cmp expect.err actual.err
 	)
 '
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 5f761bc616e..93be1c0eae5 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -150,7 +150,7 @@ test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
 	git checkout branch2 &&
 	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
 	test_must_fail git checkout -b @{-1} 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index b432b6427b6..bc46713a43e 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -163,7 +163,7 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	git config branch.child.merge refs/heads/main &&
 	git checkout child^ &&
 	git checkout child >stdout &&
-	test_i18ncmp expect stdout
+	test_cmp expect stdout
 '
 
 test_expect_success 'no advice given for explicit detached head state' '
@@ -237,15 +237,15 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 	sane_unset GIT_PRINT_SHA1_ELLIPSIS &&
 	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 1st_detach actual &&
+	test_cmp 1st_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS="no" git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 2nd_detach actual &&
+	test_cmp 2nd_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS= git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 3rd_detach actual &&
+	test_cmp 3rd_detach actual &&
 
 	sane_unset GIT_PRINT_SHA1_ELLIPSIS &&
 
@@ -256,17 +256,17 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 	# Make no mention of the env var at all
 	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 1st_detach actual &&
+	test_cmp 1st_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS='nope' &&
 	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 2nd_detach actual &&
+	test_cmp 2nd_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS=nein &&
 	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 3rd_detach actual &&
+	test_cmp 3rd_detach actual &&
 
 	true
 "
@@ -319,15 +319,15 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 
 	GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 1st_detach actual &&
+	test_cmp 1st_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS=Yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 2nd_detach actual &&
+	test_cmp 2nd_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS=YES git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
-	test_i18ncmp 3rd_detach actual &&
+	test_cmp 3rd_detach actual &&
 
 	true
 "
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 7cb7a703827..45ca35d60ac 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -135,7 +135,7 @@ test_expect_success 'add -n -u should not add but just report' '
 	after=$(git ls-files -s check top) &&
 
 	test "$before" = "$after" &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index aff877590df..a615d3b4838 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -23,7 +23,7 @@ test_expect_success 'prune files inside $GIT_DIR/worktrees' '
 	cat >expect <<EOF &&
 Removing worktrees/abc: not a valid directory
 EOF
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	! test -f .git/worktrees/abc &&
 	! test -d .git/worktrees
 '
@@ -35,7 +35,7 @@ test_expect_success 'prune directories without gitdir' '
 Removing worktrees/def: gitdir file does not exist
 EOF
 	git worktree prune --verbose >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
 '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 42d35d9ae82..fedcefe8de3 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -167,7 +167,7 @@ test_expect_success '"list" all worktrees --verbose with prunable' '
 	rm -rf prunable &&
 	git worktree list --verbose >out &&
 	sed -n "s/  */ /g;/\/prunable  *[0-9a-f].*$/,/prunable: .*$/p" <out >actual &&
-	test_i18ncmp actual expect
+	test_cmp actual expect
 '
 
 test_expect_success 'bare repo setup' '
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 2ec69a8a266..727e9ae1a44 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -46,7 +46,7 @@ test_expect_success 'ls-files -c' '
 		ls ../x* >expect.out &&
 		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual.out 2>actual.err &&
 		test_cmp expect.out actual.out &&
-		test_i18ncmp expect.err actual.err
+		test_cmp expect.err actual.err
 	)
 '
 
@@ -61,7 +61,7 @@ test_expect_success 'ls-files -o' '
 		ls ../y* >expect.out &&
 		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual.out 2>actual.err &&
 		test_cmp expect.out actual.out &&
-		test_i18ncmp expect.err actual.err
+		test_cmp expect.err actual.err
 	)
 '
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 00761e40801..cc4b10236e2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -695,7 +695,7 @@ test_expect_success 'deleting a symref' '
 	git branch -d symref >actual &&
 	test_path_is_file .git/refs/heads/target &&
 	test_path_is_missing .git/refs/heads/symref &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'deleting a dangling symref' '
@@ -704,7 +704,7 @@ test_expect_success 'deleting a dangling symref' '
 	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
 	git branch -d dangling-symref >actual &&
 	test_path_is_missing .git/refs/heads/dangling-symref &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'deleting a self-referential symref' '
@@ -713,7 +713,7 @@ test_expect_success 'deleting a self-referential symref' '
 	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
 	git branch -d self-reference >actual &&
 	test_path_is_missing .git/refs/heads/self-reference &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'renaming a symref is not allowed' '
@@ -808,7 +808,7 @@ test_expect_success 'test deleting branch without config' '
 	sha1=$(git rev-parse my7 | cut -c 1-7) &&
 	echo "Deleted branch my7 (was $sha1)." >expect &&
 	git branch -d my7 >actual 2>&1 &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'deleting currently checked out branch fails' '
@@ -843,7 +843,7 @@ test_expect_success 'branch from tag w/--track causes failure' '
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
 	test_must_fail git branch --set-upstream-to main a b c 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on detached HEAD' '
@@ -851,13 +851,13 @@ test_expect_success '--set-upstream-to fails on detached HEAD' '
 	test_when_finished git checkout - &&
 	echo "fatal: could not set upstream of HEAD to main when it does not point to any branch." >expect &&
 	test_must_fail git branch --set-upstream-to main 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
 	echo "fatal: branch '"'"'does-not-exist'"'"' does not exist" >expect &&
 	test_must_fail git branch --set-upstream-to main does-not-exist 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing src branch' '
@@ -868,7 +868,7 @@ test_expect_success '--set-upstream-to fails on a missing src branch' '
 test_expect_success '--set-upstream-to fails on a non-ref' '
 	echo "fatal: Cannot setup tracking information; starting point '"'"'HEAD^{}'"'"' is not a branch." >expect &&
 	test_must_fail git branch --set-upstream-to HEAD^{} 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on locked config' '
@@ -899,7 +899,7 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
 	echo "fatal: Branch '"'"'i-dont-exist'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream i-dont-exist 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--unset-upstream should fail if config is locked' '
@@ -921,13 +921,13 @@ test_expect_success 'test --unset-upstream on HEAD' '
 	# fail for a branch without upstream set
 	echo "fatal: Branch '"'"'main'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--unset-upstream should fail on multiple branches' '
 	echo "fatal: too many arguments to unset upstream" >expect &&
 	test_must_fail git branch --unset-upstream a b c 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success '--unset-upstream should fail on detached HEAD' '
@@ -935,7 +935,7 @@ test_expect_success '--unset-upstream should fail on detached HEAD' '
 	test_when_finished git checkout - &&
 	echo "fatal: could not unset upstream of HEAD when it does not point to any branch." >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
-	test_i18ncmp expect err
+	test_cmp expect err
 '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
@@ -957,7 +957,7 @@ test_expect_success '--set-upstream-to notices an error to set branch as own ups
 	EOF
 	test_expect_code 1 git config branch.my13.remote &&
 	test_expect_code 1 git config branch.my13.merge &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 # Keep this test last, as it changes the current branch
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 578b5f48255..349a810cee1 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -264,7 +264,7 @@ test_expect_success 'branch --merged with --verbose' '
 	* topic $(git rev-parse --short topic ) [ahead 1] foo
 	  zzz   $(git rev-parse --short zzz   ) second on main
 	EOF
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index b6fcd017afe..5325b9f67a0 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -160,7 +160,7 @@ test_expect_success 'git branch shows detached HEAD properly' '
 EOF
 	git checkout HEAD^0 &&
 	git branch >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch shows detached HEAD properly after checkout --detach' '
@@ -173,7 +173,7 @@ test_expect_success 'git branch shows detached HEAD properly after checkout --de
 EOF
 	git checkout --detach &&
 	git branch >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch shows detached HEAD properly after moving' '
@@ -185,7 +185,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving' '
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch shows detached HEAD properly from tag' '
@@ -198,7 +198,7 @@ EOF
 	git tag fromtag main &&
 	git checkout fromtag &&
 	git branch >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch shows detached HEAD properly after moving from tag' '
@@ -210,7 +210,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving from t
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch `--sort=[-]objectsize` option' '
@@ -221,7 +221,7 @@ test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	  main
 	EOF
 	git branch --sort=objectsize >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
 	* (HEAD detached from fromtag)
@@ -230,7 +230,7 @@ test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	  branch-two
 	EOF
 	git branch --sort=-objectsize >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch `--sort=[-]type` option' '
@@ -241,7 +241,7 @@ test_expect_success 'git branch `--sort=[-]type` option' '
 	  main
 	EOF
 	git branch --sort=type >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
 	* (HEAD detached from fromtag)
@@ -250,7 +250,7 @@ test_expect_success 'git branch `--sort=[-]type` option' '
 	  main
 	EOF
 	git branch --sort=-type >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch `--sort=[-]version:refname` option' '
@@ -261,7 +261,7 @@ test_expect_success 'git branch `--sort=[-]version:refname` option' '
 	  main
 	EOF
 	git branch --sort=version:refname >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
 	* (HEAD detached from fromtag)
@@ -270,7 +270,7 @@ test_expect_success 'git branch `--sort=[-]version:refname` option' '
 	  branch-one
 	EOF
 	git branch --sort=-version:refname >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch --points-at option' '
@@ -337,7 +337,7 @@ test_expect_success 'git branch --format option' '
 	Refname is refs/heads/ref-to-remote
 	EOF
 	git branch --format="Refname is %(refname)" >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'worktree colors correct' '
@@ -355,7 +355,7 @@ test_expect_success 'worktree colors correct' '
 	rm -r worktree_dir &&
 	git worktree prune &&
 	test_decode_color <actual.raw >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success "set up color tests" '
@@ -398,7 +398,7 @@ test_expect_success 'verbose output lists worktree path' '
 	git branch -vv >actual &&
 	rm -r worktree_dir &&
 	git worktree prune &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 04de03cad0a..f5bf16abcd8 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -181,7 +181,7 @@ test_expect_success 'diffstat for rename quotes funny filename' '
 	git diff-index -M -p $t0 >diff &&
 	git apply --stat <diff >diffstat &&
 	sed -e "s/|.*//" -e "s/ *\$//" <diffstat >current &&
-	test_i18ncmp expected current
+	test_cmp expected current
 '
 
 test_expect_success 'numstat for rename quotes funny filename' '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 5e88a10f8d7..587b408063a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -113,7 +113,7 @@ test_expect_success 'rebase off of the previous branch using "-"' '
 	test_cmp expect.forkpoint actual.forkpoint &&
 	# the next one is dubious---we may want to say "-",
 	# instead of @{-1}, in the message
-	test_i18ncmp expect.messages actual.messages
+	test_cmp expect.messages actual.messages
 '
 
 test_expect_success 'rebase a single mode change' '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index dc45552b4d6..b0431782230 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -86,7 +86,7 @@ test_expect_success 'rebase -i with empty todo list' '
 			git rebase -i HEAD^ >output 2>&1
 	) &&
 	tail -n 1 output >actual &&  # Ignore output about changing todo list
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -i with the exec command' '
@@ -158,9 +158,9 @@ test_expect_success 'rebase -x with empty command fails' '
 	test_when_finished "git rebase --abort ||:" &&
 	test_must_fail env git rebase -x "" @ 2>actual &&
 	test_write_lines "error: empty exec command" >expected &&
-	test_i18ncmp expected actual &&
+	test_cmp expected actual &&
 	test_must_fail env git rebase -x " " @ 2>actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'rebase -x with newline in command fails' '
@@ -168,7 +168,7 @@ test_expect_success 'rebase -x with newline in command fails' '
 	test_must_fail env git rebase -x "a${LF}b" @ 2>actual &&
 	test_write_lines "error: exec commands cannot contain newlines" \
 			 >expected &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'rebase -i with exec of inexistent command' '
@@ -1465,7 +1465,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 		FAKE_LINES="1 2 3 4" git rebase -i --root 2>actual.2
 	) &&
 	head -n4 actual.2 >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
@@ -1489,7 +1489,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES="1 2 4" \
 			git rebase -i --root 2>actual &&
-		test_i18ncmp expect actual &&
+		test_cmp expect actual &&
 		cp .git/rebase-merge/git-rebase-todo.backup \
 			.git/rebase-merge/git-rebase-todo &&
 		FAKE_LINES="1 2 drop 3 4 drop 5" git rebase --edit-todo
@@ -1535,11 +1535,11 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
 		cp .git/rebase-merge/git-rebase-todo.backup orig &&
 		FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
 		head -n6 actual.2 >actual &&
-		test_i18ncmp expect actual &&
+		test_cmp expect actual &&
 		cp orig .git/rebase-merge/git-rebase-todo &&
 		FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
 		head -n4 actual.2 >actual &&
-		test_i18ncmp expect.3 actual &&
+		test_cmp expect.3 actual &&
 		git rebase --continue 2>actual
 	) &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
@@ -1575,16 +1575,16 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = er
 		cp .git/rebase-merge/git-rebase-todo.backup orig &&
 		test_must_fail env FAKE_LINES="2 3 4" \
 			git rebase --edit-todo 2>actual &&
-		test_i18ncmp expect actual &&
+		test_cmp expect actual &&
 		test_must_fail git rebase --continue 2>actual &&
-		test_i18ncmp expect.2 actual &&
+		test_cmp expect.2 actual &&
 		test_must_fail git rebase --edit-todo &&
 		cp orig .git/rebase-merge/git-rebase-todo &&
 		test_must_fail env FAKE_LINES="1 2 3 4" \
 			git rebase --edit-todo 2>actual &&
-		test_i18ncmp expect.3 actual &&
+		test_cmp expect.3 actual &&
 		test_must_fail git rebase --continue 2>actual &&
-		test_i18ncmp expect.3 actual &&
+		test_cmp expect.3 actual &&
 		cp orig .git/rebase-merge/git-rebase-todo &&
 		FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
 		git rebase --continue 2>actual
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 4caa014c71c..43fcb68f27e 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -110,7 +110,7 @@ testrebase () {
 		fi &&
 		create_expected_success_$suffix &&
 		sed "$remove_progress_re" <actual >actual2 &&
-		test_i18ncmp expected actual2
+		test_cmp expected actual2
 	'
 
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
@@ -231,7 +231,7 @@ testrebase () {
 		fi &&
 		create_expected_failure_$suffix &&
 		sed "$remove_progress_re" <actual >actual2 &&
-		test_i18ncmp expected actual2
+		test_cmp expected actual2
 	'
 }
 
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 9198535874c..4581ae98b87 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -74,10 +74,10 @@ test_expect_success 'cherry-pick --continue rejects --rerere-autoupdate' '
 	git diff-files --quiet &&
 	test_must_fail git cherry-pick --continue --rerere-autoupdate >actual 2>&1 &&
 	echo "fatal: cherry-pick: --rerere-autoupdate cannot be used with --continue" >expect &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	test_must_fail git cherry-pick --continue --no-rerere-autoupdate >actual 2>&1 &&
 	echo "fatal: cherry-pick: --no-rerere-autoupdate cannot be used with --continue" >expect &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	git cherry-pick --abort
 '
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 5f4564c8306..014001b8f32 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -59,7 +59,7 @@ test_expect_success 'advice from failed cherry-pick' "
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 test_expect_success 'advice from failed cherry-pick --no-commit' "
@@ -73,7 +73,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
@@ -256,7 +256,7 @@ test_expect_success \
 
 	test_must_fail git cherry-pick picked &&
 
-	test_i18ncmp expected .git/MERGE_MSG
+	test_cmp expected .git/MERGE_MSG
 '
 
 test_expect_success \
@@ -276,7 +276,7 @@ test_expect_success \
 
 	test_must_fail git cherry-pick --cleanup=scissors picked &&
 
-	test_i18ncmp expected .git/MERGE_MSG
+	test_cmp expected .git/MERGE_MSG
 '
 
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
@@ -465,7 +465,7 @@ test_expect_success \
 	test_must_fail git revert picked &&
 
 	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success \
@@ -488,7 +488,7 @@ test_expect_success \
 	test_must_fail git revert --cleanup=scissors picked &&
 
 	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'failed cherry-pick does not forget -s' '
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index ec7a2c9fcfa..e8375d1c970 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -86,7 +86,7 @@ test_expect_success 'output to keep user entertained during multi-pick' '
 	git cherry-pick first..fourth >actual &&
 	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
 	test_line_count -ge 3 actual.fuzzy &&
-	test_i18ncmp expected actual.fuzzy
+	test_cmp expected actual.fuzzy
 '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
@@ -123,7 +123,7 @@ test_expect_success 'output during multi-pick indicates merge strategy' '
 	test_tick &&
 	git cherry-pick --strategy resolve first..fourth >actual &&
 	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
-	test_i18ncmp expected actual.fuzzy
+	test_cmp expected actual.fuzzy
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 5b94fdaa671..b76cb6de91d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -170,7 +170,7 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	git commit -a &&
 	test_path_is_missing .git/CHERRY_PICK_HEAD &&
 	test_must_fail git cherry-pick --skip 2>advice &&
-	test_i18ncmp expect advice
+	test_cmp expect advice
 '
 
 test_expect_success 'selectively advise --skip while launching another sequence' '
@@ -182,7 +182,7 @@ test_expect_success 'selectively advise --skip while launching another sequence'
 	EOF
 	test_must_fail git cherry-pick picked..yetanotherpick &&
 	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
-	test_i18ncmp expect advice &&
+	test_cmp expect advice &&
 	cat >expect <<-EOF &&
 	error: cherry-pick is already in progress
 	hint: try "git cherry-pick (--continue | --abort | --quit)"
@@ -190,7 +190,7 @@ test_expect_success 'selectively advise --skip while launching another sequence'
 	EOF
 	git reset --merge &&
 	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
-	test_i18ncmp expect advice
+	test_cmp expect advice
 '
 
 test_expect_success 'allow skipping commit but not abort for a new history' '
@@ -204,7 +204,7 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
 	test_must_fail git cherry-pick anotherpick &&
 	test_must_fail git cherry-pick --abort 2>advice &&
 	git cherry-pick --skip &&
-	test_i18ncmp expect advice
+	test_cmp expect advice
 '
 
 test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index dff12286699..857b145cc25 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -442,7 +442,7 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
 	git add .gitmodules &&
 	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
 	git rm submod >actual 2>actual.err &&
-	test_i18ncmp expect.err actual.err &&
+	test_cmp expect.err actual.err &&
 	test_path_is_missing submod &&
 	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
@@ -812,7 +812,7 @@ test_expect_success 'rm files with different staged content' '
 	echo content1 >foo.txt &&
 	echo content1 >bar.txt &&
 	test_must_fail git rm foo.txt bar.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm files with different staged content without hints' '
@@ -825,7 +825,7 @@ test_expect_success 'rm files with different staged content without hints' '
 	echo content2 >foo.txt &&
 	echo content2 >bar.txt &&
 	test_must_fail git -c advice.rmhints=false rm foo.txt bar.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm file with local modification' '
@@ -837,7 +837,7 @@ test_expect_success 'rm file with local modification' '
 	git commit -m "testing rm 3" &&
 	echo content3 >foo.txt &&
 	test_must_fail git rm foo.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm file with local modification without hints' '
@@ -847,7 +847,7 @@ test_expect_success 'rm file with local modification without hints' '
 	EOF
 	echo content4 >bar.txt &&
 	test_must_fail git -c advice.rmhints=false rm bar.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm file with changes in the index' '
@@ -860,7 +860,7 @@ test_expect_success 'rm file with changes in the index' '
 	echo content5 >foo.txt &&
 	git add foo.txt &&
 	test_must_fail git rm foo.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm file with changes in the index without hints' '
@@ -869,7 +869,7 @@ test_expect_success 'rm file with changes in the index without hints' '
 	    foo.txt
 	EOF
 	test_must_fail git -c advice.rmhints=false rm foo.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm files with two different errors' '
@@ -888,7 +888,7 @@ test_expect_success 'rm files with two different errors' '
 	echo content6 >bar1.txt &&
 	git add bar1.txt &&
 	test_must_fail git rm bar1.txt foo1.txt 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'rm empty string should fail' '
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b7d4ba608cb..dda84004f96 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -304,7 +304,7 @@ test_expect_success 'error on a repository with no commits' '
 	error: '"'empty/'"' does not have a commit checked out
 	fatal: adding files failed
 	EOF
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git add --dry-run of existing changed file' "
@@ -320,7 +320,7 @@ test_expect_success 'git add --dry-run of non-existing file' "
 
 test_expect_success 'git add --dry-run of an existing file output' "
 	echo \"fatal: pathspec 'ignored-file' did not match any files\" >expect &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 "
 
 cat >expect.err <<\EOF
@@ -339,8 +339,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file' '
 '
 
 test_expect_success 'git add --dry-run --ignore-missing of non-existing file output' '
-	test_i18ncmp expect.out actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
 '
 
 test_expect_success 'git add empty string should fail' '
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ed00c40370b..207714655f2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -974,7 +974,7 @@ test_expect_success 'show help from add--helper' '
 	EOF
 	test_write_lines h | force_color git add -i >actual.colored &&
 	test_decode_color <actual.colored >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 84b039e5739..5f282ecf617 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -564,7 +564,7 @@ test_expect_success 'stash show format defaults to --stat' '
 	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'stash show - stashes on stack, stash-like argument' '
@@ -792,7 +792,7 @@ test_expect_success 'apply: show same status as git status (relative to ./)' '
 		git stash apply
 	) |
 	sed -e 1d >actual && # drop "Saved..."
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -1114,7 +1114,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	git stash push -p foo >actual &&
 	echo "No local changes to save" >expect &&
 	git reset --hard HEAD~ &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'push <pathspec>: show no changes when there are none' '
@@ -1124,7 +1124,7 @@ test_expect_success 'push <pathspec>: show no changes when there are none' '
 	git stash push foo >actual &&
 	echo "No local changes to save" >expect &&
 	git reset --hard HEAD~ &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'push: <pathspec> not in the repository errors out' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f075c7f1f31..3d8b6b491f0 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -280,7 +280,7 @@ test_expect_success 'stash -u -- <ignored> leaves ignored file alone' '
 test_expect_success 'stash -u -- <non-existent> shows no changes when there are none' '
 	git stash push -u -- non-existent >actual &&
 	echo "No local changes to save" >expect &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'stash -u with globs' '
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 03489aff14e..275ce5fa15b 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -39,13 +39,13 @@ test_expect_success '--stat output after text chmod' '
 	 1 file changed, 0 insertions(+), 0 deletions(-)
 	EOF
 	git diff HEAD --stat >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success '--shortstat output after text chmod' '
 	tail -n 1 <expect >expect.short &&
 	git diff HEAD --shortstat >actual &&
-	test_i18ncmp expect.short actual
+	test_cmp expect.short actual
 '
 
 test_expect_success '--stat output after binary chmod' '
@@ -56,13 +56,13 @@ test_expect_success '--stat output after binary chmod' '
 	 2 files changed, 0 insertions(+), 0 deletions(-)
 	EOF
 	git diff HEAD --stat >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success '--shortstat output after binary chmod' '
 	tail -n 1 <expect >expect.short &&
 	git diff HEAD --shortstat >actual &&
-	test_i18ncmp expect.short actual
+	test_cmp expect.short actual
 '
 
 test_done
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index bd59328e4b2..33ff588ebca 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -34,19 +34,19 @@ EOF
 test_expect_success 'apply --stat output for binary file change' '
 	git diff >diff &&
 	git apply --stat --summary <diff >current &&
-	test_i18ncmp expected current
+	test_cmp expected current
 '
 
 test_expect_success 'diff --shortstat output for binary file change' '
 	tail -n 1 expected >expect &&
 	git diff --shortstat >current &&
-	test_i18ncmp expect current
+	test_cmp expect current
 '
 
 test_expect_success 'diff --shortstat output for binary file change only' '
 	echo " 1 file changed, 0 insertions(+), 0 deletions(-)" >expected &&
 	git diff --shortstat -- b >current &&
-	test_i18ncmp expected current
+	test_cmp expected current
 '
 
 test_expect_success 'apply --numstat notices binary file change' '
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index ce6aa3914fe..47d4df08f9e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -222,7 +222,7 @@ do
 			process_diffs "$expect" >expect &&
 			case $cmd in
 			*format-patch* | *-stat*)
-				test_i18ncmp expect actual;;
+				test_cmp expect actual;;
 			*)
 				test_cmp expect actual;;
 			esac &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 66630c8413d..cdd3154e702 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -888,11 +888,11 @@ echo "fatal: --check does not make sense" >expect.check
 
 test_expect_success 'options no longer allowed for format-patch' '
 	test_must_fail git format-patch --name-only 2>output &&
-	test_i18ncmp expect.name-only output &&
+	test_cmp expect.name-only output &&
 	test_must_fail git format-patch --name-status 2>output &&
-	test_i18ncmp expect.name-status output &&
+	test_cmp expect.name-status output &&
 	test_must_fail git format-patch --check 2>output &&
-	test_i18ncmp expect.check output
+	test_cmp expect.check output
 '
 
 test_expect_success 'format-patch --numstat should produce a patch' '
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 9c48e5c2c99..876271d6826 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -82,7 +82,7 @@ test_expect_success 'git diff --stat -M HEAD' '
 	 7 files changed, 0 insertions(+), 0 deletions(-)
 	EOF
 	git diff --stat -M HEAD >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 4cb9f0e523d..c906320b60d 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -139,7 +139,7 @@ EOF
 test_expect_success 'diffstat does not run textconv' '
 	echo file diff=fail >.gitattributes &&
 	git diff --stat HEAD^ HEAD >actual &&
-	test_i18ncmp expect.stat actual &&
+	test_cmp expect.stat actual &&
 
 	head -n1 <expect.stat >expect.line1 &&
 	head -n1 <actual >actual.line1 &&
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 7be1de736d8..61ba5f707fb 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -61,7 +61,7 @@ check_stat () {
 	EOF
 	test_expect_success "--stat $*" "
 		git -C '$dir' diff --stat $* HEAD^ >actual &&
-		test_i18ncmp expected actual
+		test_cmp expected actual
 	"
 }
 
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index a34121740a4..53061b104ec 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -25,7 +25,7 @@ test_expect_success 'mode-only change show as a 0-line change' '
 	 4 files changed, 2 insertions(+)
 	EOF
 	git diff --stat --stat-count=2 HEAD >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'binary changes do not count in lines' '
@@ -40,7 +40,7 @@ test_expect_success 'binary changes do not count in lines' '
 	 3 files changed, 2 insertions(+)
 	EOF
 	git diff --stat --stat-count=2 >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'exclude unmerged entries from total file count' '
@@ -62,7 +62,7 @@ test_expect_success 'exclude unmerged entries from total file count' '
 	 3 files changed, 3 insertions(+)
 	EOF
 	git diff --stat --stat-count=2 >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 744b8e51bea..9b433de8363 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -17,13 +17,13 @@ do
 	test_expect_success "$title" '
 		git apply --stat --summary \
 			<"$TEST_DIRECTORY/t4100/t-apply-$num.patch" >current &&
-		test_i18ncmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
+		test_cmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
 	'
 
 	test_expect_success "$title with recount" '
 		sed -e "$UNC" <"$TEST_DIRECTORY/t4100/t-apply-$num.patch" |
 		git apply --recount --stat --summary >current &&
-		test_i18ncmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
+		test_cmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
 	'
 done <<\EOF
 rename
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 99987515dc2..2aaaa0d7ded 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -906,7 +906,7 @@ test_expect_success 'am empty-file does not infloop' '
 	test_tick &&
 	test_must_fail git am empty-file 2>actual &&
 	echo Patch format detection failed. >expected &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'am --message-id really adds the message id' '
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 8ea22d1bcbb..b7c3861407d 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -61,7 +61,7 @@ test_expect_success '--no-quiet overrides --quiet' '
 	# Applying side2 will be quiet.
 	git am --no-quiet --continue >out &&
 	echo "Applying: side1" >expected &&
-	test_i18ncmp expected out
+	test_cmp expected out
 '
 
 test_expect_success '--signoff overrides --no-signoff' '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5ec0f47b567..85432b80ff5 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -123,7 +123,7 @@ test_expect_success 'NUL separation with --stat' '
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
 	git log -z --stat --pretty="format:%s" >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_failure 'NUL termination with --stat' '
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index daf01c309d0..54be7da1611 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -60,7 +60,7 @@ test_expect_success 'try to apply corrupted patch' '
 	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual &&
 	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success "NUL in commit message's body" '
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index db4e15fd596..cb67bac1c47 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -223,14 +223,14 @@ test_expect_success 'pull request format' '
 		git request-pull initial "$downstream_url" tags/full >../request
 	) &&
 	<request sed -nf fuzz.sed >request.fuzzy &&
-	test_i18ncmp expect request.fuzzy &&
+	test_cmp expect request.fuzzy &&
 
 	(
 		cd local &&
 		git request-pull initial "$downstream_url" tags/full:refs/tags/full
 	) >request &&
 	sed -nf fuzz.sed <request >request.fuzzy &&
-	test_i18ncmp expect request.fuzzy &&
+	test_cmp expect request.fuzzy &&
 
 	(
 		cd local &&
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 0f06c40eb13..a8c1bc0f66b 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -84,14 +84,14 @@ test_expect_success 'packing produces a long delta' '
 	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
 	echo 9 >expect &&
 	max_chain pack-$pack.pack >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success '--depth limits depth' '
 	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1f4cc873a83..8a5d3492c71 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,7 +547,7 @@ test_expect_success 'test lonely missing ref' '
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy 2>../error-m
 	) &&
-	test_i18ncmp expect-error error-m
+	test_cmp expect-error error-m
 '
 
 test_expect_success 'test missing ref after existing' '
@@ -555,7 +555,7 @@ test_expect_success 'test missing ref after existing' '
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy 2>../error-em
 	) &&
-	test_i18ncmp expect-error error-em
+	test_cmp expect-error error-em
 '
 
 test_expect_success 'test missing ref before existing' '
@@ -563,7 +563,7 @@ test_expect_success 'test missing ref before existing' '
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A 2>../error-me
 	) &&
-	test_i18ncmp expect-error error-me
+	test_cmp expect-error error-me
 '
 
 test_expect_success 'test --all, --depth, and explicit head' '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d3a3bb0a42b..8c462f20ae6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -140,8 +140,8 @@ test_expect_success 'remove remote protects local branches' '
 		git remote rm oops 2>actual2 &&
 		git branch -d foobranch &&
 		git tag -d footag &&
-		test_i18ncmp expect1 actual1 &&
-		test_i18ncmp expect2 actual2
+		test_cmp expect1 actual1 &&
+		test_cmp expect2 actual2
 	)
 '
 
@@ -150,7 +150,7 @@ test_expect_success 'remove errors out early when deleting non-existent branch'
 		cd test &&
 		echo "error: No such remote: '\''foo'\''" >expect &&
 		test_expect_code 2 git remote rm foo 2>actual &&
-		test_i18ncmp expect actual
+		test_cmp expect actual
 	)
 '
 
@@ -178,7 +178,7 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 		cd test &&
 		echo "error: No such remote: '\''foo'\''" >expect &&
 		test_expect_code 2 git remote rename foo bar 2>actual &&
-		test_i18ncmp expect actual
+		test_cmp expect actual
 	)
 '
 
@@ -186,14 +186,14 @@ test_expect_success 'rename errors out early when when new name is invalid' '
 	test_config remote.foo.vcs bar &&
 	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
 	test_must_fail git remote rename foo invalid...name 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'add existing foreign_vcs remote' '
 	test_config remote.foo.vcs bar &&
 	echo "error: remote foo already exists." >expect &&
 	test_expect_code 3 git remote add foo bar 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'add existing foreign_vcs remote' '
@@ -201,13 +201,13 @@ test_expect_success 'add existing foreign_vcs remote' '
 	test_config remote.bar.vcs bar &&
 	echo "error: remote bar already exists." >expect &&
 	test_expect_code 3 git remote rename foo bar 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'add invalid foreign_vcs remote' '
 	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
 	test_must_fail git remote add invalid...name bar 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >test/expect <<EOF
@@ -267,7 +267,7 @@ test_expect_success 'show' '
 		git config --add remote.two.push refs/heads/main:refs/heads/another &&
 		git remote show origin two >output &&
 		git branch -d rebase octopus &&
-		test_i18ncmp expect output
+		test_cmp expect output
 	)
 '
 
@@ -294,7 +294,7 @@ test_expect_success 'show -n' '
 		cd test &&
 		git remote show -n origin >output &&
 		mv ../one.unreachable ../one &&
-		test_i18ncmp expect output
+		test_cmp expect output
 	)
 '
 
@@ -337,7 +337,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
 		echo "two/HEAD set to main" >expect &&
-		test_i18ncmp expect output
+		test_cmp expect output
 	)
 '
 
@@ -369,7 +369,7 @@ test_expect_success 'prune --dry-run' '
 		git remote prune --dry-run origin >output &&
 		git rev-parse refs/remotes/origin/side2 &&
 		test_must_fail git rev-parse refs/remotes/origin/side &&
-		test_i18ncmp expect output
+		test_cmp expect output
 	)
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a37df6d35a7..ad1d1d5fd6b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1051,7 +1051,7 @@ test_expect_success 'fetch --prune prints the remotes url' '
 		git fetch --prune origin 2>&1 | head -n1 >../actual
 	) &&
 	echo "From ${D}/." >expect &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'branchname D/F conflict resolved by --prune' '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 4a568a2398e..f53f58895a1 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -150,7 +150,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# We could just as easily have used "main"; the "*" emphasizes its
 	# role as a pattern.
 	test_must_fail git ls-remote "$does_not_exist" >actual 2>&1 &&
-	test_i18ncmp exp actual
+	test_cmp exp actual
 '
 
 test_expect_success 'die with non-2 for wrong repository even with --exit-code' '
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 11513ec15e1..ed11569d8d7 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -74,7 +74,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "submodule.recurse option triggers recursive fetch" '
@@ -84,7 +84,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 		git -c submodule.recurse fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
@@ -94,7 +94,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err &&
+	test_cmp expect.err actual.err &&
 	grep "2 tasks" trace.out
 '
 
@@ -124,7 +124,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
@@ -155,7 +155,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "--quiet propagates to submodules" '
@@ -183,7 +183,7 @@ test_expect_success "--dry-run propagates to submodules" '
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "Without --dry-run propagates to submodules" '
@@ -192,7 +192,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
@@ -203,7 +203,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
@@ -217,7 +217,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
@@ -257,7 +257,7 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.err.sub actual.err &&
+	test_cmp expect.err.sub actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -275,7 +275,7 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err.file actual.err
+	test_cmp expect.err.file actual.err
 '
 
 test_expect_success "Recursion picks up config in submodule" '
@@ -303,7 +303,7 @@ test_expect_success "Recursion picks up config in submodule" '
 			git config --unset fetch.recurseSubmodules
 		)
 	) &&
-	test_i18ncmp expect.err.sub actual.err &&
+	test_cmp expect.err.sub actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -336,7 +336,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_i18ncmp expect.err.2 actual.err &&
+	test_cmp expect.err.2 actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -392,7 +392,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 		)
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_cmp expect.err actual.err
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
@@ -409,7 +409,7 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err.file actual.err
+	test_cmp expect.err.file actual.err
 '
 
 test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
@@ -437,7 +437,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		git config --unset fetch.recurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err.2 actual.err
+	test_cmp expect.err.2 actual.err
 '
 
 test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
@@ -465,7 +465,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err.2 actual.err
+	test_cmp expect.err.2 actual.err
 '
 
 test_expect_success "don't fetch submodule when newly recorded commits are already present" '
@@ -484,7 +484,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err actual.err &&
+	test_cmp expect.err actual.err &&
 	(
 		cd submodule &&
 		git checkout -q sub
@@ -520,7 +520,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git reset --hard
 	) &&
 	test_must_be_empty actual.out &&
-	test_i18ncmp expect.err.2 actual.err &&
+	test_cmp expect.err.2 actual.err &&
 	git checkout HEAD^ -- .gitmodules &&
 	git add .gitmodules &&
 	git commit -m "new submodule restored .gitmodules"
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index bc5ccf233f0..c024fa28183 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -118,7 +118,7 @@ test_expect_success 'rejected update prints status' '
 	git commit -m dev2 &&
 	test_must_fail git push origin dev2 2>act &&
 	sed -e "/^remote: /s/ *$//" <act >cmp &&
-	test_i18ncmp exp cmp
+	test_cmp exp cmp
 '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 6249420a806..90b2be9b2ed 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -175,7 +175,7 @@ test_expect_success 'create bundle from special rev: main^!' '
 	cat >expect <<-\EOF &&
 	<COMMIT-P> refs/heads/main
 	EOF
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	git bundle verify special-rev.bdl |
 		make_user_friendly_and_stable_output >actual &&
@@ -185,7 +185,7 @@ test_expect_success 'create bundle from special rev: main^!' '
 	The bundle requires this ref:
 	<COMMIT-O>
 	EOF
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count special-rev.bdl 3
 '
@@ -207,7 +207,7 @@ test_expect_success 'create bundle with --max-count option' '
 	The bundle requires this ref:
 	<COMMIT-O>
 	EOF
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count max-count.bdl 4
 '
@@ -236,7 +236,7 @@ test_expect_success 'create bundle with --since option' '
 	<COMMIT-M>
 	<COMMIT-K>
 	EOF
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count --thin since.bdl 13
 '
@@ -262,11 +262,11 @@ test_expect_success 'create bundle 1 - no prerequisites' '
 	# verify bundle, which has no prerequisites
 	git bundle verify 1.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	git bundle verify stdin-1.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count       1.bdl 24 &&
 	test_bundle_object_count stdin-1.bdl 24
@@ -304,11 +304,11 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 
 	git bundle verify 2.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	git bundle verify stdin-2.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count       2.bdl 16 &&
 	test_bundle_object_count stdin-2.bdl 16
@@ -326,11 +326,11 @@ test_expect_success 'fail to verify bundle without prerequisites' '
 
 	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_must_fail git -C test1.git bundle verify ../stdin-2.bdl 2>&1 |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'create bundle 3 - two refs, same object' '
@@ -363,11 +363,11 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 
 	git bundle verify 3.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	git bundle verify stdin-3.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count       3.bdl 4 &&
 	test_bundle_object_count stdin-3.bdl 4
@@ -404,11 +404,11 @@ test_expect_success 'create bundle 4 - with tags' '
 
 	git bundle verify 4.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	git bundle verify stdin-4.bdl |
 		make_user_friendly_and_stable_output >actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 
 	test_bundle_object_count       4.bdl 3 &&
 	test_bundle_object_count stdin-4.bdl 3
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7bcde054d73..ef7bdcedf23 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -829,7 +829,7 @@ test_expect_success 'bisect terms needs 0 or 1 argument' '
 	test_must_fail git bisect terms 1 2 &&
 	test_must_fail git bisect terms 2>actual &&
 	echo "error: no terms defined" >expected &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'bisect terms shows good/bad after start' '
@@ -903,7 +903,7 @@ test_expect_success 'bisect start --term-* does store terms' '
 	Your current terms are two for the old state
 	and one for the new state.
 	EOF
-	test_i18ncmp expected actual &&
+	test_cmp expected actual &&
 	git bisect terms --term-bad >actual &&
 	echo one >expected &&
 	test_cmp expected actual &&
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index a160b2bf99c..a313849406d 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -57,7 +57,7 @@ test_expect_success 'branch -v' '
 		git branch -v
 	) |
 	sed -n -e "$t6040_script" >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -75,7 +75,7 @@ test_expect_success 'branch -vv' '
 		git branch -vv
 	) |
 	sed -n -e "$t6040_script" >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'checkout (diverged from upstream)' '
@@ -146,7 +146,7 @@ test_expect_success 'status -s -b (diverged from upstream)' '
 		git checkout b1 >/dev/null &&
 		git status -s -b | head -1
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -159,7 +159,7 @@ test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
 		git checkout b1 >/dev/null &&
 		git status -s -b --no-ahead-behind | head -1
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -172,7 +172,7 @@ test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstre
 		git checkout b1 >/dev/null &&
 		git -c status.aheadbehind=false status -s -b | head -1
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -187,7 +187,7 @@ test_expect_success 'status --long --branch' '
 		git checkout b1 >/dev/null &&
 		git status --long -b | head -3
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'status --long --branch' '
@@ -196,7 +196,7 @@ test_expect_success 'status --long --branch' '
 		git checkout b1 >/dev/null &&
 		git -c status.aheadbehind=true status --long -b | head -3
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -210,7 +210,7 @@ test_expect_success 'status --long --branch --no-ahead-behind' '
 		git checkout b1 >/dev/null &&
 		git status --long -b --no-ahead-behind | head -2
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'status.aheadbehind=false status --long --branch' '
@@ -219,7 +219,7 @@ test_expect_success 'status.aheadbehind=false status --long --branch' '
 		git checkout b1 >/dev/null &&
 		git -c status.aheadbehind=false status --long -b | head -2
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -232,7 +232,7 @@ test_expect_success 'status -s -b (upstream is gone)' '
 		git checkout b5 >/dev/null &&
 		git status -s -b | head -1
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -245,7 +245,7 @@ test_expect_success 'status -s -b (up-to-date with upstream)' '
 		git checkout b6 >/dev/null &&
 		git status -s -b | head -1
 	) >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'fail to track lightweight tags' '
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 546796f8473..e89b6747bee 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -136,7 +136,7 @@ warning: tag 'Q' is externally known as 'A'
 EOF
 check_describe A-* HEAD
 test_expect_success 'warning was displayed for Q' '
-	test_i18ncmp err.expect err.actual
+	test_cmp err.expect err.actual
 '
 test_expect_success 'misnamed annotated tag forces long output' '
 	description=$(git describe --no-long Q^0) &&
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index c6706684098..0f1cb49cedc 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -21,7 +21,7 @@ EOF
 test_expect_success 'error message for path inside submodule' '
 	echo a >sub/a &&
 	test_must_fail git add sub/a 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'error message for path inside submodule from within submodule' '
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 809854fc0ce..40edf9dab53 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -20,8 +20,8 @@ test_expect_success 'Broken refs are reported correctly' '
 	test_when_finished "rm -f .git/$r" &&
 	echo "warning: ignoring broken ref $r" >broken-err &&
 	git for-each-ref >out 2>err &&
-	test_i18ncmp full-list out &&
-	test_i18ncmp broken-err err
+	test_cmp full-list out &&
+	test_cmp broken-err err
 '
 
 test_expect_success 'NULL_SHA1 refs are reported correctly' '
@@ -31,10 +31,10 @@ test_expect_success 'NULL_SHA1 refs are reported correctly' '
 	echo "warning: ignoring broken ref $r" >zeros-err &&
 	git for-each-ref >out 2>err &&
 	test_cmp full-list out &&
-	test_i18ncmp zeros-err err &&
+	test_cmp zeros-err err &&
 	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
 	test_cmp brief-list brief-out &&
-	test_i18ncmp zeros-err brief-err
+	test_cmp zeros-err brief-err
 '
 
 test_expect_success 'Missing objects are reported correctly' '
@@ -43,7 +43,7 @@ test_expect_success 'Missing objects are reported correctly' '
 	test_when_finished "rm -f .git/$r" &&
 	echo "fatal: missing object $MISSING for $r" >missing-err &&
 	test_must_fail git for-each-ref 2>err &&
-	test_i18ncmp missing-err err &&
+	test_cmp missing-err err &&
 	(
 		cat brief-list &&
 		echo "$MISSING $r"
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index 362ae37a122..84b4aacf496 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -139,7 +139,7 @@ test_expect_success 'will not overwrite untracked file in leading path' '
 	cp important sub &&
 	cp important sub2 &&
 	test_must_fail git merge sub 2>out &&
-	test_i18ncmp out expect &&
+	test_cmp out expect &&
 	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important sub &&
 	test_cmp important sub2 &&
@@ -174,7 +174,7 @@ test_expect_success 'will not overwrite untracked file on unborn branch' '
 	git checkout --orphan new &&
 	cp important c0.c &&
 	test_must_fail git merge c0 2>out &&
-	test_i18ncmp out expect
+	test_cmp out expect
 '
 
 test_expect_success 'will not overwrite untracked file on unborn branch .git/MERGE_HEAD sanity etc.' '
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index e176475ed5b..5bfb027099a 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -40,14 +40,14 @@ EOF
 
 test_expect_success 'untracked files overwritten by merge (fast and non-fast forward)' '
 	test_must_fail git merge branch 2>out &&
-	test_i18ncmp out expect &&
+	test_cmp out expect &&
 	git commit --allow-empty -m empty &&
 	(
 		GIT_MERGE_VERBOSITY=0 &&
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge branch 2>out2
 	) &&
-	test_i18ncmp out2 expect &&
+	test_cmp out2 expect &&
 	git reset --hard HEAD^
 '
 
@@ -68,7 +68,7 @@ test_expect_success 'untracked files or local changes ovewritten by merge' '
 	git add three &&
 	git add four &&
 	test_must_fail git merge branch 2>out &&
-	test_i18ncmp out expect
+	test_cmp out expect
 '
 
 cat >expect <<\EOF
@@ -90,7 +90,7 @@ test_expect_success 'cannot switch branches because of local changes' '
 	echo uno >rep/one &&
 	echo dos >rep/two &&
 	test_must_fail git checkout branch 2>out &&
-	test_i18ncmp out expect
+	test_cmp out expect
 '
 
 cat >expect <<\EOF
@@ -104,7 +104,7 @@ EOF
 test_expect_success 'not uptodate file porcelain checkout error' '
 	git add rep/one rep/two &&
 	test_must_fail git checkout branch 2>out &&
-	test_i18ncmp out expect
+	test_cmp out expect
 '
 
 cat >expect <<\EOF
@@ -135,7 +135,7 @@ test_expect_success 'not_uptodate_dir porcelain checkout error' '
 	>rep/untracked-file &&
 	>rep2/untracked-file &&
 	test_must_fail git checkout branch 2>out &&
-	test_i18ncmp out ../expect
+	test_cmp out ../expect
 '
 
 test_done
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 63d5f41a124..080a6530831 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -446,7 +446,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	echo "warning: Could not find section in .gitmodules where path=sub" >expect.err &&
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
-	test_i18ncmp expect.err actual.err &&
+	test_cmp expect.err actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
 	(
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 943a7d5c1db..bbd2b7b6f35 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -91,7 +91,7 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	git tag --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
 	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'annotated tag with --create-reflog has correct message' '
@@ -102,7 +102,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
 	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success '--create-reflog does not create reflog on failure' '
@@ -1409,7 +1409,7 @@ test_expect_success 'message in editor has initial comment: first line' '
 	# check the first line --- should be empty
 	echo >first.expect &&
 	sed -e 1q <actual >first.actual &&
-	test_i18ncmp first.expect first.actual
+	test_cmp first.expect first.actual
 '
 
 test_expect_success \
@@ -1732,7 +1732,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'multiple --points-at are OR-ed together' '
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index e5c6a038fbf..f2a8e765114 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -125,13 +125,13 @@ EOF
 test_expect_success 'git-clean, absent case' '
 	setup_absent &&
 	git clean -n > result &&
-	test_i18ncmp expected result
+	test_cmp expected result
 '
 
 test_expect_success 'git-clean, dirty case' '
 	setup_dirty &&
 	git clean -n > result &&
-	test_i18ncmp expected result
+	test_cmp expected result
 '
 
 test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 72fb418b890..0f4344c55e6 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -56,9 +56,9 @@ EOF
 		git commit -m delete &&
 		test_must_fail git merge main &&
 		test_must_fail git commit --dry-run >../actual &&
-		test_i18ncmp ../expect ../actual &&
+		test_cmp ../expect ../actual &&
 		git status >../actual &&
-		test_i18ncmp ../expect ../actual
+		test_cmp ../expect ../actual
 	)
 '
 
@@ -151,7 +151,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -185,7 +185,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -210,7 +210,7 @@ Unmerged paths:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual &&
+	test_cmp expected actual &&
 	git reset --hard &&
 	git checkout main
 '
@@ -227,7 +227,7 @@ test_expect_success 'status --branch with detached HEAD' '
 	?? expected
 	?? mdconflict/
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 ## Duplicate the above test and verify --porcelain=v1 arg parsing.
@@ -243,7 +243,7 @@ test_expect_success 'status --porcelain=v1 --branch with detached HEAD' '
 	?? expected
 	?? mdconflict/
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 ## Verify parser error on invalid --porcelain argument.
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index f01bf277279..accefde72fb 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -731,7 +731,7 @@ test_expect_success 'test ident field is working' '
 	cp -R done dthree dtwo four three ../other_worktree &&
 	GIT_WORK_TREE=../other_worktree git status 2>../err &&
 	echo "warning: untracked cache is disabled on this system or location" >../expect &&
-	test_i18ncmp ../expect ../err
+	test_cmp ../expect ../err
 '
 
 test_expect_success 'untracked cache survives a checkout' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 7d8fb188ee5..601b2bf97f0 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -75,14 +75,14 @@ test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
 	git reset --hard >.actual &&
 	echo HEAD is now at $hex $(commit_msg) >.expected &&
-	test_i18ncmp .expected .actual
+	test_cmp .expected .actual
 '
 
 test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
 	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard >.actual &&
 	echo HEAD is now at $hex $(commit_msg $test_encoding) >.expected &&
-	test_i18ncmp .expected .actual
+	test_cmp .expected .actual
 '
 
 test_expect_success 'giving a non existing revision should fail' '
@@ -469,7 +469,7 @@ test_expect_success '--mixed refreshes the index' '
 	EOF
 	echo 123 >>file2 &&
 	git reset --mixed HEAD >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'resetting specific path that is unmerged' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d44f6962933..a924fdb7a6c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -55,7 +55,7 @@ test_expect_success 'add aborts on repository with no commits' '
 	EOF
 	git init repo-no-commits &&
 	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'status should ignore inner git repo when not added' '
@@ -185,7 +185,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		git add --force .gitignore &&
 		git commit -m"Ignore everything" &&
 		! git submodule add "$submodurl" submod >actual 2>&1 &&
-		test_i18ncmp expect actual
+		test_cmp expect actual
 	)
 '
 
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 76088147089..9c3cc4cf404 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -190,7 +190,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
 	  < Add foo5
 
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
@@ -200,7 +200,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
 	  > Add foo5
 
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 rm -rf sm1 &&
@@ -211,7 +211,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 	* sm1 $head4(submodule)->$head5(blob):
 
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 rm -f sm1 &&
@@ -224,7 +224,7 @@ test_expect_success 'nonexistent commit' "
 	  Warn: sm1 doesn't contain commit $head4_full
 
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 commit_file
@@ -235,7 +235,7 @@ test_expect_success 'typechanged submodule(blob->submodule)' "
 	  > Add foo7
 
 	EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 "
 
 commit_file sm1 &&
@@ -292,7 +292,7 @@ test_expect_success 'given commit' "
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp - actual <<-EOF
+	test_cmp - actual <<-EOF
 	* sm1 $head6...0000000:
 
 	* sm2 0000000...$head7 (2):
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index b9c1624fba9..ff3ba5422e9 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -155,9 +155,9 @@ test_expect_success 'submodule update --init --recursive from subdirectory' '
 	 cd tmp &&
 	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
 	) &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	sort actual2 >actual2.sorted &&
-	test_i18ncmp expect2 actual2.sorted
+	test_cmp expect2 actual2.sorted
 '
 
 cat <<EOF >expect2
@@ -174,7 +174,7 @@ test_expect_success 'submodule update --init from and of subdirectory' '
 	  git submodule update --init sub 2>../../actual2
 	 )
 	) &&
-	test_i18ncmp expect2 actual2
+	test_cmp expect2 actual2
 '
 
 test_expect_success 'submodule update does not fetch already present commits' '
@@ -192,7 +192,7 @@ test_expect_success 'submodule update does not fetch already present commits' '
 	(cd super &&
 	  git submodule update > ../actual 2> ../actual.err
 	) &&
-	test_i18ncmp expected actual &&
+	test_cmp expected actual &&
 	test_must_be_empty actual.err
 '
 
@@ -461,7 +461,7 @@ test_expect_success 'submodule update - command in .git/config catches failure'
 	(cd super &&
 	 test_must_fail git submodule update submodule 2>../actual
 	) &&
-	test_i18ncmp actual expect
+	test_cmp actual expect
 '
 
 cat << EOF >expect
@@ -479,7 +479,7 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	 mkdir tmp && cd tmp &&
 	 test_must_fail git submodule update ../submodule 2>../../actual
 	) &&
-	test_i18ncmp actual expect
+	test_cmp actual expect
 '
 
 test_expect_success 'submodule update - command run for initial population of submodule' '
@@ -488,7 +488,7 @@ test_expect_success 'submodule update - command run for initial population of su
 	EOF
 	rm -rf super/submodule &&
 	test_must_fail git -C super submodule update 2>actual &&
-	test_i18ncmp expect actual &&
+	test_cmp expect actual &&
 	git -C super submodule update --checkout
 '
 
@@ -509,7 +509,7 @@ test_expect_success 'recursive submodule update - command in .git/config catches
 	 mkdir -p tmp && cd tmp &&
 	 test_must_fail git submodule update --recursive ../super 2>../../actual
 	) &&
-	test_i18ncmp actual expect
+	test_cmp actual expect
 '
 
 test_expect_success 'submodule init does not copy command into .git/config' '
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 79981b51eb8..e2f110b7863 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -80,7 +80,7 @@ test_expect_success 'test basic "submodule foreach" usage' '
 		git config foo.bar zar &&
 		git submodule foreach "git config --file \"\$toplevel/.git/config\" foo.bar"
 	) &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -96,7 +96,7 @@ test_expect_success 'test "submodule foreach" from subdirectory' '
 		cd clone/sub &&
 		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$displaypath-\$sha1" >../../actual
 	) &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'setup nested submodules' '
@@ -177,7 +177,7 @@ test_expect_success 'test messages from "foreach --recursive"' '
 		cd clone2 &&
 		git submodule foreach --recursive "true" > ../actual
 	) &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat > expect <<EOF
@@ -197,7 +197,7 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 		cd untracked &&
 		git submodule foreach --recursive >../../actual
 	) &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
 sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
@@ -229,7 +229,7 @@ test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
 		cd clone2/untracked &&
 		git submodule foreach --recursive "echo toplevel: \$toplevel name: \$name path: \$sm_path displaypath: \$displaypath hash: \$sha1" >../../actual
 	) &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 cat > expect <<EOF
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 6d19ece05dd..e41ac18e7e0 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -15,7 +15,7 @@ commit_msg_is () {
 
 	printf "%s" "$(git log --pretty=format:%s%b -1)" >"$actual" &&
 	printf "%s" "$1" >"$expect" &&
-	test_i18ncmp "$expect" "$actual"
+	test_cmp "$expect" "$actual"
 }
 
 # A sanity check to see if commit is working at all.
@@ -356,7 +356,7 @@ test_expect_success 'new line found before status message in commit template' '
 	touch commit-template-check &&
 	git add commit-template-check &&
 	GIT_EDITOR="cat >editor-input" git commit --untracked-files=no --allow-empty-message &&
-	test_i18ncmp expected-template editor-input
+	test_cmp expected-template editor-input
 '
 
 test_expect_success 'setup empty commit with unstaged rename and copy' '
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index e5332adc9a1..6396897cc81 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -13,7 +13,7 @@ commit_msg_is () {
 
 	printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
 	printf "%s" "$1" >$expect &&
-	test_i18ncmp $expect $actual
+	test_cmp $expect $actual
 }
 
 # Arguments: [<prefix] [<commit message>] [<commit options>]
@@ -35,7 +35,7 @@ check_summary_oneline() {
 	SUMMARY_POSTFIX="$(git log -1 --pretty='format:%h')"
 	echo "[$SUMMARY_PREFIX $SUMMARY_POSTFIX] $2" >exp &&
 
-	test_i18ncmp exp act
+	test_cmp exp act
 }
 
 test_expect_success 'output summary format' '
@@ -300,7 +300,7 @@ echo "sample
 # with '#' will be ignored, and an empty message aborts the commit." >expect
 
 test_expect_success 'cleanup commit messages (strip option,-F,-e): output' '
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'cleanup commit message (fail on invalid cleanup mode option)' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index d01aacb66b5..2b72451ba3e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -109,13 +109,13 @@ test_expect_success 'status --column' '
 #
 EOF
 	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status --column status.displayCommentPrefix=false' '
 	strip_comments expect &&
 	COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<\EOF
@@ -144,19 +144,19 @@ EOF
 
 test_expect_success 'status with status.displayCommentPrefix=true' '
 	git -c status.displayCommentPrefix=true status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status with status.displayCommentPrefix=false' '
 	strip_comments expect &&
 	git -c status.displayCommentPrefix=false status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status -v' '
 	(cat expect && git diff --cached) >expect-with-v &&
 	git status -v >output &&
-	test_i18ncmp expect-with-v output
+	test_cmp expect-with-v output
 '
 
 test_expect_success 'status -v -v' '
@@ -167,7 +167,7 @@ test_expect_success 'status -v -v' '
 	 echo "Changes not staged for commit:" &&
 	 git -c diff.mnemonicprefix=true diff) >expect-with-v &&
 	git status -v -v >output &&
-	test_i18ncmp expect-with-v output
+	test_cmp expect-with-v output
 '
 
 test_expect_success 'setup fake editor' '
@@ -214,7 +214,7 @@ EOF
 test_expect_success 'status (advice.statusHints false)' '
 	test_config advice.statusHints false &&
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 
 '
 
@@ -296,7 +296,7 @@ Ignored files:
 
 EOF
 	git status --ignored >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status with gitignore (nothing untracked)' '
@@ -358,7 +358,7 @@ Ignored files:
 
 EOF
 	git status --ignored >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >.gitignore <<\EOF
@@ -380,7 +380,7 @@ EOF
 test_expect_success 'status -s -b' '
 
 	git status -s -b >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 
 '
 
@@ -390,7 +390,7 @@ test_expect_success 'status -s -z -b' '
 	git status -s -z -b >output &&
 	nul_to_q <output >output.q &&
 	mv output.q output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'setup dir3' '
@@ -418,13 +418,13 @@ Changes not staged for commit:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status -uno >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status (status.showUntrackedFiles no)' '
 	test_config status.showuntrackedfiles no &&
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status -uno (advice.statusHints false)' '
@@ -443,7 +443,7 @@ Untracked files not listed
 EOF
 	test_config advice.statusHints false &&
 	git status -uno >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect << EOF
@@ -487,13 +487,13 @@ Untracked files:
 
 EOF
 	git status -unormal >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status (status.showUntrackedFiles normal)' '
 	test_config status.showuntrackedfiles normal &&
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<EOF
@@ -543,13 +543,13 @@ Untracked files:
 
 EOF
 	git status -uall >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status (status.showUntrackedFiles all)' '
 	test_config status.showuntrackedfiles all &&
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'teardown dir3' '
@@ -601,7 +601,7 @@ Untracked files:
 
 EOF
 	(cd dir1 && git status) >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<\EOF
@@ -670,13 +670,13 @@ Untracked files:
 EOF
 	test_config color.ui auto &&
 	test_terminal git status | test_decode_color >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success TTY 'status with color.status' '
 	test_config color.status auto &&
 	test_terminal git status | test_decode_color >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<\EOF
@@ -718,7 +718,7 @@ EOF
 test_expect_success TTY 'status -s -b with color.status' '
 
 	test_terminal git status -s -b | test_decode_color >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 
 '
 
@@ -793,7 +793,7 @@ Untracked files:
 EOF
 	test_config status.relativePaths false &&
 	(cd dir1 && git status) >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 
 '
 
@@ -860,7 +860,7 @@ Untracked files:
 
 EOF
 	git commit --dry-run dir1/modified >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<EOF
@@ -921,13 +921,13 @@ Untracked files:
 
 EOF
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 # we expect the same as the previous test
 test_expect_success 'status --untracked-files=all does not show submodule' '
 	git status --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<EOF
@@ -984,13 +984,13 @@ Untracked files:
 EOF
 	git config status.submodulesummary 10 &&
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'status submodule summary with status.displayCommentPrefix=false' '
 	strip_comments expect &&
 	git -c status.displayCommentPrefix=false status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'commit with submodule summary ignores status.displayCommentPrefix' '
@@ -1035,9 +1035,9 @@ EOF
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
 	test_must_fail git commit --dry-run >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 cat >expect <<EOF
@@ -1091,7 +1091,7 @@ Untracked files:
 EOF
 	git config status.submodulesummary 10 &&
 	git commit --dry-run --amend >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository' '
@@ -1143,17 +1143,17 @@ Untracked files:
 EOF
 	echo modified  sm/untracked &&
 	git status --ignore-submodules=untracked >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success '.gitmodules ignore=untracked suppresses submodules with untracked content' '
 	test_config diff.ignoreSubmodules dirty &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1163,14 +1163,14 @@ test_expect_success '.git/config ignore=untracked suppresses submodules with unt
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname
 '
 
 test_expect_success '--ignore-submodules=dirty suppresses submodules with untracked content' '
 	git status --ignore-submodules=dirty >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success '.gitmodules ignore=dirty suppresses submodules with untracked content' '
@@ -1180,7 +1180,7 @@ test_expect_success '.gitmodules ignore=dirty suppresses submodules with untrack
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1190,7 +1190,7 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with untrack
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1198,14 +1198,14 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with untrack
 test_expect_success '--ignore-submodules=dirty suppresses submodules with modified content' '
 	echo modified >sm/foo &&
 	git status --ignore-submodules=dirty >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success '.gitmodules ignore=dirty suppresses submodules with modified content' '
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1215,7 +1215,7 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1253,14 +1253,14 @@ Untracked files:
 
 EOF
 	git status --ignore-submodules=untracked > output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success ".gitmodules ignore=untracked doesn't suppress submodules with modified content" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1270,7 +1270,7 @@ test_expect_success ".git/config ignore=untracked doesn't suppress submodules wi
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1314,14 +1314,14 @@ Untracked files:
 
 EOF
 	git status --ignore-submodules=untracked > output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success ".gitmodules ignore=untracked doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1331,20 +1331,20 @@ test_expect_success ".git/config ignore=untracked doesn't suppress submodule sum
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
 test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summary" '
 	git status --ignore-submodules=dirty > output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 test_expect_success ".gitmodules ignore=dirty doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1354,7 +1354,7 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1398,7 +1398,7 @@ EOF
 test_expect_success "status (core.commentchar with submodule summary)" '
 	test_config core.commentchar ";" &&
 	git -c status.displayCommentPrefix=true status >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success "status (core.commentchar with two chars with submodule summary)" '
@@ -1429,7 +1429,7 @@ Untracked files:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --ignore-submodules=all > output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summary' '
@@ -1460,7 +1460,7 @@ EOF
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1470,7 +1470,7 @@ test_expect_success '.git/config ignore=all suppresses unstaged submodule summar
 	git config --add submodule.subname.ignore all &&
 	git config --add submodule.subname.path sm &&
 	git status > output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1571,7 +1571,7 @@ Changes not staged for commit:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git commit -uno --dry-run >output &&
-	test_i18ncmp expect output &&
+	test_cmp expect output &&
 	git status -s --ignore-submodules=dirty >output &&
 	test_i18ngrep "^M. sm" output
 '
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 9f5e3ce7931..7f2956d77ad 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -41,7 +41,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -61,7 +61,7 @@ Changes to be committed:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -93,7 +93,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -116,7 +116,7 @@ Changes to be committed:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -154,7 +154,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -180,7 +180,7 @@ Changes to be committed:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -210,7 +210,7 @@ You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -249,7 +249,7 @@ Changes not staged for commit:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -282,7 +282,7 @@ You are currently editing a commit while rebasing branch '\''amend_last'\'' on '
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -321,7 +321,7 @@ You are currently editing a commit while rebasing branch '\''several_edits'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -356,7 +356,7 @@ Changes not staged for commit:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -387,7 +387,7 @@ You are currently editing a commit while rebasing branch '\''several_edits'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -418,7 +418,7 @@ You are currently editing a commit while rebasing branch '\''several_edits'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -454,7 +454,7 @@ Changes not staged for commit:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -486,7 +486,7 @@ You are currently editing a commit while rebasing branch '\''several_edits'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -519,7 +519,7 @@ You are currently editing a commit while rebasing branch '\''several_edits'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -557,7 +557,7 @@ Changes not staged for commit:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -591,7 +591,7 @@ You are currently editing a commit while rebasing branch '\''several_edits'\'' o
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -619,7 +619,7 @@ You are in the middle of an am session.
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -641,7 +641,7 @@ You are in the middle of an am session.
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -664,7 +664,7 @@ The current patch is empty.
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -687,7 +687,7 @@ You are currently bisecting, started from branch '\''bisect'\''.
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -712,7 +712,7 @@ Unmerged paths:
 no changes added to commit
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -746,7 +746,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 
@@ -770,7 +770,7 @@ Changes to be committed:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status when cherry-picking after committing conflict resolution' '
@@ -789,7 +789,7 @@ Cherry-pick currently in progress.
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status shows cherry-pick with invalid oid' '
@@ -798,7 +798,7 @@ test_expect_success 'status shows cherry-pick with invalid oid' '
 	git status --untracked-files=no >actual 2>err &&
 	git cherry-pick --quit &&
 	test_must_be_empty err &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status does not show error if .git/sequencer is a file' '
@@ -816,7 +816,7 @@ HEAD detached at atag
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual &&
+	test_cmp expected actual &&
 
 	git reset --hard HEAD^ &&
 	cat >expected <<\EOF &&
@@ -824,7 +824,7 @@ HEAD detached from atag
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status while reverting commit (conflicts)' '
@@ -852,7 +852,7 @@ Unmerged paths:
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status while reverting commit (conflicts resolved)' '
@@ -872,7 +872,7 @@ Changes to be committed:
 Untracked files not listed (use -u option to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status after reverting commit' '
@@ -882,7 +882,7 @@ On branch main
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status while reverting after committing conflict resolution' '
@@ -901,7 +901,7 @@ Revert currently in progress.
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'prepare for different number of commits rebased' '
@@ -931,7 +931,7 @@ You are currently editing a commit while rebasing branch '\''several_commits'\''
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status: two commands done with some white lines in done file' '
@@ -959,7 +959,7 @@ You are currently editing a commit while rebasing branch '\''several_commits'\''
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status: two remaining commands with some white lines in todo file' '
@@ -988,7 +988,7 @@ You are currently editing a commit while rebasing branch '\''several_commits'\''
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'status: handle not-yet-started rebase -i gracefully' '
@@ -1007,7 +1007,7 @@ You are currently editing a commit while rebasing branch '\''several_commits'\''
 
 nothing to commit (use -u to show untracked files)
 EOF
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_done
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index fbfdcca0007..45d025f9601 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -236,7 +236,7 @@ test_expect_success 'refresh_index() invalidates fsmonitor cache' '
 	git reset HEAD~1 &&
 	git status >actual &&
 	git -c core.fsmonitor= status >expect &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 # test fsmonitor with and without preloadIndex
@@ -273,7 +273,7 @@ do
 			git add dir2/new &&
 			git status >actual &&
 			git -c core.fsmonitor= status >expect &&
-			test_i18ncmp expect actual
+			test_cmp expect actual
 		'
 
 		# Make sure it's actually skipping the check for modified and untracked
diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
index 91790943c3d..a88b02b06ed 100755
--- a/t/t7521-ignored-mode.sh
+++ b/t/t7521-ignored-mode.sh
@@ -30,7 +30,7 @@ test_expect_success 'Verify behavior of status on directories with ignored files
 		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify status behavior on directory with tracked & ignored files' '
@@ -55,7 +55,7 @@ test_expect_success 'Verify status behavior on directory with tracked & ignored
 	git commit -m "commit tracked files" &&
 
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify status behavior on directory with untracked and ignored files' '
@@ -80,7 +80,7 @@ test_expect_success 'Verify status behavior on directory with untracked and igno
 		dir/untracked_ignored/ignored_1.ign dir/untracked_ignored/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify status matching ignored files on ignored directory' '
@@ -96,7 +96,7 @@ test_expect_success 'Verify status matching ignored files on ignored directory'
 		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify status behavior on ignored directory containing tracked file' '
@@ -117,7 +117,7 @@ test_expect_success 'Verify status behavior on ignored directory containing trac
 	git add -f ignored_dir/tracked &&
 	git commit -m "Force add file in ignored directory" &&
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
@@ -136,7 +136,7 @@ test_expect_success 'Verify matching ignored files with --untracked-files=normal
 		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
 		untracked_dir/untracked &&
 	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
@@ -155,7 +155,7 @@ test_expect_success 'Verify matching ignored files with --untracked-files=normal
 		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
 		untracked_dir/untracked &&
 	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify status behavior on ignored directory containing tracked file' '
@@ -176,7 +176,7 @@ test_expect_success 'Verify status behavior on ignored directory containing trac
 	git add -f ignored_dir/tracked &&
 	git commit -m "Force add file in ignored directory" &&
 	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify behavior of status with --ignored=no' '
@@ -191,7 +191,7 @@ test_expect_success 'Verify behavior of status with --ignored=no' '
 		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=no --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify behavior of status with --ignored=traditional and --untracked-files=all' '
@@ -210,7 +210,7 @@ test_expect_success 'Verify behavior of status with --ignored=traditional and --
 		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=traditional --untracked-files=all >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'Verify behavior of status with --ignored=traditional and --untracked-files=normal' '
@@ -227,7 +227,7 @@ test_expect_success 'Verify behavior of status with --ignored=traditional and --
 		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=traditional --untracked-files=normal >output &&
-	test_i18ncmp expect output
+	test_cmp expect output
 '
 
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b2c1d861dcb..1cbc9715a81 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -272,7 +272,7 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	EOF
 	git cat-file commit HEAD >raw &&
 	sed -e "1,/^$/d" raw >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
@@ -296,7 +296,7 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 	EOF
 	git cat-file commit HEAD >raw &&
 	sed -e "1,/^$/d" raw >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_debug 'git log --graph --decorate --oneline --all'
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 13859ec8595..a9c816b47f2 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -66,7 +66,7 @@ EOF
 test_expect_success 'merge output uses pretty names' '
 	git reset --hard c1 &&
 	git merge c2 c3 c4 >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -84,7 +84,7 @@ test_expect_success 'merge reduces irrelevant remote heads' '
 		rm expected.tmp
 	fi &&
 	GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -101,7 +101,7 @@ EOF
 test_expect_success 'merge fast-forward output uses pretty names' '
 	git reset --hard c0 &&
 	git merge c1 c2 >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_done
-- 
2.30.0.284.gd98b1dd5eaa7

