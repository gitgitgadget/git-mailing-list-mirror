Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA5279346
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916834; cv=pass; b=GlEK3uQAjiIV0jwcEv3MjmLbC3AgZ5HGSlPDUhlzRjRbWqY3AVYDeGq/b2Lw3aj5Xy5dLGA/x/GM3KKAVDzQnc8Mi7XhDmwb7X+C3YhFkzCaQc651RRH48UWIFdx/59kVYajJsKueG4I3p+SUXe3ax8PLV66xeK9QsP1Kg2K/OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916834; c=relaxed/simple;
	bh=aPlb+KAe8jX7wZURSYR/ZyZwrT3s3+Jdh8MzCEW7Onc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3OEujwt1sykcFIB3YwLei/cjpZKF8PukJk8X5VK/k43Bt71hSLo7HuN1bjCA6iKiTPU8SoThe6TE5ojkOxpxQyI6onQ2FYaFzM1wbZIu9Q67KuqduePFdcIMUfu+EV69Fxa72BsgAE2kRnIrFXYMbUgY/Mr7BeJ2mz50v0Y3hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=H/Z7fHC2; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="H/Z7fHC2"
ARC-Seal: i=1; a=rsa-sha256; t=1771916777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lI7aVS4Uu9twrSRarwRuniX4L98RKvS2hTuDI/0Gsj2JZbB57+iQzyTaE3+W8HqVa/iIOx3Kv+HdLf2TB5wqdswt8FylVDiZF2vomo+FnSrAt0SpaEUHyq9u1ngf4/iJjMRtbfnOguUVHBVIYBHAP6S2yQ7R1/4o0LyCGYPG/ho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771916777; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yNTnBsyxC6YbwVWm3HwHnFV0e3AcF8VSj2/QJsMM3y4=; 
	b=FZM5+VqdZMpntyuhyJgNjA0uPffwphWs8vzK7Y0/N1D8otS/UafNJ5RzfjQtzYIBkCh0FbcANEQQjDRaIRM8hyKLIKZ9XDldqO5aIZpITvvZyCYXfublWkMfh2vU4bW1H95bzFzfF+21AQC1WpzYNVbvCUvvLMsZZ7Vm37lLSGg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771916777;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yNTnBsyxC6YbwVWm3HwHnFV0e3AcF8VSj2/QJsMM3y4=;
	b=H/Z7fHC2DREeEr73/kTFVaO2WXeCwmgjVmpU93UOlyporQt/0wLDp3OdW1nEDwEG
	HLuay5UVRdukB45MpKpZdZkIIGLJYGtTu14JDfo745bQz592QtIlmLsBLtLwlLk9pi+
	0dYdJLJ4o+5DzBkeR1A3oqKluUdD9IatO552CQ5g=
Received: by mx.zohomail.com with SMTPS id 1771916776211169.8819670842763;
	Mon, 23 Feb 2026 23:06:16 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v7 5/5] rebase: support --trailer
Date: Tue, 24 Feb 2026 15:05:51 +0800
Message-ID: <20260224070552.148591-6-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224070552.148591-1-me@linux.beauty>
References: <20260224070552.148591-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new --trailer=<trailer> option to git rebase to append trailer
lines to each rewritten commit message (merge backend only).

Because the apply backend does not provide a commit-message filter,
reject --trailer when --apply is in effect and require the merge backend
instead.

This option implies --force-rebase so that fast-forwarded commits are
also rewritten. Validate trailer arguments early to avoid starting an
interactive rebase with invalid input.

Add integration tests covering error paths and trailer insertion across
non-interactive and interactive rebases.

Signed-off-by: Li Chen <me@linux.beauty>
---
v7:
Validate trailer args via validate_trailer_args().
Drop redundant rebase basic-state save/restore for --trailer arguments.
Fix Documentation/git-rebase.adoc formatting for the new option.

 Documentation/git-rebase.adoc |   7 ++
 builtin/rebase.c              |  18 +++++
 sequencer.c                   |  28 +++++++
 sequencer.h                   |   3 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 147 ++++++++++++++++++++++++++++++++++
 6 files changed, 204 insertions(+)
 create mode 100755 t/t3440-rebase-trailer.sh

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e177808004..908717991a 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -497,6 +497,13 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--trailer=<trailer>::
+	Append the given trailer to every rebased commit message, processed
+	via linkgit:git-interpret-trailers[1]. This option implies
+	`--force-rebase` so that fast-forwarded commits are also rewritten.
++
+See also INCOMPATIBLE OPTIONS below.
+
 -i::
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c487e10907..3200506c89 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,6 +36,7 @@
 #include "reset.h"
 #include "trace2.h"
 #include "hook.h"
+#include "trailer.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
@@ -113,6 +114,7 @@ struct rebase_options {
 	enum action action;
 	char *reflog_action;
 	int signoff;
+	struct strvec trailer_args;
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
@@ -143,6 +145,7 @@ struct rebase_options {
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = STRVEC_INIT,		\
 		.exec = STRING_LIST_INIT_NODUP,		\
+		.trailer_args = STRVEC_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
 		.reapply_cherry_picks = -1,             \
@@ -166,6 +169,7 @@ static void rebase_options_release(struct rebase_options *opts)
 	free(opts->strategy);
 	string_list_clear(&opts->strategy_opts, 0);
 	strbuf_release(&opts->git_format_patch_opt);
+	strvec_clear(&opts->trailer_args);
 }
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -177,6 +181,10 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
+
+	for (size_t i = 0; i < opts->trailer_args.nr; i++)
+		strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);
+
 	replay.allow_ff = !(opts->flags & REBASE_FORCE);
 	if (opts->allow_rerere_autoupdate)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
@@ -1132,6 +1140,8 @@ int cmd_rebase(int argc,
 			.flags = PARSE_OPT_NOARG,
 			.defval = REBASE_DIFFSTAT,
 		},
+		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"),
+			   N_("add custom trailer(s)")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -1285,6 +1295,11 @@ int cmd_rebase(int argc,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (options.trailer_args.nr) {
+		validate_trailer_args(&options.trailer_args);
+		options.flags |= REBASE_FORCE;
+	}
+
 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges\n"
 			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
@@ -1542,6 +1557,9 @@ int cmd_rebase(int argc,
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
+	if (options.trailer_args.nr)
+		imply_merge(&options, "--trailer");
+
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
diff --git a/sequencer.c b/sequencer.c
index a3eb39bb25..a60c2a0cde 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -209,6 +209,7 @@ static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedul
 static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
+static GIT_PATH_FUNC(rebase_path_trailer, "rebase-merge/trailer")
 
 /*
  * A 'struct replay_ctx' represents the private state of the sequencer.
@@ -420,6 +421,7 @@ void replay_opts_release(struct replay_opts *opts)
 	if (opts->revs)
 		release_revisions(opts->revs);
 	free(opts->revs);
+	strvec_clear(&opts->trailer_args);
 	replay_ctx_release(ctx);
 	free(opts->ctx);
 }
@@ -2025,6 +2027,9 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 		if (opts->signoff)
 			append_signoff(buf, 0, 0);
 
+		if (opts->trailer_args.nr)
+			amend_strbuf_with_trailers(buf, &opts->trailer_args);
+
 		if ((command == TODO_FIXUP) &&
 		    (flag & TODO_REPLACE_FIXUP_MSG) &&
 		    (file_exists(rebase_path_fixup_msg()) ||
@@ -2443,6 +2448,9 @@ static int do_pick_commit(struct repository *r,
 	if (opts->signoff && !is_fixup(command))
 		append_signoff(&ctx->message, 0, 0);
 
+	if (opts->trailer_args.nr && !is_fixup(command))
+		amend_strbuf_with_trailers(&ctx->message, &opts->trailer_args);
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy ||
@@ -3234,6 +3242,18 @@ static int read_populate_opts(struct replay_opts *opts)
 
 		read_strategy_opts(opts, &buf);
 		strbuf_reset(&buf);
+		if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {
+			char *p = buf.buf, *nl;
+
+			while ((nl = strchr(p, '\n'))) {
+				*nl = '\0';
+				if (!*p)
+					BUG("rebase-merge/trailer has an empty line");
+				strvec_push(&opts->trailer_args, p);
+				p = nl + 1;
+			}
+			strbuf_reset(&buf);
+		}
 
 		if (read_oneliner(&ctx->current_fixups,
 				  rebase_path_current_fixups(),
@@ -3328,6 +3348,14 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 	else
 		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
+	if (opts->trailer_args.nr) {
+		struct strbuf buf = STRBUF_INIT;
+
+		for (size_t i = 0; i < opts->trailer_args.nr; i++)
+			strbuf_addf(&buf, "%s\n", opts->trailer_args.v[i]);
+		write_file(rebase_path_trailer(), "%s", buf.buf);
+		strbuf_release(&buf);
+	}
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..bea20da085 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,8 @@ struct replay_opts {
 	int ignore_date;
 	int commit_use_reference;
 
+	struct strvec trailer_args;
+
 	int mainline;
 
 	char *gpg_sign;
@@ -84,6 +86,7 @@ struct replay_opts {
 #define REPLAY_OPTS_INIT {			\
 	.edit = -1,				\
 	.action = -1,				\
+	.trailer_args = STRVEC_INIT,		\
 	.xopts = STRVEC_INIT,			\
 	.ctx = replay_ctx_new(),		\
 }
diff --git a/t/meson.build b/t/meson.build
index f80e366cff..1f6f8ac20b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -388,6 +388,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3440-rebase-trailer.sh',
   't3450-history.sh',
   't3451-history-reword.sh',
   't3500-cherry.sh',
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
new file mode 100755
index 0000000000..8b47579566
--- /dev/null
+++ b/t/t3440-rebase-trailer.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+#
+
+test_description='git rebase --trailer integration tests
+We verify that --trailer works with the merge backend,
+and that it is rejected early when the apply backend is requested.'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
+
+REVIEWED_BY_TRAILER="Reviewed-by: Dev <dev@example.com>"
+SP=" "
+
+test_expect_success 'setup repo with a small history' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	test_commit first file a &&
+	test_commit second file &&
+	git checkout -b conflict-branch first &&
+	test_commit file-2 file-2 &&
+	test_commit conflict file &&
+	test_commit third file &&
+	git checkout main
+'
+
+test_expect_success 'apply backend is rejected with --trailer' '
+	git checkout -B apply-backend third &&
+	test_expect_code 128 \
+		git rebase --apply --trailer "$REVIEWED_BY_TRAILER" HEAD^ 2>err &&
+	test_grep "fatal: --trailer requires the merge backend" err
+'
+
+test_expect_success 'reject empty --trailer argument' '
+	git checkout -B empty-trailer third &&
+	test_expect_code 128 git rebase --trailer "" HEAD^ 2>err &&
+	test_grep "empty --trailer" err
+'
+
+test_expect_success 'reject trailer with missing key before separator' '
+	git checkout -B missing-key third &&
+	test_expect_code 128 git rebase --trailer ": no-key" HEAD^ 2>err &&
+	test_grep "missing key before separator" err
+'
+
+test_expect_success 'allow trailer with missing value after separator' '
+	git checkout -B missing-value third &&
+	git rebase --trailer "Acked-by:" HEAD^ &&
+	test_commit_message HEAD <<-EOF
+	third
+
+	Acked-by:${SP}
+	EOF
+'
+
+test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
+	git checkout -B replace-policy third &&
+	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
+		rebase --trailer "Bug: 123" --trailer "Bug: 456" HEAD^ &&
+	test_commit_message HEAD <<-EOF
+	third
+
+	Bug: 456
+	EOF
+'
+
+test_expect_success 'multiple Signed-off-by trailers all preserved' '
+	git checkout -B multiple-signoff third &&
+	git rebase --trailer "Signed-off-by: Dev A <a@example.com>" \
+		--trailer "Signed-off-by: Dev B <b@example.com>" HEAD^ &&
+	test_commit_message HEAD <<-EOF
+	third
+
+	Signed-off-by: Dev A <a@example.com>
+	Signed-off-by: Dev B <b@example.com>
+	EOF
+'
+
+test_expect_success 'rebase --trailer adds trailer after conflicts' '
+	git checkout -B trailer-conflict third &&
+	test_commit fourth file &&
+	test_must_fail git rebase --trailer "$REVIEWED_BY_TRAILER" second &&
+	git checkout --theirs file &&
+	git add file &&
+	git rebase --continue &&
+	test_commit_message HEAD <<-EOF &&
+	fourth
+
+	$REVIEWED_BY_TRAILER
+	EOF
+	test_commit_message HEAD^ <<-EOF
+	third
+
+	$REVIEWED_BY_TRAILER
+	EOF
+'
+
+test_expect_success '--trailer handles fixup commands in todo list' '
+	git checkout -B fixup-trailer third &&
+	test_commit fixup-base base &&
+	test_commit fixup-second second &&
+	cat >todo <<-\EOF &&
+	pick fixup-base fixup-base
+	fixup fixup-second fixup-second
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	test_commit_message HEAD <<-EOF &&
+	fixup-base
+
+	$REVIEWED_BY_TRAILER
+	EOF
+	git reset --hard fixup-second &&
+	cat >todo <<-\EOF &&
+	pick fixup-base fixup-base
+	fixup -C fixup-second fixup-second
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	test_commit_message HEAD <<-EOF
+	fixup-second
+
+	$REVIEWED_BY_TRAILER
+	EOF
+'
+
+test_expect_success 'rebase --root honors trailer.<name>.key' '
+	git checkout -B root-trailer first &&
+	git -c trailer.review.key=Reviewed-by rebase --root \
+		--trailer=review="Dev <dev@example.com>" &&
+	test_commit_message HEAD <<-EOF &&
+	first
+
+	Reviewed-by: Dev <dev@example.com>
+	EOF
+	test_commit_message HEAD^ <<-EOF
+	Initial empty commit
+
+	Reviewed-by: Dev <dev@example.com>
+	EOF
+'
+test_done
-- 
2.52.0
