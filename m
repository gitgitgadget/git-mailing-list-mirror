Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5794B1F404
	for <e@80x24.org>; Mon, 15 Jan 2018 07:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeAOHd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 02:33:59 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:60536 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752979AbeAOHd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 02:33:58 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zKlTd0H2Pz5tlN;
        Mon, 15 Jan 2018 08:33:56 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6399B274;
        Mon, 15 Jan 2018 08:33:56 +0100 (CET)
Subject: Re: [PATCH 1/1] Mark messages for translations
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        bmwill@google.com, peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com
References: <20180115054419.4112-1-ash@kambanaria.org>
 <20180115054419.4112-2-ash@kambanaria.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b9e734a2-52bb-08b1-6bab-3d47b0f7ebeb@kdbg.org>
Date:   Mon, 15 Jan 2018 08:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180115054419.4112-2-ash@kambanaria.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.01.2018 um 06:44 schrieb Alexander Shopov:
> @@ -5,11 +5,11 @@
>   #include "run-command.h"
>   
>   const char git_usage_string[] =
> -	"git [--version] [--help] [-C <path>] [-c name=value]\n"
> -	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
> -	"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
> -	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> -	"           <command> [<args>]";
> +	N_("git [--version] [--help] [-C <path>] [-c name=value]\n"
> +	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
> +	   "           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
> +	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> +	   "           <command> [<args>]");
>   
>   const char git_more_info_string[] =
>   	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
> @@ -92,7 +92,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   				*envchanged = 1;
>   		} else if (!strcmp(cmd, "--git-dir")) {
>   			if (*argc < 2) {
> -				fprintf(stderr, "No directory given for --git-dir.\n" );
> +  				fprintf(stderr, _("No directory given for --git-dir.\n" ));
>   				usage(git_usage_string);

It is not obvious to me where git_usage_string is looked up in the 
message catalog. Should this not be

				usage(_(git_usage_string));

(here and in later instances)? It is used that way in builtin/help.c, 
for example.

> @@ -385,14 +385,14 @@ void setup_work_tree(void)
>   		return;
>   
>   	if (work_tree_config_is_bogus)
> -		die("unable to set up work tree using invalid config");
> +		die(_("unable to set up work tree using invalid config"));
>   
>   	work_tree = get_git_work_tree();
>   	git_dir = get_git_dir();
>   	if (!is_absolute_path(git_dir))
>   		git_dir = real_path(get_git_dir());
>   	if (!work_tree || chdir(work_tree))
> -		die("This operation must be run in a work tree");
> +		die(_("This operation must be run in a work tree"));

We have settled with lower-case letters at the beginning of error 
messages. (See Documentation/CodingGuidelines, "Error Messages".) You 
could fix that while you are touching die, die_errno, etc, messages.

> @@ -677,12 +677,12 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
>   		else {
>   			char *core_worktree;
>   			if (chdir(gitdirenv))
> -				die_errno("Could not chdir to '%s'", gitdirenv);
> +				die_errno(_("Cannot chdir to '%s'"), gitdirenv);

I notice you change past tense to present tense in some cases. IMO, this 
makes the messages more consistent. Good.

I'm not a friend of geeky abbreviations like "chdir" or "cwd" in 
user-visible messages, and I would have taken the opportunity to change 
the messages accordingly. This is really only my personal taste, though, 
and it's possible that I'm alone in this camp.

>   			if (chdir(git_work_tree_cfg))
> -				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
> +				die_errno(_("Cannot chdir to '%s'"), git_work_tree_cfg);
>   			core_worktree = xgetcwd();
>   			if (chdir(cwd->buf))
> -				die_errno("Could not come back to cwd");
> +				die_errno(_("Cannot come back to cwd");
...
> @@ -1207,7 +1207,7 @@ void sanitize_stdfds(void)
>   	while (fd != -1 && fd < 2)
>   		fd = dup(fd);
>   	if (fd == -1)
> -		die_errno("open /dev/null or dup failed");
> +		die_errno(_("open /dev/null or dup failed"));
>   	if (fd > 2)
>   		close(fd);
>   }
> @@ -1222,12 +1222,12 @@ int daemonize(void)
>   		case 0:
>   			break;
>   		case -1:
> -			die_errno("fork failed");
> +			die_errno(_("fork failed"));
>   		default:
>   			exit(0);
>   	}
>   	if (setsid() == -1)
> -		die_errno("setsid failed");
> +		die_errno(_("setsid failed"));

Here is a certain class of errors: They should occur only rarely 
(actually, is that true?) Then it is useful to have the function name in 
the message. Which rises the question: why translate them at all? It's 
possible that translators turn the message into unusable gibberish just 
to please their language. All of this is only IMHO; I don't use 
translated Git.

-- Hannes
