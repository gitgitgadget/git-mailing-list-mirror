Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDBC4332F
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 08:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiCNIG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiCNID0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 04:03:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452D1408F
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 00:59:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so31920856ejc.7
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0Bgwxx4+Zlp0/Vea87rgrZce0zrwg6IV8Sto/+e/4XQ=;
        b=CeFlz+/91OQn/gk2rUDUhojABv+PGiswBIZsTxXj+0yLtjH11LVTTADhIEhpSVqTbo
         kezDlNyBsANerc6Ei86ELGQIuTQwPgpMGEnmAe1gnOFSPfd5y3FjlVDtENdVIU7trU6b
         pnc+4l2WmSrWwnk/n9Z9Et7yJWSJ+FAA4FaFgc9HhG9KVeYqug01g3hN4gfg/MFFlheH
         tLZfzT+0iBs1744Wfu7tjRjVoNm5Ext/hQOSHsVdhGoS5Z1GjMj8jcGbvNlsX0FjEz9m
         dC/w9u8r0WfCuDWmqI2W+Xl+0+ZVwubnXvsdZ5uGgpln1pTXB9tnISVMc8rJ0qLkJM7d
         dH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0Bgwxx4+Zlp0/Vea87rgrZce0zrwg6IV8Sto/+e/4XQ=;
        b=nhYZuUGS3Tnj0vVSvx4XpXcFFsWzFjv7LaDpSaH/vUWCRlx78Ob6PjQy4IDY/UTzjN
         NEnkmdh40qB2PUhSSFqS5Fa67zRp4THQVBrMDiq1Qr8FOUG5YtXquEY4ftJyIqROF8Wm
         26RBNDTYg9lVOktfV5S7ZX8rdw8DYwVKYev3M+kqNvyKdrh86Wp6GiT0hlArcpZUF4Gz
         R+LQvDfptfSE2fLH+R5lF1D9W1NDYlN4JODzDi1R5/FYwYNQwYCZA7um/X737nSOP+rQ
         7ITsRuwNdpxtYqpKob7ZtOkfkN7w8h1EzjWf0oSCbyqVcWwN+Ia3A6yQQRUB8DkgJv/V
         9Amg==
X-Gm-Message-State: AOAM532mGuEkeXrQ4OQi/sMZMZh35rCA+fe1pIC4AHSsv2vPLXTo+6jR
        qjufsfmo7GR7OxaAOL5NMGU7Kqt1lcQ=
X-Google-Smtp-Source: ABdhPJylNHKpz3WaZC4emjzWwDXK5gDj8uIXnrzVFu29YQ83dBt+c/KxzZNkuLLhdL+Njz3O3eIp9g==
X-Received: by 2002:a17:906:4783:b0:6d0:9b6e:b5a5 with SMTP id cw3-20020a170906478300b006d09b6eb5a5mr18571860ejc.526.1647244785961;
        Mon, 14 Mar 2022 00:59:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b00416cee953dasm5288853edb.24.2022.03.14.00.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 00:59:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nTfcG-000IqI-RO;
        Mon, 14 Mar 2022 08:59:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 04/16] t/helper/fsmonitor-client: cleanup call to
 parse_options()
Date:   Mon, 14 Mar 2022 08:58:53 +0100
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <578c3682e2fb35af86087e6a0c277aa8766919d7.1647033303.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <578c3682e2fb35af86087e6a0c277aa8766919d7.1647033303.git.gitgitgadget@gmail.com>
Message-ID: <220314.86fsnlezgv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! t/helper/fsmonitor-client: create IPC client to talk to \
> FSMonitor Daemon
>
> Elminate unnecessary code in cmd__fsmonitor_client() WRT
> parsing of options.
>
> Fix name of test-tool in usage.
>
> Don't localize die() message.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/helper/test-fsmonitor-client.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
> index f7a5b3a32fa..d59a640f1f9 100644
> --- a/t/helper/test-fsmonitor-client.c
> +++ b/t/helper/test-fsmonitor-client.c
> @@ -49,7 +49,7 @@ static int do_send_query(const char *token)
>  
>  	ret = fsmonitor_ipc__send_query(token, &answer);
>  	if (ret < 0)
> -		die(_("could not query fsmonitor--daemon"));
> +		die("could not query fsmonitor--daemon");

Good, since this is just a test helper.

>  	write_in_full(1, answer.buf, answer.len);
>  	strbuf_release(&answer);
> @@ -85,8 +85,8 @@ int cmd__fsmonitor_client(int argc, const char **argv)
>  	const char *token = NULL;
>  
>  	const char * const fsmonitor_client_usage[] = {
> -		N_("test-helper fsmonitor-client query [<token>]"),
> -		N_("test-helper fsmonitor-client flush"),
> +		N_("test-tool fsmonitor-client query [<token>]"),
> +		N_("test-tool fsmonitor-client flush"),

These are still marked for N_() translation.

Even if tehse were built-ins only the one containing <token> should have
N_(), as the other one is a literal command whose translation won't
change.

>  		NULL,
>  	};
>  
> @@ -96,17 +96,12 @@ int cmd__fsmonitor_client(int argc, const char **argv)
>  		OPT_END()
>  	};
>  
> -	if (argc < 2)
> -		usage_with_options(fsmonitor_client_usage, options);
> +	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
>  
> -	if (argc == 2 && !strcmp(argv[1], "-h"))
> +	if (argc != 1)
>  		usage_with_options(fsmonitor_client_usage, options);
>  
> -	subcmd = argv[1];
> -	argv--;
> -	argc++;
> -
> -	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
> +	subcmd = argv[0];
>  
>  	setup_git_directory();

Looks good.
