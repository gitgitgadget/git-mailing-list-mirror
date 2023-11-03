Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D71C23760
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez1vYaUb"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E5187
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:30:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso18038785e9.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699047050; x=1699651850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RbsoAcM2V8HY35pZ3eC+tzaZSVUPReBS0HV2Yz6Rso=;
        b=ez1vYaUbYKcHMI+cVwpZuQzTEPJUoJhGi8Xrtr/uPQ3MmwS6s/YMiSdpx3gblFVFg0
         Nu8HPaOkSI2w3MdIp++TjK7nzLsmtewIfD8WQJAM6XkUav3JBISeoOdP9U6mFqyig/7I
         +h/ASgD2Vyqj+Xvbov56PFa09eZ4fQQ6vYMBHsW74SB0fbgdFokCd7/Vfk5HkZadvFkA
         xWHc+OMz8aENb1lN9ysqilYrcq3Snd1Ba7sZi8hezAw+6pZ5Ly/F28aTB6HHuygwvEwA
         6OwC1+Voxqrjvq3JjS9ogyLm/UckLlQUW4iNJA18ApIxMKmSK9HR8zunU4eEqrJaBf5W
         /tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047050; x=1699651850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RbsoAcM2V8HY35pZ3eC+tzaZSVUPReBS0HV2Yz6Rso=;
        b=pYxL4v7TqjRo0+JZb0seMHJ2BJD5k0qyqy/zeBfBE1UJLTW/BkYRVmjcJ8uwo3S2hH
         kvfREsuS1rsmS58418pzbuP8yOvZWoCrAfeptKN2MT2iA+CKUAVMeSifY4a7UE7AguH6
         Wl1WK4g+AMOxPnEjRNkjN/LemutgZT8JY2SqkwPB0kre0wreKZO0iMPkMjOKWeDJ4hdy
         TWdRu05NkpAeVsu83EVpMk3Q45cQMINc7TBwHAnaceqzEVQmBUOIE5873ZZs8dOoaJpl
         4VBiniNCf3rAcyrg4fIAgBVN3q/IB5dxvQz5y0BQ+PQa+vKrmDzzoppGyTU2BxC/RmfX
         YkRg==
X-Gm-Message-State: AOJu0YxmHa0mk97AxoKcRAu7IPqnZVUSFB0AiFLf7+kcP0WuoX/mTtai
	KqJpnSOyE7Z2hF1KVDPy0PsivcDVC6S06Efy
X-Google-Smtp-Source: AGHT+IG09W/0cGsyt9za30N/hvnIIm/2kktqjUF0ndHoBB2+jreqGqwQn9VQfJAZsGAXL0mqxFlSOA==
X-Received: by 2002:a05:600c:4445:b0:3fe:1af6:6542 with SMTP id v5-20020a05600c444500b003fe1af66542mr18874005wmn.33.1699047049836;
        Fri, 03 Nov 2023 14:30:49 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003fc16ee2864sm3673255wmo.48.2023.11.03.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 14:30:49 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 1/2] rebase: support non-interactive autosquash
Date: Fri,  3 Nov 2023 21:29:57 +0000
Message-ID: <20231103212958.18472-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc0
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
default for non-interactive rebase, there does not appear to be a
reason not to do --autosquash without --interactive, so support that.

Turn rebase.autoSquash into a multi-choice setting, with "interactive"
enabling autosquashing for --interactive, and "always" enabling it
without --interactive as well. Make boolean true values synonyms for
"interactive" for backward compatibility.

Don't prevent fast-forwards or report conflicts with --apply options
for rebase.autoSquash=interactive mode when rebase is invoked without
--interactive.

Change the git-rebase and config/rebase documentation accordingly, and
extend t3415-rebase-autosquash.sh to test the new rebase.autosquash
values and combinations with and without --interactive.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/rebase.txt        |  4 +-
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       | 45 +++++++++++------
 t/t3415-rebase-autosquash.sh           | 70 ++++++++++++++++++++------
 t/t3422-rebase-incompatible-options.sh |  2 +-
 5 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 9c248accec..7e5ec74e00 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -9,7 +9,9 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
+	When set to 'interactive' or 'true', enable the `--autosquash` option
+	for interactive rebase. When set to 'always', enable it for
+	non-interactive rebase as well. Defaults to 'false'.
 
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
index 261a9a61fc..35792744fc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -85,6 +85,12 @@ static const char *action_names[] = {
 	"show_current_patch"
 };
 
+enum config_autosquash {
+	AUTOSQUASH_NO = 0,
+	AUTOSQUASH_INTERACTIVE = 1,
+	AUTOSQUASH_ALWAYS
+};
+
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
@@ -131,7 +137,7 @@ struct rebase_options {
 	int reapply_cherry_picks;
 	int fork_point;
 	int update_refs;
-	int config_autosquash;
+	enum config_autosquash config_autosquash;
 	int config_rebase_merges;
 	int config_update_refs;
 };
@@ -149,7 +155,6 @@ struct rebase_options {
 		.reapply_cherry_picks = -1,             \
 		.allow_empty_message = 1,               \
 		.autosquash = -1,                       \
-		.config_autosquash = -1,                \
 		.rebase_merges = -1,                    \
 		.config_rebase_merges = -1,             \
 		.update_refs = -1,                      \
@@ -711,10 +716,8 @@ static int run_specific_rebase(struct rebase_options *opts)
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
@@ -772,7 +775,16 @@ static int rebase_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "rebase.autosquash")) {
-		opts->config_autosquash = git_config_bool(var, value);
+		int b = git_parse_maybe_bool(value);
+
+		if (b == 0)
+			opts->config_autosquash = AUTOSQUASH_NO;
+		else if (b == 1 || !strcmp(value, "interactive"))
+			opts->config_autosquash = AUTOSQUASH_INTERACTIVE;
+		else if (!strcmp(value, "always"))
+			opts->config_autosquash = AUTOSQUASH_ALWAYS;
+		else
+			die(_("invalid value for '%s': '%s'"), var, value);
 		return 0;
 	}
 
@@ -1402,13 +1414,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
+	if (options.autosquash == 1) {
+		imply_merge(&options, "--autosquash");
+	} else if (options.autosquash == -1) {
+		options.autosquash =
+			options.config_autosquash == AUTOSQUASH_ALWAYS ||
+			(options.config_autosquash == AUTOSQUASH_INTERACTIVE &&
+			 options.flags & REBASE_INTERACTIVE_EXPLICIT);
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
 
@@ -1508,7 +1529,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (is_merge(&options))
 				die(_("apply options and merge options "
 					  "cannot be used together"));
-			else if (options.autosquash == -1 && options.config_autosquash == 1)
+			else if (options.autosquash && options.config_autosquash)
 				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
 			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
 				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
@@ -1529,11 +1550,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1858,3 +1874,4 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(keep_base_onto_name);
 	return !!ret;
 }
+
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index a364530d76..4b48414b3d 100755
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
@@ -61,15 +61,36 @@ test_auto_fixup () {
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
+test_expect_success 'auto fixup (config always)' '
+	git config rebase.autosquash always &&
+	test_auto_fixup fixup-config-always &&
+	test_auto_fixup fixup-config-always-i -i &&
+	test_auto_fixup ! fixup-config-always-no --no-autosquash &&
+	test_auto_fixup ! fixup-config-always-i-no "-i --no-autosquash"
 '
 
 test_auto_squash () {
@@ -87,7 +108,7 @@ test_auto_squash () {
 	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -105,15 +126,36 @@ test_auto_squash () {
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
+	git config rebase.autosquash interactive &&
+	test_auto_squash ! squash-config-interactive &&
+	test_auto_squash squash-config-interactive-i -i &&
+	test_auto_squash ! squash-config-interactive-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto squash (config always)' '
+	git config rebase.autosquash always &&
+	test_auto_squash squash-config-always &&
+	test_auto_squash squash-config-always-i -i &&
+	test_auto_squash ! squash-config-always-no --no-autosquash &&
+	test_auto_squash ! squash-config-always-i-no "-i --no-autosquash"
 '
 
 test_expect_success 'misspelled auto squash' '
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 2eba00bdf5..d9feb3a89d 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -102,7 +102,7 @@ test_rebase_am_only () {
 
 	test_expect_success "$opt incompatible with rebase.autosquash" "
 		git checkout B^0 &&
-		test_must_fail git -c rebase.autosquash=true rebase $opt A 2>err &&
+		test_must_fail git -c rebase.autosquash=always rebase $opt A 2>err &&
 		grep -e --no-autosquash err
 	"
 
-- 
2.43.0-rc0

