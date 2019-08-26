Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951961F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbfHZT6Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:58:25 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:11489 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733294AbfHZT6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:24 -0400
Date:   Mon, 26 Aug 2019 19:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566849490; bh=FOSqJqB3wvtTtLsX+RNy4Yab+nKP9yGnAWOQBXwJQrM=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=TNGap8sstmiVEWVc/jL2h+KTGxL1UuIxSjmb+A93Y60caqiQ+vITWvS4ti4VfkWRn
         z8jeHcB6aA8iwYTMsCzKgM45FaI0Hq20eJzGwPG0WH++AoDEyNR4eTQGqD+VZyR35U
         Ip/YbbOoXX3OhhLQPy8I/30zkzQdOMzHWC39wtYR3Pp7hWIsBtRA9LTcStgMHIcOP4
         2EDtYwnaZet4VUzw7/dj1wxmb8wT9Pp6Zi6f47Fv6TlMY+j/HV+KEMxC3UjwS1tmJX
         HUQscUB3MI5CZ5JkLtXAyK+CLOixrQL0huRGHw9fU6b+vf1nzVUtyMiCdtnOI3N7Fi
         5ryglMBNDq4sQ==
To:     git@vger.kernel.org
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     Ibrahim El Rhezzali <ibrahim.el@pm.me>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: [PATCH 4/5] Signing API: Removed old gpg interface and gpg mentions in code
Message-ID: <jmdChj8zFlWgVBVPoZ6H2WQTHMdc8JO3L7Mfy_B6WjyehHOhLx2AfIiXg2K5m60QC9La0_G5zqk48sv4ko9nh2emVVwFRWp_-qIThwxK_JM=@pm.me>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ibrahim El Rhezzali <ibrahim.el@pm.me>

8a89a97d4 Removed old gpg interface and gpg mentions in code

Removing old GPG interface and updating the code to remove gpg mentions and=
 make it transparent the signign tool that is used

Signed-off-by: Ibrahim El <ibrahim.el@pm.me>
---
 Makefile                           |   1 -
 builtin/am.c                       |   8 +-
 builtin/commit-tree.c              |   2 +-
 builtin/commit.c                   |   8 +-
 builtin/fmt-merge-msg.c            |   2 +-
 builtin/merge.c                    |   6 +-
 builtin/pull.c                     |  16 +-
 builtin/push.c                     |   2 +-
 builtin/rebase.c                   |  60 +++---
 builtin/receive-pack.c             |   2 +-
 builtin/replace.c                  |   2 +-
 builtin/revert.c                   |   6 +-
 builtin/send-pack.c                |   2 +-
 builtin/tag.c                      |   4 +-
 builtin/verify-commit.c            |   8 +-
 builtin/verify-tag.c               |   4 +-
 commit.c                           |  26 +--
 commit.h                           |   2 +-
 gpg-interface.c                    | 381 ---------------------------------=
----
 gpg-interface.h                    |  70 -------
 log-tree.c                         |  18 +-
 sequencer.c                        |  56 +++---
 sequencer.h                        |   2 +-
 t/t5573-pull-verify-signatures.sh  |  10 +-
 t/t7612-merge-verify-signatures.sh |  18 +-
 tag.c                              |   6 +-
 tag.h                              |   2 +-
 27 files changed, 136 insertions(+), 588 deletions(-)
 delete mode 100644 gpg-interface.c
 delete mode 100644 gpg-interface.h

diff --git a/Makefile b/Makefile
index 244540e8d..cc7344ca3 100644
--- a/Makefile
+++ b/Makefile
@@ -885,7 +885,6 @@ LIB_OBJS +=3D fetch-pack.o
 LIB_OBJS +=3D fsck.o
 LIB_OBJS +=3D fsmonitor.o
 LIB_OBJS +=3D gettext.o
-LIB_OBJS +=3D gpg-interface.o
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hashmap.o
diff --git a/builtin/am.c b/builtin/am.c
index a76efdd5d..55066bf64 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -127,7 +127,7 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state)
 {
-=09int gpgsign;
+=09int sign_config;
=20
 =09memset(state, 0, sizeof(*state));
=20
@@ -145,8 +145,8 @@ static void am_state_init(struct am_state *state)
=20
 =09argv_array_init(&state->git_apply_opts);
=20
-=09if (!git_config_get_bool("commit.gpgsign", &gpgsign))
-=09=09state->sign_commit =3D gpgsign ? "" : NULL;
+=09if (!git_config_get_bool("commit.gpgsign", &sign_config) || !git_config=
_get_bool("commit.sign", &sign_config))
+=09=09state->sign_commit =3D sign_config ? "" : NULL;
 }
=20
 /**
@@ -2251,7 +2251,7 @@ int cmd_am(int argc, const char **argv, const char *p=
refix)
 =09=09=09N_("use current timestamp for author date")),
 =09=09OPT_RERERE_AUTOUPDATE(&state.allow_rerere_autoupdate),
 =09=09{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
-=09=09  N_("GPG-sign commits"),
+=09=09  N_("sign commits"),
 =09=09  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09=09OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 =09=09=09N_("(internal use for git-rebase)")),
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 06bc5016d..7e5e5f821 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -118,7 +118,7 @@ int cmd_commit_tree(int argc, const char **argv, const =
char *prefix)
 =09=09=09N_("read commit log message from file"), PARSE_OPT_NONEG,
 =09=09=09parse_file_arg_callback },
 =09=09{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-=09=09=09N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+=09=09=09N_("sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09=09OPT_END()
 =09};
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 3b446a029..3c8346b4f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1427,7 +1427,7 @@ static int git_commit_config(const char *k, const cha=
r *v, void *cb)
 =09}
 =09if (!strcmp(k, "commit.cleanup"))
 =09=09return git_config_string(&cleanup_arg, k, v);
-=09if (!strcmp(k, "commit.gpgsign")) {
+=09if (!strcmp(k, "commit.gpgsign") || !strcmp(k, "commit.sign")) {
 =09=09sign_commit =3D git_config_bool(k, v) ? "" : NULL;
 =09=09return 0;
 =09}
@@ -1489,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 =09=09OPT_CLEANUP(&cleanup_arg),
 =09=09OPT_BOOL(0, "status", &include_status, N_("include status in commit =
message template")),
 =09=09{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-=09=09  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+=09=09  N_("sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09=09/* end commit message options */
=20
 =09=09OPT_GROUP(N_("Commit contents options")),
@@ -1636,8 +1636,8 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 =09}
=20
 =09if (amend) {
-=09=09const char *exclude_gpgsig[2] =3D { "gpgsig", NULL };
-=09=09extra =3D read_commit_extra_headers(current_head, exclude_gpgsig);
+=09=09const char *exclude_sig[2] =3D { "gpgsig", NULL };
+=09=09extra =3D read_commit_extra_headers(current_head, exclude_sig);
 =09} else {
 =09=09struct commit_extra_header **tail =3D &extra;
 =09=09append_merge_tag_headers(parents, &tail);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 2dd0e9367..6ddf285b5 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -505,7 +505,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 =09=09=09; /* merely annotated */
 =09=09else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig,=
 NULL)) {
 =09=09=09if (!sig.len)
-=09=09=09=09strbuf_addstr(&sig, "gpg verification failed.\n");
+=09=09=09=09strbuf_addstr(&sig, "sig verification failed.\n");
 =09=09}
=20
 =09=09if (!tag_number++) {
diff --git a/builtin/merge.c b/builtin/merge.c
index 67a0bcb35..c9b95b98e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -262,7 +262,7 @@ static struct option builtin_merge_options[] =3D {
 =09=09      FF_ONLY, PARSE_OPT_NONEG),
 =09OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 =09OPT_BOOL(0, "verify-signatures", &verify_signatures,
-=09=09N_("verify that the named commit has a valid GPG signature")),
+=09=09N_("verify that the named commit has a valid signature")),
 =09OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 =09=09N_("merge strategy to use"), option_parse_strategy),
 =09OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=3Dvalue"),
@@ -284,7 +284,7 @@ static struct option builtin_merge_options[] =3D {
 =09=09 N_("allow merging unrelated histories")),
 =09OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting=
"), 1),
 =09{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-=09  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+=09  N_("Sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored f=
iles (default)")),
 =09OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
 =09OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
@@ -628,7 +628,7 @@ static int git_merge_config(const char *k, const char *=
v, void *cb)
 =09} else if (!strcmp(k, "merge.defaulttoupstream")) {
 =09=09default_to_upstream =3D git_config_bool(k, v);
 =09=09return 0;
-=09} else if (!strcmp(k, "commit.gpgsign")) {
+=09} else if (!strcmp(k, "commit.gpgsign") || !strcmp(k, "commit.sign")) {
 =09=09sign_commit =3D git_config_bool(k, v) ? "" : NULL;
 =09=09return 0;
 =09}
diff --git a/builtin/pull.c b/builtin/pull.c
index 9dd32a115..b60646b70 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -109,7 +109,7 @@ static int opt_autostash =3D -1;
 static int config_autostash;
 static struct argv_array opt_strategies =3D ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts =3D ARGV_ARRAY_INIT;
-static char *opt_gpg_sign;
+static char *opt_sign;
 static int opt_allow_unrelated_histories;
=20
 /* Options passed to git-fetch */
@@ -178,7 +178,7 @@ static struct option pull_options[] =3D {
 =09=09N_("abort if fast-forward is not possible"),
 =09=09PARSE_OPT_NOARG | PARSE_OPT_NONEG),
 =09OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
-=09=09N_("verify that the named commit has a valid GPG signature"),
+=09=09N_("verify that the named commit has a valid signature"),
 =09=09PARSE_OPT_NOARG),
 =09OPT_BOOL(0, "autostash", &opt_autostash,
 =09=09N_("automatically stash/stash pop before and after rebase")),
@@ -189,8 +189,8 @@ static struct option pull_options[] =3D {
 =09=09N_("option=3Dvalue"),
 =09=09N_("option for selected merge strategy"),
 =09=090),
-=09OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
-=09=09N_("GPG sign commit"),
+=09OPT_PASSTHRU('S', "gpg-sign", &opt_sign, N_("key-id"),
+=09=09N_("Sign commit"),
 =09=09PARSE_OPT_OPTARG),
 =09OPT_SET_INT(0, "allow-unrelated-histories",
 =09=09    &opt_allow_unrelated_histories,
@@ -656,8 +656,8 @@ static int run_merge(void)
 =09=09argv_array_push(&args, opt_verify_signatures);
 =09argv_array_pushv(&args, opt_strategies.argv);
 =09argv_array_pushv(&args, opt_strategy_opts.argv);
-=09if (opt_gpg_sign)
-=09=09argv_array_push(&args, opt_gpg_sign);
+=09if (opt_sign)
+=09=09argv_array_push(&args, opt_sign);
 =09if (opt_allow_unrelated_histories > 0)
 =09=09argv_array_push(&args, "--allow-unrelated-histories");
=20
@@ -843,8 +843,8 @@ static int run_rebase(const struct object_id *curr_head=
,
 =09=09argv_array_push(&args, opt_diffstat);
 =09argv_array_pushv(&args, opt_strategies.argv);
 =09argv_array_pushv(&args, opt_strategy_opts.argv);
-=09if (opt_gpg_sign)
-=09=09argv_array_push(&args, opt_gpg_sign);
+=09if (opt_sign)
+=09=09argv_array_push(&args, opt_sign);
 =09if (opt_autostash =3D=3D 0)
 =09=09argv_array_push(&args, "--no-autostash");
 =09else if (opt_autostash =3D=3D 1)
diff --git a/builtin/push.c b/builtin/push.c
index 74a6758cd..f0d4f7545 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -580,7 +580,7 @@ int cmd_push(int argc, const char **argv, const char *p=
refix)
 =09=09OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags=
"),
 =09=09=09TRANSPORT_PUSH_FOLLOW_TAGS),
 =09=09{ OPTION_CALLBACK,
-=09=09  0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the pus=
h"),
+=09=09  0, "signed", &push_cert, "(yes|no|if-asked)", N_("sign the push"),
 =09=09  PARSE_OPT_OPTARG, option_parse_push_signed },
 =09=09OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remot=
e side"), TRANSPORT_PUSH_ATOMIC),
 =09=09OPT_STRING_LIST('o', "push-option", &push_options_cmdline, N_("serve=
r-specific"), N_("option to transmit")),
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b8116db48..b63ce94d8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,7 +79,7 @@ struct rebase_options {
 =09int allow_rerere_autoupdate;
 =09int keep_empty;
 =09int autosquash;
-=09char *gpg_sign_opt;
+=09char *sign_opt;
 =09int autostash;
 =09char *cmd;
 =09int allow_empty_message;
@@ -112,7 +112,7 @@ static struct replay_opts get_replay_opts(const struct =
rebase_options *opts)
 =09replay.allow_empty_message =3D opts->allow_empty_message;
 =09replay.verbose =3D opts->flags & REBASE_VERBOSE;
 =09replay.reschedule_failed_exec =3D opts->reschedule_failed_exec;
-=09replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
+=09replay.sign =3D xstrdup_or_null(opts->sign_opt);
 =09replay.strategy =3D opts->strategy;
 =09if (opts->strategy_opts)
 =09=09parse_strategy_opts(&replay, opts->strategy_opts);
@@ -486,8 +486,8 @@ int cmd_rebase__interactive(int argc, const char **argv=
, const char *prefix)
 =09=09  N_("the upstream commit"), PARSE_OPT_NONEG, parse_opt_commit,
 =09=09  0 },
 =09=09OPT_STRING(0, "head-name", &opts.head_name, N_("head-name"), N_("hea=
d name")),
-=09=09{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
-=09=09=09N_("GPG-sign commits"),
+=09=09{ OPTION_STRING, 'S', "gpg-sign", &opts.sign_opt, N_("key-id"),
+=09=09=09N_("sign commits"),
 =09=09=09PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09=09OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
 =09=09=09   N_("rebase strategy")),
@@ -627,13 +627,13 @@ static int read_basic_state(struct rebase_options *op=
ts)
 =09=09=09=09  "'%s'"), buf.buf);
 =09}
=20
-=09if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
+=09if (file_exists(state_dir_path("sign_opt", opts))) {
 =09=09strbuf_reset(&buf);
-=09=09if (read_one(state_dir_path("gpg_sign_opt", opts),
+=09=09if (read_one(state_dir_path("sign_opt", opts),
 =09=09=09    &buf))
 =09=09=09return -1;
-=09=09free(opts->gpg_sign_opt);
-=09=09opts->gpg_sign_opt =3D xstrdup(buf.buf);
+=09=09free(opts->sign_opt);
+=09=09opts->sign_opt =3D xstrdup(buf.buf);
 =09}
=20
 =09if (file_exists(state_dir_path("strategy", opts))) {
@@ -680,9 +680,9 @@ static int rebase_write_basic_state(struct rebase_optio=
ns *opts)
 =09=09=09   "-%s-rerere-autoupdate",
 =09=09=09   opts->allow_rerere_autoupdate =3D=3D RERERE_AUTOUPDATE ?
 =09=09=09=09"" : "-no");
-=09if (opts->gpg_sign_opt)
-=09=09write_file(state_dir_path("gpg_sign_opt", opts), "%s",
-=09=09=09   opts->gpg_sign_opt);
+=09if (opts->sign_opt)
+=09=09write_file(state_dir_path("sign_opt", opts), "%s",
+=09=09=09   opts->sign_opt);
 =09if (opts->signoff)
 =09=09write_file(state_dir_path("strategy", opts), "--signoff");
=20
@@ -957,8 +957,8 @@ static int run_am(struct rebase_options *opts)
 =09if (opts->action && !strcmp("continue", opts->action)) {
 =09=09argv_array_push(&am.args, "--resolved");
 =09=09argv_array_pushf(&am.args, "--resolvemsg=3D%s", resolvemsg);
-=09=09if (opts->gpg_sign_opt)
-=09=09=09argv_array_push(&am.args, opts->gpg_sign_opt);
+=09=09if (opts->sign_opt)
+=09=09=09argv_array_push(&am.args, opts->sign_opt);
 =09=09status =3D run_command(&am);
 =09=09if (status)
 =09=09=09return status;
@@ -1047,8 +1047,8 @@ static int run_am(struct rebase_options *opts)
 =09=09argv_array_push(&am.args, "--rerere-autoupdate");
 =09else if (opts->allow_rerere_autoupdate =3D=3D RERERE_NOAUTOUPDATE)
 =09=09argv_array_push(&am.args, "--no-rerere-autoupdate");
-=09if (opts->gpg_sign_opt)
-=09=09argv_array_push(&am.args, opts->gpg_sign_opt);
+=09if (opts->sign_opt)
+=09=09argv_array_push(&am.args, opts->sign_opt);
 =09status =3D run_command(&am);
 =09unlink(rebased_patches);
 =09free(rebased_patches);
@@ -1077,11 +1077,11 @@ static int run_specific_rebase(struct rebase_option=
s *opts, enum action action)
 =09=09=09setenv("GIT_SEQUENCE_EDITOR", ":", 1);
 =09=09=09opts->autosquash =3D 0;
 =09=09}
-=09=09if (opts->gpg_sign_opt) {
+=09=09if (opts->sign_opt) {
 =09=09=09/* remove the leading "-S" */
-=09=09=09char *tmp =3D xstrdup(opts->gpg_sign_opt + 2);
-=09=09=09free(opts->gpg_sign_opt);
-=09=09=09opts->gpg_sign_opt =3D tmp;
+=09=09=09char *tmp =3D xstrdup(opts->sign_opt + 2);
+=09=09=09free(opts->sign_opt);
+=09=09=09opts->sign_opt =3D tmp;
 =09=09}
=20
 =09=09status =3D run_rebase_interactive(opts, action);
@@ -1129,7 +1129,7 @@ static int run_specific_rebase(struct rebase_options =
*opts, enum action action)
 =09=09=09"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
 =09add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 =09add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
-=09add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
+=09add_var(&script_snippet, "sign_opt", opts->sign_opt);
 =09add_var(&script_snippet, "cmd", opts->cmd);
 =09add_var(&script_snippet, "allow_empty_message",
 =09=09opts->allow_empty_message ?  "--allow-empty-message" : "");
@@ -1207,9 +1207,9 @@ static int rebase_config(const char *var, const char =
*value, void *data)
 =09=09return 0;
 =09}
=20
-=09if (!strcmp(var, "commit.gpgsign")) {
-=09=09free(opts->gpg_sign_opt);
-=09=09opts->gpg_sign_opt =3D git_config_bool(var, value) ?
+=09if (!strcmp(var, "commit.gpgsign") || !strcmp(var, "commit.sign")) {
+=09=09free(opts->sign_opt);
+=09=09opts->sign_opt =3D git_config_bool(var, value) ?
 =09=09=09xstrdup("-S") : NULL;
 =09=09return 0;
 =09}
@@ -1372,7 +1372,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 =09struct strbuf buf =3D STRBUF_INIT;
 =09struct object_id merge_base;
 =09enum action action =3D ACTION_NONE;
-=09const char *gpg_sign =3D NULL;
+=09const char *sign =3D NULL;
 =09struct string_list exec =3D STRING_LIST_INIT_NODUP;
 =09const char *rebase_merges =3D NULL;
 =09int fork_point =3D -1;
@@ -1445,8 +1445,8 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 =09=09OPT_BOOL(0, "autosquash", &options.autosquash,
 =09=09=09 N_("move commits that begin with "
 =09=09=09    "squash!/fixup! under -i")),
-=09=09{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
-=09=09=09N_("GPG-sign commits"),
+=09=09{ OPTION_STRING, 'S', "gpg-sign", &sign, N_("key-id"),
+=09=09=09N_("sign commits"),
 =09=09=09PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09=09OPT_BOOL(0, "autostash", &options.autostash,
 =09=09=09 N_("automatically stash/stash pop before and after")),
@@ -1695,9 +1695,9 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 =09if (options.keep_empty)
 =09=09imply_interactive(&options, "--keep-empty");
=20
-=09if (gpg_sign) {
-=09=09free(options.gpg_sign_opt);
-=09=09options.gpg_sign_opt =3D xstrfmt("-S%s", gpg_sign);
+=09if (sign) {
+=09=09free(options.sign_opt);
+=09=09options.sign_opt =3D xstrfmt("-S%s", sign);
 =09}
=20
 =09if (exec.nr) {
@@ -2143,7 +2143,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 cleanup:
 =09strbuf_release(&revisions);
 =09free(options.head_name);
-=09free(options.gpg_sign_opt);
+=09free(options.sign_opt);
 =09free(options.cmd);
 =09free(squash_onto_name);
 =09return ret;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a90dea5a..11b4ba4e9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -630,7 +630,7 @@ static void prepare_push_cert_sha1(struct child_process=
 *proc)
 =09=09return;
=20
 =09if (!already_done) {
-=09=09int bogs /* beginning_of_gpg_sig */;
+=09=09int bogs /* beginning_of_sig */;
=20
 =09=09already_done =3D 1;
 =09=09if (write_object_file(push_cert.buf, push_cert.len, "blob",
diff --git a/builtin/replace.c b/builtin/replace.c
index 644b21ca8..94a56d07c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -464,7 +464,7 @@ static int create_graft(int argc, const char **argv, in=
t force, int gentle)
 =09}
=20
 =09if (remove_signature(&buf)) {
-=09=09warning(_("the original commit '%s' has a gpg signature"), old_ref);
+=09=09warning(_("the original commit '%s' has a signature"), old_ref);
 =09=09warning(_("the signature will be removed in the replacement commit!"=
));
 =09}
=20
diff --git a/builtin/revert.c b/builtin/revert.c
index d4dcedbdc..58c1c15a8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -113,8 +113,8 @@ static int run_sequencer(int argc, const char **argv, s=
truct replay_opts *opts)
 =09=09OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge=
 strategy")),
 =09=09OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
 =09=09=09N_("option for merge strategy"), option_parse_x),
-=09=09{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
-=09=09  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+=09=09{ OPTION_STRING, 'S', "gpg-sign", &opts->sign, N_("key-id"),
+=09=09  N_("sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09=09OPT_END()
 =09};
 =09struct option *options =3D base_options;
@@ -197,7 +197,7 @@ static int run_sequencer(int argc, const char **argv, s=
truct replay_opts *opts)
 =09=09usage_with_options(usage_str, options);
=20
 =09/* These option values will be free()d */
-=09opts->gpg_sign =3D xstrdup_or_null(opts->gpg_sign);
+=09opts->sign =3D xstrdup_or_null(opts->sign);
 =09opts->strategy =3D xstrdup_or_null(opts->strategy);
=20
 =09if (cmd =3D=3D 'q') {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index ba21fb2df..171a5db8c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -166,7 +166,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 =09=09OPT_BOOL(0, "mirror", &send_mirror, N_("mirror all refs")),
 =09=09OPT_BOOL('f', "force", &force_update, N_("force updates")),
 =09=09{ OPTION_CALLBACK,
-=09=09  0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the pus=
h"),
+=09=09  0, "signed", &push_cert, "(yes|no|if-asked)", N_("sign the push"),
 =09=09  PARSE_OPT_OPTARG, option_parse_push_signed },
 =09=09OPT_STRING_LIST(0, "push-option", &push_options,
 =09=09=09=09N_("server-specific"),
diff --git a/builtin/tag.c b/builtin/tag.c
index a52aa54c0..7916d375e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -116,7 +116,7 @@ static int verify_tag(const char *name, const char *ref=
,
 =09if (format->format)
 =09=09flags =3D OUTPUT_OMIT_STATUS;
=20
-=09if (gpg_verify_tag(oid, name, flags))
+=09if (sig_verify_tag(oid, name, flags))
 =09=09return -1;
=20
 =09if (format->format)
@@ -408,7 +408,7 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
 =09=09  N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg },
 =09=09OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 =09=09OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
-=09=09OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag"))=
,
+=09=09OPT_BOOL('s', "sign", &opt.sign, N_("annotated and signed tag")),
 =09=09OPT_CLEANUP(&cleanup_arg),
 =09=09OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 =09=09=09=09=09N_("use another key to sign the tag")),
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 0f701ee70..c1a8e1410 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -21,7 +21,7 @@ static const char * const verify_commit_usage[] =3D {
 =09=09NULL
 };
=20
-static int run_gpg_verify(struct commit *commit, unsigned flags)
+static int run_sig_verify(struct commit *commit, unsigned flags)
 {
 =09struct signature signature_check;
 =09int ret;
@@ -50,7 +50,7 @@ static int verify_commit(const char *name, unsigned flags=
)
 =09=09return error("%s: cannot verify a non-commit object of type %s.",
 =09=09=09=09name, type_name(obj->type));
=20
-=09return run_gpg_verify((struct commit *)obj, flags);
+=09return run_sig_verify((struct commit *)obj, flags);
 }
=20
 static int git_verify_commit_config(const char *var, const char *value, vo=
id *cb)
@@ -67,7 +67,7 @@ int cmd_verify_commit(int argc, const char **argv, const =
char *prefix)
 =09unsigned flags =3D 0;
 =09const struct option verify_commit_options[] =3D {
 =09=09OPT__VERBOSE(&verbose, N_("print commit contents")),
-=09=09OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), OUTPUT_=
RAW),
+=09=09OPT_BIT(0, "raw", &flags, N_("print raw sig status output"), OUTPUT_=
RAW),
 =09=09OPT_END()
 =09};
=20
@@ -82,7 +82,7 @@ int cmd_verify_commit(int argc, const char **argv, const =
char *prefix)
 =09=09flags |=3D OUTPUT_VERBOSE;
=20
 =09/* sometimes the program was terminated because this signal
-=09 * was received in the process of writing the gpg input: */
+=09 * was received in the process of writing the sig input: */
 =09signal(SIGPIPE, SIG_IGN);
 =09while (i < argc)
 =09=09if (verify_commit(argv[i++], flags))
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index d25f47d38..59099fd38 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -35,7 +35,7 @@ int cmd_verify_tag(int argc, const char **argv, const cha=
r *prefix)
 =09struct ref_format format =3D REF_FORMAT_INIT;
 =09const struct option verify_tag_options[] =3D {
 =09=09OPT__VERBOSE(&verbose, N_("print tag contents")),
-=09=09OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), OUTPUT_=
RAW),
+=09=09OPT_BIT(0, "raw", &flags, N_("print raw sig status output"), OUTPUT_=
RAW),
 =09=09OPT_STRING(0, "format", &format.format, N_("format"), N_("format to =
use for the output")),
 =09=09OPT_END()
 =09};
@@ -66,7 +66,7 @@ int cmd_verify_tag(int argc, const char **argv, const cha=
r *prefix)
 =09=09=09continue;
 =09=09}
=20
-=09=09if (gpg_verify_tag(&oid, name, flags)) {
+=09=09if (sig_verify_tag(&oid, name, flags)) {
 =09=09=09had_error =3D 1;
 =09=09=09continue;
 =09=09}
diff --git a/commit.c b/commit.c
index 2727c9231..ca00ded8d 100644
--- a/commit.c
+++ b/commit.c
@@ -937,8 +937,8 @@ struct commit *get_fork_point(const char *refname, stru=
ct commit *commit)
 =09return ret;
 }
=20
-static const char gpg_sig_header[] =3D "gpgsig";
-static const int gpg_sig_header_len =3D sizeof(gpg_sig_header) - 1;
+static const char sig_header[] =3D "gpgsig";
+static const int sig_header_len =3D sizeof(sig_header) - 1;
=20
 static int do_sign_commit(struct strbuf *buf, const char *keyid)
 {
@@ -967,8 +967,8 @@ static int do_sign_commit(struct strbuf *buf, const cha=
r *keyid)
 =09=09int len =3D (eol - bol) + !!*eol;
=20
 =09=09if (!copypos) {
-=09=09=09strbuf_insert(buf, inspos, gpg_sig_header, gpg_sig_header_len);
-=09=09=09inspos +=3D gpg_sig_header_len;
+=09=09=09strbuf_insert(buf, inspos, sig_header, sig_header_len);
+=09=09=09inspos +=3D sig_header_len;
 =09=09}
 =09=09strbuf_insert(buf, inspos++, " ", 1);
 =09=09strbuf_insert(buf, inspos, bol, len);
@@ -999,9 +999,9 @@ int parse_signed_commit(const struct commit *commit,
 =09=09next =3D next ? next + 1 : tail;
 =09=09if (in_signature && line[0] =3D=3D ' ')
 =09=09=09sig =3D line + 1;
-=09=09else if (starts_with(line, gpg_sig_header) &&
-=09=09=09 line[gpg_sig_header_len] =3D=3D ' ')
-=09=09=09sig =3D line + gpg_sig_header_len + 1;
+=09=09else if (starts_with(line, sig_header) &&
+=09=09=09 line[sig_header_len] =3D=3D ' ')
+=09=09=09sig =3D line + sig_header_len + 1;
 =09=09if (sig) {
 =09=09=09strbuf_add(signature, sig, next - sig);
 =09=09=09saw_signature =3D 1;
@@ -1033,8 +1033,8 @@ int remove_signature(struct strbuf *buf)
=20
 =09=09if (in_signature && line[0] =3D=3D ' ')
 =09=09=09sig_end =3D next;
-=09=09else if (starts_with(line, gpg_sig_header) &&
-=09=09=09 line[gpg_sig_header_len] =3D=3D ' ') {
+=09=09else if (starts_with(line, sig_header) &&
+=09=09=09 line[sig_header_len] =3D=3D ' ') {
 =09=09=09sig_start =3D line;
 =09=09=09sig_end =3D next;
 =09=09=09in_signature =3D 1;
@@ -1126,16 +1126,16 @@ void verify_merge_signature(struct commit *commit, =
int verbosity)
 =09case 'G':
 =09=09break;
 =09case 'U':
-=09=09die(_("Commit %s has an untrusted GPG signature, "
+=09=09die(_("Commit %s has an untrusted signature, "
 =09=09      "allegedly by %s."), hex, signature_check.signer);
 =09case 'B':
-=09=09die(_("Commit %s has a bad GPG signature "
+=09=09die(_("Commit %s has a bad signature "
 =09=09      "allegedly by %s."), hex, signature_check.signer);
 =09default: /* 'N' */
-=09=09die(_("Commit %s does not have a GPG signature."), hex);
+=09=09die(_("Commit %s does not have a signature."), hex);
 =09}
 =09if (verbosity >=3D 0 && signature_check.result =3D=3D 'G')
-=09=09printf(_("Commit %s has a good GPG signature by %s\n"),
+=09=09printf(_("Commit %s has a good signature by %s\n"),
 =09=09       hex, signature_check.signer);
=20
 =09signature_clear(&signature_check);
diff --git a/commit.h b/commit.h
index f5a942fc5..9316fb737 100644
--- a/commit.h
+++ b/commit.h
@@ -367,7 +367,7 @@ int remove_signature(struct strbuf *buf);
  * Check the signature of the given commit. The result of the check is sto=
red
  * in sig->check_result, 'G' for a good signature, 'U' for a good signatur=
e
  * from an untrusted signer, 'B' for a bad signature and 'N' for no signat=
ure
- * at all.  This may allocate memory for sig->gpg_output, sig->gpg_status,
+ * at all.  This may allocate memory for sig->output, sig->status,
  * sig->signer and sig->key.
  */
 int check_commit_signature(const struct commit *commit, struct signature *=
sigc);
diff --git a/gpg-interface.c b/gpg-interface.c
deleted file mode 100644
index 5e7dee6fe..000000000
--- a/gpg-interface.c
+++ /dev/null
@@ -1,381 +0,0 @@
-#include "cache.h"
-#include "config.h"
-#include "run-command.h"
-#include "strbuf.h"
-#include "gpg-interface.h"
-#include "sigchain.h"
-#include "tempfile.h"
-
-#if 0
-static char *configured_signing_key;
-struct gpg_format {
-=09const char *name;
-=09const char *program;
-=09const char **verify_args;
-=09const char **sigs;
-};
-
-static const char *openpgp_verify_args[] =3D {
-=09"--keyid-format=3Dlong",
-=09NULL
-};
-static const char *openpgp_sigs[] =3D {
-=09"-----BEGIN PGP SIGNATURE-----",
-=09"-----BEGIN PGP MESSAGE-----",
-=09NULL
-};
-
-static const char *x509_verify_args[] =3D {
-=09NULL
-};
-static const char *x509_sigs[] =3D {
-=09"-----BEGIN SIGNED MESSAGE-----",
-=09NULL
-};
-
-static struct gpg_format gpg_format[] =3D {
-=09{ .name =3D "openpgp", .program =3D "gpg",
-=09  .verify_args =3D openpgp_verify_args,
-=09  .sigs =3D openpgp_sigs
-=09},
-=09{ .name =3D "x509", .program =3D "gpgsm",
-=09  .verify_args =3D x509_verify_args,
-=09  .sigs =3D x509_sigs
-=09},
-};
-
-static struct gpg_format *use_format =3D &gpg_format[0];
-
-static struct gpg_format *get_format_by_name(const char *str)
-{
-=09int i;
-
-=09for (i =3D 0; i < ARRAY_SIZE(gpg_format); i++)
-=09=09if (!strcmp(gpg_format[i].name, str))
-=09=09=09return gpg_format + i;
-=09return NULL;
-}
-
-static struct gpg_format *get_format_by_sig(const char *sig)
-{
-=09int i, j;
-
-=09for (i =3D 0; i < ARRAY_SIZE(gpg_format); i++)
-=09=09for (j =3D 0; gpg_format[i].sigs[j]; j++)
-=09=09=09if (starts_with(sig, gpg_format[i].sigs[j]))
-=09=09=09=09return gpg_format + i;
-=09return NULL;
-}
-
-void signature_check_clear(struct signature_check *sigc)
-{
-=09FREE_AND_NULL(sigc->payload);
-=09FREE_AND_NULL(sigc->gpg_output);
-=09FREE_AND_NULL(sigc->gpg_status);
-=09FREE_AND_NULL(sigc->signer);
-=09FREE_AND_NULL(sigc->key);
-=09FREE_AND_NULL(sigc->fingerprint);
-=09FREE_AND_NULL(sigc->primary_key_fingerprint);
-}
-
-/* An exclusive status -- only one of them can appear in output */
-#define GPG_STATUS_EXCLUSIVE=09(1<<0)
-/* The status includes key identifier */
-#define GPG_STATUS_KEYID=09(1<<1)
-/* The status includes user identifier */
-#define GPG_STATUS_UID=09=09(1<<2)
-/* The status includes key fingerprints */
-#define GPG_STATUS_FINGERPRINT=09(1<<3)
-
-/* Short-hand for standard exclusive *SIG status with keyid & UID */
-#define GPG_STATUS_STDSIG=09(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STA=
TUS_UID)
-
-static struct {
-=09char result;
-=09const char *check;
-=09unsigned int flags;
-} sigcheck_gpg_status[] =3D {
-=09{ 'G', "GOODSIG ", GPG_STATUS_STDSIG },
-=09{ 'B', "BADSIG ", GPG_STATUS_STDSIG },
-=09{ 'U', "TRUST_NEVER", 0 },
-=09{ 'U', "TRUST_UNDEFINED", 0 },
-=09{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID },
-=09{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
-=09{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
-=09{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
-=09{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
-};
-
-static void parse_gpg_output(struct signature_check *sigc)
-{
-=09const char *buf =3D sigc->gpg_status;
-=09const char *line, *next;
-=09int i, j;
-=09int seen_exclusive_status =3D 0;
-
-=09/* Iterate over all lines */
-=09for (line =3D buf; *line; line =3D strchrnul(line+1, '\n')) {
-=09=09while (*line =3D=3D '\n')
-=09=09=09line++;
-=09=09/* Skip lines that don't start with GNUPG status */
-=09=09if (!skip_prefix(line, "[GNUPG:] ", &line))
-=09=09=09continue;
-
-=09=09/* Iterate over all search strings */
-=09=09for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
-=09=09=09if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
-=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
-=09=09=09=09=09if (seen_exclusive_status++)
-=09=09=09=09=09=09goto found_duplicate_status;
-=09=09=09=09}
-
-=09=09=09=09if (sigcheck_gpg_status[i].result)
-=09=09=09=09=09sigc->result =3D sigcheck_gpg_status[i].result;
-=09=09=09=09/* Do we have key information? */
-=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
-=09=09=09=09=09next =3D strchrnul(line, ' ');
-=09=09=09=09=09free(sigc->key);
-=09=09=09=09=09sigc->key =3D xmemdupz(line, next - line);
-=09=09=09=09=09/* Do we have signer information? */
-=09=09=09=09=09if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID=
)) {
-=09=09=09=09=09=09line =3D next + 1;
-=09=09=09=09=09=09next =3D strchrnul(line, '\n');
-=09=09=09=09=09=09free(sigc->signer);
-=09=09=09=09=09=09sigc->signer =3D xmemdupz(line, next - line);
-=09=09=09=09=09}
-=09=09=09=09}
-=09=09=09=09/* Do we have fingerprint? */
-=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
-=09=09=09=09=09next =3D strchrnul(line, ' ');
-=09=09=09=09=09free(sigc->fingerprint);
-=09=09=09=09=09sigc->fingerprint =3D xmemdupz(line, next - line);
-
-=09=09=09=09=09/* Skip interim fields */
-=09=09=09=09=09for (j =3D 9; j > 0; j--) {
-=09=09=09=09=09=09if (!*next)
-=09=09=09=09=09=09=09break;
-=09=09=09=09=09=09line =3D next + 1;
-=09=09=09=09=09=09next =3D strchrnul(line, ' ');
-=09=09=09=09=09}
-
-=09=09=09=09=09next =3D strchrnul(line, '\n');
-=09=09=09=09=09free(sigc->primary_key_fingerprint);
-=09=09=09=09=09sigc->primary_key_fingerprint =3D xmemdupz(line, next - lin=
e);
-=09=09=09=09}
-
-=09=09=09=09break;
-=09=09=09}
-=09=09}
-=09}
-=09return;
-
-found_duplicate_status:
-=09/*
-=09 * GOODSIG, BADSIG etc. can occur only once for each signature.
-=09 * Therefore, if we had more than one then we're dealing with multiple
-=09 * signatures.  We don't support them currently, and they're rather
-=09 * hard to create, so something is likely fishy and we should reject
-=09 * them altogether.
-=09 */
-=09sigc->result =3D 'E';
-=09/* Clear partial data to avoid confusion */
-=09FREE_AND_NULL(sigc->primary_key_fingerprint);
-=09FREE_AND_NULL(sigc->fingerprint);
-=09FREE_AND_NULL(sigc->signer);
-=09FREE_AND_NULL(sigc->key);
-}
-
-int check_signature(const char *payload, size_t plen, const char *signatur=
e,
-=09size_t slen, struct signature_check *sigc)
-{
-=09struct strbuf gpg_output =3D STRBUF_INIT;
-=09struct strbuf gpg_status =3D STRBUF_INIT;
-=09int status;
-
-=09sigc->result =3D 'N';
-
-=09status =3D verify_signed_buffer(payload, plen, signature, slen,
-=09=09=09=09      &gpg_output, &gpg_status);
-=09if (status && !gpg_output.len)
-=09=09goto out;
-=09sigc->payload =3D xmemdupz(payload, plen);
-=09sigc->gpg_output =3D strbuf_detach(&gpg_output, NULL);
-=09sigc->gpg_status =3D strbuf_detach(&gpg_status, NULL);
-=09parse_gpg_output(sigc);
-=09status |=3D sigc->result !=3D 'G' && sigc->result !=3D 'U';
-
- out:
-=09strbuf_release(&gpg_status);
-=09strbuf_release(&gpg_output);
-
-=09return !!status;
-}
-
-void print_signature_buffer(const struct signature_check *sigc, unsigned f=
lags)
-{
-=09const char *output =3D flags & GPG_VERIFY_RAW ?
-=09=09sigc->gpg_status : sigc->gpg_output;
-
-=09if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
-=09=09fputs(sigc->payload, stdout);
-
-=09if (output)
-=09=09fputs(output, stderr);
-}
-
-size_t parse_signature(const char *buf, size_t size)
-{
-=09size_t len =3D 0;
-=09size_t match =3D size;
-=09while (len < size) {
-=09=09const char *eol;
-
-=09=09if (get_format_by_sig(buf + len))
-=09=09=09match =3D len;
-
-=09=09eol =3D memchr(buf + len, '\n', size - len);
-=09=09len +=3D eol ? eol - (buf + len) + 1 : size - len;
-=09}
-=09return match;
-}
-
-void set_signing_key(const char *key)
-{
-=09free(configured_signing_key);
-=09configured_signing_key =3D xstrdup(key);
-}
-
-int git_gpg_config(const char *var, const char *value, void *cb)
-{
-=09struct gpg_format *fmt =3D NULL;
-=09char *fmtname =3D NULL;
-
-=09if (!strcmp(var, "user.signingkey")) {
-=09=09if (!value)
-=09=09=09return config_error_nonbool(var);
-=09=09set_signing_key(value);
-=09=09return 0;
-=09}
-
-=09if (!strcmp(var, "gpg.format")) {
-=09=09if (!value)
-=09=09=09return config_error_nonbool(var);
-=09=09fmt =3D get_format_by_name(value);
-=09=09if (!fmt)
-=09=09=09return error("unsupported value for %s: %s",
-=09=09=09=09     var, value);
-=09=09use_format =3D fmt;
-=09=09return 0;
-=09}
-
-=09if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
-=09=09fmtname =3D "openpgp";
-
-=09if (!strcmp(var, "gpg.x509.program"))
-=09=09fmtname =3D "x509";
-
-=09if (fmtname) {
-=09=09fmt =3D get_format_by_name(fmtname);
-=09=09return git_config_string(&fmt->program, var, value);
-=09}
-
-=09return 0;
-}
-
-const char *get_signing_key(void)
-{
-=09if (configured_signing_key)
-=09=09return configured_signing_key;
-=09return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
-}
-
-int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const cha=
r *signing_key)
-{=09
-=09struct child_process gpg =3D CHILD_PROCESS_INIT;
-=09int ret;
-=09size_t i, j, bottom;
-=09struct strbuf gpg_status =3D STRBUF_INIT;
-
-=09argv_array_pushl(&gpg.args,
-=09=09=09 use_format->program,
-=09=09=09 "--status-fd=3D2",
-=09=09=09 "-bsau", signing_key,
-=09=09=09 NULL);
-
-=09bottom =3D signature->len;
-
-=09/*
-=09 * When the username signingkey is bad, program could be terminated
-=09 * because gpg exits without reading and then write gets SIGPIPE.
-=09 */
-=09sigchain_push(SIGPIPE, SIG_IGN);
-=09ret =3D pipe_command(&gpg, buffer->buf, buffer->len,
-=09=09=09   signature, 1024, &gpg_status, 0);
-=09sigchain_pop(SIGPIPE);
-
-=09ret |=3D !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
-=09strbuf_release(&gpg_status);
-=09if (ret)
-=09=09return error(_("gpg failed to sign the data"));
-
-=09/* Strip CR from the line endings, in case we are on Windows. */
-=09for (i =3D j =3D bottom; i < signature->len; i++)
-=09=09if (signature->buf[i] !=3D '\r') {
-=09=09=09if (i !=3D j)
-=09=09=09=09signature->buf[j] =3D signature->buf[i];
-=09=09=09j++;
-=09=09}
-=09strbuf_setlen(signature, j);
-
-=09return 0;
-}
-
-int verify_signed_buffer(const char *payload, size_t payload_size,
-=09=09=09 const char *signature, size_t signature_size,
-=09=09=09 struct strbuf *gpg_output, struct strbuf *gpg_status)
-{
-=09struct child_process gpg =3D CHILD_PROCESS_INIT;
-=09struct gpg_format *fmt;
-=09struct tempfile *temp;
-=09int ret;
-=09struct strbuf buf =3D STRBUF_INIT;
-
-=09temp =3D mks_tempfile_t(".git_vtag_tmpXXXXXX");
-=09if (!temp)
-=09=09return error_errno(_("could not create temporary file"));
-=09if (write_in_full(temp->fd, signature, signature_size) < 0 ||
-=09    close_tempfile_gently(temp) < 0) {
-=09=09error_errno(_("failed writing detached signature to '%s'"),
-=09=09=09    temp->filename.buf);
-=09=09delete_tempfile(&temp);
-=09=09return -1;
-=09}
-
-=09fmt =3D get_format_by_sig(signature);
-=09if (!fmt)
-=09=09BUG("bad signature '%s'", signature);
-
-=09argv_array_push(&gpg.args, fmt->program);
-=09argv_array_pushv(&gpg.args, fmt->verify_args);
-=09argv_array_pushl(&gpg.args,
-=09=09=09 "--status-fd=3D1",
-=09=09=09 "--verify", temp->filename.buf, "-",
-=09=09=09 NULL);
-
-=09if (!gpg_status)
-=09=09gpg_status =3D &buf;
-
-=09sigchain_push(SIGPIPE, SIG_IGN);
-=09ret =3D pipe_command(&gpg, payload, payload_size,
-=09=09=09   gpg_status, 0, gpg_output, 0);
-=09sigchain_pop(SIGPIPE);
-
-=09delete_tempfile(&temp);
-
-=09ret |=3D !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
-=09strbuf_release(&buf); /* no matter it was used or not */
-
-=09return ret;
-}
-
-#endif
\ No newline at end of file
diff --git a/gpg-interface.h b/gpg-interface.h
deleted file mode 100644
index c808d1685..000000000
--- a/gpg-interface.h
+++ /dev/null
@@ -1,70 +0,0 @@
-#ifndef GPG_INTERFACE_H
-#define GPG_INTERFACE_H
-
-#if 0
-struct strbuf;
-
-#define GPG_VERIFY_VERBOSE=09=091
-#define GPG_VERIFY_RAW=09=09=092
-#define GPG_VERIFY_OMIT_STATUS=094
-
-struct signature_check {
-=09char *payload;
-=09char *gpg_output;
-=09char *gpg_status;
-
-=09/*
-=09 * possible "result":
-=09 * 0 (not checked)
-=09 * N (checked but no further result)
-=09 * U (untrusted good)
-=09 * G (good)
-=09 * B (bad)
-=09 */
-=09char result;
-=09char *signer;
-=09char *key;
-=09char *fingerprint;
-=09char *primary_key_fingerprint;
-};
-
-void signature_check_clear(struct signature_check *sigc);
-
-/*
- * Look at GPG signed content (e.g. a signed tag object), whose
- * payload is followed by a detached signature on it.  Return the
- * offset where the embedded detached signature begins, or the end of
- * the data when there is no such signature.
- */
-size_t parse_signature(const char *buf, size_t size);
-
-/*
- * Create a detached signature for the contents of "buffer" and append
- * it after "signature"; "buffer" and "signature" can be the same
- * strbuf instance, which would cause the detached signature appended
- * at the end.
- */
-int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
-=09=09const char *signing_key);
-
-/*
- * Run "gpg" to see if the payload matches the detached signature.
- * gpg_output, when set, receives the diagnostic output from GPG.
- * gpg_status, when set, receives the status output from GPG.
- */
-int verify_signed_buffer(const char *payload, size_t payload_size,
-=09=09=09 const char *signature, size_t signature_size,
-=09=09=09 struct strbuf *gpg_output, struct strbuf *gpg_status);
-
-int git_gpg_config(const char *, const char *, void *);
-void set_signing_key(const char *);
-const char *get_signing_key(void);
-int check_signature(const char *payload, size_t plen,
-=09=09    const char *signature, size_t slen,
-=09=09    struct signature_check *sigc);
-void print_signature_buffer(const struct signature_check *sigc,
-=09=09=09    unsigned flags);
-
-#endif
-
-#endif
\ No newline at end of file
diff --git a/log-tree.c b/log-tree.c
index c13a7e06d..4d59d000c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -448,7 +448,7 @@ static void show_signature(struct rev_info *opt, struct=
 commit *commit)
 {
 =09struct strbuf payload =3D STRBUF_INIT;
 =09struct strbuf signature =3D STRBUF_INIT;
-=09struct strbuf gpg_output =3D STRBUF_INIT;
+=09struct strbuf sig_output =3D STRBUF_INIT;
 =09int status;
=20
 =09if (parse_signed_commit(commit, &payload, &signature) <=3D 0)
@@ -456,14 +456,14 @@ static void show_signature(struct rev_info *opt, stru=
ct commit *commit)
=20
 =09status =3D verify_signed_buffer(payload.buf, payload.len,
 =09=09=09=09      signature.buf, signature.len,
-=09=09=09=09      &gpg_output, NULL);
-=09if (status && !gpg_output.len)
-=09=09strbuf_addstr(&gpg_output, "No signature\n");
+=09=09=09=09      &sig_output, NULL);
+=09if (status && !sig_output.len)
+=09=09strbuf_addstr(&sig_output, "No signature\n");
=20
-=09show_sig_lines(opt, status, gpg_output.buf);
+=09show_sig_lines(opt, status, sig_output.buf);
=20
  out:
-=09strbuf_release(&gpg_output);
+=09strbuf_release(&sig_output);
 =09strbuf_release(&payload);
 =09strbuf_release(&signature);
 }
@@ -497,7 +497,7 @@ static int show_one_mergetag(struct commit *commit,
 =09struct tag *tag;
 =09struct strbuf verify_message;
 =09int status, nth;
-=09size_t payload_size, gpg_message_offset;
+=09size_t payload_size, sig_message_offset;
=20
 =09hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
 =09tag =3D lookup_tag(the_repository, &oid);
@@ -518,7 +518,7 @@ static int show_one_mergetag(struct commit *commit,
 =09else
 =09=09strbuf_addf(&verify_message,
 =09=09=09    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
-=09gpg_message_offset =3D verify_message.len;
+=09sig_message_offset =3D verify_message.len;
=20
 =09payload_size =3D parse_signature(extra->value, extra->len);
 =09status =3D -1;
@@ -529,7 +529,7 @@ static int show_one_mergetag(struct commit *commit,
 =09=09=09=09=09  extra->len - payload_size,
 =09=09=09=09=09  &verify_message, NULL))
 =09=09=09status =3D 0; /* good */
-=09=09else if (verify_message.len <=3D gpg_message_offset)
+=09=09else if (verify_message.len <=3D sig_message_offset)
 =09=09=09strbuf_addstr(&verify_message, "No signature\n");
 =09=09/* otherwise we couldn't verify, which is shown as bad */
 =09}
diff --git a/sequencer.c b/sequencer.c
index e3cfe40d2..95147ba82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -147,7 +147,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebas=
e-merge/refs-to-delete")
  * The following files are written by git-rebase just after parsing the
  * command-line.
  */
-static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt"=
)
+static GIT_PATH_FUNC(rebase_path_sign_opt, "rebase-merge/sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -193,8 +193,8 @@ static int git_sequencer_config(const char *k, const ch=
ar *v, void *cb)
 =09=09return status;
 =09}
=20
-=09if (!strcmp(k, "commit.gpgsign")) {
-=09=09opts->gpg_sign =3D git_config_bool(k, v) ? xstrdup("") : NULL;
+=09if (!strcmp(k, "commit.gpgsign") || !strcmp(k, "commit.sign")) {
+=09=09opts->sign =3D git_config_bool(k, v) ? xstrdup("") : NULL;
 =09=09return 0;
 =09}
=20
@@ -267,13 +267,13 @@ static int has_conforming_footer(struct strbuf *sb, s=
truct strbuf *sob,
 =09return 1;
 }
=20
-static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
+static const char *sign_opt_quoted(struct replay_opts *opts)
 {
 =09static struct strbuf buf =3D STRBUF_INIT;
=20
 =09strbuf_reset(&buf);
-=09if (opts->gpg_sign)
-=09=09sq_quotef(&buf, "-S%s", opts->gpg_sign);
+=09if (opts->sign)
+=09=09sq_quotef(&buf, "-S%s", opts->sign);
 =09return buf.buf;
 }
=20
@@ -297,7 +297,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 =09=09}
 =09}
=20
-=09free(opts->gpg_sign);
+=09free(opts->sign);
 =09free(opts->strategy);
 =09for (i =3D 0; i < opts->xopts_nr; i++)
 =09=09free(opts->xopts[i]);
@@ -980,7 +980,7 @@ static int run_git_commit(struct repository *r,
 =09=09else
 =09=09=09res =3D commit_tree(msg.buf, msg.len, cache_tree_oid,
 =09=09=09=09=09  NULL, &root_commit, author,
-=09=09=09=09=09  opts->gpg_sign);
+=09=09=09=09=09  opts->sign);
=20
 =09=09strbuf_release(&msg);
 =09=09strbuf_release(&script);
@@ -996,10 +996,10 @@ static int run_git_commit(struct repository *r,
 =09cmd.git_cmd =3D 1;
=20
 =09if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
-=09=09const char *gpg_opt =3D gpg_sign_opt_quoted(opts);
+=09=09const char *sig_opt =3D sign_opt_quoted(opts);
=20
 =09=09return error(_(staged_changes_advice),
-=09=09=09     gpg_opt, gpg_opt);
+=09=09=09     sig_opt, sig_opt);
 =09}
=20
 =09argv_array_push(&cmd.args, "commit");
@@ -1008,8 +1008,8 @@ static int run_git_commit(struct repository *r,
 =09=09argv_array_push(&cmd.args, "-n");
 =09if ((flags & AMEND_MSG))
 =09=09argv_array_push(&cmd.args, "--amend");
-=09if (opts->gpg_sign)
-=09=09argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+=09if (opts->sign)
+=09=09argv_array_pushf(&cmd.args, "-S%s", opts->sign);
 =09if (defmsg)
 =09=09argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 =09else if (!(flags & EDIT_MSG))
@@ -1390,7 +1390,7 @@ static int try_to_commit(struct repository *r,
 =09=09return -1;
=20
 =09if (flags & AMEND_MSG) {
-=09=09const char *exclude_gpgsig[] =3D { "gpgsig", NULL };
+=09=09const char *exclude_sig[] =3D { "gpgsig", NULL };
 =09=09const char *out_enc =3D get_commit_output_encoding();
 =09=09const char *message =3D logmsg_reencode(current_head, NULL,
 =09=09=09=09=09=09      out_enc);
@@ -1410,7 +1410,7 @@ static int try_to_commit(struct repository *r,
 =09=09=09goto out;
 =09=09}
 =09=09parents =3D copy_commit_list(current_head->parents);
-=09=09extra =3D read_commit_extra_headers(current_head, exclude_gpgsig);
+=09=09extra =3D read_commit_extra_headers(current_head, exclude_sig);
 =09} else if (current_head) {
 =09=09commit_list_insert(current_head, &parents);
 =09}
@@ -1459,7 +1459,7 @@ static int try_to_commit(struct repository *r,
 =09reset_ident_date();
=20
 =09if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
-=09=09=09=09 oid, author, opts->gpg_sign, extra)) {
+=09=09=09=09 oid, author, opts->sign, extra)) {
 =09=09res =3D error(_("failed to write commit object"));
 =09=09goto out;
 =09}
@@ -2445,7 +2445,7 @@ static int populate_opts_cb(const char *key, const ch=
ar *value, void *data)
 =09else if (!strcmp(key, "options.strategy"))
 =09=09git_config_string_dup(&opts->strategy, key, value);
 =09else if (!strcmp(key, "options.gpg-sign"))
-=09=09git_config_string_dup(&opts->gpg_sign, key, value);
+=09=09git_config_string_dup(&opts->sign, key, value);
 =09else if (!strcmp(key, "options.strategy-option")) {
 =09=09ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 =09=09opts->xopts[opts->xopts_nr++] =3D xstrdup(value);
@@ -2500,12 +2500,12 @@ static int read_populate_opts(struct replay_opts *o=
pts)
 =09if (is_rebase_i(opts)) {
 =09=09struct strbuf buf =3D STRBUF_INIT;
=20
-=09=09if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+=09=09if (read_oneliner(&buf, rebase_path_sign_opt(), 1)) {
 =09=09=09if (!starts_with(buf.buf, "-S"))
 =09=09=09=09strbuf_reset(&buf);
 =09=09=09else {
-=09=09=09=09free(opts->gpg_sign);
-=09=09=09=09opts->gpg_sign =3D xstrdup(buf.buf + 2);
+=09=09=09=09free(opts->sign);
+=09=09=09=09opts->sign =3D xstrdup(buf.buf + 2);
 =09=09=09}
 =09=09=09strbuf_reset(&buf);
 =09=09}
@@ -2607,8 +2607,8 @@ int write_basic_state(struct replay_opts *opts, const=
 char *head_name,
 =09else if (opts->allow_rerere_auto =3D=3D RERERE_NOAUTOUPDATE)
 =09=09write_file(rebase_path_allow_rerere_autoupdate(), "--no-rerere-autou=
pdate\n");
=20
-=09if (opts->gpg_sign)
-=09=09write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
+=09if (opts->sign)
+=09=09write_file(rebase_path_sign_opt(), "-S%s\n", opts->sign);
 =09if (opts->signoff)
 =09=09write_file(rebase_path_signoff(), "--signoff\n");
 =09if (opts->reschedule_failed_exec)
@@ -2864,9 +2864,9 @@ static int save_opts(struct replay_opts *opts)
 =09if (opts->strategy)
 =09=09res |=3D git_config_set_in_file_gently(opts_file,
 =09=09=09=09=09"options.strategy", opts->strategy);
-=09if (opts->gpg_sign)
+=09if (opts->sign)
 =09=09res |=3D git_config_set_in_file_gently(opts_file,
-=09=09=09=09=09"options.gpg-sign", opts->gpg_sign);
+=09=09=09=09=09"options.gpg-sign", opts->sign);
 =09if (opts->xopts) {
 =09=09int i;
 =09=09for (i =3D 0; i < opts->xopts_nr; i++)
@@ -2971,7 +2971,7 @@ static int error_with_patch(struct repository *r,
 =09=09=09  "Once you are satisfied with your changes, run\n"
 =09=09=09  "\n"
 =09=09=09  "  git rebase --continue\n"),
-=09=09=09gpg_sign_opt_quoted(opts));
+=09=09=09sign_opt_quoted(opts));
 =09} else if (exit_code) {
 =09=09if (commit)
 =09=09=09fprintf_ln(stderr, _("Could not apply %s... %.*s"),
@@ -3414,9 +3414,9 @@ static int do_merge(struct repository *r,
 =09=09struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
 =09=09if (read_env_script(&cmd.env_array)) {
-=09=09=09const char *gpg_opt =3D gpg_sign_opt_quoted(opts);
+=09=09=09const char *sig_opt =3D sign_opt_quoted(opts);
=20
-=09=09=09ret =3D error(_(staged_changes_advice), gpg_opt, gpg_opt);
+=09=09=09ret =3D error(_(staged_changes_advice), sig_opt, sig_opt);
 =09=09=09goto leave_merge;
 =09=09}
=20
@@ -3430,8 +3430,8 @@ static int do_merge(struct repository *r,
 =09=09argv_array_push(&cmd.args, "--no-stat");
 =09=09argv_array_push(&cmd.args, "-F");
 =09=09argv_array_push(&cmd.args, git_path_merge_msg(r));
-=09=09if (opts->gpg_sign)
-=09=09=09argv_array_push(&cmd.args, opts->gpg_sign);
+=09=09if (opts->sign)
+=09=09=09argv_array_push(&cmd.args, opts->sign);
=20
 =09=09/* Add the tips to be merged */
 =09=09for (j =3D to_merge; j; j =3D j->next)
diff --git a/sequencer.h b/sequencer.h
index 0c494b83d..353547d12 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -46,7 +46,7 @@ struct replay_opts {
=20
 =09int mainline;
=20
-=09char *gpg_sign;
+=09char *sign;
 =09enum commit_msg_cleanup_mode default_msg_cleanup;
 =09int explicit_cleanup;
=20
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signat=
ures.sh
index 3e9876e19..6dfe3f8c1 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -45,25 +45,25 @@ test_expect_success GPG 'create repositories with signe=
d commits' '
 test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_must_fail git pull --ff-only --verify-signatures unsigned 2>puller=
ror &&
-=09test_i18ngrep "does not have a GPG signature" pullerror
+=09test_i18ngrep "does not have a signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with bad signature with --verify-sign=
atures' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &=
&
-=09test_i18ngrep "has a bad GPG signature" pullerror
+=09test_i18ngrep "has a bad signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with untrusted signature with --verif=
y-signatures' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_must_fail git pull --ff-only --verify-signatures untrusted 2>pulle=
rror &&
-=09test_i18ngrep "has an untrusted GPG signature" pullerror
+=09test_i18ngrep "has an untrusted signature" pullerror
 '
=20
 test_expect_success GPG 'pull signed commit with --verify-signatures' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09git pull --verify-signatures signed >pulloutput &&
-=09test_i18ngrep "has a good GPG signature" pulloutput
+=09test_i18ngrep "has a good signature" pulloutput
 '
=20
 test_expect_success GPG 'pull commit with bad signature without verificati=
on' '
@@ -82,7 +82,7 @@ test_expect_success GPG 'pull unsigned commit into unborn=
 branch' '
 =09git init empty-repo &&
 =09test_must_fail \
 =09=09git -C empty-repo pull --verify-signatures ..  2>pullerror &&
-=09test_i18ngrep "does not have a GPG signature" pullerror
+=09test_i18ngrep "does not have a signature" pullerror
 '
=20
 test_done
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-sign=
atures.sh
index d99218a72..207c7ae2a 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -37,53 +37,53 @@ test_expect_success GPG 'create signed commits' '
 test_expect_success GPG 'merge unsigned commit with verification' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_must_fail git merge --ff-only --verify-signatures side-unsigned 2>=
mergeerror &&
-=09test_i18ngrep "does not have a GPG signature" mergeerror
+=09test_i18ngrep "does not have a signature" mergeerror
 '
=20
 test_expect_success GPG 'merge unsigned commit with merge.verifySignatures=
=3Dtrue' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_config merge.verifySignatures true &&
 =09test_must_fail git merge --ff-only side-unsigned 2>mergeerror &&
-=09test_i18ngrep "does not have a GPG signature" mergeerror
+=09test_i18ngrep "does not have a signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with bad signature with verification=
' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_must_fail git merge --ff-only --verify-signatures $(cat forged.com=
mit) 2>mergeerror &&
-=09test_i18ngrep "has a bad GPG signature" mergeerror
+=09test_i18ngrep "has a bad signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with bad signature with merge.verify=
Signatures=3Dtrue' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_config merge.verifySignatures true &&
 =09test_must_fail git merge --ff-only $(cat forged.commit) 2>mergeerror &&
-=09test_i18ngrep "has a bad GPG signature" mergeerror
+=09test_i18ngrep "has a bad signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with verifi=
cation' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_must_fail git merge --ff-only --verify-signatures side-untrusted 2=
>mergeerror &&
-=09test_i18ngrep "has an untrusted GPG signature" mergeerror
+=09test_i18ngrep "has an untrusted signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with merge.=
verifySignatures=3Dtrue' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_config merge.verifySignatures true &&
 =09test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
-=09test_i18ngrep "has an untrusted GPG signature" mergeerror
+=09test_i18ngrep "has an untrusted signature" mergeerror
 '
=20
 test_expect_success GPG 'merge signed commit with verification' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09git merge --verbose --ff-only --verify-signatures side-signed >mergeout=
put &&
-=09test_i18ngrep "has a good GPG signature" mergeoutput
+=09test_i18ngrep "has a good signature" mergeoutput
 '
=20
 test_expect_success GPG 'merge signed commit with merge.verifySignatures=
=3Dtrue' '
 =09test_when_finished "git reset --hard && git checkout initial" &&
 =09test_config merge.verifySignatures true &&
 =09git merge --verbose --ff-only side-signed >mergeoutput &&
-=09test_i18ngrep "has a good GPG signature" mergeoutput
+=09test_i18ngrep "has a good signature" mergeoutput
 '
=20
 test_expect_success GPG 'merge commit with bad signature without verificat=
ion' '
@@ -107,7 +107,7 @@ test_expect_success GPG 'merge unsigned commit into unb=
orn branch' '
 =09test_when_finished "git checkout initial" &&
 =09git checkout --orphan unborn &&
 =09test_must_fail git merge --verify-signatures side-unsigned 2>mergeerror=
 &&
-=09test_i18ngrep "does not have a GPG signature" mergeerror
+=09test_i18ngrep "does not have a signature" mergeerror
 '
=20
 test_done
diff --git a/tag.c b/tag.c
index d9bbf5249..6eb045fba 100644
--- a/tag.c
+++ b/tag.c
@@ -10,7 +10,7 @@
=20
 const char *tag_type =3D "tag";
=20
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned fl=
ags)
+static int run_sig_verify(const char *buf, unsigned long size, unsigned fl=
ags)
 {
 =09struct signature sigc;
 =09size_t payload_size;
@@ -36,7 +36,7 @@ static int run_gpg_verify(const char *buf, unsigned long =
size, unsigned flags)
 =09return ret;
 }
=20
-int gpg_verify_tag(const struct object_id *oid, const char *name_to_report=
,
+int sig_verify_tag(const struct object_id *oid, const char *name_to_report=
,
 =09=09unsigned flags)
 {
 =09enum object_type type;
@@ -59,7 +59,7 @@ int gpg_verify_tag(const struct object_id *oid, const cha=
r *name_to_report,
 =09=09=09=09name_to_report :
 =09=09=09=09find_unique_abbrev(oid, DEFAULT_ABBREV));
=20
-=09ret =3D run_gpg_verify(buf, size, flags);
+=09ret =3D run_sig_verify(buf, size, flags);
=20
 =09free(buf);
 =09return ret;
diff --git a/tag.h b/tag.h
index 03265fbfe..24f1e8538 100644
--- a/tag.h
+++ b/tag.h
@@ -17,7 +17,7 @@ int parse_tag(struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const char=
 *, int);
 struct object *deref_tag_noverify(struct object *);
-int gpg_verify_tag(const struct object_id *oid,
+int sig_verify_tag(const struct object_id *oid,
 =09=09   const char *name_to_report, unsigned flags);
=20
 #endif /* TAG_H */
--=20
2.11.0


