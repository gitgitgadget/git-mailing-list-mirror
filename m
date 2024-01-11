Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8C56B79
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0xz+46Z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so5318723f8f.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705003592; x=1705608392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzUGCqjZjGOxnsxrGSnuaXsivB6Eccs+tgtl6alDu/U=;
        b=l0xz+46ZntTYORJt8RBeMGFRBfBy75vKLtkPjTh2lBuC77yYoMCQNaTQ/dE+PFOC7X
         LUVIDBsuDo1h2Rjlwb04VcxOHK1Jx4FDDasjiR2abN5UOzuwvetRS7KKfHqTRbUiW1fa
         0kgslzP28vH6cyhb03u3ylXwiCoIWisKcy5b7u7d2pT+OOgy4HMIvmdGtKOGoxKm1GAc
         oXI/yuA32udHEyitHHfu4QLaOfFvd7uLj7Y60lg9Bbb6srKMjrzlkg2w9okhW97iKV30
         dVzapLsTrxYsgumi4FgjvBGV9N5ZMfitw2yuim8+rQ8KVGmsBDqrKQoEE28+ynbIFnOu
         /geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003592; x=1705608392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OzUGCqjZjGOxnsxrGSnuaXsivB6Eccs+tgtl6alDu/U=;
        b=GIawlACdh1JOKAA3kqiLAxXKzvJMvpUvMlp1Xlv0abaoc/9bvNp5b8Sk75kwRsuLbY
         szTvktxYlR89+VHENVPI5Sa1VNZmXHGVd3kzA0jAaNjvuWvZgr9Se39w17PRvnS1YSDT
         xq3NmLnErZN/tR8qcrzrljGjuScKty6Vb3Z4NDOeLP5GApIu2MUKf/tH6nIu3yGboZdX
         mJUsgKquD+kxapgkzKcfRRFda04jj8de+4JdHPtDITrT3NRnhhveMWhS9BoQ5Pj0pT26
         sV8ty6cix8+t/rDMqWr/IS3P81I/bw+zzEtOfn+236ew3m9mrDoQOtEBLwz2m8wfOWjx
         sryg==
X-Gm-Message-State: AOJu0YwTzRqRAHNvt2l8XPBPigzFVxeM8Ayih4DQgeqx1V3N+4Mfq0Hh
	YFYDklwc+enFTKBo6uE5OyA=
X-Google-Smtp-Source: AGHT+IHXS5YbkJev8Rg6n5RMhpDSF+RUczZ1HuRvevju+sySx5Xdm+9wX/UKgkDMcfNraqhw6rxIxQ==
X-Received: by 2002:adf:fc50:0:b0:337:6a69:e94 with SMTP id e16-20020adffc50000000b003376a690e94mr71875wrs.28.1705003592125;
        Thu, 11 Jan 2024 12:06:32 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-6835-a146-250e-421c.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:6835:a146:250e:421c])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000178d00b0033743c2d17dsm1989247wrg.28.2024.01.11.12.06.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 12:06:31 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	wanja.hentze@bevuta.com
Subject: [PATCH v3] builtin/revert.c: refactor using an enum for cmd-action
Date: Thu, 11 Jan 2024 21:06:27 +0100
Message-Id: <20240111200627.64199-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqsf33fy3t.fsf@gitster.g>
References: <xmqqsf33fy3t.fsf@gitster.g>
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

On 11. Jan 2024, at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> > I think ACTION_NONE was intended to covey that the user did not pass
> > one of the OPT_CMDMODE() options like "--continue" as there isn't a
> > "--start" option. I don't have a strong opinion between "_NONE" and
> > "_START".
>
> I agree with you why NONE is called as such.  If "revert" does not
> take "--start" (I do not remember offhand), I would think it would
> be better to follow suit.
My point was that yes, it might be in sync with what the user passes in
as arguments, but when I followed the code and saw lots of references to
ACTION_NONE I was puzzled, since my intuition of that name was that
_no action_ should be taken (which did not make sense to me).

So the (provocative) question is: Do we want to keep the variable name
in sync with some input parameters, or rather with the real action that
should be taken?

(Depending on the outcome of this discussion I would also prepare a
patch renaming it in builtin/rebase.c)

What do you think about this version which keeps the
`if (cmd != ACTION_START)` in favour of the `goto` and instead of the
constant if/else checks for the `verify_opt_compatible` (with the
`assert` at the last one) here is one version with a
`get_cmd_flag`-function (I am not that happy with the name...) that has
a `switch` and it has a runtime error handling with `BUG`.

I think it is the most concise of the options so far.

Ciao
Michael

 builtin/revert.c | 65 +++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 89821bab95..891aa1d720 100644
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
@@ -33,6 +41,17 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
+static char* get_cmd_optionname(enum action cmd)
+{
+	switch (cmd) {
+	case ACTION_CONTINUE: return "--continue";
+	case ACTION_SKIP: return "--skip";
+	case ACTION_ABORT: return "--abort";
+	case ACTION_QUIT: return "--quit";
+	case ACTION_START: BUG("no commandline flag for ACTION_START");
+	}
+}
+
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
@@ -85,12 +104,12 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
-	int cmd = 0;
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
@@ -144,20 +163,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
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
+	if (cmd != ACTION_START)
+		verify_opt_compatible(me, get_cmd_optionname(cmd),
 				"--no-commit", opts->no_commit,
 				"--signoff", opts->signoff,
 				"--mainline", opts->mainline,
@@ -168,7 +175,6 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				NULL);
-	}
 
 	if (!opts->strategy && opts->default_strategy) {
 		opts->strategy = opts->default_strategy;
@@ -183,9 +189,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--edit", opts->edit > 0,
 				NULL);
 
-	if (cmd) {
-		opts->revs = NULL;
-	} else {
+	if (cmd == ACTION_START) {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		repo_init_revisions(the_repository, opts->revs, NULL);
@@ -198,6 +202,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
+	} else {
+		opts->revs = NULL;
 	}
 
 	if (argc > 1)
@@ -210,19 +216,22 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
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

