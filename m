Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809FEC433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 18:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJASnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJASnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 14:43:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6B13FAE
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 11:43:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so6698628pgc.0
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=Lbnfb3dgbjmuXyBgw0OKSbxQNAkpjxsbRoPFuS3VhE0=;
        b=dYsG5NfiZlzgdQxAJHwPFfx7suIJkbT/WcM5Hza3Lhb59VL77S2hKfDDztd9OgnP+9
         TIykTyhoH4+mR167zB63vj51loP1AORdn6Ufs13gfB8OK0SQ4x3TaTE/CHuwBzYxKPbR
         uTkcQbWrdBAjurlKCKy6qEYgOdnqorPFfZhBj2bonC992vPW5pBA+2hilxqEz3fhNO+0
         1mIDe5I7VjKxUhP2/er673quC1lLtgmVZgU1GdmbCIOH7U+FnsjpQcnm6mWr9J7Wb7g8
         IqqT0rPuKbtE4OMj5RZjB6E7zOfJP4P422jt21ZCrEMc7FcWpPkp/E02CWdvDCzHw2+P
         dcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Lbnfb3dgbjmuXyBgw0OKSbxQNAkpjxsbRoPFuS3VhE0=;
        b=WC/7DTtHGNVtbuOdRe2zgySGdDbFLa0dmGqpT6ZBx63DaTa9Ltc9ZxIfXKyl0atf/C
         hNotox8PBIA80Tg0b7yo20msrfXTreAwNb2Ud7e7mAwsSoNeX80lrOqgKF7Rtj6hWKkD
         DjSlLVd77r/K5tWPS4xgO8utPo4JHjsyG01/4Wb9jcA5jiLn00+WoqlhkqqnoyCsc8un
         YXhSX22bg00PHpYO9PGTQmyX/++XbUEz1j+i+vvLqo68o1vLtfp0kNV7r3OwMic+A7zR
         Jetk9wnuuGsqFqvV3MsNZoIMpHnGe0rFswqeBQ87IR3cZ9eOoPx7OddJuygJLSXweHGx
         ipCA==
X-Gm-Message-State: ACrzQf1YOD/AsV4+J28dhujhQpsfX1r6/heWi+NxgkNNuY9wTnPBlLjK
        +LvPTtiCc4d4IRGmdKRBgsY=
X-Google-Smtp-Source: AMsMyM6tporLzz6S25/oyqZndnp0Z9aRog6splevB+YxXltqJ+z9RXFMyA7iyGiaQE+bKqLRv5Zz4g==
X-Received: by 2002:a62:1684:0:b0:554:cade:6970 with SMTP id 126-20020a621684000000b00554cade6970mr14891617pfw.11.1664649787061;
        Sat, 01 Oct 2022 11:43:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090ad38f00b00209a12b3879sm3573370pju.37.2022.10.01.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 11:43:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 21/36] doc txt & -h consistency: add missing options
 and labels
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-21.36-1713227d497-20220930T180415Z-avarab@gmail.com>
Date:   Sat, 01 Oct 2022 11:43:05 -0700
In-Reply-To: <patch-v3-21.36-1713227d497-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:44
        +0200")
Message-ID: <xmqqwn9j2xmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix various issues of SYNOPSIS and -h output syntax where:
>
>  * Options such as --force were missing entirely
>  * ...or the short option, such as -f

In the full option listing (e.g. what usage_with_options() gives for
options with both short and long form, such as "git commit -h"), it
indeed is good to show both, i.e.

	-q, --quiet    run quietly
	-v, --verbose  run verbosely

is good and we have enough room to do so.

But for commands with so small number of options that we cram the
options on the summary line without hiding them behind a single
"[<options>]" placeholder, I am not sure if it is a good idea to
show both and do

	usage: git cmd [-f|--force] [-q|--quiet] [-v|--verbose] <pathspec>

in the first place.  It would be easier to understand without
distracting choice, i.e.

	usage: git cmd [--force] [--quiet] [--verbose] <pathspec>

or even with only the short-form (but that risks to become
unfriendly to new people who haven't learned what a single letter
option "-x" means, so I would not recommend it).

Especially with the mandatory space around vertical bar, it would
look horrible,

	usage: git cmd [-f | --force] [-q | --quiet] [-v | --verbose] <pathspec>

as the visual binding between the short and long form of the same
option becomes weaker.

So, I dunno. 


>  * We said "opts" or "options", but could instead enumerate
>    the (small) set of supported options

Yes, see above.

>  * argument labels were missing entirely (ls-remote)

I do not know what an "argument label" is, but I can see that
ls-remote.c lacked the description for the --sort option.

>  * How we referred to an argument was inconsistent between the two,
>    e.g. <pack> v.s. <pack>.idx.

I didn't see anything in this category in this patch.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

> -'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
> +'git send-pack' [--mirror] [--dry-run] [--force]
> +		[--receive-pack=<git-receive-pack>]

It may not matter what order the options are given, but having
anything before "--dry-run" looks somewhat strange.  It is not like
this list is given in the same order as they appear in the options[]
array.

I wonder if "--mirror" is the most closely related to (read: easier
to understand if it is listed close to) "--all" and <ref>,
i.e. immediately before the destination repository?

We do not really care about these commands that end-users will never
invoke themselves, so I'll let it pass, even though this one looks a
bit questionable.

> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 872436d7426..68392d2a56e 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
>  SYNOPSIS
>  --------
>  [verse]
> -'git sparse-checkout' <subcommand> [<options>]
> +'git sparse-checkout' (init | list | set | add | reapply | disable) [<options>]

OK.  We have only limited number that fits on a line; otherwise
"<subcommand>" -> "<command>" which refers reders to the COMMANDS
section of the documentation.

> diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
> index 969bb2e15f1..4e6bf44427f 100644
> --- a/Documentation/git-update-server-info.txt
> +++ b/Documentation/git-update-server-info.txt
> @@ -9,7 +9,7 @@ git-update-server-info - Update auxiliary info file to help dumb servers
>  SYNOPSIS
>  --------
>  [verse]
> -'git update-server-info'
> +'git update-server-info' [-f | --force]
>  
>  DESCRIPTION
>  -----------
> @@ -19,6 +19,12 @@ $GIT_OBJECT_DIRECTORY/info directories to help clients discover
>  what references and packs the server has.  This command
>  generates such auxiliary files.
>  
> +OPTIONS
> +-------
> +-f::
> +--force::
> +	Allow adding otherwise ignored files.

The option help text says this:

    N_("update the info files from scratch"), 0),

> diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
> index 92097f6673d..96d10cfdffe 100644
> --- a/Documentation/git-verify-commit.txt
> +++ b/Documentation/git-verify-commit.txt
> @@ -8,7 +8,7 @@ git-verify-commit - Check the GPG signature of commits
>  SYNOPSIS
>  --------
>  [verse]
> -'git verify-commit' <commit>...
> +'git verify-commit' [-v | --verbose] <commit>...
>  
>  DESCRIPTION
>  -----------

The DESCRIPTION section also mentions "--raw".

> diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
> index 0b8075dad96..a454df2711e 100644
> --- a/Documentation/git-verify-tag.txt
> +++ b/Documentation/git-verify-tag.txt
> @@ -8,7 +8,7 @@ git-verify-tag - Check the GPG signature of tags
>  SYNOPSIS
>  --------
>  [verse]
> -'git verify-tag' [--format=<format>] <tag>...
> +'git verify-tag' [-v | --verbose] [--format=<format>] <tag>...
>  
>  DESCRIPTION
>  -----------

The DESCRIPTION section also mentions "--raw".

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index ca672a6a619..d4eb0097d24 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
>  	const char *socket_path;
>  	int ignore_sighup = 0;
>  	static const char *usage[] = {
> -		"git-credential-cache--daemon [opts] <socket-path>",
> +		"git-credential-cache--daemon [--debug] <socket-path>",
>  		NULL
>  	};
>  	int debug = 0;

OK.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index e17c4b4c69b..23e3f05fb10 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -23,8 +23,9 @@
>  define_commit_slab(commit_names, struct commit_name *);
>  
>  static const char * const describe_usage[] = {
> -	N_("git describe [<options>] [<commit-ish>...]"),
> -	N_("git describe [<options>] --dirty"),
> +	N_("git describe [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]"),
> +	N_("git describe [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]"),
> +	N_("git describe <blob>"),
>  	NULL
>  };

OK.

> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index e667cf52e7d..aea139b9d8f 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -9,7 +9,7 @@
>  #include "submodule.h"
>  
>  static const char diff_cache_usage[] =
> -"git diff-index [-m] [--cached] "
> +"git diff-index [-m] [--cached] [--merge-base] "
>  "[<common-diff-options>] <tree-ish> [<path>...]"
>  "\n"
>  COMMON_DIFF_OPTIONS_HELP;

OK.

> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index df44e5cc0d1..5d5ac038716 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -7,7 +7,7 @@
>  
>  static const char * const ls_remote_usage[] = {
>  	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
> -	   "              [-q | --quiet] [--exit-code] [--get-url]\n"
> +	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]\n"
>  	   "              [--symref] [<repository> [<refs>...]]"),
>  	NULL
>  };

OK.

We do not need to express that --sort=<key0> --sort=<key1>... can be
given multiple times without triggering the usual last-one-wins?  In
the documentation, the option description can say "this option can
be given multiple times", but here we cannot, so the best we could
do would be [--sort=<key>...] and I wonder if that is worth it.

> diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
> index cfbd5c36c76..27c2ca06acb 100644
> --- a/builtin/pack-refs.c
> +++ b/builtin/pack-refs.c
> @@ -5,7 +5,7 @@
>  #include "repository.h"
>  
>  static char const * const pack_refs_usage[] = {
> -	N_("git pack-refs [<options>]"),
> +	N_("git pack-refs [--all] [--no-prune]"),
>  	NULL
>  };

Even though "[--[no-]all] [--[no-]prune" would be more complete, I
do not mind listing only the side that makes it behave differently
from the default.  But if you reroll with a more complete version
with documentation updates, I wouldn't complain at all.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index ee2a0807f01..ee32c714a76 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -21,14 +21,15 @@
>   */
>  
>  static const char * const revert_usage[] = {
> -	N_("git revert [<options>] <commit-ish>..."),
> -	N_("git revert <subcommand>"),
> +	N_("git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>..."),
> +	N_("git revert (--continue | --skip | --abort | --quit)"),
>  	NULL
>  };

This one uses "[--[no-]edit]", which is OK.  Also <keyid> unlike the
other ones I saw in my yesterdays review is not <key-id>, which is
somewhat curious.

>  static const char * const cherry_pick_usage[] = {
> -	N_("git cherry-pick [<options>] <commit-ish>..."),
> -	N_("git cherry-pick <subcommand>"),
> +	N_("git cherry-pick [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff]\n"
> +	   "                [-S[<keyid>]] <commit>..."),
> +	N_("git cherry-pick (--continue | --skip | --abort | --quit)"),
>  	NULL
>  };

And here we see "[--edit]", which is not exactly consistent.

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 64962be0168..4c5d125fa0a 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -20,6 +20,7 @@ static const char * const send_pack_usage[] = {
>  	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
>  	   "              [--receive-pack=<git-receive-pack>]\n"
>  	   "              [--verbose] [--thin] [--atomic]\n"
> +	   "              [--[no-]signed | --signed=(true|false|if-asked)]\n"
>  	   "              [<host>:]<directory> (--all | <ref>...)"),
>  	NULL,
>  };

Excellent.

> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 1b0f10225f0..50b6df78df0 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -5,8 +5,9 @@
>  #include "parse-options.h"
>  
>  static const char * const git_symbolic_ref_usage[] = {
> -	N_("git symbolic-ref [<options>] <name> [<ref>]"),
> -	N_("git symbolic-ref -d [-q] <name>"),
> +	N_("git symbolic-ref [-m <reason>] <name> <ref>"),
> +	N_("git symbolic-ref [-q] [--short] <name>"),
> +	N_("git symbolic-ref --delete [-q] <name>"),
>  	NULL
>  };

Why spell out --delete without allowing -d?  Especially when listing
only -q for OPT__QUIET()?

    git symbolic-ref (-d|--delete) [-q|--quiet] <name>

would be more complete but I think the original (i.e. "-d [-q]") is
more consistent.

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 75dece0e4f1..d428c45dc8d 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -23,11 +23,13 @@
>  #include "date.h"
>  
>  static const char * const git_tag_usage[] = {
> -	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> -	   "        <tagname> [<head>]"),
> +	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +	   "        <tagname> [<commit> | <object>]"),

OK.

>  	N_("git tag -d <tagname>..."),


> -	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
> -	   "        [--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
> +	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
> +	   "        [--points-at <object>] [--column[=<options>] | --no-column]\n"
> +	   "        [--create-reflog] [--sort=<key>] [--format=<format>]\n"
> +	   "        [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),

OK.

>  	N_("git tag -v [--format=<format>] <tagname>..."),
>  	NULL
>  };


> diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
> index 880fffec587..d2239c9ef4d 100644
> --- a/builtin/update-server-info.c
> +++ b/builtin/update-server-info.c
> @@ -4,7 +4,7 @@
>  #include "parse-options.h"
>  
>  static const char * const update_server_info_usage[] = {
> -	"git update-server-info [--force]",
> +	"git update-server-info [-f | --force]",
>  	NULL
>  };
>  
> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index 125af53885f..25b69da2bf2 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -8,7 +8,8 @@
>  #include "serve.h"
>  
>  static const char * const upload_pack_usage[] = {
> -	N_("git upload-pack [<options>] <dir>"),
> +	N_("git-upload-pack [--[no-]strict] [--timeout=<n>] [--stateless-rpc]\n"
> +	   "                [--advertise-refs] <directory>"),
>  	NULL
>  };

OK.  We do not really care about these commands that end-users will
never invoke themselves, but these look good.

> diff --git a/help.c b/help.c
> index d04542d8261..f1e090a4428 100644
> --- a/help.c
> +++ b/help.c
> @@ -757,7 +757,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  	struct strbuf buf = STRBUF_INIT;
>  	int build_options = 0;
>  	const char * const usage[] = {
> -		N_("git version [<options>]"),
> +		N_("git version [--build-options]"),
>  		NULL
>  	};
>  	struct option options[] = {

OK.
