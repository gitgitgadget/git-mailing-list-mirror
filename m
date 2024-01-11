Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEBDDC9
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USeflk0G"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd65f803b7so33060491fa.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704960290; x=1705565090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pX6EDh2jtD7IuXytekAEmwbfSO6EQtHGhtIwcWKS1FA=;
        b=USeflk0G/YyjF+W/eFJOYJKUBwJ4B3R+CbJsnxqIAOUkyiBuOmJf36z8XEp0d6cASh
         lZRdl98Alhf549t5pFg2T+z+VysY4QK925RNTIS+pO4jZ70FaWjodVkveCx83i5azHo2
         XlAsGj3wYkmOJlgnUwuhJ66mXeekuvYxI+uAUEZklWVhFYKOaWeTRDB4kdtRshULPCj8
         eB3ti0KI9B6ZnWdE6X9y7lfCq8+5XygD4dLOl/EydXEtWOi1s5vo2NUtL1J3riUy5nDu
         8j0ALVHBKkSpD6XnYD5IwpXUeQ7dk9mtmEv8VKdeHkx3BfWPcicPvqbtO6FjEA7mDa2d
         gexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704960290; x=1705565090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX6EDh2jtD7IuXytekAEmwbfSO6EQtHGhtIwcWKS1FA=;
        b=Biu9SJneiyYJc5eqGZP2okIKbW0KXbZ6rMJTRq/lFJYQSIBUYbiJ2/DgUcpbupY5eC
         neR+eVnuoLHs26t9z2P8O69+P7/e2z0wDl1v94DoRPK87t/wsuSyQ6zvDfmYMNvDw4jO
         xYVuDwiIvailP7A4yKYyYaHKqzzp0Yn9LP6dUqAGcRQpgCzH/NUU310djGSmW7vFAA9v
         +B9Y8hprQ1BtqJQKxUgGr03dFZQoQYyVjS3+GIYCDpWi65Lx3bznekpAmbBZQsNAMq2c
         +SCJRyeYZAeoHm8+4OxJuCIM+a05IJPSukU1CtP3vkAfAJruK8GLlyEGXo5m8vdUJnEE
         rRhQ==
X-Gm-Message-State: AOJu0YyTlAhm57NunpVHuJVjLucYIOiZvmmq+Qf7QEdIlSeqxCgWtIa8
	KjRh9UvCmJETJoxqCLTR2OcrceTRmKs=
X-Google-Smtp-Source: AGHT+IGVI/k03ETE8UW4+1TFZrqGfX9UEZfAQDLT1j9cEdp4s7HwoNDtirlZjwCs48TUygZPOisXyw==
X-Received: by 2002:a2e:9204:0:b0:2c8:39fc:acf5 with SMTP id k4-20020a2e9204000000b002c839fcacf5mr132776ljg.2.1704960289943;
        Thu, 11 Jan 2024 00:04:49 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-3935-bdb5-fa62-644a.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:3935:bdb5:fa62:644a])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b003373ece28efsm522361wrs.29.2024.01.11.00.04.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 00:04:49 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	Wanja Henze <wanja.hentze@bevuta.com>
Subject: [PATCH] builtin/revert.c: refactor using an enum for cmd-action
Date: Thu, 11 Jan 2024 09:04:17 +0100
Message-Id: <20240111080417.59346-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done to avoid having to keep the char values in sync in
different places and also to get compiler warnings on non-exhaustive
switches.

The newly introduced `revert_action`-enum aligns with the
builtin/rebase.c `action`-enum though the name `revert_action` is chosen
to better differentiate it from `replay_opts->action` with a different
function. For rebase the equivalent of the latter is
`rebase_options->type` and `rebase_options->action` corresponds to the
`cmd` variable in revert.c.

In the rebase `action` enum there is the enumeration constant
`ACTION_NONE` which is not particularly descriptive, since it seems to
imply that no action should be taken. Instead it signals a start of a
revert/cherry-pick process, so here `REVERT_ACTION_START` was chosen.

Co-authored-by: Wanja Henze <wanja.hentze@bevuta.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
Hello!

When I was working on `revert/cherry-pick --show-current-patch` (still
needs a little bit more discussion, if actually wanted, see thread [1])
I found the construct with the `cmd` as an int a bit irritating. I hope
this patch makes it more obvious what is actually going on.

Is there a reason why `ACTION_NONE` was chosen as a name in
builtin/rebase.c? My best guess is that it came along because it is the
implied action when no other specific action is passed in, but I don't
find that particularly descriptive on what its actual function is...
(Yes, naming things is hard... :D)

An alternative to prefixing the enum name with "revert_" would be to
rename `replay_opts->action` to `replay_opts->type` so it aligns with
rebase. Would you prefer that instead?

Cheers
Michael

[1] https://lore.kernel.org/git/20231218121048.68290-1-mi.al.lohmann@gmail.com/

 builtin/revert.c | 80 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 89821bab95..b5278b7a3b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -20,6 +20,14 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
+enum revert_action {
+	REVERT_ACTION_START = 0,
+	REVERT_ACTION_CONTINUE,
+	REVERT_ACTION_SKIP,
+	REVERT_ACTION_ABORT,
+	REVERT_ACTION_QUIT,
+};
+
 static const char * const revert_usage[] = {
 	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
 	N_("git revert (--continue | --skip | --abort | --quit)"),
@@ -85,12 +93,12 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
-	int cmd = 0;
+	enum revert_action cmd = REVERT_ACTION_START;
 	struct option base_options[] = {
-		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
-		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
-		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
-		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
+		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), REVERT_ACTION_QUIT),
+		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), REVERT_ACTION_CONTINUE),
+		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), REVERT_ACTION_ABORT),
+		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), REVERT_ACTION_SKIP),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
@@ -144,30 +152,37 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	}
 
 	/* Check for incompatible command line arguments */
-	if (cmd) {
-		char *this_operation;
-		if (cmd == 'q')
+	{
+		char *this_operation = 0;
+		switch (cmd) {
+		case REVERT_ACTION_START:
+			break;
+		case REVERT_ACTION_QUIT:
 			this_operation = "--quit";
-		else if (cmd == 'c')
+			break;
+		case REVERT_ACTION_CONTINUE:
 			this_operation = "--continue";
-		else if (cmd == 's')
+			break;
+		case REVERT_ACTION_SKIP:
 			this_operation = "--skip";
-		else {
-			assert(cmd == 'a');
+			break;
+		case REVERT_ACTION_ABORT:
 			this_operation = "--abort";
+			break;
 		}
 
-		verify_opt_compatible(me, this_operation,
-				"--no-commit", opts->no_commit,
-				"--signoff", opts->signoff,
-				"--mainline", opts->mainline,
-				"--strategy", opts->strategy ? 1 : 0,
-				"--strategy-option", opts->xopts.nr ? 1 : 0,
-				"-x", opts->record_origin,
-				"--ff", opts->allow_ff,
-				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
-				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
-				NULL);
+		if (this_operation)
+			verify_opt_compatible(me, this_operation,
+					"--no-commit", opts->no_commit,
+					"--signoff", opts->signoff,
+					"--mainline", opts->mainline,
+					"--strategy", opts->strategy ? 1 : 0,
+					"--strategy-option", opts->xopts.nr ? 1 : 0,
+					"-x", opts->record_origin,
+					"--ff", opts->allow_ff,
+					"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
+					"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+					NULL);
 	}
 
 	if (!opts->strategy && opts->default_strategy) {
@@ -183,9 +198,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--edit", opts->edit > 0,
 				NULL);
 
-	if (cmd) {
-		opts->revs = NULL;
-	} else {
+	if (cmd == REVERT_ACTION_START) {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		repo_init_revisions(the_repository, opts->revs, NULL);
@@ -198,6 +211,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
+	} else {
+		opts->revs = NULL;
 	}
 
 	if (argc > 1)
@@ -210,19 +225,22 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 	free(options);
 
-	if (cmd == 'q') {
+	switch (cmd) {
+	case REVERT_ACTION_QUIT: {
 		int ret = sequencer_remove_state(opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
 	}
-	if (cmd == 'c')
+	case REVERT_ACTION_CONTINUE:
 		return sequencer_continue(the_repository, opts);
-	if (cmd == 'a')
+	case REVERT_ACTION_ABORT:
 		return sequencer_rollback(the_repository, opts);
-	if (cmd == 's')
+	case REVERT_ACTION_SKIP:
 		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	case REVERT_ACTION_START:
+		return sequencer_pick_revisions(the_repository, opts);
+	}
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
2.42.0

