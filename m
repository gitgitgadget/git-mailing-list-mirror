Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF2395
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubnb4Kzn"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDBD69
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 17:08:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso44218111fa.3
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699142921; x=1699747721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D41gnG3yEnvjFu49xlZhYAoW4xNc0rdFvubgtvf8tPs=;
        b=Ubnb4Kzn27SLG2/nhz3/obN040P6stZYCzg8J756I7JfGX+rO3Jo3brv7drM76idFB
         R8ba0EZ0EYpn5CH6pFQ8bbXfDpv7prt34mH1eeYffWgfX1HMEI1ESLkGSeggKhODxNkj
         aIuBKqvL91WCbLgQDF2x0zTdpvzTHjxIn9KA/sMfp+NhxbeFVJNxbTLFNVWNuxleJ6iF
         XG87Kq+4zGKFF9qI8Xc8FDo4y5VQgjlH4Eh2YmOxSEi/EhQ5+l+19Bo/plhOrr2nclIi
         4Yl+jPzx7ZjfGpywv1qQ+yKs+ZjykztJtz9DW5IdgqSCSutmEFIa+9RvuyX+Qq9aBogi
         EX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699142921; x=1699747721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D41gnG3yEnvjFu49xlZhYAoW4xNc0rdFvubgtvf8tPs=;
        b=KXFC8VSm5V3LqliMTiqRHhyUD8XYDevjmNaS2PdhpJ3ZtuOg+CEs8KuKcD1INxT0GR
         vtaupnnjGMnpeV4gTE4LCGAjpuMJY4wwSE2odafUyHrIVdRDZsIHq5yz9MAh6RYz5tAX
         F/2H9J+pxW3gtNa15g/4+EK+V6AZBClWjHu+MvH50ESLjspNH5lPP4F+QiPJtNyt+1Pt
         m9yxZDaWFWFxzvzU9wpBpZUkVpvYg5C3hFlH5QaLVKRRKRL98JXwhAsCMJm1Wk1kq/qC
         UGL/jXoU5dVgAi93eOOSLJimtCmOwYF9oB/JhGZvI74bHT9P6uBgADko8EePj/AGK9zP
         tRuQ==
X-Gm-Message-State: AOJu0YyPofoPrfwoiHeKXELKkp6qtcHL1UlUKg+7PNnolU3HZBJygiwX
	Nowjl3tFw3XeqlWMBqfMZJRkrY3oYERd/Q==
X-Google-Smtp-Source: AGHT+IFxzjj9/DTEnpwRR05K4t66Thkw+QvQ6WBBtwJnuTcWm1SHu6eqSjBrAWYy0DTJlJ3fUbSrgw==
X-Received: by 2002:a2e:b4ab:0:b0:2c5:3139:2d04 with SMTP id q11-20020a2eb4ab000000b002c531392d04mr19158560ljm.47.1699142920485;
        Sat, 04 Nov 2023 17:08:40 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d438e000000b00327de0173f6sm5453111wrq.115.2023.11.04.17.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 17:08:40 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 1/2] rebase: support non-interactive autosquash
Date: Sun,  5 Nov 2023 00:08:07 +0000
Message-ID: <20231105000808.10171-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc0
In-Reply-To: <20231104220330.14577-1-andy.koppe@gmail.com>
References: <20231104220330.14577-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, the rebase --autosquash option and rebase.autoSquash=true
config setting are quietly ignored when used without --interactive,
except that they prevent fast-forward and that they trigger conflicts
with --apply and relatives, which is less than helpful particularly for
the config setting.

Since the "merge" backend used for interactive rebase also is the
default for non-interactive rebase, there doesn't appear to be a
reason not to do --autosquash without --interactive, so support that.

Turn rebase.autoSquash into a comma-separated list of flags, with
"interactive" or "i" enabling auto-squashing with --interactive, and
"no-interactive" or "no-i" enabling it without. Make boolean true mean
"interactive" for backward compatibility.

Don't prevent fast-forwards or report conflicts with --apply options
when auto-squashing is not active.

Change the git-rebase and config/rebase documentation accordingly, and
extend t3415-rebase-autosquash.sh to test the new rebase.autosquash
values and combinations with and without --interactive.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/rebase.txt        | 11 +++-
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       | 66 +++++++++++++++-----
 t/t3415-rebase-autosquash.sh           | 83 +++++++++++++++++++++-----
 t/t3422-rebase-incompatible-options.sh |  2 +-
 5 files changed, 132 insertions(+), 32 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 9c248accec..68191e5673 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -9,7 +9,16 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
+	A comma-separated list of flags for when to enable auto-squashing.
+	Specifying `interactive` or `i` enables auto-squashing for rebasing with
+	`--interactive`, whereas `no-interactive` or `no-i` enables it for
+	rebasing without that option. For example, setting this to `i,no-i`
+	enables auto-squashing for both types. Setting it to true is equivalent
+	to setting it to `interactive`.
+
+	The `--autosquash` and `--no-autosquash` options of
+	linkgit:git-rebase[1] override the setting here.
+	Auto-squashing is disabled by default.
 
 rebase.autoStash::
 	When set to true, automatically create a temporary stash entry
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7b39ad244..102ff91493 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -592,7 +592,7 @@ See also INCOMPATIBLE OPTIONS below.
 	When the commit log message begins with "squash! ..." or "fixup! ..."
 	or "amend! ...", and there is already a commit in the todo list that
 	matches the same `...`, automatically modify the todo list of
-	`rebase -i`, so that the commit marked for squashing comes right after
+	`rebase`, so that the commit marked for squashing comes right after
 	the commit to be modified, and change the action of the moved commit
 	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
 	matches the `...` if the commit subject matches, or if the `...` refers
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 261a9a61fc..26c3e5dcb4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -131,7 +131,10 @@ struct rebase_options {
 	int reapply_cherry_picks;
 	int fork_point;
 	int update_refs;
-	int config_autosquash;
+	enum {
+		AUTOSQUASH_INTERACTIVE = 1 << 0,
+		AUTOSQUASH_NO_INTERACTIVE = 1 << 1,
+	} config_autosquash;
 	int config_rebase_merges;
 	int config_update_refs;
 };
@@ -149,7 +152,6 @@ struct rebase_options {
 		.reapply_cherry_picks = -1,             \
 		.allow_empty_message = 1,               \
 		.autosquash = -1,                       \
-		.config_autosquash = -1,                \
 		.rebase_merges = -1,                    \
 		.config_rebase_merges = -1,             \
 		.update_refs = -1,                      \
@@ -711,10 +713,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	if (opts->type == REBASE_MERGE) {
 		/* Run sequencer-based rebase */
 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
-		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
-			opts->autosquash = 0;
-		}
 		if (opts->gpg_sign_opt) {
 			/* remove the leading "-S" */
 			char *tmp = xstrdup(opts->gpg_sign_opt + 2);
@@ -748,6 +748,30 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
+static void parse_rebase_autosquash_value(struct rebase_options *opts,
+					  const char *var, const char *value)
+{
+	struct string_list tokens = STRING_LIST_INIT_NODUP;
+	char *buf = xstrdup(value);
+
+	opts->config_autosquash = 0;
+	string_list_split_in_place(&tokens, buf, ",", -1);
+
+	for (int i = 0; i < tokens.nr; i++) {
+		const char *s = tokens.items[i].string;
+
+		if (!strcmp(s, "i") || !strcmp(s, "interactive"))
+			opts->config_autosquash |= AUTOSQUASH_INTERACTIVE;
+		else if (!strcmp(s, "no-i") || !strcmp(s, "no-interactive"))
+			opts->config_autosquash |= AUTOSQUASH_NO_INTERACTIVE;
+		else
+			die(_("invalid value for '%s': '%s'"), var, s);
+	}
+
+	string_list_clear(&tokens, 0);
+	free(buf);
+}
+
 static void parse_rebase_merges_value(struct rebase_options *options, const char *value)
 {
 	if (!strcmp("no-rebase-cousins", value))
@@ -772,8 +796,14 @@ static int rebase_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "rebase.autosquash")) {
-		opts->config_autosquash = git_config_bool(var, value);
-		return 0;
+		int b = git_parse_maybe_bool(value);
+
+		if (b < 0)
+			parse_rebase_autosquash_value(opts, var, value);
+		else if (b)
+			opts->config_autosquash = AUTOSQUASH_INTERACTIVE;
+		else
+			opts->config_autosquash = 0;
 	}
 
 	if (!strcmp(var, "commit.gpgsign")) {
@@ -1402,13 +1432,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
+	if (options.autosquash == 1) {
+		imply_merge(&options, "--autosquash");
+	} else if (options.autosquash == -1) {
+		int conf = options.config_autosquash;
+		options.autosquash =
+			(options.flags & REBASE_INTERACTIVE_EXPLICIT)
+			? !!(conf & AUTOSQUASH_INTERACTIVE)
+			: !!(conf & AUTOSQUASH_NO_INTERACTIVE);
+	}
+
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
 	    (options.action != ACTION_NONE) ||
 	    (options.exec.nr > 0) ||
-	    (options.autosquash == -1 && options.config_autosquash == 1) ||
-	    options.autosquash == 1) {
+	    options.autosquash) {
 		allow_preemptive_ff = 0;
 	}
+
 	if (options.committer_date_is_author_date || options.ignore_date)
 		options.flags |= REBASE_FORCE;
 
@@ -1508,7 +1548,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (is_merge(&options))
 				die(_("apply options and merge options "
 					  "cannot be used together"));
-			else if (options.autosquash == -1 && options.config_autosquash == 1)
+			else if (options.autosquash && options.config_autosquash)
 				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
 			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
 				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
@@ -1529,11 +1569,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
 				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
 
-	if (options.autosquash == 1)
-		imply_merge(&options, "--autosquash");
-	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
-			     ((options.config_autosquash >= 0) ? options.config_autosquash : 0);
-
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			options.type = REBASE_MERGE;
@@ -1858,3 +1893,4 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(keep_base_onto_name);
 	return !!ret;
 }
+
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index a364530d76..1386eb6394 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -43,7 +43,7 @@ test_auto_fixup () {
 
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -61,15 +61,43 @@ test_auto_fixup () {
 }
 
 test_expect_success 'auto fixup (option)' '
-	test_auto_fixup final-fixup-option --autosquash
+	test_auto_fixup fixup-option --autosquash &&
+	test_auto_fixup fixup-option-i "-i --autosquash"
 '
 
-test_expect_success 'auto fixup (config)' '
-	git config rebase.autosquash true &&
-	test_auto_fixup final-fixup-config-true &&
-	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
+test_expect_success 'auto fixup (config false)' '
 	git config rebase.autosquash false &&
-	test_auto_fixup ! final-fixup-config-false
+	test_auto_fixup ! fixup-config-false &&
+	test_auto_fixup ! fixup-config-false-i -i
+'
+
+test_expect_success 'auto fixup (config true)' '
+	git config rebase.autosquash true &&
+	test_auto_fixup ! fixup-config-true &&
+	test_auto_fixup fixup-config-true-i -i &&
+	test_auto_fixup ! fixup-config-true-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto fixup (config interactive)' '
+	git config rebase.autosquash interactive &&
+	test_auto_fixup ! fixup-config-interactive &&
+	test_auto_fixup fixup-config-interactive-i -i &&
+	test_auto_fixup ! fixup-config-interactive-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto fixup (config no-interactive)' '
+	git config rebase.autosquash no-interactive &&
+	test_auto_fixup fixup-config-no-interactive &&
+	test_auto_fixup ! fixup-config-no-interactive-i -i &&
+	test_auto_fixup ! fixup-config-no-interactive-no "--no-autosquash"
+'
+
+test_expect_success 'auto fixup (config always)' '
+	git config rebase.autosquash i,no-i &&
+	test_auto_fixup fixup-config-always &&
+	test_auto_fixup fixup-config-always-i -i &&
+	test_auto_fixup ! fixup-config-always-no --no-autosquash &&
+	test_auto_fixup ! fixup-config-always-i-no "-i --no-autosquash"
 '
 
 test_auto_squash () {
@@ -87,7 +115,7 @@ test_auto_squash () {
 	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -105,15 +133,42 @@ test_auto_squash () {
 }
 
 test_expect_success 'auto squash (option)' '
-	test_auto_squash final-squash --autosquash
+	test_auto_squash squash-option --autosquash &&
+	test_auto_squash squash-option-i "-i --autosquash"
 '
 
-test_expect_success 'auto squash (config)' '
-	git config rebase.autosquash true &&
-	test_auto_squash final-squash-config-true &&
-	test_auto_squash ! squash-config-true-no --no-autosquash &&
+test_expect_success 'auto squash (config false)' '
 	git config rebase.autosquash false &&
-	test_auto_squash ! final-squash-config-false
+	test_auto_squash ! squash-config-false &&
+	test_auto_squash ! squash-config-false-i -i
+'
+
+test_expect_success 'auto squash (config true)' '
+	git config rebase.autosquash true &&
+	test_auto_squash ! squash-config-true &&
+	test_auto_squash squash-config-true-i -i &&
+	test_auto_squash ! squash-config-true-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto squash (config interactive)' '
+	git config rebase.autosquash i &&
+	test_auto_squash ! squash-config-interactive &&
+	test_auto_squash squash-config-interactive-i -i &&
+	test_auto_squash ! squash-config-interactive-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto squash (config no-interactive)' '
+	git config rebase.autosquash no-i &&
+	test_auto_squash squash-config-no-interactive &&
+	test_auto_squash ! squash-config-no-interactive-i -i &&
+	test_auto_squash ! squash-config-no-interactive-no "--no-autosquash"
+'
+test_expect_success 'auto squash (config always)' '
+	git config rebase.autosquash interactive,no-interactive &&
+	test_auto_squash squash-config-always &&
+	test_auto_squash squash-config-always-i -i &&
+	test_auto_squash ! squash-config-always-no --no-autosquash &&
+	test_auto_squash ! squash-config-always-i-no "-i --no-autosquash"
 '
 
 test_expect_success 'misspelled auto squash' '
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 2eba00bdf5..e5119e7371 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -102,7 +102,7 @@ test_rebase_am_only () {
 
 	test_expect_success "$opt incompatible with rebase.autosquash" "
 		git checkout B^0 &&
-		test_must_fail git -c rebase.autosquash=true rebase $opt A 2>err &&
+		test_must_fail git -c rebase.autosquash=no-i rebase $opt A 2>err &&
 		grep -e --no-autosquash err
 	"
 
-- 
2.43.0-rc0

