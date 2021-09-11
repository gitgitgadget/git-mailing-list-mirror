Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DF1C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2BB610A3
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhIKTLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhIKTLl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26231C061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so7056306wra.8
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fa3Uuc3rjYfQ798EIUlQeMJ2OrD2g3TpZE7dkwfKdaI=;
        b=nm+zfV/N/xMDodxzbSNCYtNuezd607UKN5RU01F5tneij5S8qWyr0bhV1YeXsPatEI
         PBtJ6WvhGipI+gQZygfAxJRKVZoKzvFeVH7T1E19i7tSCfWTJrVN9E7cTmYC+ADlhpaY
         n8TdOZx2/yJRA8rt+sg3JUq6vMou6Hhezu7R+4rXATbF+HQdyG5GKoA2k7Fm3d/PE7DQ
         1CDq+cFnwESPwAVIesOF53Xw8iTYSvYGflceN9BNbnrmZiMfzo8wwCjVYyOdNB/9idiG
         GDBbdaIVpRh2bwmRTUu2VnXEWfFkntAtuhfKZ3llTRcnefnlkLEB6t9ejww2qWk23+EE
         EvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fa3Uuc3rjYfQ798EIUlQeMJ2OrD2g3TpZE7dkwfKdaI=;
        b=uJDjDHmo/6C7ijrom2K2kKGMvKWOM3AaEdTDFzK0BSwqadp1CSOzRirCH6yEvkI8t6
         A4YnwcgB/XYn6+IIMNQOukJq9dEMQICfm5LEPNCSKop0EiR8C/RfsqrTFJHCDnTJanD4
         hsylji/4Q5S3IpXp6Dwjh/6pUW46g5sE1jcfQ+DDkjq9dh4xncdvspsCp1Xo/V563ZjK
         bvqhZ9JABCtZMzMj2L57LwonGNUI0MW8smJ4KzsNyt+U0SBR/8s2U+PwU6W+hRrOtdvM
         GHMq8VM7KBL00aEPnrvNzgIdVd8Mm2aE0X9TAhvx094rAPE1zYyHJW6939VLhSd2Urf8
         ruaA==
X-Gm-Message-State: AOAM531Yh47s3dveaHvf5tV9koj1pJyeRD5oYS4wZa+82aoiufc57ca1
        SlvxYTQ9U4NWYIb4PwxvojT+xCfNWKYrqg==
X-Google-Smtp-Source: ABdhPJzGvUMk9AVdNUEruW/xaOuqpLAT3Z6ydPg4FJK0SMUi4Ub8erS2LeKQRBhTKwExi6/msLKFaQ==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr2150692wri.55.1631387426074;
        Sat, 11 Sep 2021 12:10:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] parse-options: properly align continued usage output & related
Date:   Sat, 11 Sep 2021 21:08:59 +0200
Message-Id: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes usage_with_options_internal() in parse-options.c
to properly align continued "\n" usage output.

I think this v3 will address the feedback on v2. I'm not confident the
direction will be agreed with, but let's see.

I've taken Carlo Marcelo Arenas Belón's suggestion of just not
building the credential-cache built-ins under NO_UNIX_SOCKETS, which
I'm much happier with as a solution than my v2, I just thought Junio
would veto it, but it seems he likes the direction.

The removal of the undocumented API from "git blame" is now its own
commit, which I think does a good job of justifying itself.

Then the justification in "parse-options: stop supporting" is updated
& much improved, i.e. I've had my eye on migrating git.c to
parse_options(), which wants to make use of this sort of API, but
can't because of the limitations of the API being removed here. I
think per the justification in that commit it makes sense to remove
this here, and just add something like it back later.

Ævar Arnfjörð Bjarmason (6):
  credential-cache{,--daemon}: don't build under NO_UNIX_SOCKETS
  blame: replace usage end blurb with better option spec
  parse-options: stop supporting "" in the usagestr array
  built-ins: "properly" align continued usage output
  send-pack: properly use parse_options() API for usage string
  parse-options: properly align continued usage output

 Documentation/git-send-pack.txt    |  4 +-
 Makefile                           |  3 ++
 builtin.h                          |  2 +
 builtin/blame.c                    |  9 ++--
 builtin/credential-cache--daemon.c | 21 ---------
 builtin/credential-cache.c         | 21 ---------
 builtin/ls-remote.c                |  4 +-
 builtin/rev-parse.c                |  3 ++
 builtin/send-pack.c                |  8 ++--
 builtin/show-branch.c              |  6 +--
 builtin/stash.c                    |  2 +-
 builtin/tag.c                      |  4 +-
 git.c                              |  2 +
 parse-options.c                    | 71 +++++++++++++++++++++++++-----
 t/helper/test-parse-options.c      |  2 -
 t/t0040-parse-options.sh           |  2 -
 t/t1502-rev-parse-parseopt.sh      | 34 +++++++-------
 17 files changed, 104 insertions(+), 94 deletions(-)

Range-diff against v2:
1:  9e8facb6f8c < -:  ----------- test-lib.sh: add a UNIX_SOCKETS prerequisite
2:  d6c44402715 ! 1:  ad857e80fd8 git.c: add a NEED_UNIX_SOCKETS option for built-ins
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git.c: add a NEED_UNIX_SOCKETS option for built-ins
    +    credential-cache{,--daemon}: don't build under NO_UNIX_SOCKETS
     
         Change the implementation of b5dd96b70ac (make credential helpers
    -    builtins, 2020-08-13) to declare in the "struct cmd_struct" that
    -    NO_UNIX_SOCKETS can't be set.
    +    builtins, 2020-08-13) to not build these at all under
    +    NO_UNIX_SOCKETS.
     
    -    This is one of two in-tree users for the empty lines in
    -    parse_options() usage, getting rid of that is the main motivation for
    -    this, but it also doesn't make sense to emit these sorts of usage
    -    messages just to appease t0012-help.sh, which seemingly b5dd96b70ac
    -    aimed to do.
    +    This is the easiest way to get rid of one out of two users of an
    +    obscure parse_options() API I'm trying to get rid of. It does mean
    +    that the goal of emitting a custom error message in b5dd96b70ac is
    +    being eliminated, but per [1] that seems to be an OK direction to go
    +    in.
     
    -    I.e. these commands don't support "[options]", or "<action>" so
    -    emitting that at the beginning is incorrect. We should just die right
    -    away.
    +    By not compiling it at all it won't be included in the "struct
    +    cmd_struct", and therefore will also be omitted from
    +    "--list-cmds=builtins".
     
    -    The existing code also had the edge case of not emitting the die()
    -    message if a "-h" argument was given, since parse_options() will
    -    handle the exit() itself in that case. We could feed it
    -    PARSE_OPT_NO_INTERNAL_HELP, but this is better.
    -
    -    By moving this up to the "struct cmd_struct" we can also skip these in
    -    --list-cmds=builtins instead, as noted above we shouldn't be exiting
    -    with code 129 in these cases.
    +    1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Makefile ##
    +@@ Makefile: BUILTIN_OBJS += builtin/commit-tree.o
    + BUILTIN_OBJS += builtin/commit.o
    + BUILTIN_OBJS += builtin/config.o
    + BUILTIN_OBJS += builtin/count-objects.o
    ++ifndef NO_UNIX_SOCKETS
    + BUILTIN_OBJS += builtin/credential-cache--daemon.o
    + BUILTIN_OBJS += builtin/credential-cache.o
    ++endif
    + BUILTIN_OBJS += builtin/credential-store.o
    + BUILTIN_OBJS += builtin/credential.o
    + BUILTIN_OBJS += builtin/describe.o
    +@@ Makefile: ifdef NO_INET_PTON
    + endif
    + ifdef NO_UNIX_SOCKETS
    + 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
    ++	EXCLUDED_PROGRAMS += git-credential-cache git-credential-cache--daemon
    + else
    + 	LIB_OBJS += unix-socket.o
    + 	LIB_OBJS += unix-stream-server.o
    +
      ## builtin.h ##
    -@@
    -  *	more informed decision, e.g., by ignoring `pager.<cmd>` for
    -  *	certain subcommands.
    -  *
    -+ * `NEED_UNIX_SOCKETS`:
    -+ *
    -+ *	This built-in will not work if NO_UNIX_SOCKETS is defined. It
    -+ *	will be recognized for emitting error messages, but won't be
    -+ *	listed in --list-cmds=builtins.
    -+ *
    -  * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
    -  *
    -  * Additionally, if `foo` is a new command, there are 4 more things to do:
    +@@ builtin.h: int cmd_commit_tree(int argc, const char **argv, const char *prefix);
    + int cmd_config(int argc, const char **argv, const char *prefix);
    + int cmd_count_objects(int argc, const char **argv, const char *prefix);
    + int cmd_credential(int argc, const char **argv, const char *prefix);
    ++#ifndef NO_UNIX_SOCKETS
    + int cmd_credential_cache(int argc, const char **argv, const char *prefix);
    + int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
    ++#endif
    + int cmd_credential_store(int argc, const char **argv, const char *prefix);
    + int cmd_describe(int argc, const char **argv, const char *prefix);
    + int cmd_diff_files(int argc, const char **argv, const char *prefix);
     
      ## builtin/credential-cache--daemon.c ##
    +@@
    + #include "builtin.h"
    + #include "parse-options.h"
    +-
    +-#ifndef NO_UNIX_SOCKETS
    +-
    + #include "config.h"
    + #include "tempfile.h"
    + #include "credential.h"
     @@ builtin/credential-cache--daemon.c: int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
      
    - int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
    - {
    + 	return 0;
    + }
    +-
    +-#else
    +-
    +-int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
    +-{
     -	const char * const usage[] = {
     -		"git credential-cache--daemon [options] <action>",
     -		"",
    @@ builtin/credential-cache--daemon.c: int cmd_credential_cache_daemon(int argc, co
     -
     -	argc = parse_options(argc, argv, prefix, options, usage, 0);
     -	die(_("credential-cache--daemon unavailable; no unix socket support"));
    -+	BUG("should not be called under NO_UNIX_SOCKETS");
    - }
    - 
    - #endif /* NO_UNIX_SOCKET */
    +-}
    +-
    +-#endif /* NO_UNIX_SOCKET */
     
      ## builtin/credential-cache.c ##
    +@@
    + #include "builtin.h"
    + #include "parse-options.h"
    +-
    +-#ifndef NO_UNIX_SOCKETS
    +-
    + #include "credential.h"
    + #include "string-list.h"
    + #include "unix-socket.h"
     @@ builtin/credential-cache.c: int cmd_credential_cache(int argc, const char **argv, const char *prefix)
      
    - int cmd_credential_cache(int argc, const char **argv, const char *prefix)
    - {
    + 	return 0;
    + }
    +-
    +-#else
    +-
    +-int cmd_credential_cache(int argc, const char **argv, const char *prefix)
    +-{
     -	const char * const usage[] = {
     -		"git credential-cache [options] <action>",
     -		"",
    @@ builtin/credential-cache.c: int cmd_credential_cache(int argc, const char **argv
     -
     -	argc = parse_options(argc, argv, prefix, options, usage, 0);
     -	die(_("credential-cache unavailable; no unix socket support"));
    -+	BUG("should not be called under NO_UNIX_SOCKETS");
    - }
    - 
    - #endif /* NO_UNIX_SOCKETS */
    +-}
    +-
    +-#endif /* NO_UNIX_SOCKETS */
     
      ## git.c ##
    -@@
    - #define SUPPORT_SUPER_PREFIX	(1<<4)
    - #define DELAY_PAGER_CONFIG	(1<<5)
    - #define NO_PARSEOPT		(1<<6) /* parse-options is not used */
    -+#define NEED_UNIX_SOCKETS	(1<<7) /* Works unless -DNO_UNIX_SOCKETS */
    - 
    - struct cmd_struct {
    - 	const char *cmd;
    -@@ git.c: static int list_cmds(const char *spec)
    - 	struct string_list list = STRING_LIST_INIT_DUP;
    - 	int i;
    - 	int nongit;
    -+	unsigned int exclude_option = 0;
    -+#ifdef NO_UNIX_SOCKETS
    -+	exclude_option |= NEED_UNIX_SOCKETS;
    -+#endif
    - 
    - 	/*
    - 	* Set up the repository so we can pick up any repo-level config (like
    -@@ git.c: static int list_cmds(const char *spec)
    - 		int len = sep - spec;
    - 
    - 		if (match_token(spec, len, "builtins"))
    --			list_builtins(&list, 0);
    -+			list_builtins(&list, exclude_option);
    - 		else if (match_token(spec, len, "main"))
    - 			list_all_main_cmds(&list);
    - 		else if (match_token(spec, len, "others"))
    -@@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
    - 	const char *prefix;
    - 
    - 	prefix = NULL;
    -+#ifdef NO_UNIX_SOCKETS
    -+	if (p->option & NEED_UNIX_SOCKETS)
    -+		die(_("%s is unavailable; there is no UNIX socket support in this build of Git"), p->cmd);
    -+#endif
    - 	help = argc == 2 && !strcmp(argv[1], "-h");
    - 	if (!help) {
    - 		if (p->option & RUN_SETUP)
     @@ git.c: static struct cmd_struct commands[] = {
      	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
      	{ "count-objects", cmd_count_objects, RUN_SETUP },
      	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
    --	{ "credential-cache", cmd_credential_cache },
    --	{ "credential-cache--daemon", cmd_credential_cache_daemon },
    -+	{ "credential-cache", cmd_credential_cache, NEED_UNIX_SOCKETS },
    -+	{ "credential-cache--daemon", cmd_credential_cache_daemon, NEED_UNIX_SOCKETS },
    ++#ifndef NO_UNIX_SOCKETS
    + 	{ "credential-cache", cmd_credential_cache },
    + 	{ "credential-cache--daemon", cmd_credential_cache_daemon },
    ++#endif
      	{ "credential-store", cmd_credential_store },
      	{ "describe", cmd_describe, RUN_SETUP },
      	{ "diff", cmd_diff, NO_PARSEOPT },
    -
    - ## t/t0012-help.sh ##
    -@@ t/t0012-help.sh: do
    - 	'
    - done <builtins
    - 
    -+test_expect_success UNIX_SOCKETS 'builtin list includes NEED_UNIX_SOCKETS under UNIX_SOCKETS' '
    -+	grep ^credential-cache$ builtins &&
    -+	grep ^credential-cache--daemon$ builtins
    -+'
    -+
    -+test_expect_success !UNIX_SOCKETS 'builtin list excludes NEED_UNIX_SOCKETS under !UNIX_SOCKETS' '
    -+	! grep ^credential-cache$ builtins &&
    -+	! grep ^credential-cache--daemon$ builtins
    -+'
    -+
    - test_done
-:  ----------- > 2:  036eb0efb5b blame: replace usage end blurb with better option spec
3:  11f4a119563 ! 3:  e23a8231f38 parse-options: stop supporting "" in the usagestr array
    @@ Commit message
         encountered a "" we'll emit all strings after that point verbatim
         without any "or: " prefixing.
     
    -    This gets rid of that special case, which was added in
    -    f389c808b67 (Rework make_usage to print the usage message immediately,
    -    2007-10-14). It was only used "blame" (the "credential-cache*" use of
    -    it was removed in the preceding commit). Before this change we'd emit:
    +    In the preceding commits we got rid of the two users of this
    +    undocumented part of the API. Let's remove it in preparation for
    +    improving the output emitted by usage_with_options_internal().
     
    -        $ git blame -h
    -        usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>
    +    I think we might want to use this in the future, but in that case
    +    we'll be much better off with an API that emulates the
    +    non-parse_options() way that git.c does this.
     
    -            <rev-opts> are documented in git-rev-list(1)
    +    That git.c code uses a separate "git_usage_string" and
    +    "git_more_info_string". See b7d9681974e (Print info about "git help
    +    COMMAND" on git's main usage pages, 2008-06-06). By splitting the two
    +    up we can emit something in the middle, as indeed git.c does.
     
    -    This changes that output to simply use "[<git-rev-list args>]" instead
    -    of "[<rev-opts>]". This accomplishes the same, is more consistent as
    -    "git bundle" and "git blame" use the same way of referring to these
    -    options now.
    +    I'd like our "git <cmd> -h" info to be more helpful, and I'd also like
    +    parse_options() to handle the "git" command itself, because of the
    +    limitations of how this was done in usage_with_options_internal() we
    +    couldn't migrate a caller like git.c to parse_options().
     
    -    The use of this in "blame" dated back to 5817da01434 (git-blame:
    -    migrate to incremental parse-option [1/2], 2008-07-08), and the use in
    -    "bundle" to 2e0afafebd8 (Add git-bundle: move objects and
    -    references by archive, 2007-02-22).
    -
    -    Once we get rid of this special case we can also use usage_msg_opt()
    -    to emit the error message we'd get on an invalid "-L <range>"
    -    argument, which means we can get rid of the old-style "blame_usage"
    -    variable.
    +    So let's just remove this for now, it has no users, and once we want
    +    to do this again we can simply add another argument to the relevant
    +    functions, or otherwise hook into things so that we can print
    +    something at the end and/or middle.
     
         It's possible that this change introduce breakage somewhere. We'd only
         catch these cases at runtime, and the "git rev-parse --parseopt"
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/blame.c ##
    -@@
    - #include "refs.h"
    - #include "tag.h"
    - 
    --static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
    --
    - static const char *blame_opt_usage[] = {
    --	blame_usage,
    --	"",
    --	N_("<rev-opts> are documented in git-rev-list(1)"),
    -+	N_("git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>"),
    - 	NULL
    - };
    - 
    -@@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
    - 				    nth_line_cb, &sb, lno, anchor,
    - 				    &bottom, &top, sb.path,
    - 				    the_repository->index))
    --			usage(blame_usage);
    -+			usage_msg_opt(_("Invalid -L <range> parameters"),
    -+				      blame_opt_usage, options);
    - 		if ((!lno && (top || bottom)) || lno < bottom)
    - 			die(Q_("file %s has only %lu line",
    - 			       "file %s has only %lu lines",
    -
      ## builtin/rev-parse.c ##
     @@ builtin/rev-parse.c: static int cmd_parseopt(int argc, const char **argv, const char *prefix)
      	for (;;) {
4:  4547cc968b1 = 4:  5638d2bc832 built-ins: "properly" align continued usage output
5:  b884b361ace = 5:  821e5e14132 send-pack: properly use parse_options() API for usage string
6:  e83d66da6d4 = 6:  0df2840ce4e parse-options: properly align continued usage output
-- 
2.33.0.995.ga5ea46173a2

