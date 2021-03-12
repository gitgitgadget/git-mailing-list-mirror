Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C1C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C4264F87
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCLIUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhCLIUI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 03:20:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0CC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:20:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w18so6715594edc.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Aij1OK7yOPxf66eRExXNiijlOOpd2joj+LvzJZq4liU=;
        b=SdOUfSrMcxJwXnfdS09Ec2QnMujkkMexO6dPKep3qPOSnMZVSnWSDypY4s8ykPOfYZ
         8Z1IZmhg/VBUkBrt/evk96W+UbPTU8+l4qIJWZXe15s4o3hEL7+zswm2c6CJHNND3JaE
         Z3DiI5WmGA4RT61Qzb6WMK30sLM1h1C/WwFC+en6u2qd+BZYSpUumWZ11WhFMsJicc8J
         cbM+WHjfjAhMJjHLPi0unWYivSGN0nxH9qBE73jfyabQYsDL5+roBvqGu71E26nkREqv
         HxLbmuz78H/DjH5B6fJnkB2S4EqURJYujIyJzFY8uc9oHw3jG+LBYP65ADHj8B1SaLvX
         V77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Aij1OK7yOPxf66eRExXNiijlOOpd2joj+LvzJZq4liU=;
        b=B6QJEjIW6Q31lfSnJ3VJUYMyBv1kiWX7iNFEEVxMxDs4CIWyXdV2xl+9KfNw3J77Yp
         bwyfQNTDD/JHRPXzxVUEBRI9L/PPmlo72Qz2Y9STLJWIo1pcT+qJGwVqeUlXlgTtnAxr
         YcobYXQ/PUnQAz23/ERwKBbvkqSYN8N2HwjZqVc4rftSZTom2U2HCwx/7U336EDB/pzm
         pfDtph5OSIY81GQ+dy/wP5Nq+ZIUxSIgUTtnlOh44cj/KH8m4Oz3cYjCTFnzbdm38zMN
         dWm9dt3S8dBLb4yYD47i391t2b5zrGO2XZng7uQxK4KaRu2ESLJrDfDZdslqxoWW7bSG
         rYpQ==
X-Gm-Message-State: AOAM530+WUJb4AuAMTB3r2UvKc/u6lsv7ZZ1fmb777BxJP+1lt48+Y9d
        yEg1mqKZoyfVKARVLKDfNbKZNnHBg3vaDQ==
X-Google-Smtp-Source: ABdhPJzs3xm6laijIY6UQLYWMYDI7M19v4rQ/f0veKTDgyQnq84bMctYIgSfgZO4UNmmyKDNc8tRNw==
X-Received: by 2002:a05:6402:1350:: with SMTP id y16mr12735591edw.309.1615537206382;
        Fri, 12 Mar 2021 00:20:06 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l10sm2499126edr.87.2021.03.12.00.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:20:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 03/37] hook: add list command
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-4-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-4-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 09:20:05 +0100
Message-ID: <87o8fohjgq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> new file mode 100644
> index 0000000000..71449ecbc7
> --- /dev/null
> +++ b/Documentation/config/hook.txt
> @@ -0,0 +1,9 @@
> +hook.<command>.command::
> +	A command to execute during the <command> hook event. This can be an
> +	executable on your device, a oneliner for your shell, or the name of a
> +	hookcmd. See linkgit:git-hook[1].
> +
> +hookcmd.<name>.command::
> +	A command to execute during a hook for which <name> has been specified
> +	as a command. This can be an executable on your device or a oneliner for
> +	your shell. See linkgit:git-hook[1].
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index 9eeab0009d..f19875ed68 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,12 +8,65 @@ git-hook - Manage configured hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook'
> +'git hook' list <hook-name>

Having just read this far (maybe this pattern is shared in the rest of
the series): Let's just squash this and the 2nd patch together.

Sometimes it's worth doing the scaffolding first, but adding a new
built-in is so trivial that I don't think it's worth it, and it just
results in back & forth churn like the above...

>  DESCRIPTION
>  -----------
> -A placeholder command. Later, you will be able to list, add, and modify hooks
> -with this command.

...and this...

> +You can list configured hooks with this command. Later, you will be able to run,
> +add, and modify hooks with this command.
> +
> +This command parses the default configuration files for sections `hook` and
> +`hookcmd`. `hook` is used to describe the commands which will be run during a
> +particular hook event; commands are run in the order Git encounters them during
> +the configuration parse (see linkgit:git-config[1]). `hookcmd` is used to
> +describe attributes of a specific command. If additional attributes don't need
> +to be specified, a command to run can be specified directly in the `hook`
> +section; if a `hookcmd` by that name isn't found, Git will attempt to run the
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
> +
> +With these configs, you'd then see:
> +
> +----
> +$ git hook list "post-commit"
> +global: /bin/linter --c
> +global: ~/typocheck.sh
> +local: python ~/run-test-suite.py
> +
> +$ git hook list "prepare-commit-msg"
> +local: /bin/linter --c
> +----
> +
> +COMMANDS
> +--------
> +
> +list `<hook-name>`::
> +
> +List the hooks which have been configured for `<hook-name>`. Hooks appear
> +in the order they should be run, and print the config scope where the relevant
> +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
> +This output is human-readable and the format is subject to change over time.
> +
> +CONFIGURATION
> +-------------
> +include::config/hook.txt[]
>  
>  GIT
>  ---
> diff --git a/Makefile b/Makefile
> index 8e904a1ab5..3fa51597d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -891,6 +891,7 @@ LIB_OBJS += hash-lookup.o
>  LIB_OBJS += hashmap.o
>  LIB_OBJS += help.o
>  LIB_OBJS += hex.o
> +LIB_OBJS += hook.o
>  LIB_OBJS += ident.o
>  LIB_OBJS += json-writer.o
>  LIB_OBJS += kwset.o
> diff --git a/builtin/hook.c b/builtin/hook.c
> index b2bbc84d4d..bb64cd77ca 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -1,21 +1,67 @@
>  #include "cache.h"
> -

Stray back & forth whitespace churn?

>  #include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
>  
>  static const char * const builtin_hook_usage[] = {
> -	N_("git hook"),
> +	N_("git hook list <hookname>"),
>  	NULL
>  };
>  
> -int cmd_hook(int argc, const char **argv, const char *prefix)
> +static int list(int argc, const char **argv, const char *prefix)

...and here the cmd_hook() function being replaced (not really, just
moved below, but you get my drift...)

>  {
> -	struct option builtin_hook_options[] = {
> +	struct list_head *head, *pos;
> +	struct strbuf hookname = STRBUF_INIT;
> +
> +	struct option list_options[] = {
>  		OPT_END(),
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, builtin_hook_options,
> +	argc = parse_options(argc, argv, prefix, list_options,
>  			     builtin_hook_usage, 0);
>  
> +	if (argc < 1) {
> +		usage_msg_opt(_("You must specify a hook event name to list."),
> +			      builtin_hook_usage, list_options);
> +	}
> +
> +	strbuf_addstr(&hookname, argv[0]);
> +
> +	head = hook_list(&hookname);
> +

More on strbuf usage later in another soon-to-be-sent E-Mail.

> +	if (list_empty(head)) {
> +		printf(_("no commands configured for hook '%s'\n"),
> +		       hookname.buf);
> +		strbuf_release(&hookname);
> +		return 0;
> +	}
> +
> +	list_for_each(pos, head) {
> +		struct hook *item = list_entry(pos, struct hook, list);
> +		if (item)
> +			printf("%s: %s\n",
> +			       config_scope_name(item->origin),
> +			       item->command.buf);
> +	}
> +
> +	clear_hook_list(head);
> +	strbuf_release(&hookname);
> +
>  	return 0;
>  }
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
> index 0000000000..fede40e925
> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,120 @@
> +#include "cache.h"
> +
> +#include "hook.h"
> +#include "config.h"
> +
> +void free_hook(struct hook *ptr)
> +{
> +	if (ptr) {
> +		strbuf_release(&ptr->command);
> +		free(ptr);
> +	}
> +}

Neither strbuf_release() nor free() need or should have a "if (ptr)" guard.

> +
> +static void append_or_move_hook(struct list_head *head, const char *command)
> +{
> +	struct list_head *pos = NULL, *tmp = NULL;
> +	struct hook *to_add = NULL;
> +
> +	/*
> +	 * remove the prior entry with this command; we'll replace it at the
> +	 * end.
> +	 */
> +	list_for_each_safe(pos, tmp, head) {
> +		struct hook *it = list_entry(pos, struct hook, list);
> +		if (!strcmp(it->command.buf, command)) {
> +		    list_del(pos);
> +		    /* we'll simply move the hook to the end */
> +		    to_add = it;
> +		    break;
> +		}
> +	}
> +
> +	if (!to_add) {
> +		/* adding a new hook, not moving an old one */
> +		to_add = xmalloc(sizeof(*to_add));
> +		strbuf_init(&to_add->command, 0);
> +		strbuf_addstr(&to_add->command, command);
> +	}
> +
> +	/* re-set the scope so we show where an override was specified */
> +	to_add->origin = current_config_scope();
> +
> +	list_add_tail(&to_add->list, head);
> +}
> +
> +static void remove_hook(struct list_head *to_remove)
> +{
> +	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
> +	list_del(to_remove);
> +	free_hook(hook_to_remove);
> +}
> +
> +void clear_hook_list(struct list_head *head)
> +{
> +	struct list_head *pos, *tmp;
> +	list_for_each_safe(pos, tmp, head)
> +		remove_hook(pos);
> +}
> +
> +struct hook_config_cb
> +{
> +	struct strbuf *hookname;
> +	struct list_head *list;
> +};
> +
> +static int hook_config_lookup(const char *key, const char *value, void *cb_data)
> +{
> +	struct hook_config_cb *data = cb_data;
> +	const char *hook_key = data->hookname->buf;
> +	struct list_head *head = data->list;
> +
> +	if (!strcmp(key, hook_key)) {
> +		const char *command = value;
> +		struct strbuf hookcmd_name = STRBUF_INIT;
> +
> +		/*
> +		 * Check if a hookcmd with that name exists. If it doesn't,
> +		 * 'git_config_get_value()' is documented not to touch &command,
> +		 * so we don't need to do anything.
> +		 */
> +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
> +		git_config_get_value(hookcmd_name.buf, &command);
> +
> +		if (!command) {
> +			strbuf_release(&hookcmd_name);
> +			BUG("git_config_get_value overwrote a string it shouldn't have");
> +		}
> +
> +		/*
> +		 * TODO: implement an option-getting callback, e.g.
> +		 *   get configs by pattern hookcmd.$value.*
> +		 *   for each key+value, do_callback(key, value, cb_data)
> +		 */
> +
> +		append_or_move_hook(head, command);
> +
> +		strbuf_release(&hookcmd_name);
> +	}
> +
> +	return 0;
> +}
> +
> +struct list_head* hook_list(const struct strbuf* hookname)
> +{
> +	struct strbuf hook_key = STRBUF_INIT;
> +	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> +	struct hook_config_cb cb_data = { &hook_key, hook_head };
> +
> +	INIT_LIST_HEAD(hook_head);
> +
> +	if (!hookname)
> +		return NULL;

...if a strbuf being passed in is NULL?

> [...]
> +ROOT=
> +if test_have_prereq MINGW
> +then
> +	# In Git for Windows, Unix-like paths work only in shell scripts;
> +	# `git.exe`, however, will prefix them with the pseudo root directory
> +	# (of the Unix shell). Let's accommodate for that.
> +	ROOT="$(cd / && pwd)"
> +fi

I didn't read up on previous rounds, but if we're squashing this into 02
having a seperate commit summarizing this little hack would be most
welcome, or have it in this commit message.

Isn't this sort of thing generally usable, maybe we can add it under a
longer variable name to test-lib.sh?
