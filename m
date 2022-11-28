Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB85FC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiK1SCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiK1SCG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:02:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6045EE5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 09:48:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m19so15235272edj.8
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 09:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9nnjTllyBcoBrM+3tD0YB91UufSkuog1IRZOB0D1tA=;
        b=Yd6iLiyvvQKOGfaGVRZaLkYtAAooo5LUMlLYJDjgOz8cXmGlepxGH9FNm5orRs0mZD
         O7OIThqyR9tlMq8ouljT1h8lVOOo0biZuP6GGO1rzmM0+Uk8eM9dHe6WfeKYKoHWTipg
         JcGeXpo2k/rileyxY1GrbZSiSvvZR4esQgMir3kzTmrBQ8LiN6mm/kvKuXdfPacJMyIt
         /XY+j4oKnlKNDxTfJFLeQA1Xi+X5LOYzEJyC19uX33thO1IjpXzmRQQfBJa5CxFgRUxJ
         i8Ik0HBofluZD2zbFwlC92VkIeBIMfDOQC8yRavLjevdrj/YREuVjxxZSg1EtadPajyA
         KI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9nnjTllyBcoBrM+3tD0YB91UufSkuog1IRZOB0D1tA=;
        b=kZnhhCbdCeJDu7lyMP44iLPAd1eJX94zsVcuMJxrgonkGVUTiRZFoyWrs6rzlpD8iz
         MsQaOkA8s/7KUc+3JhCdwWpxAiM9CyeWnkV91ATSXYhwT422b3+ZKvcWevjZv9HjO5Oo
         Fp0TH37rW489B0+I+mepMRLmPMf5fTTpVdVZdGFu1iy3kHEpGKrxtMeNpnQ9og5v0wdH
         huKl8RygQFedz7uWUyC6wD5aGkmIIgKv9iPxr19LEroeTXEVzcI1LWp0Hphyw8AwMSlX
         Y63eMV4/D0zreuUVUx3CmMc59KVVgQyrUIn75tRdEH6xhVdJz3+gB5MmpFaX2d/akRh5
         D6qw==
X-Gm-Message-State: ANoB5plkwrs5oUHIuUdL8Fsu1lCxfs9c7Y3dkBQU9V3GHRAa7g2kJa36
        KghySJ6043X7ea5QBcZna72i7h8v50I=
X-Google-Smtp-Source: AA0mqf7vn0l/M+5H4yCSsWBGvUvwTnVx6o5AU3/tYx4X0Hlk3hk8VV3RdZ/li7DW3acPQW/JQWC01Q==
X-Received: by 2002:a05:6402:5388:b0:46a:f4b0:2d23 with SMTP id ew8-20020a056402538800b0046af4b02d23mr9911181edb.78.1669657710019;
        Mon, 28 Nov 2022 09:48:30 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b00463c475684csm5403881edx.73.2022.11.28.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:48:29 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] am: Allow passing --no-verify flag
Date:   Mon, 28 Nov 2022 18:48:25 +0100
Message-Id: <20221128174825.1510407-1-thierry.reding@gmail.com>
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
Changes in v3:
- move tests to existing t/t4150-am

Changes in v2:
- add test to verify that the new option works

 Documentation/git-am.txt |  8 +++++++-
 builtin/am.c             | 11 ++++++++---
 t/t4150-am.sh            | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

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
index cdad4b688078..84e6bebeca7a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -345,6 +345,16 @@ test_expect_success 'am with failing applypatch-msg hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with failing applypatch-msg hook (no verify)' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_hook applypatch-msg <<-\EOF &&
+	exit 1
+	EOF
+	git am --no-verify patch1
+'
+
 test_expect_success 'am with pre-applypatch hook' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
@@ -374,6 +384,16 @@ test_expect_success 'am with failing pre-applypatch hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with failing pre-applypatch hook (no verify)' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_hook pre-applypatch <<-\EOF &&
+	exit 1
+	EOF
+	git am --no-verify patch1
+'
+
 test_expect_success 'am with post-applypatch hook' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.38.1

