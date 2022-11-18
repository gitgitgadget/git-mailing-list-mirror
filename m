Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48665C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 13:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiKRN1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbiKRN1v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 08:27:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86685A2F
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 05:27:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so7133123edb.9
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ9osMGteyCbEKsy7iUKyds88ZDJpYP3bzw9K+r3NZw=;
        b=Yo7cUzWuk6S0RlUQ30ogFN0csDFFry7OdxPH8gJYlBuw8Lg0Sla7ZAIxC1HSsn9byB
         MVKUwMlJmVdFSFXhdFtzZfl1UBmgd80s+bn/f1umLbSGZ73dHirLOnckvOuDNJDS+xKq
         dunIKhZ6AJrV4nHKPXFlT94thv64ng7wBXgIjY93vCHoL1i01U/A8yd2TJlWcBOqgEyl
         rHyDd5fpmHxMjPCo93awTczDAFR2b5MMYrH5DsMjfxZvp9/CbbFZE60kABiLgDr/2N97
         jj7n6dFocD7W/rtl1zpDqVElAwe+kWk2iD0UcU4aDFfXsTRqG/gIsr0UlLBAA0ZqBtoi
         J9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ9osMGteyCbEKsy7iUKyds88ZDJpYP3bzw9K+r3NZw=;
        b=1kYWUtlCHrIGCbRDaRaZP0F3cUBUodsKVvu4dSaKkTL2oPQzQD+s4dQTZCEdAULtLf
         Q/kJ/Ga7udAwgCijvOIWqp4WxzbLD4enLz5yJ5slUxP6l0edwnEdAf7xtvE+gOyTBDWt
         kM1iWW7DV6Q6tAzwUx9tEa6PYqZ/7e4Fk9lVRJl4Sm+GehHvlj3BSEMrAmvOy5tWy7l2
         dYZHMRbaID906j4FkkCawru233ohc9uyIcn1JS13pGtREMELnzVTQbOeAfhAMT3n/lNE
         mhx9ySl50c4rr8+oWxijeiQdWqJogfWZ35jhD+NgHVFewEyuh+lTi7GbjBryqMzg65Pa
         /BZg==
X-Gm-Message-State: ANoB5pnxvVLn4U/zyNFPR2JJH/OGyP1NbkBf6PsIGhLOof1l2I7j1wdi
        2LxIIg+qZDabfNtHU7rn22Hefeebcys=
X-Google-Smtp-Source: AA0mqf6eBRnorEQBVKClE6yTjh5N/dGtamiqP9/ivxwHrxIe0xVHHrQ4ctVZcE0cYS1rjPiQC1kRoA==
X-Received: by 2002:aa7:d408:0:b0:468:677a:877 with SMTP id z8-20020aa7d408000000b00468677a0877mr6094995edq.407.1668778067133;
        Fri, 18 Nov 2022 05:27:47 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a18-20020a50ff12000000b00463a83ce063sm1778350edu.96.2022.11.18.05.27.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:27:46 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] am: Allow passing --no-verify flag
Date:   Fri, 18 Nov 2022 14:27:43 +0100
Message-Id: <20221118132743.3525725-1-thierry.reding@gmail.com>
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
 Documentation/git-am.txt |  8 +++++++-
 builtin/am.c             | 11 ++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

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
-- 
2.38.1

