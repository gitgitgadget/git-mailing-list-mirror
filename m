Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3DFC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLQNaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQNaM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:30:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E7CE27
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 1so7520421lfz.4
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQa8j6zINBI6UQtr4mnwQ+qq3aNXNvX6YCSsR8lArTk=;
        b=UXMxxSqq2uzNXzgDJnaMK5XnQuxm4yZEZaClUjY4sD4OmdS/7umvHYItB1RMuPpG8B
         AxKvOMMTCIenlX6+d+ugzlilm43nXKxm0xIX1lxgbgRnoITP0yJ8Q/Zm7OgjHpOxHo58
         FMJeccr8s0C1n3SY4RKYj4V8RkzNis9R6pG9imyA1itnbtYbIYHNaTMbiWGTlahlE9KE
         MEeFalCIWdPktob7RdcIYcUDoHy2SsdOed1xCDNTRq04Yvi6QFH5zYUfH0dj8ir+ESaL
         w1wWf0ZSkB+FXGdrGt8o+IT5Xs7arjOFf7NySKGs/Bv9oHvNVoK5GezsQot7AmhVoLwD
         eLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQa8j6zINBI6UQtr4mnwQ+qq3aNXNvX6YCSsR8lArTk=;
        b=eac1q5dg5uCZVHqZtAnZvbAgtTsbB04xP/PbSqI9nJlkZKvqaW2XravmG+fvR0oGdO
         xqiMJhQB72+MJfpqbZKMLXRR4KpZxjmWmmmIVSxwueYZHcky2a10hOeJLreAI4wQu/56
         cjUVY8d3nhB5Xt9zXhDKFZE4XGW/tdvj9pit7LcH39c2SnAdUS0uq94XyNzcQlhsVI0N
         bTEtFghjz/jB2zcbdJ8HeiOnYm1UVDWErvUlhJKCpAM2ZZOW1y3GxeByrfmGjkHHHMfJ
         Ug6q8sHe+t9ti0wZfcEdBB0MbdWnk7F/vPtlbonAJU3/84xXpHvY7UkmgFDieWmwbJxl
         5GxA==
X-Gm-Message-State: ANoB5pnU2n5hABnKyv0G+hX7nectY56XvMrws+nt/VBVFU40R35uYsfm
        ELuHjZDBtDEJXj7WigWdUN8=
X-Google-Smtp-Source: AA0mqf6O5KbbebpdUCWC/TP4u7KzjuUlQF56HSZtdfFfPX7/3FGMG9BvHBVzNswfAnjR+9ihGxCQTA==
X-Received: by 2002:a19:5048:0:b0:4b5:8298:5867 with SMTP id z8-20020a195048000000b004b582985867mr9527940lfj.66.1671283809053;
        Sat, 17 Dec 2022 05:30:09 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004a100c21eaesm512420lfr.97.2022.12.17.05.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 05:30:08 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 0/5] diff-merges: more features to fix '-m'
Date:   Sat, 17 Dec 2022 16:29:50 +0300
Message-Id: <20221217132955.108542-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patch series is yet another attempt to improve '-m' behavior by
first improving --diff-merges to be able to provide current '-m' semantics,
and then introducing a configuration variable to tweak '-m' behavior.

Below is some historic context of the issue, followed by more thorough
description of the patch series.

The last attempt to fix '-m' option for "git log" to imply '-p', to
make it consistent with similar options (-c/--cc), was called by the
request on the mailing list, here:

https://lore.kernel.org/git/CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com/

However, the suggested (and accepted at first) patch series:

https://lore.kernel.org/git/20210520214703.27323-11-sorganov@gmail.com/#t

appeared to have two problems:

* --diff-merges options are incomplete and have no way to provide
  exact existing '-m' semantics.

* implying '-p' by '-m' by default broke some legacy uses of
  "git log --firt-parent -m".

Due to this, the last patch of those patch series has been later
reverted:

https://lore.kernel.org/git/YQyUM2uZdFBX8G0r@google.com/

effectively leaving the issue unresolved.

These patch series in turn consists of the following patches:

1. --diff-merges=[no]-hide

The set of diff-merges options happened to be incomplete, and failed
to implement exact semantics of -m option that hides output of diffs
for merge commits unless -p option is active as well.

The new "hide" option fixes this issue, so that now

  --diff-merges=on --diff-merges=hide

combo is the exact synonym for -m.

The log.diffMerges configuration also accepts "hide" and "no-hide"
values, and governs the default value for the hide bit. The
configuration behaves as if "--diff-merges=[no-]hide" is inserted
first in the command-line.

A new log.diffMergesHide configuration is introduced as well, to aid
in avoiding of multiple log.diffMerges configuration entries when both
format and hide flag are to be configured.

2. log.diffMerges-m-imply-p

Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
options do. Simply fixing this inconsistency by unconditional
modification of '-m' semantics appeared to be a bad idea, as it broke
some legacy scripts/aliases. This patch rather provides configuration
variable to tweak '-m' behavior accordingly.

3. Support list of values for --diff-merges

This allows for shorter --diff-merges=on,hide forms.

4. Issue warning for lone '-m'.

Lone '-m' is in use by scripts/aliases that aim at enabling diff
output for merge commits, but only if '-p' is then specified as well.

As '-m' may now be configured to imply '-p' (using
'log.diffMerges-m-imply-p'), issue warning if lone '-m' is specified,
and suggest to instead use '--diff-merges=on,hide' that does not
depend on user configuration.

This is expected to give a provision for enabling
log.diffMerges-m-imply-p by default in the future.

5. Improve documentation for --diff-merges.

Updates in v1:

  * Added background context to the patch series foreword.

  * Documentation improvements added in a separate commit.

  * Remove commit unrelated to '-m' behavior.

  * Fix style: (p != NULL) -> (p).

  * Fix documentation placement of 'hide' option.

  * Fix log.diffMergesForce tests to avoid dependency on current
    defaults.

Sergey Organov (5):
  diff-merges: implement [no-]hide option and log.diffMergesHide config
  diff-merges: implement log.diffMerges-m-imply-p config
  diff-merges: support list of values for --diff-merges
  diff-merges: issue warning on lone '-m' option
  diff-merges: improve --diff-merges documentation

 Documentation/config/log.txt                  |   9 ++
 Documentation/diff-options.txt                | 104 +++++++++++-------
 builtin/log.c                                 |   4 +
 diff-merges.c                                 |  76 +++++++++++--
 diff-merges.h                                 |   4 +
 t/t4013-diff-various.sh                       |  71 +++++++++++-
 ...ges=first-parent_--diff-merges=hide_master |  34 ++++++
 t/t9902-completion.sh                         |   6 +
 8 files changed, 257 insertions(+), 51 deletions(-)
 create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master

Interdiff against v0:
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 7452c7fad638..265a57312e58 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -43,17 +43,6 @@ log.diffMergesHide::
 log.diffMerges-m-imply-p::
 	`true` enables implication of `-p` by `-m`.
 
-log.diffMergesForce::
-	Use specified log format for -c, --cc, and --remerge-diff
-	options instead of their respective formats when the option
-	appears on the command line one time. See `--diff-merges` in
-	linkgit:git-log[1] for allowed values. Using 'off' or 'none'
-	disables the override (default).
-+
-The override is useful when external tool hard-codes one of the above
-options. Using any of these options two (or more) times will get back
-the original meaning of the options.
-
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 46c98c87e24f..a3fbdb85a8b8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,76 +34,86 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r|[no-]hide)::
+-m::
+	Show diffs for merge commits in the default format.
+	Shortcut for '--diff-merges=on,hide' unless
+	`log.diffMerges-m-imply-p` configuration is active, in which
+	case it's a shortcut for '--diff-merges=on -p'.
+
+-c::
+	Shortcut for '--diff-merges=combined -p'.
+
+--cc::
+	Shortcut for '--diff-merges=dense-combined -p'.
+
+--remerge-diff::
+	Shortcut for '--diff-merges=remerge -p'.
+
 --no-diff-merges::
-	Specify diff format to be used for merge commits. Default is
+	Synonym for '--diff-merges=off'.
+
+--diff-merges=(<format>|<flag>)[,(<format>|<flag>),...]::
+	Specify diff format and flags to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
-	`first-parent` is the default. Comma-separated list of
-	supported values is accepted as well.
+	`first-parent` is the default.
 +
---diff-merges=(off|none):::
---no-diff-merges:::
+The last format specified has precedence, whereas flags are
+cumulative. Comma-separated list is handy to provide flag(s) along
+with format, e.g.: `--diff-merges=first-parent,hide` is handy form of
+`--diff-merges=first-parent --diff-merges=hide`.
++
+The following formats are supported:
++
+--
+off, none::
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
---diff-merges=on:::
---diff-merges=m:::
--m:::
-	These options make diff output for merge commits to be shown in
-	the default format. The default format could be changed using
+on, m::
+	Make diff output for merge commits to be shown in the default
+	format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
 +
-	`-m` is a shortcut for '--diff-merges=on,hide'.
-	In addition it implies `-p` when `log.diffMerges-m-imply-p` is
-	active.
-+
---diff-merges=first-parent:::
---diff-merges=1:::
-	This option makes merge commits show the full diff with
-	respect to the first parent only.
-+
---diff-merges=separate:::
-	This makes merge commits show the full diff with respect to
-	each of the parents. Separate log entry and diff is generated
-	for each parent.
-+
---diff-merges=remerge:::
---diff-merges=r:::
---remerge-diff:::
-	With this option, two-parent merge commits are remerged to
-	create a temporary tree object -- potentially containing files
-	with conflict markers and such.  A diff is then shown between
-	that temporary tree and the actual merge commit.
-+
---diff-merges=hide:::
---diff-merges=no-hide:::
-	Hide (do not hide) the diff for merge commits unless `-p` options is given
-	as well. The default `no-hide` could be changed using `log.diffMerges`
-	configuration parameter.
+first-parent, 1::
+	Show full diff with respect to first parent. This is the same
+	format as `--patch` produces for non-merge commits.
++
+separate::
+	Show full diff with respect to each of parents.
+	Separate log entry and diff is generated for each parent.
++
+remerge, r::
+	Remerge two-parent merge commits to create a temporary tree
+	object--potentially containing files with conflict markers
+	and such.  A diff is then shown between that temporary tree
+	and the actual merge commit.
 +
 The output emitted when this option is used is subject to change, and
 so is its interaction with other options (unless explicitly
 documented).
 +
---diff-merges=combined:::
---diff-merges=c:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. `-c` implies
-	`-p`.
+combined, c::
+	Show differences from each of the parents to the merge
+	result simultaneously instead of showing pairwise diff between
+	a parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents.
 +
---diff-merges=dense-combined:::
---diff-merges=cc:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.  `--cc` implies `-p`.
+dense-combined, cc::
+	Further compress output produced by `--diff-merges=combined`
+	by omitting uninteresting hunks whose contents in the parents
+	have only two variants and the merge result picks one of them
+	without modification.
+--
++
+The following flags are supported:
++
+--
+[no-]hide::
+	Hide diff for merge commits unless `-p` options is given as
+	well. The default `no-hide` could be changed using
+	`log.diffMerges` configuration parameter.
+--
 
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
diff --git a/builtin/log.c b/builtin/log.c
index 1e8d0a2545a9..332b5e478cc5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -585,8 +585,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return diff_merges_hide_config(git_config_bool(var, value));
 	if (!strcmp(var, "log.diffmerges-m-imply-p"))
 		return diff_merges_m_imply_p_config(git_config_bool(var, value));
-	if (!strcmp(var, "log.diffmergesforce"))
-		return diff_merges_force_config(value);
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/diff-merges.c b/diff-merges.c
index b3b3c9e44ba8..1f4e43e16940 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -7,7 +7,6 @@ typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
 
 static diff_merges_setup_func_t set_to_default = set_separate;
-static diff_merges_setup_func_t force_func = NULL;
 static int suppress_m_parsing;
 static int hide = 0;
 static int m_imply_p = 0;
@@ -166,21 +165,6 @@ int diff_merges_m_imply_p_config(int on)
 	return 0;
 }
 
-int diff_merges_force_config(const char *value)
-{
-	diff_merges_setup_func_t func = func_by_opt(value);
-
-	if (!func)
-		return -1;
-
-	if (func == set_none)
-		force_func = NULL;
-	else if (func != set_hide && func != set_no_hide)
-		force_func = func;
-
-	return 0;
-}
-
 void diff_merges_suppress_m_parsing(void)
 {
 	suppress_m_parsing = 1;
@@ -191,7 +175,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	int argcount = 1;
 	const char *optarg;
 	const char *arg = argv[0];
-	diff_merges_setup_func_t set_func = NULL;
 
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
@@ -199,11 +182,14 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		revs->merges_imply_patch = m_imply_p;
 		got_m = 1;
 	} else if (!strcmp(arg, "-c")) {
-		set_func = set_combined;
+		set_combined(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--cc")) {
-		set_func = set_dense_combined;
+		set_dense_combined(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--remerge-diff")) {
-		set_func = set_remerge_diff;
+		set_remerge_diff(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		set_none(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -213,12 +199,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	} else
 		return 0;
 
-	if (set_func != NULL) {
-		(force_func ? force_func : set_func)(revs);
-		force_func = NULL;
-		revs->merges_imply_patch = 1;
-	}
-
 	revs->explicit_diff_merges = 1;
 	return argcount;
 }
diff --git a/diff-merges.h b/diff-merges.h
index 6ef0cc87bb2a..9f0b3901fe82 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -15,8 +15,6 @@ int diff_merges_hide_config(int hide);
 
 int diff_merges_m_imply_p_config(int on);
 
-int diff_merges_force_config(const char *value);
-
 void diff_merges_suppress_m_parsing(void);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 2c68d06074ed..a07513e67fd6 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -565,24 +565,6 @@ test_expect_success 'git config log.diffMerges-m-imply-p has proper effect' '
 	test_cmp expected actual
 '
 
-test_expect_success 'git config log.diffMergesForce has proper effect' '
-	git log -m -p master >result &&
-	process_diffs result >expected &&
-	test_config log.diffMergesForce on &&
-	git log --cc master >result &&
-	process_diffs result >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'git config log.diffMergesForce override by duplicate' '
-	git log --cc master >result &&
-	process_diffs result >expected &&
-	test_config log.diffMergesForce on &&
-	git log --cc --cc master >result &&
-	process_diffs result >actual &&
-	test_cmp expected actual
-'
-
 # -m in "git diff-index" means "match missing", that differs
 # from its meaning in "git diff". Let's check it in diff-index.
 # The line in the output for removed file should disappear when
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 411e08b2fa1b..26a7e4ff877c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2498,7 +2498,6 @@ test_expect_success 'git config - variable name' '
 	log.decorate Z
 	log.diffMerges Z
 	log.diffMergesHide Z
-	log.diffMergesForce Z
 	log.diffMerges-m-imply-p Z
 	EOF
 '
@@ -2529,7 +2528,6 @@ test_expect_success 'git -c - variable name' '
 	log.decorate=Z
 	log.diffMerges=Z
 	log.diffMergesHide=Z
-	log.diffMergesForce=Z
 	log.diffMerges-m-imply-p=Z
 	EOF
 '
@@ -2554,7 +2552,6 @@ test_expect_success 'git clone --config= - variable name' '
 	log.decorate=Z
 	log.diffMerges=Z
 	log.diffMergesHide=Z
-	log.diffMergesForce=Z
 	log.diffMerges-m-imply-p=Z
 	EOF
 '
-- 
2.25.1

