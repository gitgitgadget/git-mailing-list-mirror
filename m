Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5941C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK3R2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiK3R2n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 12:28:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF14323BD9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 09:28:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ha10so43122657ejb.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 09:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2zJc658qMbF8b15K9R1H9TPI4+MHukBaeWeGfomKgA=;
        b=n3eZOZ8YvD2gc7dS1dAeypw9oKTpXKSiOOFx8zYSr6lG7KSttptsBn4/8NEH/jbBl4
         EfQdGjhw3Bv+O7pJHJ2zCetrIyl/C3C6gRs5M83i75BUlSVKhiwS4FW6+zMNTTcjSaSW
         ylh82rtDNpjkzO66uoGK72OablF8AkbKBK8+hjiBaeKZr8c/L/E0fwInEazSTWmY9Wro
         pRDHQdWMOA2fAryVvXW3hFFsqIo7rpcHCRwwd0wxkipJ9EWTeyyK9Tz7qjifts/m50/f
         y9/NJu0Gl4gg50nlJj6o8Z2/DWbhT5KVDu01XflzAAdvZj6XrCP+1TrfSg2BcrLNaAvp
         Y8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2zJc658qMbF8b15K9R1H9TPI4+MHukBaeWeGfomKgA=;
        b=uwyXF5HQgBljiGRQu00qWxF6qjfnnE2byFQdgHcByRXQx96j6VCVVUKrAGjkkQDpaV
         Sz06bu/cMCRRik+2eI1xn2b2G9OsbMhrXcTgqRhaYtZ0EdHMg+wQkJ+shCBJ+q4FRvjp
         DKa6Jzu3OpuxZqE8hRkxg9vO28mBvsyMqBJBNs8t+rRbuAM7Spke/6w4EmGzJ3nA4BaB
         GKQcZLyzU4DDP4rSVrf3uZI/ZBhLUFRxisa+KVErrBNDdowNVV5oNfRZSkdwpyMhbTqZ
         xMKM6j9yRmqnj+FieDcF/nIx7+qagvcVOYXe8jm6DZTsv9hjg6dyzz+4ec6t/KqXRPHA
         uktg==
X-Gm-Message-State: ANoB5pkUMothZw7Q4t8TXWP908ILgqJgLhG2gONm2SQ5fUgdUCdDqC7/
        2GVLoZm/99IDAkAmSesH8hiQcriHDag=
X-Google-Smtp-Source: AA0mqf7IfSo9zoYImwzxpojfceh5sRytGhYAq3JYPeMSD5WeL5KAaZ6BRui3jV6p+3OSFRMdr5BZUw==
X-Received: by 2002:a17:906:3954:b0:7bf:852b:e23c with SMTP id g20-20020a170906395400b007bf852be23cmr13780903eje.614.1669829320740;
        Wed, 30 Nov 2022 09:28:40 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b007ae566edb8bsm865893ejb.73.2022.11.30.09.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:28:40 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] am: Allow passing --no-verify flag
Date:   Wed, 30 Nov 2022 18:28:33 +0100
Message-Id: <20221130172833.2662751-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The git-am --no-verify flag is analogous to the same flag passed to
git-commit. It bypasses the pre-applypatch and applypatch-msg hooks
if they are enabled.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- check that scripts haven't run and that commits have been applied

Changes in v3:
- move tests to existing t/t4150-am

Changes in v2:
- add test to verify that the new option works

 Documentation/git-am.txt |  8 +++++++-
 builtin/am.c             | 11 ++++++++---
 t/t4150-am.sh            | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 326276e51ce5..0c1dfb3c98b4 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
+'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-verify]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -138,6 +138,12 @@ include::rerere-options.txt[]
 --interactive::
 	Run interactively.
 
+-n::
+--no-verify::
+	By default, the pre-applypatch and applypatch-msg hooks are run.
+	When any of `--no-verify` or `-n` is given, these are bypassed.
+	See also linkgit:githooks[5].
+
 --committer-date-is-author-date::
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
diff --git a/builtin/am.c b/builtin/am.c
index 30c9b3a9cd72..dfe8104f570d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -117,6 +117,7 @@ struct am_state {
 
 	/* various operating modes and command line options */
 	int interactive;
+	int no_verify;
 	int threeway;
 	int quiet;
 	int signoff; /* enum signoff_type */
@@ -472,10 +473,12 @@ static void am_destroy(const struct am_state *state)
  */
 static int run_applypatch_msg_hook(struct am_state *state)
 {
-	int ret;
+	int ret = 0;
 
 	assert(state->msg);
-	ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
+
+	if (!state->no_verify)
+		ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1640,7 +1643,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hooks("pre-applypatch"))
+	if (!state->no_verify && run_hooks("pre-applypatch"))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -2330,6 +2333,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
+		OPT_BOOL('n', "no-verify", &state.no_verify,
+			N_("bypass pre-applypatch and applypatch-msg hooks")),
 		OPT_HIDDEN_BOOL('b', "binary", &binary,
 			N_("historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cdad4b688078..d77c4dcefeb7 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -345,6 +345,22 @@ test_expect_success 'am with failing applypatch-msg hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with failing applypatch-msg hook (no verify)' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_hook applypatch-msg <<-\EOF &&
+	echo hook-message >"$1"
+	exit 1
+	EOF
+	git am --no-verify patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	git log -1 --format=format:%B >actual &&
+	test_cmp msg actual
+'
+
 test_expect_success 'am with pre-applypatch hook' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
@@ -374,6 +390,22 @@ test_expect_success 'am with failing pre-applypatch hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with failing pre-applypatch hook (no verify)' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	touch empty-file &&
+	test_hook pre-applypatch <<-\EOF &&
+	rm empty-file
+	exit 1
+	EOF
+	git am --no-verify patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	test_path_is_file empty-file
+'
+
 test_expect_success 'am with post-applypatch hook' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.38.1

