Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA1AC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BEA22273
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjqGd628"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgIKNng (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgIKN2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 09:28:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E9C061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:27:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so11490277wrx.7
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vd2BKUYLqnV4ROPk5QYa0SSW68SArgKUPTrh2yHOLG0=;
        b=FjqGd6286/1GppydIzOjnwCyvlpwgDGoluXaQmC29CWo+Vmuuh0YCxAOuvOOcY9LPZ
         5kpGwEBwSa+TNDOQ5tI26C7gFzoZp8BT/KKrum8O+ol8umrGNm+SFe7SqxLd7f0ukeGt
         mqMJixnn3xOWxT0hgRBtMVuvMOmq1hUuAEHHz40tAVT2Ddbl6qKCMZXgN85CmL1ajtLR
         q4OcWcXE4QoCoC1iPtco4jfUKsLhcfY3NNeoM6qtT0t/nbZii4FVuiYf9sTYhDi7tW/Y
         vl6oWyiVb/jp/ncAZRYgWhvXOXAero6f+6YBHNxyhGF1QYob0Uom0tNbF9/w1rN0Oplr
         OTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vd2BKUYLqnV4ROPk5QYa0SSW68SArgKUPTrh2yHOLG0=;
        b=BBz4xdALRRFd8w5Xs1FBBm8L0ZyxrnkW9/eVm+91RN828jiPbD9h6gnlk6tjsFSeqG
         qNJG8cecHM/4OL9eIy+jQVp8YDaDeUrLtVqS+GuW2w3mrmI8T1mdlUd+5tNkfafbjghM
         k/wMZOiYmMd2IwUSDL9G1JyjTkyXMRS9tAITn7JzqoThSLUoBhxK1m1YoREerF4jzI46
         5V7jihAtXsM059CBvCSoyVKCIulZG8DuMSaHxGHh1VBBUVXz8PZHrBuYiymCbbH71Yms
         1uVQiPDrLX4LUYOaRXmMwFduWk5VKwwyeaCA2Bmkz4tJzLnx17Dc2w/wcJNn5XdwaNfK
         EgFQ==
X-Gm-Message-State: AOAM533Rl2Bd6uzUyklEQXgx5M0tgKR350j3fp/2VSikIusEQdY/ylsi
        7LyhsdZLwK02Obo3nPCUXhlJxvn66Gw=
X-Google-Smtp-Source: ABdhPJy/Is6PFe7gwyiVjjzFsL+y+Qu6AFMqfEVPBSCCGDG1wntHF7eF6Hco7Fw90vLBzee7OBzm0A==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr2142365wrn.5.1599830863560;
        Fri, 11 Sep 2020 06:27:43 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id 11sm4529053wmi.14.2020.09.11.06.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:27:43 -0700 (PDT)
Subject: Re: [PATCH v4 3/9] hook: add list command
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-4-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9146d342-7b3c-091f-4904-e7d8696544be@gmail.com>
Date:   Fri, 11 Sep 2020 14:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909004939.1942347-4-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 09/09/2020 01:49, Emily Shaffer wrote:
> Teach 'git hook list <hookname>', which checks the known configs in
> order to create an ordered list of hooks to run on a given hook event.
> 
> Multiple commands can be specified for a given hook by providing
> multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
> run in config order. If more properties need to be set on a given hook
> in the future, commands can also be specified by providing
> "hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
> <hookcmd-name>]" subsection; at minimum, this subsection must contain a
> "hookcmd.<hookcmd-name>.command = <path-to-hook>" line.
> 
> For example:
> 
>    $ git config --list | grep ^hook
>    hook.pre-commit.command=baz
>    hook.pre-commit.command=~/bar.sh
>    hookcmd.baz.command=~/baz/from/hookcmd.sh
> 
>    $ git hook list pre-commit
>    ~/baz/from/hookcmd.sh
>    ~/bar.sh
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   Documentation/git-hook.txt    |  37 +++++++++++-
>   Makefile                      |   1 +
>   builtin/hook.c                |  55 ++++++++++++++++--
>   hook.c                        | 102 ++++++++++++++++++++++++++++++++++
>   hook.h                        |  15 +++++
>   t/t1360-config-based-hooks.sh |  68 ++++++++++++++++++++++-
>   6 files changed, 271 insertions(+), 7 deletions(-)
>   create mode 100644 hook.c
>   create mode 100644 hook.h
> 
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index 2d50c414cc..e458586e96 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,12 +8,47 @@ git-hook - Manage configured hooks
>   SYNOPSIS
>   --------
>   [verse]
> -'git hook'
> +'git hook' list <hook-name>
>   
>   DESCRIPTION
>   -----------
>   You can list, add, and modify hooks with this command.
>   
> +This command parses the default configuration files for sections "hook" and
> +"hookcmd". "hook" is used to describe the commands which will be run during a
> +particular hook event; commands are run in config order. "hookcmd" is used to
> +describe attributes of a specific command. If additional attributes don't need
> +to be specified, a command to run can be specified directly in the "hook"
> +section; if a "hookcmd" by that name isn't found, Git will attempt to run the
> +provided value directly. For example:
> +
> +Global config
> +----
> +  [hook "post-commit"]
> +    command = "linter"
> +    command = "~/typocheck.sh"
> +
> +  [hookcmd "linter"]
> +    command = "/bin/linter --c"
> +----
> +
> +Local config
> +----
> +  [hook "prepare-commit-msg"]
> +    command = "linter"
> +  [hook "post-commit"]
> +    command = "python ~/run-test-suite.py"
> +----

I think it would be helpful to have a couple of lines explaining what 
the example configuration sets up

> +COMMANDS
> +--------
> +
> +list <hook-name>::
> +
> +List the hooks which have been configured for <hook-name>. Hooks appear
> +in the order they should be run, and note the config scope where the relevant
> +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).

Thanks for clarifying that it is the origin of the 
hook.<hook-name>.command that is printed. An example of the output of 
the config above would be useful I think.

>   GIT
>   ---
>   Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 6eee75555e..804de45b16 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -890,6 +890,7 @@ LIB_OBJS += grep.o
>   LIB_OBJS += hashmap.o
>   LIB_OBJS += help.o
>   LIB_OBJS += hex.o
> +LIB_OBJS += hook.o
>   LIB_OBJS += ident.o
>   LIB_OBJS += interdiff.o
>   LIB_OBJS += json-writer.o
> diff --git a/builtin/hook.c b/builtin/hook.c
> index b2bbc84d4d..a0759a4c26 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -1,21 +1,68 @@
>   #include "cache.h"
>   
>   #include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
>   #include "parse-options.h"
> +#include "strbuf.h"
>   
>   static const char * const builtin_hook_usage[] = {
> -	N_("git hook"),
> +	N_("git hook list <hookname>"),
>   	NULL
>   };
>   
> -int cmd_hook(int argc, const char **argv, const char *prefix)
> +static int list(int argc, const char **argv, const char *prefix)
>   {
> -	struct option builtin_hook_options[] = {
> +	struct list_head *head, *pos;
> +	struct hook *item;
> +	struct strbuf hookname = STRBUF_INIT;
> +
> +	struct option list_options[] = {
>   		OPT_END(),
>   	};
>   
> -	argc = parse_options(argc, argv, prefix, builtin_hook_options,
> +	argc = parse_options(argc, argv, prefix, list_options,
>   			     builtin_hook_usage, 0);
>   
> +	if (argc < 1) {
> +		usage_msg_opt("a hookname must be provided to operate on.",
> +			      builtin_hook_usage, list_options);
> +	}
> +
> +	strbuf_addstr(&hookname, argv[0]);
> +
> +	head = hook_list(&hookname);
> +
> +	if (list_empty(head)) {
> +		printf(_("no commands configured for hook '%s'\n"),
> +		       hookname.buf);
> +		return 0;
> +	}
> +
> +	list_for_each(pos, head) {
> +		item = list_entry(pos, struct hook, list);
> +		if (item)
> +			printf("%s:\t%s\n",
> +			       config_scope_name(item->origin),
> +			       item->command.buf);
> +	}
> +
> +	clear_hook_list();
> +	strbuf_release(&hookname);
> +
>   	return 0;
>   }
> +
> +int cmd_hook(int argc, const char **argv, const char *prefix)
> +{
> +	struct option builtin_hook_options[] = {
> +		OPT_END(),
> +	};
> +	if (argc < 2)
> +		usage_with_options(builtin_hook_usage, builtin_hook_options);
> +
> +	if (!strcmp(argv[1], "list"))
> +		return list(argc - 1, argv + 1, prefix);
> +
> +	usage_with_options(builtin_hook_usage, builtin_hook_options);
> +}
> diff --git a/hook.c b/hook.c
> new file mode 100644
> index 0000000000..b006950eb8
> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,102 @@
> +#include "cache.h"
> +
> +#include "hook.h"
> +#include "config.h"
> +
> +/*
> + * NEEDSWORK: a stateful hook_head means we can't run two hook events in the
> + * background at the same time - which might be ok, or might not.
> + *
> + * Maybe it's better to cache a list head per hookname, since we can probably
> + * guess that the hook list won't change during a user-initiated operation. For
> + * now, within list_hooks, call clear_hook_list() at the outset.
> + */
> +static LIST_HEAD(hook_head);

I can see a cache might be useful for the sequencer which needs to run 
the prepare-msg hook for each commit (it should probably not be running 
the post-commit hook but does at the moment) and for am which runs some 
hooks for each patch but until then I'm not sure why we need a global 
variable here, can't we just declare `hook_head` in `list_hook()`?

> +void free_hook(struct hook *ptr)
> +{
> +	if (ptr) {
> +		strbuf_release(&ptr->command);
> +		free(ptr);
> +	}
> +}
> +
> +static void emplace_hook(struct list_head *pos, const char *command)
> +{
> +	struct hook *to_add = malloc(sizeof(struct hook));
> +	to_add->origin = current_config_scope();
> +	strbuf_init(&to_add->command, 0);
> +	/* even with use_shell, run_command() needs quotes */
> +	strbuf_addf(&to_add->command, "'%s'", command);
> +
> +	list_add_tail(&to_add->list, pos);
> +}
> +
> +static void remove_hook(struct list_head *to_remove)
> +{
> +	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
> +	list_del(to_remove);
> +	free_hook(hook_to_remove);
> +}
> +
> +void clear_hook_list(void)
> +{
> +	struct list_head *pos, *tmp;
> +	list_for_each_safe(pos, tmp, &hook_head)
> +		remove_hook(pos);
> +}
> +
> +static int hook_config_lookup(const char *key, const char *value, void *hook_key_cb)
> +{
> +	const char *hook_key = hook_key_cb;
> +
> +	if (!strcmp(key, hook_key)) {
> +		const char *command = value;
> +		struct strbuf hookcmd_name = STRBUF_INIT;
> +		struct list_head *pos = NULL, *tmp = NULL;
> +
> +		/* Check if a hookcmd with that name exists. */
> +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
> +		git_config_get_value(hookcmd_name.buf, &command);
> +
> +		if (!command)
> +			BUG("git_config_get_value overwrote a string it shouldn't have");
> +
> +		/*
> +		 * TODO: implement an option-getting callback, e.g.
> +		 *   get configs by pattern hookcmd.$value.*
> +		 *   for each key+value, do_callback(key, value, cb_data)
> +		 */
> +
> +		list_for_each_safe(pos, tmp, &hook_head) {
> +			struct hook *hook = list_entry(pos, struct hook, list);
> +			/*
> +			 * The list of hooks to run can be reordered by being redeclared
> +			 * in the config. Options about hook ordering should be checked
> +			 * here.
> +			 */
> +			if (0 == strcmp(hook->command.buf, command))

We normally write this as !strcmp(...)

> +				remove_hook(pos);
> +		}
> +		emplace_hook(pos, command);
> +	}
> +
> +	return 0;
> +}
> +
> +struct list_head* hook_list(const struct strbuf* hookname)
> +{
> +	struct strbuf hook_key = STRBUF_INIT;
> +
> +	if (!hookname)
> +		return NULL;
> +
> +	/* hook_head is stateful */
> +	clear_hook_list();
> +
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
> +
> +	git_config(hook_config_lookup, (void*)hook_key.buf);
> +
> +	return &hook_head;
> +}
> diff --git a/hook.h b/hook.h
> new file mode 100644
> index 0000000000..aaf6511cff
> --- /dev/null
> +++ b/hook.h
> @@ -0,0 +1,15 @@
> +#include "config.h"
> +#include "list.h"
> +#include "strbuf.h"
> +
> +struct hook
> +{
> +	struct list_head list;
> +	enum config_scope origin;
> +	struct strbuf command;
> +};
> +
> +struct list_head* hook_list(const struct strbuf *hookname);
> +
> +void free_hook(struct hook *ptr);
> +void clear_hook_list(void);
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> index 34b0df5216..46d1ed354a 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -4,8 +4,72 @@ test_description='config-managed multihooks, including git-hook command'
>   
>   . ./test-lib.sh
>   
> -test_expect_success 'git hook command does not crash' '
> -	git hook
> +ROOT=
> +if test_have_prereq MINGW
> +then
> +	# In Git for Windows, Unix-like paths work only in shell scripts;
> +	# `git.exe`, however, will prefix them with the pseudo root directory
> +	# (of the Unix shell). Let's accommodate for that.
> +	ROOT="$(cd / && pwd)"
> +fi
> +
> +setup_hooks () {
> +	test_config hook.pre-commit.command "/path/ghi" --add
> +	test_config_global hook.pre-commit.command "/path/def" --add
> +}
> +
> +setup_hookcmd () {
> +	test_config hook.pre-commit.command "abc" --add
> +	test_config_global hookcmd.abc.command "/path/abc" --add
> +}
> +
> +test_expect_success 'git hook rejects commands without a mode' '
> +	test_must_fail git hook pre-commit
> +'

Thanks for changing the tests to be independent of each other

Best Wishes

Phillip

> +
> +test_expect_success 'git hook rejects commands without a hookname' '
> +	test_must_fail git hook list
> +'
> +
> +test_expect_success 'git hook list orders by config order' '
> +	setup_hooks &&
> +
> +	cat >expected <<-EOF &&
> +	global:	$ROOT/path/def
> +	local:	$ROOT/path/ghi
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list dereferences a hookcmd' '
> +	setup_hooks &&
> +	setup_hookcmd &&
> +
> +	cat >expected <<-EOF &&
> +	global:	$ROOT/path/def
> +	local:	$ROOT/path/ghi
> +	local:	$ROOT/path/abc
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git hook list reorders on duplicate commands' '
> +	setup_hooks &&
> +
> +	test_config hook.pre-commit.command "/path/def" --add &&
> +
> +	cat >expected <<-EOF &&
> +	local:	$ROOT/path/ghi
> +	local:	$ROOT/path/def
> +	EOF
> +
> +	git hook list pre-commit >actual &&
> +	test_cmp expected actual
>   '
>   
>   test_done
> 

