Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B536C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 10:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6842077B
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 10:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjrKVlVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfLLK7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:59:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40911 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfLLK7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 05:59:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so2224483wrn.7
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FiS0VxDChxX9GXDyM67EBF3aSjoPYbe8zD6+4sI2R6E=;
        b=DjrKVlVjZnqf6AvWzG5ptVlRPHVq1numO2+RMbVHgT6+MBMArGNuwi0iNSJGcP9K82
         yEyq4n043nw1kAgKWUH66lQs1akO4tCCdJsyvFt+maJGLmeE97begtm8D8H/fGZ4Y5Vt
         7qQPmA+f5DAMmS6ndY8U9FxCF+nyRFaumvfMxpd6gBi80g0eHrVHZIAOvxt17dStVpHu
         v3xAn0AibJk28fsssoNiJp1V3T9cOcslLkf1qKBdapyHj1a0m19FQ/5ss2X/DEfYc28o
         g6QOeM29BzQeLWEa4r+gvclSThZ81hjMANCcazpCAfMam+d78+d9XZsEiALdvdUeEIBy
         UZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FiS0VxDChxX9GXDyM67EBF3aSjoPYbe8zD6+4sI2R6E=;
        b=pselAPywfjg+1UYssnQy94DsA+X0hljEVhbyoEtvARhXbE6p7HdfRqcJ7mPlkya2Z2
         JQZI5g73/liKXkZyaUwttCGOSYTU0ZkwAHWZ28i7wsIL+I4RWPhYuwNvQ8QlFNoLHZSA
         iDkNTJJ50uMuwI+P8VNOrXuJhEVkSj7WkpuwdaPn0W7A8EjU1zsYHEbZbgP/QwYjMlC2
         zwg7U9i+FJ6twe8/BqzI1N6zTn/AgJd+4eLFiztxkVn67wbRvdAeoZmFXyNdoowYcuGv
         bG12vM6896DNyN6fTu0X9XKSKtdyndcWTT8T06jOLilTJh6sNaVDruXDKEmCH7oCL2m6
         24KQ==
X-Gm-Message-State: APjAAAVSIFRhbh4r6Zz+NsHgs/p8MEtQl5fP5K9XhPy+3iLnQBF3c/sQ
        noPIfHRkQyJFsOWl838cftU=
X-Google-Smtp-Source: APXvYqw/xe2A5oKr4NpEvKW8vDY1jFb4YJBjdxIXRrvW+2jzPVQ0xJsP7zTAfrI1XXPAPaOEEKyyvw==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr5524188wrt.362.1576148337762;
        Thu, 12 Dec 2019 02:58:57 -0800 (PST)
Received: from szeder.dev (x4dbe262b.dyn.telefonica.de. [77.190.38.43])
        by smtp.gmail.com with ESMTPSA id n16sm5635396wro.88.2019.12.12.02.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 02:58:57 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:58:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] hook: add --list mode
Message-ID: <20191212105855.GJ6527@szeder.dev>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20191210023335.49987-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210023335.49987-4-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 06:33:32PM -0800, Emily Shaffer wrote:
> Teach 'git hook --list <hookname>', which checks the known configs in
> order to create an ordered list of hooks to run on a given hook event.
> 
> The hook config format is "hook.<hookname> = <order>:<path-to-hook>".
> This paves the way for multiple hook support; hooks should be run in the
> order specified by the user in the config, and in the case of an order
> number collision, configuration order should be used (e.g. global hook
> 004 will run before repo hook 004).
> 
> For example:
> 
>   $ grep -A2 "\[hook\]" ~/.gitconfig
>   [hook]
>           pre-commit = 001:~/test.sh
>           pre-commit = 999:~/baz.sh
> 
>   $ grep -A1 "\[hook\]" ~/git/.git/config
>   [hook]
>           pre-commit = 900:~/bar.sh
> 
>   $ ./bin-wrappers/git hook --list pre-commit
>   001     global  ~/test.sh
>   900     repo    ~/bar.sh
>   999     global  ~/baz.sh
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-hook.txt    | 17 +++++++-
>  Makefile                      |  1 +
>  builtin/hook.c                | 54 ++++++++++++++++++++++-
>  hook.c                        | 81 +++++++++++++++++++++++++++++++++++
>  hook.h                        | 14 ++++++
>  t/t1360-config-based-hooks.sh | 43 ++++++++++++++++++-
>  6 files changed, 206 insertions(+), 4 deletions(-)
>  create mode 100644 hook.c
>  create mode 100644 hook.h
> 
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index 2d50c414cc..a141884239 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,12 +8,27 @@ git-hook - Manage configured hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook'
> +'git hook' -l | --list <hook-name>
>  
>  DESCRIPTION
>  -----------
>  You can list, add, and modify hooks with this command.
>  
> +This command parses the default configuration files for lines which look like
> +"hook.<hook-name> = <order number>:<hook command>", e.g. "hook.pre-commit =
> +010:/path/to/script.sh". In this way, multiple scripts can be run during a
> +single hook. Hooks are sorted in ascending order by order number; in the event
> +of an order number conflict, they are sorted in configuration order.
> +
> +OPTIONS
> +-------
> +
> +-l::
> +--list::
> +	List the hooks which have been configured for <hook-name>. Hooks appear
> +	in the order they should be run. Output of this command follows the
> +	format '<order number> <origin config> <hook command>'.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite

> diff --git a/builtin/hook.c b/builtin/hook.c
> index b2bbc84d4d..8261302b27 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -1,21 +1,73 @@
>  #include "cache.h"
>  
>  #include "builtin.h"
> +#include "config.h"
> +#include "hook.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
>  
>  static const char * const builtin_hook_usage[] = {
> -	N_("git hook"),
> +	N_("git hook --list <hookname>"),
>  	NULL
>  };
>  
> +enum hook_command {
> +	HOOK_NO_COMMAND = 0,
> +	HOOK_LIST,
> +};
> +
> +static int print_hook_list(const struct strbuf *hookname)
> +{
> +	struct list_head *head, *pos;
> +	struct hook *item;
> +
> +	head = hook_list(hookname);
> +
> +	list_for_each(pos, head) {
> +		item = list_entry(pos, struct hook, list);
> +		if (item)
> +			printf("%.3d\t%s\t%s\n", item->order,
> +			       config_scope_to_string(item->origin),
> +			       item->command.buf);
> +	}
> +
> +	return 0;
> +}
> +
>  int cmd_hook(int argc, const char **argv, const char *prefix)
>  {
> +	enum hook_command command = 0;
> +	struct strbuf hookname = STRBUF_INIT;
> +
>  	struct option builtin_hook_options[] = {
> +		OPT_CMDMODE('l', "list", &command,
> +			    N_("list scripts which will be run for <hookname>"),
> +			    HOOK_LIST),

I'm not sure about '--list' being an option.  I don't know what other
operations you have in mind for this 'git hook' command, but I suppose
that besides listing configured hooks it will be able to at least add,
remove, and reorder them as well.  These seem to be better implemented
as subcommands, along the lines of e.g. how notes and remotes can be
added, removed, etc.

>  		OPT_END(),
>  	};
