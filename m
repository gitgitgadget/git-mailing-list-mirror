Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126550276
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTb/EhVB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e62341ad7so5703265e9.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704995306; x=1705600106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bubWS5dLpYdJXKe68NUzxlzvwaV5KqiCzCJmiAa6zA0=;
        b=GTb/EhVBOuX17lNEf4fDE2tnAuuVUqXw2d/xKV3i22hHy5TQfapEst5ChVCbwdmXzQ
         UCIJkUL0d/tl2Y5z79vNwtH8v7VahVeIHEBlGv5YNjITb0BiJGFctt9VS6U2XvpiSkxu
         5FCOUmM4+58epYQlVrqlhUw/9Itv6AHr7vcXPyE2I6cUi+FD6fl/2VLsyBsP4trJ++Bt
         96jnxybAwMy6XLsQ7rc/lSVV2zqJaAn6gl4NbFckmPbuoQid77BE8/g3gzV7agwRJNcc
         BFzfj3FpaII0yCDnUBKlBFALVA3BRb3tNtMaRqLQoUEuBQzH4IbSdVWzAKOwZojS5Ej8
         b2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995306; x=1705600106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bubWS5dLpYdJXKe68NUzxlzvwaV5KqiCzCJmiAa6zA0=;
        b=BVBgrLGO3nlaztbaYLgCZPbDU+eyRcdX6xumDFS0nmEmAXA3XQ0QsyzzW8XxaGb3yo
         Ch+xkyGJAS4zgxWrqOyf3qHgYV/GUmOAJIMOVJO3+V3nG5UbaHmuw4RqjcK7bqKKRIpd
         yIKs9cT8jZo5do8NjlLmIMiEr/Z5F9SjSohFmqzmoQxwLjTyUGa+XpFd/LWkJjKUA+uM
         25DpyDsdx3Cpwx7XupI2vcWFu7QjKTK2CsTVC7AMkdAsOX7Kl6Bb3m+mvmFLRsf4DhtC
         v4+whVsByvbk59OBUQnWC3UfM5j02XE9mZpxjJvTKDZBowOG+MWpUQBBRSMvBYcCvW2k
         KbqA==
X-Gm-Message-State: AOJu0YxmBodUNsbnXakN7+aTsZHMZMIilFJfhq2bWu+CPal1wYRYwOKA
	lRGgyaR0Is+beGzaSWJpBcGbJGAZnpvxqA==
X-Google-Smtp-Source: AGHT+IHeIt6b42AcVHV3Ubs4vVxf5gXOlikjVpvEgnVjKly8BG3iqACVl7rDcvK+mfpR7SrHaXS13g==
X-Received: by 2002:a05:600c:c19:b0:40d:94f5:b8f5 with SMTP id fm25-20020a05600c0c1900b0040d94f5b8f5mr102409wmb.139.1704995305570;
        Thu, 11 Jan 2024 09:48:25 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-6835-a146-250e-421c.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:6835:a146:250e:421c])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040d62f89381sm2751569wmn.35.2024.01.11.09.48.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 09:48:25 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	phillip.wood@dunelm.org.uk,
	wanja.hentze@bevuta.com
Subject: [PATCH v2] builtin/revert.c: refactor using an enum for cmd-action
Date: Thu, 11 Jan 2024 18:47:27 +0100
Message-Id: <20240111174727.55189-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <1ed0e249-dab9-4cf3-9b76-c8797b97c9c5@gmail.com>
References: <1ed0e249-dab9-4cf3-9b76-c8797b97c9c5@gmail.com>
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

In the rebase `action` enum there is the enumeration constant
`ACTION_NONE` which is not particularly descriptive, since it seems to
imply that no action should be taken. Instead it signals a start of a
revert/cherry-pick process, so here `ACTION_START` was chosen.

Co-authored-by: Wanja Henze <wanja.hentze@bevuta.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
Hi Phillip!

Thanks for the feedback!

On 11/01/2024 16:57, Phillip Wood wrote:
> I can see the attraction of using an exhaustive switch() here but as
> we don't want to do anything in the _START case it gets a bit messy
> with the extra conditional below. I wonder if we'd be better to
> replace "if (cmd) {" with "if (cmd != REVERT_ACTION_START) {".
> Alternatively if you want to stick with the switch then declaring
> "this_operation" at the beginning of the function would mean you can
> get rid of the new "{}" block.

> The extra indentation here is unfortunate as some of the lines are
> rather long already. In the current code it is clear that we only call
> verify_opt_compatible() when cmd is non-nul, I think it would be
> clearer to use "if (cmd != REVERT_ACTION_START)" here.

Totally agreed - an alternative to the `if` would be a `goto` (see this
version of the patch). This would keep the benefit of the exhaustive
switch, but I don't know if that would fit the style used in this
project... (at least it is a jump forward...)

Changes compared to the previous patch:
- initialize `this_operation` pointer with NULL instead of 0
- drop "REVERT_" prefix of enum and its members
- declare `this_operation` at the toplevel to get rid of codeblock
- skip the verify_opt_compatible in case of ACTION_START with a `goto`

Best wishes
Michael

 builtin/revert.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 89821bab95..19e6653f99 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -20,6 +20,14 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
+enum action {
+	ACTION_START = 0,
+	ACTION_CONTINUE,
+	ACTION_SKIP,
+	ACTION_ABORT,
+	ACTION_QUIT,
+};
+
 static const char * const revert_usage[] = {
 	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
 	N_("git revert (--continue | --skip | --abort | --quit)"),
@@ -85,12 +93,13 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
-	int cmd = 0;
+	char *this_operation = NULL;
+	enum action cmd = ACTION_START;
 	struct option base_options[] = {
-		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
-		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
-		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
-		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
+		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), ACTION_QUIT),
+		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), ACTION_CONTINUE),
+		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), ACTION_ABORT),
+		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), ACTION_SKIP),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
@@ -144,32 +153,36 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	}
 
 	/* Check for incompatible command line arguments */
-	if (cmd) {
-		char *this_operation;
-		if (cmd == 'q')
-			this_operation = "--quit";
-		else if (cmd == 'c')
-			this_operation = "--continue";
-		else if (cmd == 's')
-			this_operation = "--skip";
-		else {
-			assert(cmd == 'a');
-			this_operation = "--abort";
-		}
-
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
+	switch (cmd) {
+	case ACTION_START:
+		goto skip_opt_compatibility_verification;
+	case ACTION_QUIT:
+		this_operation = "--quit";
+		break;
+	case ACTION_CONTINUE:
+		this_operation = "--continue";
+		break;
+	case ACTION_SKIP:
+		this_operation = "--skip";
+		break;
+	case ACTION_ABORT:
+		this_operation = "--abort";
+		break;
 	}
 
+	verify_opt_compatible(me, this_operation,
+			"--no-commit", opts->no_commit,
+			"--signoff", opts->signoff,
+			"--mainline", opts->mainline,
+			"--strategy", opts->strategy ? 1 : 0,
+			"--strategy-option", opts->xopts.nr ? 1 : 0,
+			"-x", opts->record_origin,
+			"--ff", opts->allow_ff,
+			"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
+			"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+			NULL);
+
+skip_opt_compatibility_verification:
 	if (!opts->strategy && opts->default_strategy) {
 		opts->strategy = opts->default_strategy;
 		opts->default_strategy = NULL;
@@ -183,9 +196,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--edit", opts->edit > 0,
 				NULL);
 
-	if (cmd) {
-		opts->revs = NULL;
-	} else {
+	if (cmd == ACTION_START) {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		repo_init_revisions(the_repository, opts->revs, NULL);
@@ -198,6 +209,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
+	} else {
+		opts->revs = NULL;
 	}
 
 	if (argc > 1)
@@ -210,19 +223,22 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 	free(options);
 
-	if (cmd == 'q') {
+	switch (cmd) {
+	case ACTION_QUIT: {
 		int ret = sequencer_remove_state(opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
 	}
-	if (cmd == 'c')
+	case ACTION_CONTINUE:
 		return sequencer_continue(the_repository, opts);
-	if (cmd == 'a')
+	case ACTION_ABORT:
 		return sequencer_rollback(the_repository, opts);
-	if (cmd == 's')
+	case ACTION_SKIP:
 		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	case ACTION_START:
+		return sequencer_pick_revisions(the_repository, opts);
+	}
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
2.39.3 (Apple Git-145)

