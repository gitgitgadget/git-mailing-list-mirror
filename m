Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213E8C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 18:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350630AbiA1Sfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiA1Sft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 13:35:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C7C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 10:35:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j23so11546156edp.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lhRNOggVQxTBX7cQO4N2ocUHMifFY9DJKp2EcFhYUyo=;
        b=pODJthEqaKtpFIHfGT0lT1jEK0KC7XjD9u/MOHEDhJhIAbNjr/pTCqX0bTb9cI9DvE
         9UvTWSmd3NrkGYFblgDLuhY4YyQW2odi8hgQi1bkd+eswXPFVpOBAM7pe04y2fsdix5S
         sfX7DTkOy/MDZYJ/hGSiupLzj2rKXVRoyvhNQ2BcJrBwIEZNftRbf2a8KXRhZt35vVFX
         WUJ4B9+0qlqPxk9dWQgiIvRBl8Y0QFK4sl/BHG/pIYkPSY+0K0YQ4yQxPsd9S4i/XtTG
         aO+9xwVB8CUUnDldAO8SkXVHnjnnNLlC6H8ohpDTWrxzaFUc4viVdsrIbGwms+k5U8xg
         eJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lhRNOggVQxTBX7cQO4N2ocUHMifFY9DJKp2EcFhYUyo=;
        b=57BbVdAujo5AGSWLxau6tqtWaJXK5m91/kCl/TU/Znok7IPiZBp+aDEpK2mTIVKhpn
         QYYg/gXpCq+sfbd9KeQcOgSmci2TPkk1ehybiA9Se1XhLP1uwo44ET229P/i8tgfCyJT
         pknWDzM6cTq3FSdBs/ROQ5k97Ry5ccSb5nV+yptmcuOXWmAqzSc77BKQaGHeQ8hUDeya
         rvb4tx9j8Q7qwu/ICP2PZQzyLAS01Vw5cpAzZ7CXpnFoWJv0cQN2Zvvd4CKrE3+bMYf1
         0ogMC/UE9dlYgDLA/gf35QP/wP1YhS3FLDprn31I3m/cL7xNJyWjum5Krx+u4Z7ynIXy
         FmFA==
X-Gm-Message-State: AOAM5332Tw8LD1qw+kwq9h05BbAs7E6wTBxmQkMGll34Eg9wzD6a4795
        Qxmgyz+U7ioxta25ZXJ2S94=
X-Google-Smtp-Source: ABdhPJzsogLueinu7/olAjn3TceA1L8CHVmSRK4PCgZffkgBLYNNZc0/jfDpAavZykL6UgUMpPESRQ==
X-Received: by 2002:a05:6402:1705:: with SMTP id y5mr9374968edu.200.1643394946643;
        Fri, 28 Jan 2022 10:35:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dc24sm10228070ejb.201.2022.01.28.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 10:35:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDW65-003jut-9B;
        Fri, 28 Jan 2022 19:35:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Date:   Fri, 28 Jan 2022 19:21:38 +0100
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
 <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
 <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
Message-ID: <220128.8635l7d7y6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Johannes Schindelin wrote:

> On Thu, 27 Jan 2022, Derrick Stolee wrote:
>
>> The biggest benefits of using handle_options() is for other pre-command
>> options such as --exec-path, which I use on a regular basis when testing
>> new functionality.
>>
>> There are other options in handle_options() that might not be
>> appropriate, or might be incorrect if we just make handle_options()
>> non-static. For example, `scalar --list-cmds=parseopt` wouldn't show the
>> scalar commands and would instead show the git commands.
>
> Right, and since `handle_options()` lives in the same file as `git`'s
> `cmd_main()` function, we would not only have to disentangle options that
> work only for `git` from those that would also work for `scalar`, but we
> would have to extract the `handle_options()` function into a separate
> file.
>
> And while at it, a tangent someone with infinite time on their hands might
> suggest is: why not convert `handle_options()` to the `parse_options()`
> machinery? Which would of course solve one issue by adding several new
> ones. Don't get me wrong: I would find it useful to convert
> `git.c:handle_options()` to a function in `libgit.a` which uses the
> `parse_options()` machinery. It'll just require a lot of time, and I do
> not see enough benefit that would make it worth embarking on that
> particular journey.
>
> But since I had a look at `handle_options()` anyway, I might just as well
> summarize my insights about how applicable the supported options are for
> `scalar` here:
> [...]
> # Detrimental
>
>   --exec-path
>
> 	Since `scalar` is tightly coupled to a specific Git version, it
> 	would cause much more harm than benefit to encourage users to use
> 	a different Git version by offering them this option.

So just to clarify, do you and Stolee disagree about scalar supporting
--exec-path, per his comments above?

>
>   --list-cmds
>
> 	As you pointed out, this option would produce misleading output.
>
> Given that only the `-c` and `-C` options are _actually_ useful in the
> context of the `scalar` command, I would argue that I chose the best
> approach, as the benefit of the intrusive refactorings that would be
> necessary to share code with `git.c` is rather small compared with the
> amount of work.
>
>> So my feeling is that we should continue to delay this functionality
>> until Scalar is more stable, perhaps even until after it moves out of
>> contrib/. The need to change handle_options() to work with a new
>> top-level command is novel enough to be worth careful scrutiny, but that
>> effort is only valuable if the Git community is more committed to having
>> Scalar in the tree for the long term.
>
> I am okay with holding off with this, for now.
>
> On the other hand, as I pointed out above: I do not really see it worth
> the effort to refactor `git.c:handle_options()` for the minimal benefit it
> would give us over the approach I chose in the patch under discussion.

I'm fine with just integrating this patch as-is, I just wanted to chime
in upthread with a question/context about a thing stated in previous
discussion/a link to that discussion.

It does seem to me that you're making a mountain out of a molehill
here. The below quick hack is a lib-ification of -c, -C and --config-env
that took me around 10 minutes. For ease of reading I squashed it into
your patch.

I mean, we're just talking about copy/pasting existing working code to a
new header file, giving it a function parameter, and other small bits of
scaffolding.

One thing we'll be doing by doing that is not wasting the time of
(checks $(ls -l po/*.po|wc -l) ...) around 20 translator on 2 new
strings you introduced, and if you view it with the move detection you
can see it's almost entirely just moving existing code around.

In this case I don't mind much, but speaking generally I see you and
Stolee tying yourselves in knots again about scalar being in contrib so
we shouldn't use libgit.

It already uses libgit, there's even (last I checked) at least one
function in it only used directly by the scalar code.

I don't remember anyone having any objection to scalar using libgit
code, or even that there's libgit code just to help it along. That's a
self-imposed limitation you two seem to have invented.

Personally I find a patch like the below much easier to review. It's the
parts that aren't easy to review boilerplate are all things that we have
in-tree already.

Whereas proposing a new way to parse -c or -C will lead (at least me) to
carefully eyeballing that new implementation, looking at how it differs
(if at all) from the existing one, wondering why the i18n strings are
subtly different etc (I saw one reason is that since the code was
copy/pasted initially the git.c version was updated, but your patch
wasn't updated to copy it).

diff --git a/Makefile b/Makefile
index 5580859afdb..2d0a6611cd5 100644
--- a/Makefile
+++ b/Makefile
@@ -900,6 +900,7 @@ LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += gettext.o
+LIB_OBJS += gitcmd.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..ee793ff6ccc 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
+#include "gitcmd.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -808,17 +809,33 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf scalar_usage = STRBUF_INIT;
 	int i;
 
-	if (argc > 1) {
 	argv++;
 	argc--;
 
+	while (argc > 1 && *argv[0] == '-') {
+		int show_usage = 0;
+
+		if (gity_handle_options(&argv, &argc, NULL, &show_usage)) {
+			(argv)++;
+			(argc)--;
+
+			if (show_usage)
+				goto usage;
+		} else {
+			break;
+		}
+	}
+
+	if (argc) {
 		for (i = 0; builtins[i].name; i++)
 			if (!strcmp(builtins[i].name, argv[0]))
 				return !!builtins[i].fn(argc, argv);
 	}
 
+usage:
 	strbuf_addstr(&scalar_usage,
-		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+		      N_("scalar [-C <directory>] [-c <key>=<value>] "
+			 "<command> [<options>]\n\nCommands:\n"));
 	for (i = 0; builtins[i].name; i++)
 		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);

diff --git a/Makefile b/Makefile
index 5580859afdb..2d0a6611cd5 100644
--- a/Makefile
+++ b/Makefile
@@ -900,6 +900,7 @@ LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += gettext.o
+LIB_OBJS += gitcmd.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..ee793ff6ccc 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
+#include "gitcmd.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -808,17 +809,33 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf scalar_usage = STRBUF_INIT;
 	int i;
 
-	if (argc > 1) {
 	argv++;
 	argc--;
 
+	while (argc > 1 && *argv[0] == '-') {
+		int show_usage = 0;
+
+		if (gity_handle_options(&argv, &argc, NULL, &show_usage)) {
+			(argv)++;
+			(argc)--;
+
+			if (show_usage)
+				goto usage;
+		} else {
+			break;
+		}
+	}
+
+	if (argc) {
 		for (i = 0; builtins[i].name; i++)
 			if (!strcmp(builtins[i].name, argv[0]))
 				return !!builtins[i].fn(argc, argv);
 	}
 
+usage:
 	strbuf_addstr(&scalar_usage,
-		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+		      N_("scalar [-C <directory>] [-c <key>=<value>] "
+			 "<command> [<options>]\n\nCommands:\n"));
 	for (i = 0; builtins[i].name; i++)
 		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f416d637289..cf4e5b889cc 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -36,6 +36,16 @@ The `scalar` command implements various subcommands, and different options
 depending on the subcommand. With the exception of `clone`, `list` and
 `reconfigure --all`, all subcommands expect to be run in an enlistment.
 
+The following options can be specified _before_ the subcommand:
+
+-C <directory>::
+	Before running the subcommand, change the working directory. This
+	option imitates the same option of linkgit:git[1].
+
+-c <key>=<value>::
+	For the duration of running the specified subcommand, configure this
+	setting. This option imitates the same option of linkgit:git[1].
+
 COMMANDS
 --------
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 2e1502ad45e..89781568f43 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -85,4 +85,12 @@ test_expect_success 'scalar delete with enlistment' '
 	test_path_is_missing cloned
 '
 
+test_expect_success 'scalar supports -c/-C' '
+	test_when_finished "scalar delete sub" &&
+	git init sub &&
+	scalar -C sub -c status.aheadBehind=bogus register &&
+	test -z "$(git -C sub config --local status.aheadBehind)" &&
+	test true = "$(git -C sub config core.preloadIndex)"
+'
+
 test_done
diff --git a/git.c b/git.c
index edda922ce6d..dc75b3f0294 100644
--- a/git.c
+++ b/git.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "alias.h"
 #include "shallow.h"
+#include "gitcmd.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
@@ -138,6 +139,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
+		int show_usage = 0;
 		if (cmd[0] != '-')
 			break;
 
@@ -247,22 +249,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
-		} else if (!strcmp(cmd, "-c")) {
-			if (*argc < 2) {
-				fprintf(stderr, _("-c expects a configuration string\n" ));
-				usage(git_usage_string);
-			}
-			git_config_push_parameter((*argv)[1]);
-			(*argv)++;
-			(*argc)--;
-		} else if (!strcmp(cmd, "--config-env")) {
-			if (*argc < 2) {
-				fprintf(stderr, _("no config key given for --config-env\n" ));
-				usage(git_usage_string);
-			}
-			git_config_push_env((*argv)[1]);
-			(*argv)++;
-			(*argc)--;
 		} else if (skip_prefix(cmd, "--config-env=", &cmd)) {
 			git_config_push_env(cmd);
 		} else if (!strcmp(cmd, "--literal-pathspecs")) {
@@ -295,19 +281,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
 			if (envchanged)
 				*envchanged = 1;
-		} else if (!strcmp(cmd, "-C")) {
-			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for '%s' option\n" ), "-C");
-				usage(git_usage_string);
-			}
-			if ((*argv)[1][0]) {
-				if (chdir((*argv)[1]))
-					die_errno("cannot change to '%s'", (*argv)[1]);
-				if (envchanged)
-					*envchanged = 1;
-			}
-			(*argv)++;
-			(*argc)--;
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
 			trace2_cmd_name("_query_");
 			if (!strcmp(cmd, "parseopt")) {
@@ -322,6 +295,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			} else {
 				exit(list_cmds(cmd));
 			}
+		} else if (gity_handle_options(argv, argc, envchanged,
+					       &show_usage)) {
+			if (show_usage)
+				usage(git_usage_string);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/gitcmd.c b/gitcmd.c
new file mode 100644
index 00000000000..0d8630ec2a4
--- /dev/null
+++ b/gitcmd.c
@@ -0,0 +1,47 @@
+#include "cache.h"
+#include "gitcmd.h"
+#include "config.h"
+
+int gity_handle_options(const char ***argv, int *argc,
+			int *envchanged, int *show_usage)
+{
+	const char *cmd = (*argv)[0];
+
+	if (!strcmp(cmd, "-c")) {
+		if (*argc < 2) {
+			fprintf(stderr, _("-c expects a configuration string\n" ));
+			goto usage;
+		}
+		git_config_push_parameter((*argv)[1]);
+		(*argv)++;
+		(*argc)--;
+	} else if (!strcmp(cmd, "--config-env")) {
+		if (*argc < 2) {
+			fprintf(stderr, _("no config key given for --config-env\n" ));
+			goto usage;
+		}
+		git_config_push_env((*argv)[1]);
+		(*argv)++;
+		(*argc)--;
+	} else if (!strcmp(cmd, "-C")) {
+		if (*argc < 2) {
+			fprintf(stderr, _("no directory given for '%s' option\n" ), "-C");
+			goto usage;
+		}
+		if ((*argv)[1][0]) {
+			if (chdir((*argv)[1]))
+				die_errno("cannot change to '%s'", (*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
+		}
+		(*argv)++;
+		(*argc)--;
+	} else {
+		return 0;
+	}
+	return 1;
+usage:
+	*show_usage = 1;
+	return 1;
+}
+
diff --git a/gitcmd.h b/gitcmd.h
new file mode 100644
index 00000000000..95c934b1500
--- /dev/null
+++ b/gitcmd.h
@@ -0,0 +1,11 @@
+#ifndef GITCMD_H
+#define GITCMD_H
+
+/**
+ * Handle options like in a "git"-y way, i.e. to emulate a command
+ * that works like "git" itself. This is the part of handle_options()
+ * that contrib/scalar needs from git.c.
+ */
+int gity_handle_options(const char ***argv, int *argc, int *envchanged,
+			int *show_usage);
+#endif
