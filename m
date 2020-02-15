Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD84C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB8020718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbryVDZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBOVhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgBOVhD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:37:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so15112243wrs.12
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9NiOgzSTYNHSMkg2kWxt+Mlkfa6/rBg6G0MnRcDqvxU=;
        b=TbryVDZUNN5uoz8w+ch1Ku2bYEO9gi4/r12fsw5oPfEMkCawuanPAgBpvqnQJAwrCR
         OuWTufmhYNlkO3AMMrEoVG6OdDi9F021/2EZkprg3rUg/JoeKVFMySOXxetMg5oAgzwE
         agyRzupZjANQ0PKf6oN/7ru7CJuVnCmqtF5JZWEZxXDoxOrjF88ZKeUnbMuheUchFhw/
         O7QgDW2tUhUSfpe+EP2Rfzryx9YAiCtEOL1S6+MnqDu/Umhfxoc0LYMH/DltKzPUVySJ
         jHBYMTK+SvEqvDhxLbHF1o9LBx1rviv3W5IuD4BhQfBcyQKLSDGgIGPMRpW1nkL5O0lq
         dNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9NiOgzSTYNHSMkg2kWxt+Mlkfa6/rBg6G0MnRcDqvxU=;
        b=hquCTImQn0b1J58INf9THMAPwKqDtXfV9xGqrPSyLep6fIXt3vAT26P7G7bZ+Yxuut
         RQ+Y7gJrHagurQ3n6moRIbLEFJYjTStRnyl61w85GgMzwiexO9z5WpoPDh68Ir2sfZeA
         mVvHM4JuxRs0Md2+Tral+iGmRTVVs1DAVP/r3FC0RjzTD1p8T9acrL+6RltrlHm43wmy
         kMzZyNQPze8R6CxKa4rHgc32Qvm6aj6t8rq+U8xZC9aB+zq6dGvOJN0nHg5xEiHTiDNz
         cOt/fKsxHpxelB3NtUAVTzKfUiq+iUKnB0nxivy6k94kqVzyA9VUKrn6+GQguLrQbyAg
         SAJw==
X-Gm-Message-State: APjAAAXz2xIPKIedV3ms4O5aDGnUmBnQ6QCl2xocoDxMDGWmjYIr9x6u
        gVtZtRKYTfOr2pHoOmURb9dTg/KQ
X-Google-Smtp-Source: APXvYqwxwq360FTK9Aaf4t3ghIw25CQ1GYE3f7b8fy6udwPULpd7mOqLW7WJwG4j3QSepQBR+PsMWA==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr12393318wrx.103.1581802618552;
        Sat, 15 Feb 2020 13:36:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q130sm14318682wme.19.2020.02.15.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:58 -0800 (PST)
Message-Id: <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:41 +0000
Subject: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Two related changes, with separate rationale for each:

Rename the 'interactive' backend to 'merge' because:
  * 'interactive' as a name caused confusion; this backend has been used
    for many kinds of non-interactive rebases, and will probably be used
    in the future for more non-interactive rebases than interactive ones
    given that we are making it the default.
  * 'interactive' is not the underlying strategy; merging is.
  * the directory where state is stored is not called
    .git/rebase-interactive but .git/rebase-merge.

Rename the 'am' backend to 'apply' because:
  * Few users are familiar with git-am as a reference point.
  * Related to the above, the name 'am' makes sentences in the
    documentation harder for users to read and comprehend (they may read
    it as the verb from "I am"); avoiding this difficult places a large
    burden on anyone writing documentation about this backend to be very
    careful with quoting and sentence structure and often forces
    annoying redundancy to try to avoid such problems.
  * Users stumble over pronunciation ("am" as in "I am a person not a
    backend" or "am" as in "the first and thirteenth letters in the
    alphabet in order are "A-M"); this may drive confusion when one user
    tries to explain to another what they are doing.
  * While "am" is the tool driving this backend, the tool driving git-am
    is git-apply, and since we are driving towards lower-level tools
    for the naming of the merge backend we may as well do so here too.
  * The directory where state is stored has never been called
    .git/rebase-am, it was always called .git/rebase-apply.

For all the reasons listed above:
  * Modify the documentation to refer to the backends with the new names
  * Provide a brief note in the documentation connecting the new names
    to the old names in case users run across the old names anywhere
    (e.g. in old release notes or older versions of the documentation)
  * Change the (new) --am command line flag to --apply
  * Rename some enums, variables, and functions to reinforce the new
    backend names for us as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/rebase.txt   |  8 +--
 Documentation/git-rebase.txt      | 77 +++++++++++++-----------
 builtin/rebase.c                  | 99 +++++++++++++++----------------
 t/t3400-rebase.sh                 | 16 ++---
 t/t3401-rebase-and-am-rename.sh   |  4 +-
 t/t3404-rebase-interactive.sh     |  2 +-
 t/t3406-rebase-message.sh         | 12 ++--
 t/t3407-rebase-abort.sh           |  6 +-
 t/t3420-rebase-autostash.sh       | 22 +++----
 t/t3421-rebase-topology-linear.sh | 34 +++++------
 t/t3424-rebase-empty.sh           |  6 +-
 t/t3425-rebase-topology-merges.sh |  8 +--
 t/t3432-rebase-fast-forward.sh    |  4 +-
 t/t5407-post-rewrite-hook.sh      | 16 ++---
 t/t5520-pull.sh                   |  2 +-
 t/t6047-diff3-conflict-markers.sh |  4 +-
 t/t7512-status-help.sh            | 12 ++--
 t/t9903-bash-prompt.sh            |  2 +-
 18 files changed, 166 insertions(+), 168 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index e6ae30c9999..7f7a07d22f8 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -7,11 +7,9 @@ rebase.useBuiltin::
 
 rebase.backend::
 	Default backend to use for rebasing.  Possible choices are
-	'am' or 'merge' (note that the merge backend is sometimes also
-	refered to as the interactive backend or the interactive
-	machinery elsewhere in the docs).  Also, in the future, if the
-	merge backend gains all remaining capabilities of the am
-	backend, this setting may become unused.
+	'apply' or 'merge'.  In the future, if the merge backend gains
+	all remaining capabilities of the apply backend, this setting
+	may become unused.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index fbac1cf38dd..8c1f4b82680 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,10 +258,10 @@ See also INCOMPATIBLE OPTIONS below.
 	original branch. The index and working tree are also left
 	unchanged as a result.
 
---am:
-	Use git-am internally to rebase.  This option may become a
-	no-op in the future once the interactive backend handles
-	everything the am one does.
+--apply:
+	Use applying strategies to rebase (calling `git-am`
+	internally).  This option may become a no-op in the future
+	once the merge backend handles everything the apply one does.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -385,7 +385,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.  Implies --am.
+	ever ignored.  Implies --apply.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -425,7 +425,7 @@ with `--keep-base` in order to drop those commits from your branch.
 --whitespace=<option>::
 	These flags are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Implies --am.
+	Implies --apply.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -569,7 +569,7 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --am
+ * --apply
  * --committer-date-is-author-date
  * --ignore-date
  * --ignore-whitespace
@@ -604,42 +604,48 @@ In addition, the following pairs of options are incompatible:
 BEHAVIORAL DIFFERENCES
 -----------------------
 
-There are some subtle differences how the backends behave.
+git rebase has two primary backends: apply and merge.  (The apply
+backend used to known as the 'am' backend, but the name led to
+confusion as it looks like a verb instead of a noun.  Also, the merge
+backend used to be known as the interactive backend, but it is now
+used for non-interactive cases as well.  Both were renamed based on
+lower-level functionality that underpinned each.) There are some
+subtle differences in how these two backends behave:
 
 Empty commits
 ~~~~~~~~~~~~~
 
-The am backend unfortunately drops intentionally empty commits, i.e.
+The apply backend unfortunately drops intentionally empty commits, i.e.
 commits that started empty, though these are rare in practice.  It
 also drops commits that become empty and has no option for controlling
 this behavior.
 
-The interactive backend keeps intentionally empty commits.  Similar to
-the am backend, by default the interactive backend drops commits that
-become empty unless -i/--interactive is specified (in which case it
-stops and asks the user what to do).  The interactive backend also has
-an --empty={drop,keep,ask} option for changing the behavior of
-handling commits that become empty.
+The merge backend keeps intentionally empty commits.  Similar to the
+apply backend, by default the merge backend drops commits that become
+empty unless -i/--interactive is specified (in which case it stops and
+asks the user what to do).  The merge backend also has an
+--empty={drop,keep,ask} option for changing the behavior of handling
+commits that become empty.
 
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Due to the lack of accurate tree information (arising from
 constructing fake ancestors with the limited information available in
-patches), directory rename detection is disabled in the am backend.
+patches), directory rename detection is disabled in the apply backend.
 Disabled directory rename detection means that if one side of history
 renames a directory and the other adds new files to the old directory,
 then the new files will be left behind in the old directory without
 any warning at the time of rebasing that you may want to move these
 files into the new directory.
 
-Directory rename detection works with the merge and interactive
-backends to provide you warnings in such cases.
+Directory rename detection works with the merge backend to provide you
+warnings in such cases.
 
 Context
 ~~~~~~~
 
-The am backend works by creating a sequence of patches (by calling
+The apply backend works by creating a sequence of patches (by calling
 `format-patch` internally), and then applying the patches in sequence
 (calling `am` internally).  Patches are composed of multiple hunks,
 each with line numbers, a context region, and the actual changes.  The
@@ -654,7 +660,7 @@ Setting diff.context to a larger value may prevent such types of
 problems, but increases the chance of spurious conflicts (since it
 will require more lines of matching context to apply).
 
-The interactive backend works with a full copy of each relevant file,
+The merge backend works with a full copy of each relevant file,
 insulating it from these types of problems.
 
 Labelling of conflicts markers
@@ -662,34 +668,33 @@ Labelling of conflicts markers
 
 When there are content conflicts, the merge machinery tries to
 annotate each side's conflict markers with the commits where the
-content came from.  Since the am backend drops the original
+content came from.  Since the apply backend drops the original
 information about the rebased commits and their parents (and instead
 generates new fake commits based off limited information in the
 generated patches), those commits cannot be identified; instead it has
 to fall back to a commit summary.  Also, when merge.conflictStyle is
-set to diff3, the am backend will use "constructed merge base" to
+set to diff3, the apply backend will use "constructed merge base" to
 label the content from the merge base, and thus provide no information
 about the merge base commit whatsoever.
 
-The interactive backend works with the full commits on both sides of
-history and thus has no such limitations.
+The merge backend works with the full commits on both sides of history
+and thus has no such limitations.
 
 Hooks
 ~~~~~
 
-The am backend has not traditionally called the post-commit hook,
-while the merge/interactive backend has.  However, this was by
-accident of implementation rather than by design.  Both backends
-should have the same behavior, though it is not clear which one is
-correct.
+The apply backend has not traditionally called the post-commit hook,
+while the merge backend has.  However, this was by accident of
+implementation rather than by design.  Both backends should have the
+same behavior, though it is not clear which one is correct.
 
 Interruptability
 ~~~~~~~~~~~~~~~~
 
-The am backend has safety problems with an ill-timed interrupt; if the
-user presses Ctrl-C at the wrong time to try to abort the rebase, the
-rebase can enter a state where it cannot be aborted with a subsequent
-`git rebase --abort`.  The interactive backend does not appear to
+The apply backend has safety problems with an ill-timed interrupt; if
+the user presses Ctrl-C at the wrong time to try to abort the rebase,
+the rebase can enter a state where it cannot be aborted with a
+subsequent `git rebase --abort`.  The merge backend does not appear to
 suffer from the same shortcoming.  (See
 https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
 details.)
@@ -707,9 +712,9 @@ completeness:
 
 * Progress, informational, and error messages: The two backends
   provide slightly different progress and informational messages.
-  Also, the am backend writes error messages (such as "Your files
-  would be overwritten...") to stdout, while the interactive backend
-  writes them to stderr.
+  Also, the apply backend writes error messages (such as "Your files
+  would be overwritten...") to stdout, while the merge backend writes
+  them to stderr.
 
 * State directories: The two backends keep their state in different
   directories under .git/
diff --git a/builtin/rebase.c b/builtin/rebase.c
index db8fd699d79..f3036f40c67 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -44,9 +44,8 @@ static GIT_PATH_FUNC(merge_dir, "rebase-merge")
 
 enum rebase_type {
 	REBASE_UNSPECIFIED = -1,
-	REBASE_AM,
+	REBASE_APPLY,
 	REBASE_MERGE,
-	REBASE_INTERACTIVE,
 	REBASE_PRESERVE_MERGES
 };
 
@@ -380,7 +379,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	return ret;
 }
 
-static int run_rebase_interactive(struct rebase_options *opts,
+static int run_sequencer_rebase(struct rebase_options *opts,
 				  enum action command)
 {
 	unsigned flags = 0;
@@ -462,7 +461,7 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 	 * If we ever want to remap --keep-empty to --empty=keep, insert:
 	 * 	opts->empty = unset ? EMPTY_UNSPECIFIED : EMPTY_KEEP;
 	 */
-	opts->type = REBASE_INTERACTIVE;
+	opts->type = REBASE_MERGE;
 	return 0;
 }
 
@@ -555,28 +554,26 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	return !!run_rebase_interactive(&opts, command);
+	return !!run_sequencer_rebase(&opts, command);
 }
 
-static int is_interactive(struct rebase_options *opts)
+static int is_merge(struct rebase_options *opts)
 {
-	return opts->type == REBASE_INTERACTIVE ||
+	return opts->type == REBASE_MERGE ||
 		opts->type == REBASE_PRESERVE_MERGES;
 }
 
-static void imply_interactive(struct rebase_options *opts, const char *option)
+static void imply_merge(struct rebase_options *opts, const char *option)
 {
 	switch (opts->type) {
-	case REBASE_AM:
+	case REBASE_APPLY:
 		die(_("%s requires an interactive rebase"), option);
 		break;
-	case REBASE_INTERACTIVE:
+	case REBASE_MERGE:
 	case REBASE_PRESERVE_MERGES:
 		break;
-	case REBASE_MERGE:
-		/* we now implement --merge via --interactive */
 	default:
-		opts->type = REBASE_INTERACTIVE; /* implied */
+		opts->type = REBASE_MERGE; /* implied */
 		break;
 	}
 }
@@ -785,7 +782,7 @@ static int finish_rebase(struct rebase_options *opts)
 	 * user should see them.
 	 */
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
-	if (opts->type == REBASE_INTERACTIVE) {
+	if (opts->type == REBASE_MERGE) {
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
 		replay.action = REPLAY_INTERACTIVE_REBASE;
@@ -1118,8 +1115,8 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	int status;
 	const char *backend, *backend_func;
 
-	if (opts->type == REBASE_INTERACTIVE) {
-		/* Run builtin interactive rebase */
+	if (opts->type == REBASE_MERGE) {
+		/* Run sequencer-based rebase */
 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
@@ -1132,11 +1129,11 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 			opts->gpg_sign_opt = tmp;
 		}
 
-		status = run_rebase_interactive(opts, action);
+		status = run_sequencer_rebase(opts, action);
 		goto finished_rebase;
 	}
 
-	if (opts->type == REBASE_AM) {
+	if (opts->type == REBASE_APPLY) {
 		status = run_am(opts);
 		goto finished_rebase;
 	}
@@ -1190,7 +1187,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "git_format_patch_opt",
 		opts->git_format_patch_opt.buf);
 
-	if (is_interactive(opts) &&
+	if (is_merge(opts) &&
 	    !(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
 		strbuf_addstr(&script_snippet,
 			      "GIT_SEQUENCE_EDITOR=:; export GIT_SEQUENCE_EDITOR; ");
@@ -1215,8 +1212,8 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 finished_rebase:
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
-	else if (opts->type == REBASE_INTERACTIVE)
-		; /* interactive rebase cleans up after itself */
+	else if (opts->type == REBASE_MERGE)
+		; /* merge backend cleans up after itself */
 	else if (status == 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
 			finish_rebase(opts);
@@ -1348,7 +1345,7 @@ static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
-	opts->type = REBASE_AM;
+	opts->type = REBASE_APPLY;
 
 	return 0;
 }
@@ -1361,7 +1358,7 @@ static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
-	if (!is_interactive(opts))
+	if (!is_merge(opts))
 		opts->type = REBASE_MERGE;
 
 	return 0;
@@ -1376,7 +1373,7 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
-	opts->type = REBASE_INTERACTIVE;
+	opts->type = REBASE_MERGE;
 	opts->flags |= REBASE_INTERACTIVE_EXPLICIT;
 
 	return 0;
@@ -1440,7 +1437,7 @@ static void set_reflog_action(struct rebase_options *options)
 	const char *env;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!is_interactive(options))
+	if (!is_merge(options))
 		return;
 
 	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
@@ -1537,8 +1534,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
-		{ OPTION_CALLBACK, 0, "am", &options, NULL,
-			N_("use apply-mail strategies to rebase"),
+		{ OPTION_CALLBACK, 0, "apply", &options, NULL,
+			N_("use apply strategies to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_am },
 		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
@@ -1615,7 +1612,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("It looks like 'git am' is in progress. Cannot rebase."));
 
 	if (is_directory(apply_dir())) {
-		options.type = REBASE_AM;
+		options.type = REBASE_APPLY;
 		options.state_dir = apply_dir();
 	} else if (is_directory(merge_dir())) {
 		strbuf_reset(&buf);
@@ -1627,7 +1624,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
 			if(file_exists(buf.buf)) {
-				options.type = REBASE_INTERACTIVE;
+				options.type = REBASE_MERGE;
 				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
 			} else
 				options.type = REBASE_MERGE;
@@ -1667,12 +1664,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
-	if (action == ACTION_EDIT_TODO && !is_interactive(&options))
+	if (action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
 	if (trace2_is_enabled()) {
-		if (is_interactive(&options))
+		if (is_merge(&options))
 			trace2_cmd_mode("interactive");
 		else if (exec.nr)
 			trace2_cmd_mode("interactive-exec");
@@ -1748,7 +1745,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
-		if (options.type == REBASE_INTERACTIVE) {
+		if (options.type == REBASE_MERGE) {
 			struct replay_opts replay = REPLAY_OPTS_INIT;
 
 			replay.action = REPLAY_INTERACTIVE_REBASE;
@@ -1831,7 +1828,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		argv_array_push(&options.git_am_opts, "-q");
 
 	if (options.empty != EMPTY_UNSPECIFIED)
-		imply_interactive(&options, "--empty");
+		imply_merge(&options, "--empty");
 
 	if (gpg_sign) {
 		free(options.gpg_sign_opt);
@@ -1841,7 +1838,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (exec.nr) {
 		int i;
 
-		imply_interactive(&options, "--exec");
+		imply_merge(&options, "--exec");
 
 		strbuf_reset(&buf);
 		for (i = 0; i < exec.nr; i++)
@@ -1857,7 +1854,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		else if (strcmp("no-rebase-cousins", rebase_merges))
 			die(_("Unknown mode: %s"), rebase_merges);
 		options.rebase_merges = 1;
-		imply_interactive(&options, "--rebase-merges");
+		imply_merge(&options, "--rebase-merges");
 	}
 
 	if (strategy_options.nr) {
@@ -1876,10 +1873,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.strategy) {
 		options.strategy = xstrdup(options.strategy);
 		switch (options.type) {
-		case REBASE_AM:
+		case REBASE_APPLY:
 			die(_("--strategy requires --merge or --interactive"));
 		case REBASE_MERGE:
-		case REBASE_INTERACTIVE:
 		case REBASE_PRESERVE_MERGES:
 			/* compatible */
 			break;
@@ -1892,34 +1888,34 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (options.type == REBASE_MERGE)
-		imply_interactive(&options, "--merge");
+		imply_merge(&options, "--merge");
 
 	if (options.root && !options.onto_name)
-		imply_interactive(&options, "--root without --onto");
+		imply_merge(&options, "--root without --onto");
 
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc || options.type == REBASE_AM) {
-		/* all am options except -q are compatible only with --am */
+	if (options.git_am_opts.argc || options.type == REBASE_APPLY) {
+		/* all am options except -q are compatible only with --apply */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
 				break;
 
 		if (i >= 0) {
-			if (is_interactive(&options))
-				die(_("cannot combine am options with either "
-				      "interactive or merge options"));
+			if (is_merge(&options))
+				die(_("cannot combine apply options with "
+				      "merge options"));
 			else
-				options.type = REBASE_AM;
+				options.type = REBASE_APPLY;
 		}
 	}
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			imply_interactive(&options, "--merge");
-		else if (!strcmp(options.default_backend, "am"))
-			options.type = REBASE_AM;
+			imply_merge(&options, "--merge");
+		else if (!strcmp(options.default_backend, "apply"))
+			options.type = REBASE_APPLY;
 		else
 			die(_("Unknown rebase backend: %s"),
 			    options.default_backend);
@@ -1927,11 +1923,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	switch (options.type) {
 	case REBASE_MERGE:
-	case REBASE_INTERACTIVE:
 	case REBASE_PRESERVE_MERGES:
 		options.state_dir = merge_dir();
 		break;
-	case REBASE_AM:
+	case REBASE_APPLY:
 		options.state_dir = apply_dir();
 		break;
 	default:
@@ -1946,7 +1941,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		else
 			options.empty = EMPTY_DROP;
 	}
-	if (reschedule_failed_exec > 0 && !is_interactive(&options))
+	if (reschedule_failed_exec > 0 && !is_merge(&options))
 		die(_("--reschedule-failed-exec requires "
 		      "--exec or --interactive"));
 	if (reschedule_failed_exec >= 0)
@@ -2247,7 +2242,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		diff_flush(&opts);
 	}
 
-	if (is_interactive(&options))
+	if (is_merge(&options))
 		goto run_rebase;
 
 	/* Detach HEAD and reset the tree */
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0a491f23632..7c7e085043d 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -183,19 +183,19 @@ test_expect_success 'default to common base in @{upstream}s reflog if no upstrea
 	test_cmp expect actual
 '
 
-test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--am)' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--apply)' '
 	git checkout -B default-base master &&
 	git checkout -B default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
-	git rebase --am &&
+	git rebase --apply &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
 	test_cmp expect actual &&
 	git checkout default-base &&
 	git reset --hard HEAD^ &&
 	git checkout default &&
-	git rebase --am &&
+	git rebase --apply &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
 	test_cmp expect actual
@@ -224,9 +224,9 @@ test_expect_success 'cherry-picked commits and fork-point work together' '
 	test_cmp expect D
 '
 
-test_expect_success 'rebase --am -q is quiet' '
+test_expect_success 'rebase --apply -q is quiet' '
 	git checkout -b quiet topic &&
-	git rebase --am -q master >output.out 2>&1 &&
+	git rebase --apply -q master >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
@@ -315,7 +315,7 @@ EOF
 	test_cmp From_.msg out
 '
 
-test_expect_success 'rebase --am and --show-current-patch' '
+test_expect_success 'rebase --apply and --show-current-patch' '
 	test_create_repo conflict-apply &&
 	(
 		cd conflict-apply &&
@@ -325,13 +325,13 @@ test_expect_success 'rebase --am and --show-current-patch' '
 		echo two >>init.t &&
 		git commit -a -m two &&
 		git tag two &&
-		test_must_fail git rebase --am -f --onto init HEAD^ &&
+		test_must_fail git rebase --apply -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
 		grep "show.*$(git rev-parse two)" stderr
 	)
 '
 
-test_expect_success 'rebase --am and .gitattributes' '
+test_expect_success 'rebase --apply and .gitattributes' '
 	test_create_repo attributes &&
 	(
 		cd attributes &&
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index 50803958fd0..f18bae94507 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -52,13 +52,13 @@ test_expect_success 'rebase --interactive: directory rename detected' '
 	)
 '
 
-test_expect_failure 'rebase --am: directory rename detected' '
+test_expect_failure 'rebase --apply: directory rename detected' '
 	(
 		cd dir-rename &&
 
 		git checkout B^0 &&
 
-		git -c merge.directoryRenames=true rebase --am A &&
+		git -c merge.directoryRenames=true rebase --apply A &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f964b2cd41d..2f51606e777 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1138,7 +1138,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git checkout conflict-branch &&
 	(
 		set_fake_editor &&
-		test_must_fail git rebase -f --am --onto HEAD~2 HEAD~ &&
+		test_must_fail git rebase -f --apply --onto HEAD~2 HEAD~ &&
 		test_must_fail git rebase --edit-todo
 	) &&
 	git rebase --abort
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 7ce617fc1fb..61b76f33019 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -23,24 +23,24 @@ test_expect_success 'rebase -m' '
 '
 
 test_expect_success 'rebase against master twice' '
-	git rebase --am master >out &&
+	git rebase --apply master >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
 
 test_expect_success 'rebase against master twice with --force' '
-	git rebase --force-rebase --am master >out &&
+	git rebase --force-rebase --apply master >out &&
 	test_i18ngrep "Current branch topic is up to date, rebase forced" out
 '
 
 test_expect_success 'rebase against master twice from another branch' '
 	git checkout topic^ &&
-	git rebase --am master topic >out &&
+	git rebase --apply master topic >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
 
 test_expect_success 'rebase fast-forward to master' '
 	git checkout topic^ &&
-	git rebase --am topic >out &&
+	git rebase --apply topic >out &&
 	test_i18ngrep "Fast-forwarded HEAD to topic" out
 '
 
@@ -89,7 +89,7 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	git checkout -b reflog-topic start &&
 	test_commit reflog-to-rebase &&
 
-	git rebase --am reflog-onto &&
+	git rebase --apply reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
 	rebase finished: returning to refs/heads/reflog-topic
@@ -99,7 +99,7 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	test_cmp expect actual &&
 
 	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase --am reflog-onto &&
+	GIT_REFLOG_ACTION=change-the-reflog git rebase --apply reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
 	rebase finished: returning to refs/heads/reflog-prefix
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 3e318261703..97efea0f569 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -96,14 +96,14 @@ testrebase() {
 	'
 }
 
-testrebase " --am" .git/rebase-apply
+testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
-test_expect_success 'rebase --am --quit' '
+test_expect_success 'rebase --apply --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
-	test_must_fail git rebase --am master &&
+	test_must_fail git rebase --apply master &&
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 3816159e207..b97ea623639 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
 	remove_progress_re="$(printf "s/.*\\r//")"
 '
 
-create_expected_success_am () {
+create_expected_success_apply () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	First, rewinding head to replay your work on top of it...
@@ -44,7 +44,7 @@ create_expected_success_am () {
 	EOF
 }
 
-create_expected_success_interactive () {
+create_expected_success_merge () {
 	q_to_cr >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	Applied autostash.
@@ -52,7 +52,7 @@ create_expected_success_interactive () {
 	EOF
 }
 
-create_expected_failure_am () {
+create_expected_failure_apply () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	First, rewinding head to replay your work on top of it...
@@ -64,7 +64,7 @@ create_expected_failure_am () {
 	EOF
 }
 
-create_expected_failure_interactive () {
+create_expected_failure_merge () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	Applying autostash resulted in conflicts.
@@ -101,9 +101,9 @@ testrebase () {
 
 	test_expect_success "rebase$type --autostash: check output" '
 		test_when_finished git branch -D rebased-feature-branch &&
-		suffix=${type#\ --} && suffix=${suffix:-am} &&
-		if test ${suffix} = "merge"; then
-			suffix=interactive
+		suffix=${type#\ --} && suffix=${suffix:-apply} &&
+		if test ${suffix} = "interactive"; then
+			suffix=merge
 		fi &&
 		create_expected_success_$suffix &&
 		sed "$remove_progress_re" <actual >actual2 &&
@@ -202,9 +202,9 @@ testrebase () {
 
 	test_expect_success "rebase$type: check output with conflicting stash" '
 		test_when_finished git branch -D rebased-feature-branch &&
-		suffix=${type#\ --} && suffix=${suffix:-am} &&
-		if test ${suffix} = "merge"; then
-			suffix=interactive
+		suffix=${type#\ --} && suffix=${suffix:-apply} &&
+		if test ${suffix} = "interactive"; then
+			suffix=merge
 		fi &&
 		create_expected_failure_$suffix &&
 		sed "$remove_progress_re" <actual >actual2 &&
@@ -234,7 +234,7 @@ test_expect_success "rebase: noop rebase" '
 	git checkout feature-branch
 '
 
-testrebase " --am" .git/rebase-apply
+testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index e12304012a2..cf8dfd6c203 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -26,7 +26,7 @@ test_run_rebase () {
 		test_linear_range 'd e' c..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -50,7 +50,7 @@ test_run_rebase () {
 		test_cmp_rev e HEAD
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -66,7 +66,7 @@ test_run_rebase () {
 		test_linear_range 'd e' b..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
@@ -83,7 +83,7 @@ test_run_rebase () {
 		test_linear_range 'd e' branch-b..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
@@ -98,7 +98,7 @@ test_run_rebase () {
 		test_cmp_rev e HEAD
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
@@ -139,7 +139,7 @@ test_run_rebase () {
 		test_linear_range 'd i' h..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -154,7 +154,7 @@ test_run_rebase () {
 		test_linear_range 'd' h..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -169,7 +169,7 @@ test_run_rebase () {
 		test_linear_range 'd i' f..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -184,7 +184,7 @@ test_run_rebase () {
 		test_linear_range 'd gp i' h..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -212,7 +212,7 @@ test_run_rebase () {
 		test_linear_range 'j d k l' c..
 	"
 }
-test_run_rebase failure --am
+test_run_rebase failure --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
@@ -227,7 +227,7 @@ test_run_rebase () {
 		test_linear_range 'd k l' c..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -242,7 +242,7 @@ test_run_rebase () {
 		test_linear_range 'd k l' j..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -282,7 +282,7 @@ test_run_rebase () {
 		test_linear_range 'x y' c..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -297,7 +297,7 @@ test_run_rebase () {
 		test_linear_range 'x y' c..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
@@ -312,7 +312,7 @@ test_run_rebase () {
 		test_linear_range 'x y' m..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -328,7 +328,7 @@ test_run_rebase () {
 	"
 }
 
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
@@ -343,7 +343,7 @@ test_run_rebase () {
 		test_linear_range 'x y' m..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index cfb1ebc1ff9..98fc2a558a0 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -34,11 +34,11 @@ test_expect_success 'setup test repository' '
 	git commit -m "Five letters ought to be enough for anybody"
 '
 
-test_expect_failure 'rebase (am-backend)' '
+test_expect_failure 'rebase (apply-backend)' '
 	test_when_finished "git rebase --abort" &&
 	git checkout -B testing localmods &&
-	# rebase (--am) should not drop commits that start empty
-	git rebase upstream &&
+	# rebase (--apply) should not drop commits that start empty
+	git rebase --apply upstream &&
 
 	test_write_lines D C B A >expect &&
 	git log --format=%s >actual &&
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 19700b025b5..e42faa44e74 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -54,7 +54,7 @@ test_run_rebase () {
 		test_linear_range 'n o' e..
 	"
 }
-test_run_rebase success --am
+test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 
@@ -70,7 +70,7 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" d..
 	"
 }
-test_run_rebase success 'n o e' --am
+test_run_rebase success 'n o e' --apply
 test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
@@ -86,7 +86,7 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-test_run_rebase success 'd n o e' --am
+test_run_rebase success 'd n o e' --apply
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
@@ -102,7 +102,7 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-test_run_rebase success 'd n o e' --am
+test_run_rebase success 'd n o e' --apply
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 4b3cecce560..6c9d4a13758 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -28,8 +28,8 @@ test_rebase_same_head () {
 	shift &&
 	cmp_f="$1" &&
 	shift &&
-	test_rebase_same_head_ $status_n $what_n $cmp_n " --am" "$*" &&
-	test_rebase_same_head_ $status_f $what_f $cmp_f " --am --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n " --apply" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f " --apply --no-ff" "$*"
 	test_rebase_same_head_ $status_n $what_n $cmp_n " --merge" "$*" &&
 	test_rebase_same_head_ $status_f $what_f $cmp_f " --merge --no-ff" "$*"
 }
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index a8a73616e46..80750a817e9 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -53,10 +53,10 @@ test_expect_success 'git commit --amend --no-post-rewrite' '
 	test ! -f post-rewrite.data
 '
 
-test_expect_success 'git rebase --am' '
+test_expect_success 'git rebase --apply' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --am --onto A B &&
+	test_must_fail git rebase --apply --onto A B &&
 	echo C > foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -68,10 +68,10 @@ test_expect_success 'git rebase --am' '
 	verify_hook_input
 '
 
-test_expect_success 'git rebase --am --skip' '
+test_expect_success 'git rebase --apply --skip' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --am --onto A B &&
+	test_must_fail git rebase --apply --onto A B &&
 	test_must_fail git rebase --skip &&
 	echo D > foo &&
 	git add foo &&
@@ -84,10 +84,10 @@ test_expect_success 'git rebase --am --skip' '
 	verify_hook_input
 '
 
-test_expect_success 'git rebase --am --skip the last one' '
+test_expect_success 'git rebase --apply --skip the last one' '
 	git reset --hard F &&
 	clear_hook_input &&
-	test_must_fail git rebase --am --onto D A &&
+	test_must_fail git rebase --apply --onto D A &&
 	git rebase --skip &&
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
@@ -128,7 +128,7 @@ test_expect_success 'git rebase -m --skip' '
 	verify_hook_input
 '
 
-test_expect_success 'git rebase with implicit use of interactive backend' '
+test_expect_success 'git rebase with implicit use of merge backend' '
 	git reset --hard D &&
 	clear_hook_input &&
 	test_must_fail git rebase --keep-empty --onto A B &&
@@ -143,7 +143,7 @@ test_expect_success 'git rebase with implicit use of interactive backend' '
 	verify_hook_input
 '
 
-test_expect_success 'git rebase --skip with implicit use of interactive backend' '
+test_expect_success 'git rebase --skip with implicit use of merge backend' '
 	git reset --hard D &&
 	clear_hook_input &&
 	test_must_fail git rebase --keep-empty --onto A B &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4f9e7f7ff6b..2f86fca0428 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -297,7 +297,7 @@ test_expect_success '--rebase (merge) fast forward' '
 test_expect_success '--rebase (am) fast forward' '
 	git reset --hard before-rebase &&
 
-	git -c rebase.backend=am pull --rebase . ff &&
+	git -c rebase.backend=apply pull --rebase . ff &&
 	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index d383ce81302..f4655bb358f 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -199,11 +199,11 @@ test_expect_success 'rebase --merge describes parent of commit being picked' '
 	)
 '
 
-test_expect_success 'rebase --am describes fake ancestor base' '
+test_expect_success 'rebase --apply describes fake ancestor base' '
 	(
 		cd rebase &&
 		git rebase --abort &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase --am master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply master &&
 		grep "||||||| constructed merge base" file
 	)
 '
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index d22b0acf2ac..29518e0949b 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -71,10 +71,10 @@ test_expect_success 'prepare for rebase conflicts' '
 '
 
 
-test_expect_success 'status when rebase --am in progress before resolving conflicts' '
+test_expect_success 'status when rebase --apply in progress before resolving conflicts' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
-	test_must_fail git rebase --am HEAD^ --onto HEAD^^ &&
+	test_must_fail git rebase --apply HEAD^ --onto HEAD^^ &&
 	cat >expected <<EOF &&
 rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
@@ -94,11 +94,11 @@ EOF
 '
 
 
-test_expect_success 'status when rebase --am in progress before rebase --continue' '
+test_expect_success 'status when rebase --apply in progress before rebase --continue' '
 	git reset --hard rebase_conflicts &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
-	test_must_fail git rebase --am HEAD^ --onto HEAD^^ &&
+	test_must_fail git rebase --apply HEAD^ --onto HEAD^^ &&
 	echo three >main.txt &&
 	git add main.txt &&
 	cat >expected <<EOF &&
@@ -688,7 +688,7 @@ EOF
 '
 
 
-test_expect_success 'status when rebase --am conflicts with statushints disabled' '
+test_expect_success 'status when rebase --apply conflicts with statushints disabled' '
 	git reset --hard master &&
 	git checkout -b statushints_disabled &&
 	test_when_finished "git config --local advice.statushints true" &&
@@ -698,7 +698,7 @@ test_expect_success 'status when rebase --am conflicts with statushints disabled
 	test_commit three_statushints main.txt three &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
-	test_must_fail git rebase --am HEAD^ --onto HEAD^^ &&
+	test_must_fail git rebase --apply HEAD^ --onto HEAD^^ &&
 	cat >expected <<EOF &&
 rebase in progress; onto $ONTO
 You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 7ca35d358d6..ab5da2cabc4 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -193,7 +193,7 @@ test_expect_success 'prompt - rebase am' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
-	test_must_fail git rebase --am b1 b2 &&
+	test_must_fail git rebase --apply b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
-- 
gitgitgadget
