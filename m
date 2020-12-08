Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC76C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABB823A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgLHA1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLHA1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:27:37 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103BC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:26:51 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 15so6406688oix.8
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0AD2JBGiNlHy90T6GND2uz3DdXgG0Ql/jOUQNFbxH8=;
        b=uMOm+lZSkgCGl7rSQQGIGlFWtjZYs/FYxnHxjO54XHkiUl7yYGlIZs/UyaMiWnHbEx
         4k4yJsSTkNq9LXdBGyBMrbfTTDeDTeHa7MXV3jc1vavJkJf4W4+33G1zj90VBoo9QRQd
         kLikmtiE0RS8HLbXUzbSyWGMsWxOqYrNRRw5fpnr7vLEGtJnj1S2CdblMcNgsUrvvzh2
         7201u1tE7oVBflYB53i4wkS9q95e2jNKVAOcw/DSMQU1wlxjB8nhIkJ98crW1b7NSiPr
         hNoCoM3hkqAZujhoFzPKcf3i93gHRaxBjOd1zPxKE6HNQtTFoucODu+duhkTUudlP0/5
         /1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0AD2JBGiNlHy90T6GND2uz3DdXgG0Ql/jOUQNFbxH8=;
        b=aNQkFOnrcpE+SgFXwCPQw607HnTNEZo0AQuF1UOwiLVw1oLjfgZzp7W+lyV/PXnFP7
         jZ9rIh+DlGCEut3x79JrOpg27d9Pgq1tth2jI+wFqvQfiKZ5h+0q/bJAP5dw69xhfiDN
         SJgt5oGQofWI5VXjVYfiCDrN40Be7z9rrHqzH/IshmnoBtLfu1cjNOZ3Wu+P9w4BcXn4
         ApMU2+6K1hc6tHFzKFe1U20O1aq1kxenZNLYpqq8op09akEnpW6iSNIw+nPL/ggUH7x9
         sixJAMyAnUjp/TqFsSEV2jqwIdKxmO73ASKXe4aXg7+aGO1R64vnbcPZcK+itLnWaBeH
         i+cA==
X-Gm-Message-State: AOAM532vx4R3lIdUciQ2DgDssqHhszmGwdNgJDF1QgjDK/RpC+rGEUvZ
        LMWnH40gNWIndrkLCuiYiNsxzYS4ClcUSM02
X-Google-Smtp-Source: ABdhPJwFjxC+ixoJUabb7Kb6smRxXE8zQtDWJpT2zk93BtTJ2ssumDDV6tbohh/ShImVEjHRVDDWZg==
X-Received: by 2002:aca:d4cf:: with SMTP id l198mr988066oig.170.1607387210526;
        Mon, 07 Dec 2020 16:26:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k20sm3360456oig.35.2020.12.07.16.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/19] pull: default ff-only mode
Date:   Mon,  7 Dec 2020 18:26:29 -0600
Message-Id: <20201208002648.1370414-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old thread "Pull is Mostly Evil" [1] came to haunt us again.

This is my latest attempt to try to fix it.

This patch series is divided in 3 parts:

== Part I ==

1. Improve the current documentation
2. Improve the current default warning
3. Minimize the instances where we display the default warning
4. Add a --merge option
5. Fix the behavior of the warning with --ff

== Part II ==

1. Introduce pull.mode
2. Introduce pull.mode=ff-only
3. Advice on future changes, and suggest changing pull.mode

== Part III ==

1. Change the default mode to pull.mode=ff-only

v3 of the series only did part I, and the interdiff is only of that part.

Since then the change in semantics of --ff-only is dropped, because
that solution didn't pan out, and now I'm sending the one I think
it will: "pull.mode=ff-only".

Plus a fixed typo, and fixed a merge conflict with the latest master
(not in the interdiff).

If this is a bit overwhelming, you can check the branches in my gitlab[2].

 * fc/pull/improvements (part 1)
 * fc/pull/ff-only (part 2)
 * fc/pull/ff-only-switch (part 3)

[1] https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/
[2] https://gitlab.com/felipec/git/

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c220da143a..21b50aff77 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -44,13 +44,13 @@ Assume the following history exists and the current branch is
     D---E master
 ------------
 
-Then `git pull` will merge in a fast-foward way up to the new master.
+Then `git pull` will merge in a fast-forward way up to the new master.
 
 ------------
     D---E---A---B---C master, origin/master
 ------------
 
-However, a non-fast-foward case looks very different.
+However, a non-fast-forward case looks very different.
 
 ------------
 	  A---B---C master on origin
diff --git a/builtin/pull.c b/builtin/pull.c
index 0735c77f42..97a7657473 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -112,24 +112,6 @@ static int opt_show_forced_updates = -1;
 static char *set_upstream;
 static struct strvec opt_fetch = STRVEC_INIT;
 
-static int parse_opt_ff_only(const struct option *opt, const char *arg, int unset)
-{
-	char **value = opt->value;
-	opt_rebase = REBASE_DEFAULT;
-	free(*value);
-	*value = xstrdup_or_null("--ff-only");
-	return 0;
-}
-
-static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
-{
-	enum rebase_type *value = opt->value;
-	free(opt_ff);
-	opt_ff = NULL;
-	*value = REBASE_FALSE;
-	return 0;
-}
-
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -147,9 +129,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
-		N_("incorporate changes by merging"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -178,9 +159,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
-	OPT_CALLBACK_F(0, "ff-only", &opt_ff, NULL,
+	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_ff_only),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -1027,25 +1008,19 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!can_ff && !opt_rebase) {
-		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
-			die(_("The pull was not fast-forward, please either merge or rebase."));
-
-		if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-			advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-				"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
-				"You can squelch this message by running one of the following commands:\n"
-				"\n"
-				"  git config pull.rebase false  # merge (the default strategy)\n"
-				"  git config pull.rebase true   # rebase\n"
-				"  git config pull.ff only       # fast-forward only\n"
-				"\n"
-				"You can replace \"git config\" with \"git config --global\" to set a default\n"
-				"preference for all repositories.\n"
-				"If unsure, run \"git pull --merge\".\n"
-				"Read \"git pull --help\" for more information."
-				));
-		}
+	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
+		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+			"you need to specify if you want a merge, or a rebase.\n"
+			"You can squelch this message by running one of the following commands:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories.\n"
+			"If unsure, run \"git pull --merge\".\n"
+			"Read \"git pull --help\" for more information."));
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0cdac4010b..9fae07cdfa 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -819,89 +819,4 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
-setup_other () {
-	test_when_finished "git checkout master && git branch -D other test" &&
-	git checkout -b other $1 &&
-	>new &&
-	git add new &&
-	git commit -m new &&
-	git checkout -b test -t other &&
-	git reset --hard master
-}
-
-setup_ff () {
-	setup_other master
-}
-
-setup_non_ff () {
-	setup_other master^
-}
-
-test_expect_success 'fast-forward (ff-only)' '
-	test_config pull.ff only &&
-	setup_ff &&
-	git pull
-'
-
-test_expect_success 'non-fast-forward (ff-only)' '
-	test_config pull.ff only &&
-	setup_non_ff &&
-	test_must_fail git pull
-'
-
-test_expect_success 'non-fast-forward with merge (ff-only)' '
-	test_config pull.ff only &&
-	setup_non_ff &&
-	git pull --merge
-'
-
-test_expect_success 'non-fast-forward with rebase (ff-only)' '
-	test_config pull.ff only &&
-	setup_non_ff &&
-	git pull --rebase
-'
-
-test_expect_success 'non-fast-forward error message (ff-only)' '
-	test_config pull.ff only &&
-	setup_non_ff &&
-	test_must_fail git pull 2> error &&
-	cat error &&
-	grep -q "The pull was not fast-forward" error
-'
-
-test_expect_success '--merge overrides --ff-only' '
-	setup_non_ff &&
-	git pull --ff-only --merge
-'
-
-test_expect_success '--rebase overrides --ff-only' '
-	setup_non_ff &&
-	git pull --ff-only --rebase
-'
-
-test_expect_success '--ff-only overrides --merge' '
-	setup_non_ff &&
-	test_must_fail git pull --merge --ff-only
-'
-
-test_expect_success '--ff-only overrides pull.rebase=false' '
-	test_config pull.rebase false &&
-	setup_non_ff &&
-	test_must_fail git pull --ff-only
-'
-
-test_expect_success 'pull.rebase=true overrides pull.ff=only' '
-	test_config pull.ff only &&
-	test_config pull.rebase true &&
-	setup_non_ff &&
-	git pull
-'
-
-test_expect_success 'pull.rebase=false overrides pull.ff=only' '
-	test_config pull.ff only &&
-	test_config pull.rebase false &&
-	setup_non_ff &&
-	test_must_fail git pull
-'
-
 test_done


Felipe Contreras (19):
  doc: pull: explain what is a fast-forward
  pull: improve default warning
  pull: refactor fast-forward check
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: move default warning
  pull: display default warning only when non-ff
  pull: trivial whitespace style fix
  pull: introduce --merge option
  pull: show warning with --ff
  rebase: add REBASE_DEFAULT
  pull: move configurations fetches
  test: merge-pull-config: trivial cleanup
  test: pull-options: revert unnecessary changes
  pull: trivial memory fix
  pull: add pull.mode
  pull: add pull.mode=ff-only
  pull: advice of future changes
  future: pull: enable ff-only mode by default

 Documentation/config/branch.txt |   6 ++
 Documentation/config/pull.txt   |   6 ++
 Documentation/git-pull.txt      |  24 ++++-
 builtin/pull.c                  | 157 +++++++++++++++++++++-----------
 builtin/remote.c                |  22 ++++-
 rebase.c                        |  12 +++
 rebase.h                        |  13 ++-
 t/t5520-pull.sh                 |  87 ++++++++++++++++++
 t/t5521-pull-options.sh         |  22 ++---
 t/t7601-merge-pull-config.sh    |  60 ------------
 10 files changed, 282 insertions(+), 127 deletions(-)

-- 
2.29.2

