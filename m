Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF96C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 22:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiBYWzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYWzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 17:55:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14371EF354
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:54:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm8so9409625edb.3
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7oT/nrM9UhH7AvC7t2Fiq9kRJmf5iNImkVIqS+iKA0o=;
        b=dAFqKGjq9Sa6MGJ6KE6K+3QTvld8Y5rHhu34+yzo39MsC2+ETPKFyVD2iEc7MRjUZn
         jIX2v+QRkrWmoA8SWppHUDsrFZ4FCE3bni24+3xRRA/LYf24GBPQFPCEAi72EmmaC80b
         ax/zPUD0E61DqExaXslDERLb2aepzaO2Rgx5xBgS7rglSLZ3K4SSx0rhogkn7uYIgcWt
         Dg9AlThyN8mfwbaiPOZHlUhu8ym+wT1D5vjJVyuQXV4zq3zLmqVq6z4Rw2B4GOdV33ly
         6ZPkj3aGf0yH//xzSBlRLVfzCF6ynXEz69ObGxRarYb6eRqMEKU5n2/yq87jINXw2F8p
         xH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7oT/nrM9UhH7AvC7t2Fiq9kRJmf5iNImkVIqS+iKA0o=;
        b=iOEYJqzzCQFKH3280eMRLau6BUpFH4szEKM3IA9US40gtJbbWJhS6uUxmSgQwR0Aj8
         tlZKPv6gDSz3XoP4AS9vbrhAZOpkS9XWLZnyxRwwSzk5ztk6h3Oiw0/RsNujVjPYQjbp
         m9/q3DG2z3Rrd15nGhzGR53KiBHIozJLaQyF5WqueKKoRVUHl+TBHMzes7gIf2f1dv7N
         Ir8kK2k7eUDdAuVVKUqnBZyWs19Zt4UTGGRgH0OFOuuyv5CswEADfHkKF5NRIOwStifj
         e0p8l8vs3qEbHnuM6ve3P8+W8y01yG0a4xNxiAfmzaGauOuMJP03BkuGmXPIlY0AGaz9
         8kBw==
X-Gm-Message-State: AOAM5338niOY60WO6Di+fb/bFc3lIn7YaAlmwXdlyI82V5r4oyYuj0WS
        DgBb0/duRa11n0lGx3J86VowyL1ce/Ghsg==
X-Google-Smtp-Source: ABdhPJzSWh+dqvjkAf2qBzN1UViqrwrcdvluZU8zz442QUodIKFDL0ODWajk9Fe8xyFgwdOAjbxoKw==
X-Received: by 2002:aa7:cb96:0:b0:413:8d05:ebc with SMTP id r22-20020aa7cb96000000b004138d050ebcmr571544edt.81.1645829681019;
        Fri, 25 Feb 2022 14:54:41 -0800 (PST)
Received: from gmgdl ([109.36.128.147])
        by smtp.gmail.com with ESMTPSA id b7-20020a50e787000000b00412d6970125sm1959568edn.104.2022.02.25.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:54:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNjTz-000jT0-KD;
        Fri, 25 Feb 2022 23:54:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 06/30] fsmonitor--daemon: add a built-in fsmonitor
 daemon
Date:   Fri, 25 Feb 2022 23:46:49 +0100
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <bdd7334da3162ce77c216d61ce9d979f12637ac5.1644612979.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bdd7334da3162ce77c216d61ce9d979f12637ac5.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <220225.865yp27e1c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 11 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create a built-in file system monitoring daemon that can be used by
> the existing `fsmonitor` feature (protocol API and index extension)
> to improve the performance of various Git commands, such as `status`.
>
> The `fsmonitor--daemon` feature builds upon the `Simple IPC` API and
> provides an alternative to hook access to existing fsmonitors such
> as `watchman`.
>
> This commit merely adds the new command without any functionality.
>
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  .gitignore                  |  1 +
>  Makefile                    |  1 +
>  builtin.h                   |  1 +
>  builtin/fsmonitor--daemon.c | 46 +++++++++++++++++++++++++++++++++++++
>  git.c                       |  1 +
>  5 files changed, 50 insertions(+)
>  create mode 100644 builtin/fsmonitor--daemon.c
>
> diff --git a/.gitignore b/.gitignore
> index f817c509ec0..e81de1063a4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -72,6 +72,7 @@
>  /git-format-patch
>  /git-fsck
>  /git-fsck-objects
> +/git-fsmonitor--daemon
>  /git-gc
>  /git-get-tar-commit-id
>  /git-grep
> diff --git a/Makefile b/Makefile
> index 9943f0f7c11..3b7a3f88b50 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1106,6 +1106,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
>  BUILTIN_OBJS += builtin/for-each-ref.o
>  BUILTIN_OBJS += builtin/for-each-repo.o
>  BUILTIN_OBJS += builtin/fsck.o
> +BUILTIN_OBJS += builtin/fsmonitor--daemon.o
>  BUILTIN_OBJS += builtin/gc.o
>  BUILTIN_OBJS += builtin/get-tar-commit-id.o
>  BUILTIN_OBJS += builtin/grep.o
> diff --git a/builtin.h b/builtin.h
> index 83379f3832c..40e9ecc8485 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -159,6 +159,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
>  int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
>  int cmd_format_patch(int argc, const char **argv, const char *prefix);
>  int cmd_fsck(int argc, const char **argv, const char *prefix);
> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix);
>  int cmd_gc(int argc, const char **argv, const char *prefix);
>  int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
>  int cmd_grep(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> new file mode 100644
> index 00000000000..f0498793379
> --- /dev/null
> +++ b/builtin/fsmonitor--daemon.c
> @@ -0,0 +1,46 @@
> +#include "builtin.h"
> +#include "config.h"
> +#include "parse-options.h"
> +#include "fsmonitor.h"
> +#include "fsmonitor-ipc.h"
> +#include "simple-ipc.h"
> +#include "khash.h"
> +
> +static const char * const builtin_fsmonitor__daemon_usage[] = {
> +	NULL
> +};
> +
> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +
> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> +{
> +	const char *subcmd;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	git_config(git_default_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     builtin_fsmonitor__daemon_usage, 0);
> +	if (argc != 1)
> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
> +	subcmd = argv[0];
> +
> +	die(_("Unhandled subcommand '%s'"), subcmd);
> +}
> +
> +#else
> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
> +
> +	die(_("fsmonitor--daemon not supported on this platform"));
> +}
> +#endif
> diff --git a/git.c b/git.c
> index 340665d4a04..a8b44d9b587 100644
> --- a/git.c
> +++ b/git.c
> @@ -536,6 +536,7 @@ static struct cmd_struct commands[] = {
>  	{ "format-patch", cmd_format_patch, RUN_SETUP },
>  	{ "fsck", cmd_fsck, RUN_SETUP },
>  	{ "fsck-objects", cmd_fsck, RUN_SETUP },
> +	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
>  	{ "gc", cmd_gc, RUN_SETUP },
>  	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },


I brought this up in another thread in how this series interacts with
another, but this patch below on top of "seen" would allow you to catch
parse_options() BUGs on Linux, even if you don't have a no-OSX
non-Windows backend yet:
	
	diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
	index 591433e897d..62c0b1d486b 100644
	--- a/builtin/fsmonitor--daemon.c
	+++ b/builtin/fsmonitor--daemon.c
	@@ -18,7 +18,6 @@ static const char * const builtin_fsmonitor__daemon_usage[] = {
	 	NULL
	 };
	 
	-#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
	 /*
	  * Global state loaded from config.
	  */
	@@ -63,6 +62,7 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
	 
	 	return git_default_config(var, value, cb);
	 }
	+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
	 
	 /*
	  * Acting as a CLIENT.
	@@ -1492,6 +1492,8 @@ static int try_to_start_background_daemon(void)
	 	}
	 }
	 
	+#endif
	+
	 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
	 {
	 	const char *subcmd;
	@@ -1532,6 +1534,7 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
	 		return -1;
	 	}
	 
	+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
	 	if (!strcmp(subcmd, "start"))
	 		return !!try_to_start_background_daemon();
	 
	@@ -1543,20 +1546,8 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
	 
	 	if (!strcmp(subcmd, "status"))
	 		return !!do_as_client__status();
	-
	 	die(_("Unhandled subcommand '%s'"), subcmd);
	-}
	-
	 #else
	-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
	-{
	-	struct option options[] = {
	-		OPT_END()
	-	};
	-
	-	if (argc == 2 && !strcmp(argv[1], "-h"))
	-		usage_with_options(builtin_fsmonitor__daemon_usage, options);
	-
	 	die(_("fsmonitor--daemon not supported on this platform"));
	-}
	 #endif
	+}

I.e. we can be a less zealous when setting the ifdef boundaries, and
it's actually less code as well.
