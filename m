Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F9DC433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 01:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiKSBnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiKSBms (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 20:42:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469685A05
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 16:50:34 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so16789061ejb.13
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 16:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbnxNPkD/tBk8mexggAmk/fbagHB969gN62HVwBMN1E=;
        b=eUQV6doGaCvGwfJxLgx/mBDS/X82dgKPdH88aESoaWlTV6oSHdlXkuiJpS2voNmxfh
         27u7jpFqu9l6RFcy9nUj9jDrRWGUNfiKhUuGjZXkXAcwE2S3XE06/VU5ikABYcXeOwic
         6ovEgTtx/18mLH9gHWws4CUtIk3LNSNVRxkIdsl/yGGU8EmU6HMNtKZ363awQ+oG6IPU
         hzkrWFJP9eobmGSqFPlSL6363BLThKTx7Q41RAxtionVO1lQfQfQ7axQ6OeuTIE00zUw
         bkqXrRr2VodB652o+ijzh1izDUpaaNNfoYp4nPC0xl+2qLwVhJ0nofEndjAkIONhJmV+
         NZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbnxNPkD/tBk8mexggAmk/fbagHB969gN62HVwBMN1E=;
        b=lN000PV0KWaE18mbEkNIJmZBsNYZKFkoldUWqs85gS9dIXSrArkCOMUix++dUjx2BJ
         KLn3V2sU8qzjhoaqxPDuCZ8U0iHLJjJNGQ38ux3wF5A5zUR/E747ae5LVvBMiT7ud7/D
         sfEo7Vc58SBNbp3mwHdAVZ7/6JBZsNVc3QCM51N9PLEwUccnZgrPJdeB4wC5nujHNr+t
         8TOr91Chwu0SFOzy0HPGA6Lnhiqe55/8o3ZV743n2aXEWKf5OudOaD5K1WYt7LVTpWD6
         ZOWIxQfNBe4En/mOMrWV5mOJ14rt539BMrwPl/2IlEA99bskwnRsCijaiMzkQWYnmmox
         EOgQ==
X-Gm-Message-State: ANoB5pkhiFxAAusFaszfsz7B85r+btYFNzPUfFUCAIQ8pzAkOCxupkUg
        /yWpZpW0O96YRHGCHXXbCmYeW5XIAD4=
X-Google-Smtp-Source: AA0mqf5bNbQ5e5zDqNmBWwaJiwOtKUXRHFH6yhMMdzYHNvbNkb2nbpCT/4iNFfRtwV4JyOJeR/FMOw==
X-Received: by 2002:a17:906:901:b0:7ae:23c:3cb4 with SMTP id i1-20020a170906090100b007ae023c3cb4mr7721845ejd.599.1668819032547;
        Fri, 18 Nov 2022 16:50:32 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id mf20-20020a1709071a5400b0078a543e9301sm2258883ejc.200.2022.11.18.16.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:50:32 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] am: Allow passing --no-verify flag
Date:   Sat, 19 Nov 2022 01:50:31 +0100
Message-Id: <20221119005031.3170699-1-thierry.reding@gmail.com>
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
Changes in v2:
- add test to verify that the new option works

 Documentation/git-am.txt |  8 +++++-
 builtin/am.c             | 11 ++++++--
 t/t4154-am-noverify.sh   | 60 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100755 t/t4154-am-noverify.sh

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
index 20aea0d2487b..26ad8a468dc4 100644
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
@@ -2329,6 +2332,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
+		OPT_BOOL('n', "no-verify", &state.no_verify,
+			N_("bypass pre-applypatch and applypatch-msg hooks")),
 		OPT_HIDDEN_BOOL('b', "binary", &binary,
 			N_("historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
diff --git a/t/t4154-am-noverify.sh b/t/t4154-am-noverify.sh
new file mode 100755
index 000000000000..fbf45998243f
--- /dev/null
+++ b/t/t4154-am-noverify.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git am --no-verify'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "root" >file &&
+	git add file &&
+	git commit -m "zeroth" &&
+	git branch side-success &&
+	git branch side-failure &&
+	echo "foo" >>file &&
+	git add file &&
+	git commit -m "first" &&
+	git format-patch --stdout HEAD^ >patch1
+'
+
+setup_success_hook () {
+	test_when_finished "rm -f actual_hooks expected_hooks" &&
+	echo "$1" >expected_hooks &&
+	test_hook "$1" <<-EOF
+	echo $1 >>actual_hooks
+	EOF
+}
+
+test_expect_success '--no-verify with succeeding hook' '
+	setup_success_hook "pre-applypatch" &&
+	setup_success_hook "applypatch-msg" &&
+	git checkout side-success &&
+	git am --no-verify patch1
+'
+
+setup_failing_hook () {
+	test_when_finished "rm -f actual_hooks" &&
+	test_hook "$1" <<-EOF
+	echo $1-failing-hook >>actual_hooks
+	exit 1
+	EOF
+}
+
+test_expect_failure 'with failing hook' '
+	test_when_finished "git am --abort" &&
+	setup_failing_hook "pre-applypatch" &&
+	setup_failing_hook "applypatch-msg" &&
+	git checkout side-failure &&
+	git am patch1
+'
+
+test_expect_success '--no-verify with failing hook' '
+	setup_success_hook "pre-applypatch" &&
+	setup_success_hook "applypatch-msg" &&
+	git checkout side-failure &&
+	git am --no-verify patch1
+'
+
+test_done
-- 
2.38.1

