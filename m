Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4B1EA84
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353058; cv=pass; b=FSROOViOn+qbxu6vA3ck/LyKbxFEkbjpZDiUrzd+BWthCprKK3xRsI/zuDhmQeIfKOcMYP5Z3yIT/m3TL1drfw6l+P2DtBJY1sJQLRTctxaUxNaARurlZft6v0uMMEmDldPMGUQ812AASE7zyiJ1RMA5ShhyPZL6+VyMqBsWR6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353058; c=relaxed/simple;
	bh=ShEzd0jmr0lIBBTSFpVNZuUwY3QMQIlOSDPraQn8wjg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMExBeV/2E97+kP5DQhkIx+2qyIUiz65dCN0EG+evhGEhJfPdqjPMm/GwfvRSMuywzOFl2z0jUm7UfukgGwIrIKIPnrbXY+xM6VVhBHVf1/4s3B3yWW0vkqVVt3/wohm6FuTZp+tLgQ+Z25W8/eD/hYHzb21UJkd7QQX5vKz0MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=nQ65B1yn; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="nQ65B1yn"
ARC-Seal: i=1; a=rsa-sha256; t=1762353006; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nl1/bwULe99OlEe2D+f5FeMZHTJRxVFnV1b+p9nhY/2vvB0XCJW8gBLyup0CK1Ors8SuD8zMl662VnlNimgaLsRZJvC5j6+w6dOwHGSi3j5M/SKXD77bIIffRcbmNOcde4xiXQkjt+j5CNHkZB+trH+iPa8rTSWpTP+mzip+2Ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762353006; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=28codrR6IHtjIB8rz/2BOLVnrtmD/MpPh70pgjOSYzc=; 
	b=KUKCu2znSlwW7VyWJyc8ScS2SxAty8KOaHaHeN5+jw9X1+DFmL5KXI4Hx/aqvh8f/Dz2CzvZefOPPGx5IKyl9tw2aYVLqcTa2ELQrHHm8I0nUyuk3DXa4e88+Cm4Mv26HtCkWUXMYD3qhaWbSQFUyNRZZhLC0ERyaFCf8Vpnm2I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762353006;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=28codrR6IHtjIB8rz/2BOLVnrtmD/MpPh70pgjOSYzc=;
	b=nQ65B1yn9YIPhy8F1sOQf8Ei6o5gDGMGRBMUO/9166rn+j0+h2Y3ZgNTwbimuHJj
	rCouP68GqVtrnULRE0cHSVO37LYYtcs99cBOKaH4YXOQPmulF8VyYGFTux6ZGwHx9YW
	7c23VRthrBrc/LJQRsdIt5pmmtGWJtt4/lZoGUhE=
Received: by mx.zohomail.com with SMTPS id 1762353004414330.7922387827947;
	Wed, 5 Nov 2025 06:30:04 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 4/4] rebase: support --trailer
Date: Wed,  5 Nov 2025 22:29:44 +0800
Message-ID: <20251105142944.73061-5-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105142944.73061-1-me@linux.beauty>
References: <20251105142944.73061-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Implement a new `--trailer <text>` option for `git rebase`
(support merge backend only now), which appends arbitrary
trailer lines to each rebased commit message.

Reject it if the user passes an option that requires the
apply backend (git am) since it lacks message‑filter/trailer
hook. otherwise we can just use the merge backend.

Automatically set REBASE_FORCE when any trailer is supplied.

And reject invalid input before user edits the interactive file.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 Documentation/git-rebase.adoc |   9 ++-
 builtin/rebase.c              |  50 +++++++++++++
 sequencer.c                   |  34 +++++++++
 sequencer.h                   |   4 +-
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 134 ++++++++++++++++++++++++++++++++++
 trailer.c                     |  29 +++++++-
 trailer.h                     |   5 ++
 8 files changed, 262 insertions(+), 4 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 005caf6164..4d2fe4be6e 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -487,9 +487,16 @@ See also INCOMPATIBLE OPTIONS below.
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
+
 See also INCOMPATIBLE OPTIONS below.
 
+--trailer=<trailer>::
+       Append the given trailer line(s) to every rebased commit
+       message, processed via linkgit:git-interpret-trailers[1].
+       When this option is present *rebase automatically implies*
+       `--force-rebase` so that fast‑forwarded commits are also
+       rewritten.
+
 -i::
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c468828189..a88abe08b4 100644
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
+		.trailer_args = STRVEC_INIT,  \
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
@@ -500,6 +508,23 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
+	strbuf_reset(&buf);
+
+	if (strbuf_read_file(&buf, state_dir_path("trailer", opts), 0) >= 0) {
+		const char *p = buf.buf, *end = buf.buf + buf.len;
+
+		while (p < end) {
+			char *nl = memchr(p, '\n', end - p);
+			if (!nl)
+				die("nl shouldn't be NULL");
+			*nl = '\0';
+
+			if (*p)
+				strvec_push(&opts->trailer_args, p);
+
+			p = nl + 1;
+		}
+	}
 	strbuf_release(&buf);
 
 	return 0;
@@ -528,6 +553,21 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	if (opts->signoff)
 		write_file(state_dir_path("signoff", opts), "--signoff");
 
+	/*
+	 * save opts->trailer_args into state_dir/trailer
+	 */
+	if (opts->trailer_args.nr) {
+		struct strbuf buf = STRBUF_INIT;
+
+		for (size_t i = 0; i < opts->trailer_args.nr; i++) {
+				strbuf_addstr(&buf, opts->trailer_args.v[i]);
+				strbuf_addch(&buf, '\n');
+		}
+		write_file(state_dir_path("trailer", opts),
+				   "%s", buf.buf);
+		strbuf_release(&buf);
+	}
+
 	return 0;
 }
 
@@ -1132,6 +1172,8 @@ int cmd_rebase(int argc,
 			.flags = PARSE_OPT_NOARG,
 			.defval = REBASE_DIFFSTAT,
 		},
+		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"),
+				N_("add custom trailer(s)")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -1285,6 +1327,11 @@ int cmd_rebase(int argc,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (options.trailer_args.nr) {
+		validate_trailer_args_after_config(&options.trailer_args);
+		options.flags |= REBASE_FORCE;
+	}
+
 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges\n"
 			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
@@ -1542,6 +1589,9 @@ int cmd_rebase(int argc,
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
+	if (options.trailer_args.nr)
+		imply_merge(&options, "--trailer");
+
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
diff --git a/sequencer.c b/sequencer.c
index 5476d39ba9..fbf35cb474 100644
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
@@ -2025,6 +2027,10 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 		if (opts->signoff)
 			append_signoff(buf, 0, 0);
 
+		if (opts->trailer_args.nr &&
+			amend_strbuf_with_trailers(buf, &opts->trailer_args))
+			return error(_("unable to add trailers to commit message"));
+
 		if ((command == TODO_FIXUP) &&
 		    (flag & TODO_REPLACE_FIXUP_MSG) &&
 		    (file_exists(rebase_path_fixup_msg()) ||
@@ -2443,6 +2449,14 @@ static int do_pick_commit(struct repository *r,
 	if (opts->signoff && !is_fixup(command))
 		append_signoff(&ctx->message, 0, 0);
 
+	if (opts->trailer_args.nr && !is_fixup(command)) {
+		if (amend_strbuf_with_trailers(&ctx->message,
+					       &opts->trailer_args)) {
+			res = error(_("unable to add trailers to commit message"));
+			goto leave;
+		}
+	}
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy ||
@@ -2517,6 +2531,7 @@ static int do_pick_commit(struct repository *r,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
 	} /* else allow == 0 and there's nothing special to do */
+
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
@@ -3234,6 +3249,17 @@ static int read_populate_opts(struct replay_opts *opts)
 
 		read_strategy_opts(opts, &buf);
 		strbuf_reset(&buf);
+		if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {
+			char *p = buf.buf, *nl;
+
+			while ((nl = strchr(p, '\n'))) {
+				*nl = '\0';
+				if (*p)
+					strvec_push(&opts->trailer_args, p);
+				p = nl + 1;
+			}
+			strbuf_reset(&buf);
+		}
 
 		if (read_oneliner(&ctx->current_fixups,
 				  rebase_path_current_fixups(),
@@ -3328,6 +3354,14 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
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
index 719684c8a9..e21835c5a0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,7 @@ struct replay_opts {
 	int record_origin;
 	int no_commit;
 	int signoff;
+	struct strvec trailer_args;
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
@@ -82,8 +83,9 @@ struct replay_opts {
 	struct replay_ctx *ctx;
 };
 #define REPLAY_OPTS_INIT {			\
-	.edit = -1,				\
 	.action = -1,				\
+	.edit = -1,				\
+	.trailer_args = STRVEC_INIT, \
 	.xopts = STRVEC_INIT,			\
 	.ctx = replay_ctx_new(),		\
 }
diff --git a/t/meson.build b/t/meson.build
index c9ddd89889..6ebb08feca 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -384,6 +384,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3440-rebase-trailer.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
new file mode 100755
index 0000000000..d0e0434664
--- /dev/null
+++ b/t/t3440-rebase-trailer.sh
@@ -0,0 +1,134 @@
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
+
+expect_trailer_msg() {
+	test_commit_message "$1" <<-EOF
+	$2
+
+	${3:-$REVIEWED_BY_TRAILER}
+	EOF
+}
+
+test_expect_success 'setup repo with a small history' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	test_commit first file a &&
+	test_commit second file &&
+	git checkout -b conflict-branch first &&
+	test_commit file-2 file-2 &&
+	test_commit conflict file &&
+	test_commit third file
+'
+
+test_expect_success 'apply backend is rejected with --trailer' '
+	head_before=$(git rev-parse HEAD) &&
+	test_expect_code 128 \
+	git rebase --apply --trailer "$REVIEWED_BY_TRAILER" \
+				HEAD^ 2>err &&
+	test_grep "fatal: --trailer requires the merge backend" err &&
+	test_cmp_rev HEAD $head_before
+'
+
+test_expect_success 'reject empty --trailer argument' '
+	test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&
+	test_grep "empty --trailer" err
+'
+
+test_expect_success 'reject trailer with missing key before separator' '
+	test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
+	test_grep "missing key before separator" err
+'
+
+test_expect_success 'allow trailer with missing value after separator' '
+	git rebase -m --trailer "Acked-by:" HEAD~1 third &&
+	sed -e "s/_/ /g" <<-\EOF >expect &&
+	third
+
+	Acked-by:_
+	EOF
+	test_commit_message HEAD expect
+'
+
+test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
+	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
+		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 third &&
+	cat >expect <<-\EOF &&
+	third
+
+	Bug: 456
+	EOF
+	test_commit_message HEAD expect
+'
+
+test_expect_success 'multiple Signed-off-by trailers all preserved' '
+	git rebase -m \
+			--trailer "Signed-off-by: Dev A <a@example.com>" \
+			--trailer "Signed-off-by: Dev B <b@example.com>" HEAD~1 third &&
+	cat >expect <<-\EOF &&
+	third
+
+	Signed-off-by: Dev A <a@example.com>
+	Signed-off-by: Dev B <b@example.com>
+	EOF
+	test_commit_message HEAD expect
+'
+
+test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
+	git checkout -B conflict-branch third &&
+	test_commit fourth file &&
+	test_must_fail git rebase -m \
+			--trailer "$REVIEWED_BY_TRAILER" \
+			second &&
+	git checkout --theirs file &&
+	git add file &&
+	git rebase --continue &&
+	expect_trailer_msg HEAD "fourth" &&
+	expect_trailer_msg HEAD^ "third"
+'
+
+test_expect_success '--trailer handles fixup commands in todo list' '
+	git checkout -B fixup-trailer HEAD &&
+	test_commit fixup-base base &&
+	test_commit fixup-second second &&
+	first_short=$(git rev-parse --short fixup-base) &&
+	second_short=$(git rev-parse --short fixup-second) &&
+	cat >todo <<EOF &&
+pick $first_short fixup-base
+fixup $second_short fixup-second
+EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	expect_trailer_msg HEAD "fixup-base" &&
+	git reset --hard fixup-second &&
+	cat >todo <<EOF &&
+pick $first_short fixup-base
+fixup -C $second_short fixup-second
+EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	expect_trailer_msg HEAD "fixup-second"
+'
+
+test_expect_success 'rebase --root --trailer updates every commit' '
+	git checkout first &&
+	git -c trailer.review.key=Reviewed-by rebase --root \
+		--trailer=review="Dev <dev@example.com>" &&
+	expect_trailer_msg HEAD  "first" &&
+	expect_trailer_msg HEAD^ "Initial empty commit"
+'
+test_done
diff --git a/trailer.c b/trailer.c
index f5838f5699..f6ff2f01ee 100644
--- a/trailer.c
+++ b/trailer.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
+#include "strvec.h"
 #include "trailer.h"
 #include "list.h"
 #include "wrapper.h"
@@ -774,6 +775,30 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
+void validate_trailer_args_after_config(const struct strvec *cli_args)
+{
+	char *cl_separators;
+
+	trailer_config_init();
+
+	cl_separators = xstrfmt("=%s", separators);
+
+	for (size_t i = 0; i < cli_args->nr; i++) {
+		const char *txt = cli_args->v[i];
+		ssize_t separator_pos;
+
+		if (!*txt)
+			die(_("empty --trailer argument"));
+
+		separator_pos = find_separator(txt, cl_separators);
+		if (separator_pos == 0)
+			die(_("invalid trailer '%s': missing key before separator"),
+		    txt);
+	}
+
+	free(cl_separators);
+}
+
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1226,8 +1251,8 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-static int amend_strbuf_with_trailers(struct strbuf *buf,
-				      const struct strvec *trailer_args)
+int amend_strbuf_with_trailers(struct strbuf *buf,
+			       const struct strvec *trailer_args)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	LIST_HEAD(new_trailer_head);
diff --git a/trailer.h b/trailer.h
index daea46ca5d..541657a11f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -68,6 +68,8 @@ void parse_trailers_from_config(struct list_head *config_head);
 void parse_trailers_from_command_line_args(struct list_head *arg_head,
 					   struct list_head *new_trailer_head);
 
+void validate_trailer_args_after_config(const struct strvec *cli_args);
+
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
@@ -195,6 +197,9 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+int amend_strbuf_with_trailers(struct strbuf *buf,
+			       const struct strvec *trailer_args);
+
 /*
  * Augment a file to add trailers to it (similar to 'git interpret-trailers').
  * Returns 0 on success or a non-zero error code on failure.
-- 
2.51.0

