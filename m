Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D6ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiHaQw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiHaQwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:52:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60AFDB04C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:52:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b16so19182427edd.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=JeZEyORbpbC8OP1gdLxPcfnmEy8HHTfhMKkPM9DxN0c=;
        b=bgEHoSdAwLG+Lpw/a2Sq0EATFkH3rVaNFYtjAt4zx8KVzR82SbiFpHRDKwQsmagXvv
         Y6yZ4sgcP88cOnn44ut+s6beZIbB0jtbhBS4+t02fdA8A+E4qUqbs/kYdRRiIqIPiEyc
         3K+2PSlf7sajLogiVSj+Q+Kt0ul8IZ34q8DGingSmauWE6XjJFkf17NxrRWpIoxq7yTK
         9vuTkqrhxA+CM+y76WBWZ94MXjwdLpzBKas91o1MaeH2CimuI2GeIOamO1ZaTF9A6Ku2
         JEzKQKPrTXNIDxV6uA86u104fM+9Vg+OlIylpXJ2DDlQ8isA/eP15gAotp6QbLD+GN71
         0q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JeZEyORbpbC8OP1gdLxPcfnmEy8HHTfhMKkPM9DxN0c=;
        b=P1Vuf5QSafPp4NTx6IyhnffcO9qwCn5Grm/BtAozcw2dJPcOLO84hO0KlBLdBr8bV2
         xFMsbcLvxAl3PwFCRNXTbZe2aMpwGPaikbyDrNBiKcRfOI/ERVlbf0A98EgTvO/U1Sk9
         mE83fiOcnYIXzF5JUXu3DyTf4W8y2W7fpmLH3Cvhtl08/u7lySyOCqLcQtnrefEEoFfs
         OmRXmUmb5MD+kubKgA6I5SCfb8+c5fNBEApXs3kJgbdP9z6VRKbEgDOc484MraiU6fJO
         E0OQAQ49TYgm0PAGoUcHOfh5FLwbtCkpoypJvq2jEFBUI430MXu4zXfmbVaaMo61/0fz
         SRHg==
X-Gm-Message-State: ACgBeo25+blVH0FwqN6mSmtkfX9/NynsUy/15sq5npxqL7vm3Vp+qWZA
        DlcUkIOPuseLJGE5B/vZT7g=
X-Google-Smtp-Source: AA6agR5WsM1aUEvidM8psnqDtCMooZ3J15ziGr1e4OiDRTyxB6xIv6Pt9CEOoqI7VHeWKnvyQ057Gg==
X-Received: by 2002:a05:6402:145a:b0:448:303c:d811 with SMTP id d26-20020a056402145a00b00448303cd811mr16708846edx.414.1661964724230;
        Wed, 31 Aug 2022 09:52:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b00447b1772a26sm9228427edo.12.2022.08.31.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:52:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTQwc-000MAr-2a;
        Wed, 31 Aug 2022 18:52:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johasc@microsoft.com>
Subject: Re: [PATCH 4/8] scalar: implement the `help` subcommand
Date:   Wed, 31 Aug 2022 18:48:58 +0200
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <220831.8635dc9wzx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johasc@microsoft.com>
>
> It is merely handing off to `git help scalar`.
>
> Signed-off-by: Johannes Schindelin <johasc@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  scalar.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/scalar.c b/scalar.c
> index 642d16124eb..675d7a6b0a9 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
>  	return res;
>  }
>  
> +static int cmd_help(int argc, const char **argv)
> +{
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +	const char * const usage[] = {
> +		N_("scalar help"),


This should not have N_(), as it's a literal command.

> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, NULL, options,
> +			     usage, 0);
> +
> +	if (argc != 0)

If we're re-rolling anyway we usually just do "if (argc)". We don't need
to worry about argc < 0 (despite the signed type, which is a historical
C wart).

> +		usage_with_options(usage, options);
> +
> +	return run_git("help", "scalar", NULL);

Performance isn't sensitive here, but have you tried just calling
cmd_help() instead with the appropriate arguments? It would avoid
spawning another command..
