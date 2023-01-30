Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74673C54EED
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 10:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjA3KDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjA3KDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 05:03:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DC974B
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:03:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so14212493ejc.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DlQbz9VRTIQIT0d6xxQq5DYRDKlPcQzHMv1ZXdafxM=;
        b=YHdxlpUnjWV2cEsa1UyCe4+WCQ9FmEu9/0I04qLQ1Dyyhudcdc2IdbnxKDDDtl6M6W
         QP5tGTlfEsNn7mCjuQAvdAb0aQ0qGBIVpNbuXC+Cg10w41B4Ux9hhtLF7YN6fRzq/iMI
         unUQXAjZ+IpI6TuLxNGcdTOLIs89OpRakWnk/CBOdhb/xA27omaJ1ZuR2vj2n3wk00UG
         gPZ6VxkH1RLpIm4QN8hpfkHssBjr8nzc4nLJmqlDqSJEr4to8pYaX1SKvjshbczHpYg+
         71ZMa5HUobCVYEw2ajqTt1NAbydndy5GunXwAuerfOA9jAcAR3e+d9SHX9Gosn4JooUP
         wgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DlQbz9VRTIQIT0d6xxQq5DYRDKlPcQzHMv1ZXdafxM=;
        b=ci9jWSCHWu7J6Y4gtKT7MunC+FWRl71iREmeCrGS0askgdyYB04XozgkRg/wBhDR7X
         aw63YGWuRFKS+CT7FHC6Flk40kuzmwQFdGZTiH8bkb9wg1Xw2PQK0PV+n8g5+S6jwUS8
         K5hbrYKZoEBdU3DQud6ek7cubH9Ao9CyoOy+rDaeqceXZZv6aK8KQvRo6FC1udTDRXED
         sDgKY+9LV2XIW3iNcBujGSNcifux9AHIptFRY7TVr2RDpFxa+69QVG2/r7WofEGwzF1f
         SJ1WnXORE+xwUSFCMd540w0SUIAj4TXv2bnDlKkoavJJsey3ywroZ+L2A34LZP9l9cod
         wwEA==
X-Gm-Message-State: AO0yUKVXHzeYb9IzMunFGLXEa4oevip+aWtCTLCsSN623U8dOegSDLlw
        0o1M8ISYPwzOtCtHFl+ecfE=
X-Google-Smtp-Source: AK7set8YnnQijV8+ftVmKkF4bkWToPDmDa6MtX7IOJBeIi9/TcszBlFckkrsE0R7dmbCpUbXADBdtw==
X-Received: by 2002:a17:906:4dcf:b0:87b:cdab:988e with SMTP id f15-20020a1709064dcf00b0087bcdab988emr13155490ejw.21.1675073023256;
        Mon, 30 Jan 2023 02:03:43 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709064e9200b0084c7f96d023sm6676676eju.147.2023.01.30.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:03:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMR0n-001hnU-2L;
        Mon, 30 Jan 2023 11:03:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v15 2/6] fsmonitor: relocate socket file if .git
 directory is remote
Date:   Mon, 30 Jan 2023 10:58:49 +0100
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
 <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
 <7bf1cdfe3b259f7135f3a50dcdd653563d5e19f6.1664904751.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <7bf1cdfe3b259f7135f3a50dcdd653563d5e19f6.1664904751.git.gitgitgadget@gmail.com>
Message-ID: <230130.86o7qgs5j6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> If the .git directory is on a remote filesystem, create the socket
> file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  Makefile                               |  1 +
>  builtin/fsmonitor--daemon.c            |  3 +-
>  compat/fsmonitor/fsm-ipc-darwin.c      | 52 ++++++++++++++++++++++++++
>  compat/fsmonitor/fsm-ipc-win32.c       |  9 +++++
>  compat/fsmonitor/fsm-settings-darwin.c |  2 +-
>  contrib/buildsystems/CMakeLists.txt    |  2 +
>  fsmonitor-ipc.c                        | 18 ++++-----
>  fsmonitor-ipc.h                        |  4 +-
>  8 files changed, 78 insertions(+), 13 deletions(-)
>  create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
>
> diff --git a/Makefile b/Makefile
> index ffab427ea5b..feb675a6959 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2039,6 +2039,7 @@ ifdef FSMONITOR_DAEMON_BACKEND
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>  	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
>  endif
>  
>  ifdef FSMONITOR_OS_SETTINGS
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 2c109cf8b37..0123fc33ed2 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -1343,7 +1343,8 @@ static int fsmonitor_run_daemon(void)
>  	 * directory.)
>  	 */
>  	strbuf_init(&state.path_ipc, 0);
> -	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
> +	strbuf_addstr(&state.path_ipc,
> +		absolute_path(fsmonitor_ipc__get_path(the_repository)));
>  
>  	/*
>  	 * Confirm that we can create platform-specific resources for the
> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
> new file mode 100644
> index 00000000000..ce843d63348
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-ipc-darwin.c
> @@ -0,0 +1,52 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "strbuf.h"
> +#include "fsmonitor.h"
> +#include "fsmonitor-ipc.h"
> +#include "fsmonitor-path-utils.h"
> +
> +static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
> +
> +const char *fsmonitor_ipc__get_path(struct repository *r)
> +{
> +	static const char *ipc_path = NULL;
> +	SHA_CTX sha1ctx;
> +	char *sock_dir = NULL;

...don't init this to NULL...

> +	struct strbuf ipc_file = STRBUF_INIT;
> +	unsigned char hash[SHA_DIGEST_LENGTH];
> +
> +	if (!r)
> +		BUG("No repository passed into fsmonitor_ipc__get_path");
> +
> +	if (ipc_path)
> +		return ipc_path;
> +
> +
> +	/* By default the socket file is created in the .git directory */
> +	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
> +		ipc_path = fsmonitor_ipc__get_default_path();
> +		return ipc_path;
> +	}
> +
> +	SHA1_Init(&sha1ctx);
> +	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> +	SHA1_Final(hash, &sha1ctx);
> +
> +	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);

...instead check the return value here. So:

	if (!repo_config_get_string(..., &sock_dir))
        	...

> +	/* Create the socket file in either socketDir or $HOME */
> +	if (sock_dir && *sock_dir) {
> +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +					sock_dir, hash_to_hex(hash));

^ Add the body of this branch to the "..." above.

> +	} else {
> +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));

...and keep this in the "else".

> +	}
> +	free(sock_dir);

You'd then add this free() to the first branch, but better yet in this
case avoid this allocation, use "const char *" and use
repo_config_get_string_tmp(). It's made for exactly this sort of use-case.

> +
> +	ipc_path = interpolate_path(ipc_file.buf, 1);
> +	if (!ipc_path)
> +		die(_("Invalid path: %s"), ipc_file.buf);
> +
> +	strbuf_release(&ipc_file);
> +	return ipc_path;
> +}
> diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
> new file mode 100644
> index 00000000000..e08c505c148
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-ipc-win32.c
> @@ -0,0 +1,9 @@
> +#include "config.h"
> +#include "fsmonitor-ipc.h"
> +
> +const char *fsmonitor_ipc__get_path(struct repository *r) {
> +	static char *ret;

Missing \n here.

>  try_again:
> -	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
> -				       &connection);
> +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
> +						&options, &connection);

This post-image is mis-indented.

>  #include "simple-ipc.h"
>  
> +struct repository;
> +

I think we'd usually forard-declare such things, if needed...

>  /*
>   * Returns true if built-in file system monitor daemon is defined
>   * for this platform.
> @@ -16,7 +18,7 @@ int fsmonitor_ipc__is_supported(void);
>   *
>   * Returns NULL if the daemon is not supported on this platform.
>   */
> -const char *fsmonitor_ipc__get_path(void);

..right before they're needed, so before this line?

> +const char *fsmonitor_ipc__get_path(struct repository *r);
>  
>  /*
>   * Try to determine whether there is a `git-fsmonitor--daemon` process

