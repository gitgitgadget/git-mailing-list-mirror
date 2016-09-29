Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B528207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755697AbcI2TVx (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:21:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35496 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbcI2TVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:21:51 -0400
Received: by mail-pa0-f54.google.com with SMTP id oz2so30503534pac.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=n4lnYzfVW8Oq8Lz5dBADLlD93l8CtO/9APeOKHL9mX0=;
        b=F3hqhpl7tby3jPUR5jeVUgEusNQWrUbpsTAmjxW4fHb3vNeFiQ721x7cus5nvo36wI
         cujkBt/xy8csxZBHRrJ2HZNsMEB5ZxgXjgtdAiBLTMVPuajCgYnIrSeO1s2Ng9rcneeL
         +TXsJ6XuN+meotmB+KB2aPLYfbwG5JicJk6LGOBRscPO92mNywh8yKXue2yMBkL6dce6
         zjxpILxtfcHnaVohim1vo11dS8zGqUOQ3GLPyzFaqplQM/D40AqWhDjzIROXOSCSzaMi
         n6QseSy+jzE1YcTrfngPTqWcvKb4VOYvbuo2i6PEC/Y/TMdZbnJ0zFj6n+slkhYD8+YE
         6PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=n4lnYzfVW8Oq8Lz5dBADLlD93l8CtO/9APeOKHL9mX0=;
        b=Kke7z3046hDAuN5VxQiMfolS2RhgZ6bigD7HIMj8xKE8j/YEUIJeeSKVXkMfnycJtW
         alCmYuYnBa9FRvOSPR5XYNJ95/5BYpxXr3+orF4ofTDvpxAPgbsDoNMPD/ifS/Fdsxz0
         d1U29wWZUtGkbORf/8OW51FgP3ynFLixZ+K3axEn/9O1ghpHwWgTpLqa2z1gHSrusmpJ
         3aGiSIZF39UndFvFVdVsviC0A+PoEuftBmNNL9SqoJFb5kFiAPCXcCvoXJ9Z89Q9RBmC
         t4/Ov9huCIrl6lvRy4P2ptba3iEN3OtFADWa6mpYlSOLLj4JuzC9tAT712AtMyYzsyqM
         SDYQ==
X-Gm-Message-State: AA6/9RkZqDPrf8sEzzcndcCwASPqXWIVwpmFHs6BezKJfQorR3nlWB9DokAv6BJNVeUBXklB
X-Received: by 10.66.235.100 with SMTP id ul4mr5171706pac.50.1475176909922;
        Thu, 29 Sep 2016 12:21:49 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e1sm22184087pap.11.2016.09.29.12.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 12:21:48 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC/PATCH 2/2] sequencer: allow origin line below commit title
Date:   Thu, 29 Sep 2016 12:21:38 -0700
Message-Id: <14d37973223a60e8ea7a2267683dabda2cc492f2.1475176070.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1475176070.git.jonathantanmy@google.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
In-Reply-To: <cover.1475176070.git.jonathantanmy@google.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git cherry-pick -x is invoked, a "(cherry picked from commit ...)"
line is appended to the footer of a commit message that Git interprets
to contain a footer; otherwise it is appended at the end as a new
paragraph, preceded by a blank line. This behavior may appear
inconsistent, especially to users who differ from Git in their
interpretation of what constitutes a footer.

Provide the user, through a configuration option and command-line flag,
the option of placing the "cherry picked" line below the commit title
instead of the current behavior.  This allows the "cherry picked" line
to be placed in a consistent manner, independent of the nature of the
footer of the existing commit message.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config.txt          |  4 +++
 Documentation/git-cherry-pick.txt | 15 +++++++++-
 builtin/revert.c                  | 38 ++++++++++++++++++++++++-
 sequencer.c                       | 39 ++++++++++++++++++++------
 sequencer.h                       |  7 +++++
 t/t3511-cherry-pick-x.sh          | 59 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 152 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..fb1990f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -945,6 +945,10 @@ browser.<tool>.path::
 	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
+cherrypick.originLineLocation::
+	Default for the `--origin-line-location` option in git-cherry-pick.
+	Defaults to `bottom`.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771..5a8359f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -58,7 +58,7 @@ OPTIONS
 	message prior to committing.
 
 -x::
-	When recording the commit, append a line that says
+	When recording the commit, add a line that says
 	"(cherry picked from commit ...)" to the original commit
 	message in order to indicate which commit this change was
 	cherry-picked from.  This is done only for cherry
@@ -71,6 +71,14 @@ OPTIONS
 	development branch), adding this information can be
 	useful.
 
+--origin-line-location::
+	Where to put the "(cherry picked from commit ...)" line when requested
+	with the `-x` option.  May be `top`, meaning at the top of the commit
+	message body, immediately below the commit title (see the DISCUSSION
+	section of linkgit:git-commit[1]), or `bottom`, meaning at the end of
+	the commit message.  The default is controlled by the
+	`cherrypick.originLineLocation` configuration variable.
+
 -r::
 	It used to be that the command defaulted to do `-x`
 	described above, and `-r` was to disable it.  Now the
@@ -224,6 +232,11 @@ the working tree.
 spending extra time to avoid mistakes based on incorrectly matching
 context lines.
 
+CONFIGURATION
+-------------
+cherrypick.originLineLocation::
+	Default for the `--origin-line-location` option.  Defaults to `bottom`.
+
 SEE ALSO
 --------
 linkgit:git-revert[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 4e69380..a5459a0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -71,11 +71,25 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
+static int set_origin_line(enum origin_line *line, const char *str)
+{
+	if (!strcmp(str, "bottom")) {
+		*line = ORIGIN_LINE_BOTTOM;
+		return 1;
+	}
+	if (!strcmp(str, "top")) {
+		*line = ORIGIN_LINE_TOP;
+		return 1;
+	}
+	return 0;
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	int cmd = 0;
+	const char *origin_str = NULL;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
@@ -98,6 +112,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOL('x', NULL, &opts->record_origin, N_("append commit name")),
+			OPT_STRING(0, "origin-line-location", &origin_str, N_("origin-line-location"), N_("location of appended commit name")),
 			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
@@ -125,6 +140,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	else
 		opts->subcommand = REPLAY_NONE;
 
+	/* Set the origin line location */
+	if (origin_str)
+		if (!set_origin_line(&opts->origin_line, origin_str))
+			die(_("%s: --origin-line-location must be top or bottom"),
+			    me);
+
 	/* Check for incompatible command line arguments */
 	if (opts->subcommand != REPLAY_NONE) {
 		char *this_operation;
@@ -176,6 +197,21 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		usage_with_options(usage_str, options);
 }
 
+static int git_cherry_pick_config(const char *var, const char *value,
+				  void *opts_)
+{
+	struct replay_opts *opts = opts_;
+
+	if (!strcmp(var, "cherrypick.originlinelocation")) {
+		if (!value)
+			return config_error_nonbool(var);
+		set_origin_line(&opts->origin_line, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, opts_);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -200,7 +236,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
-	git_config(git_default_config, NULL);
+	git_config(git_cherry_pick_config, &opts);
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
diff --git a/sequencer.c b/sequencer.c
index b29c9ca..ef9e5bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -450,23 +450,45 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 static void append_message(struct strbuf *msgbuf,
 			   const struct commit_message *msg,
 			   int record_origin,
+			   enum origin_line origin_line,
 			   const struct commit *commit)
 {
 	/*
-	 * Append the commit log message to msgbuf; it starts
+	 * The commit log message starts
 	 * after the tree, parent, author, committer
 	 * information followed by "\n\n".
 	 */
 	const char *p = strstr(msg->message, "\n\n");
-	if (p)
-		strbuf_addstr(msgbuf, skip_blank_lines(p + 2));
+	p = skip_blank_lines(p + 2);
+	if (!record_origin) {
+		strbuf_addstr(msgbuf, p);
+		return;
+	}
 
-	if (record_origin) {
+	switch (origin_line) {
+	case ORIGIN_LINE_TOP:
+		/* First, add only the subject. */
+		p = format_subject(msgbuf, p, "\n");
+		strbuf_addstr(msgbuf, "\n\n");
+		break;
+	case ORIGIN_LINE_BOTTOM:
+		strbuf_addstr(msgbuf, p);
 		if (!has_conforming_footer(msgbuf, NULL, 0))
 			strbuf_addch(msgbuf, '\n');
-		strbuf_addstr(msgbuf, cherry_picked_prefix);
-		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
-		strbuf_addstr(msgbuf, ")\n");
+		break;
+	}
+
+	strbuf_addstr(msgbuf, cherry_picked_prefix);
+	strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
+	strbuf_addstr(msgbuf, ")\n");
+
+	if (origin_line == ORIGIN_LINE_TOP) {
+		/* Add the rest of the commit message. */
+		p = skip_blank_lines(p);
+		if (*p) {
+			strbuf_addch(msgbuf, '\n');
+			strbuf_addstr(msgbuf, p);
+		}
 	}
 }
 
@@ -566,7 +588,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		next = commit;
 		next_label = msg.label;
 
-		append_message(&msgbuf, &msg, opts->record_origin, commit);
+		append_message(&msgbuf, &msg, opts->record_origin,
+			       opts->origin_line, commit);
 	}
 
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
diff --git a/sequencer.h b/sequencer.h
index 5ed5cb1..7cf381c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -20,6 +20,11 @@ enum replay_subcommand {
 	REPLAY_ROLLBACK
 };
 
+enum origin_line {
+	ORIGIN_LINE_BOTTOM,
+	ORIGIN_LINE_TOP
+};
+
 struct replay_opts {
 	enum replay_action action;
 	enum replay_subcommand subcommand;
@@ -46,6 +51,8 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	enum origin_line origin_line;
 };
 
 int sequencer_pick_revisions(struct replay_opts *opts);
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9cce5ae..57e3861 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -244,4 +244,63 @@ test_expect_success 'cherry-pick preserves commit message' '
 	test_cmp expect actual
 '
 
+mesg_one_para="This is a commit message
+in one paragraph"
+
+test_expect_success 'cherry-pick -x (top location) one-paragraph commit message' '
+	pristine_detach initial &&
+	test_config cherrypick.originLineLocation top &&
+	test_commit "$mesg_one_para" foo b mesg-one-para &&
+	git reset --hard initial &&
+	sha1=$(git rev-parse mesg-one-para^0) &&
+	git cherry-pick -x mesg-one-para &&
+	cat <<-EOF >expect &&
+		$mesg_one_para
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+space=" "
+mesg_multi_para="$mesg_one_para
+$space
+
+$mesg_one_para"
+
+test_expect_success 'cherry-pick -x (top location) multi-paragraph commit message' '
+	pristine_detach initial &&
+	test_config cherrypick.originLineLocation top &&
+	test_commit "$mesg_multi_para" foo b mesg-multi-para &&
+	git reset --hard initial &&
+	sha1=$(git rev-parse mesg-multi-para^0) &&
+	git cherry-pick -x mesg-multi-para &&
+	cat <<-EOF >expect &&
+		$mesg_one_para
+
+		(cherry picked from commit $sha1)
+
+		$mesg_one_para
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -x location argument overrides config' '
+	test_config cherrypick.originLineLocation top &&
+	git reset --hard initial &&
+	sha1=$(git rev-parse mesg-multi-para^0) &&
+	git cherry-pick -x --origin-line-location=bottom mesg-multi-para &&
+	cat <<-EOF >expect &&
+		$mesg_one_para
+
+		$mesg_one_para
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0.rc3.226.g39d4020

