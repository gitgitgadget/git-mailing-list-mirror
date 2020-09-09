Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10EC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 21:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDADC21D6C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 21:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EV4b+ipr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIVFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:05:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56146 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIVFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 17:05:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 940C28BB2F;
        Wed,  9 Sep 2020 17:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FP6JTzzSO7IydlFMobTwAEoUbnk=; b=EV4b+i
        pr9dnM2ySQVj3n83L8/IPmJRu7sxskI1pdEhCvcVgLxRlF+hkWG1UTjetCNCdZsd
        DCiCaxF4qMudqtfV+era09l/eZMAOc33QWCLOiKYeXkWMJ2ABWLny71T7wSk0bml
        Ix+MyVuBKRpB1MWrWTJ/7XsRezumyGqIgIA5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k+cmPa3jsJwfc4SzuvCr2yTwgIIyRStL
        C/fayPUqlZ/aaYiyQYpKMc2ObNtx5s2bf2L13nrpjQRItgD7JFpwLPDMeg94Wybo
        /rtW7sS9qZgzU5gW25HnuLcKlbB3J3tVNW21QEXATpRGGMW19tctJ6LBXIJ6XRK7
        0SL8G7+SF4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AE778BB2E;
        Wed,  9 Sep 2020 17:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 147B88BB2D;
        Wed,  9 Sep 2020 17:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6?= =?utf-8?Q?r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/9] propose config-based hooks
References: <20200909004939.1942347-1-emilyshaffer@google.com>
Date:   Wed, 09 Sep 2020 14:04:55 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 8 Sep 2020 17:49:30 -0700")
Message-ID: <xmqqeenau0eg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CFAB604-F2E0-11EA-87FB-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v3, the biggest change is the conversion of commit hooks to use the new
> hook machinery. The first change ("commit: use config-based hooks") is the
> important part; the second change ("run_commit_hook: take strvec instead of varargs")
> is probably subjective, but I thought it was a decent tech debt reduction.
>
> I wanted to send this reroll quickly since I had promised it in standup last
> week, but I've got pretty good progress locally on the patch for configuring
> "hook.runHookDir"; I'm planning to send that soon, probably this week.

I've had the attached merge-fix patch as a way to adjust argv_array
to strvec transition [*1*], but now *most* but not all parts of this
series have been migrated to the strvec API, you should apply some
parts in the merge-fix patch to your copy.  I think the changes in
the old "merge-fix" patch to *.c and *.h are already in your series
that has been rebased on a newer 'master' that has strvec, but
documentation and possibly in-code comments may need to be adjusted.

Another way to sanity check the result would be to run this:

    $ git diff master..es/config-hooks | grep -i argv.array

Thanks.  

[Footnote]

*1* The way I work with a topic that causes conflicts with other
    topics is to merge a new version of topic and letting the rerere
    records I created while resolving the conflicts with the
    previous round.  After textual conflicts are thusly resolved, if
    there are further changes that do not cause textual conflict
    that are necessary, they are written in the form of a
    "merge-fix" patch like the attached.

-- >8 --

 Documentation/technical/api-parse-options.txt  |  4 ++--
 Documentation/technical/config-based-hooks.txt |  4 ++--
 builtin/hook.c                                 | 16 ++++++++--------
 hook.c                                         |  6 +++---
 hook.h                                         |  4 ++--
 parse-options-cb.c                             |  8 ++++----
 parse-options.h                                |  6 +++---
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index b4f1fc4a1a..679bd98629 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -173,9 +173,9 @@ There are some macros to easily define options:
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
 
-`OPT_ARGV_ARRAY(short, long, &struct argv_array, arg_str, description)`::
+`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
 	Introduce an option with a string argument.
-	The string argument is stored as an element in `argv_array`.
+	The string argument is stored as an element in `strvec`.
 	Use of `--no-option` will clear the list of preceding values.
 
 `OPT_INTEGER(short, long, &int_var, description)`::
diff --git a/Documentation/technical/config-based-hooks.txt b/Documentation/technical/config-based-hooks.txt
index c6e762b192..4443f70ded 100644
--- a/Documentation/technical/config-based-hooks.txt
+++ b/Documentation/technical/config-based-hooks.txt
@@ -106,10 +106,10 @@ a concise config afterwards. It may take a form similar to `git rebase
 `hook.c` and `hook.h` are responsible for interacting with the config files. In
 the case when the code generating a hook event doesn't have special concerns
 about how to run the hooks, the hook library will provide a basic API to call
-all hooks in config order with an `argv_array` provided by the code which
+all hooks in config order with an `strvec` provided by the code which
 generates the hook event:
 
-*`int run_hooks(const char *hookname, struct argv_array *args)`*
+*`int run_hooks(const char *hookname, struct strvec *args)`*
 
 This call includes the hook command provided by `run-command.h:find_hook()`;
 eventually, this legacy hook will be gated by a config `hook.runHookDir`. The
diff --git a/builtin/hook.c b/builtin/hook.c
index cd61fad5fb..debcb5a77a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -5,7 +5,7 @@
 #include "hook.h"
 #include "parse-options.h"
 #include "strbuf.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 static const char * const builtin_hook_usage[] = {
 	N_("git hook list <hookname>"),
@@ -67,14 +67,14 @@ static int list(int argc, const char **argv, const char *prefix)
 static int run(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf hookname = STRBUF_INIT;
-	struct argv_array env_argv = ARGV_ARRAY_INIT;
-	struct argv_array arg_argv = ARGV_ARRAY_INIT;
+	struct strvec env_argv = STRVEC_INIT;
+	struct strvec arg_argv = STRVEC_INIT;
 
 	struct option run_options[] = {
-		OPT_ARGV_ARRAY('e', "env", &env_argv, N_("var"),
-			       N_("environment variables for hook to use")),
-		OPT_ARGV_ARRAY('a', "arg", &arg_argv, N_("args"),
-			       N_("argument to pass to hook")),
+		OPT_STRVEC('e', "env", &env_argv, N_("var"),
+			   N_("environment variables for hook to use")),
+		OPT_STRVEC('a', "arg", &arg_argv, N_("args"),
+			   N_("argument to pass to hook")),
 		OPT_END(),
 	};
 
@@ -87,7 +87,7 @@ static int run(int argc, const char **argv, const char *prefix)
 
 	strbuf_addstr(&hookname, argv[0]);
 
-	return run_hooks(env_argv.argv, &hookname, &arg_argv);
+	return run_hooks(env_argv.v, &hookname, &arg_argv);
 }
 
 int cmd_hook(int argc, const char **argv, const char *prefix)
diff --git a/hook.c b/hook.c
index 902e213173..40d319adb1 100644
--- a/hook.c
+++ b/hook.c
@@ -98,7 +98,7 @@ struct list_head* hook_list(const struct strbuf* hookname)
 }
 
 int run_hooks(const char *const *env, const struct strbuf *hookname,
-	      const struct argv_array *args)
+	      const struct strvec *args)
 {
 	struct list_head *to_run, *pos = NULL, *tmp = NULL;
 	int rc = 0;
@@ -110,14 +110,14 @@ int run_hooks(const char *const *env, const struct strbuf *hookname,
 		struct hook *hook = list_entry(pos, struct hook, list);
 
 		/* add command */
-		argv_array_push(&hook_proc.args, hook->command.buf);
+		strvec_push(&hook_proc.args, hook->command.buf);
 
 		/*
 		 * add passed-in argv, without expanding - let the user get back
 		 * exactly what they put in
 		 */
 		if (args)
-			argv_array_pushv(&hook_proc.args, args->argv);
+			strvec_pushv(&hook_proc.args, args->v);
 
 		hook_proc.env = env;
 		hook_proc.no_stdin = 1;
diff --git a/hook.h b/hook.h
index cf598d6ccb..d020788a6b 100644
--- a/hook.h
+++ b/hook.h
@@ -1,7 +1,7 @@
 #include "config.h"
 #include "list.h"
 #include "strbuf.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 struct hook
 {
@@ -12,7 +12,7 @@ struct hook
 
 struct list_head* hook_list(const struct strbuf *hookname);
 int run_hooks(const char *const *env, const struct strbuf *hookname,
-	      const struct argv_array *args);
+	      const struct strvec *args);
 
 void free_hook(struct hook *ptr);
 void clear_hook_list(void);
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4f993cd734..d2b8b7b98a 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -205,19 +205,19 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int parse_opt_argv_array(const struct option *opt, const char *arg, int unset)
+int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
 {
-	struct argv_array *v = opt->value;
+	struct strvec *v = opt->value;
 
 	if (unset) {
-		argv_array_clear(v);
+		strvec_clear(v);
 		return 0;
 	}
 
 	if (!arg)
 		return -1;
 
-	argv_array_push(v, arg);
+	strvec_push(v, arg);
 	return 0;
 }
 
diff --git a/parse-options.h b/parse-options.h
index e2e2de75c8..177259488b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,9 +177,9 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-#define OPT_ARGV_ARRAY(s, l, v, a, h) \
+#define OPT_STRVEC(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
-				      (h), 0, &parse_opt_argv_array }
+				      (h), 0, &parse_opt_strvec }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
@@ -299,7 +299,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
-int parse_opt_argv_array(const struct option *, const char *, int);
+int parse_opt_strvec(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
-- 
2.28.0-558-g7a0184fd7b

