Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB09C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349779AbiHSSFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350315AbiHSSFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:05:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BE1D0F6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:52:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs25so5994372wrb.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=Xy52PRACUVRAi/EeL5U14+2V0g7yxYaQLc34AKUVqN0=;
        b=FDer6sqej5MSbC6D2JEdKut/dWWmeOlwMA4zlO8tjlZRAzigveI9EXbXB7uilOkee7
         frLvsPGtjmbI6YJmi3gHfxyggu89VMzZVGpA8f+0fd9HsMTKiFPXF/n/zkSO35AK9OIh
         2+knKZyGIpFZHA784K9BTXqjSPeH8eeoXW+ZidGKv1uszNSBsJHxeZkD8FO7Pw4sxzUA
         nyMIsmV5cztzD0ljvn3A/o3h1Y89SK3G/2Kmu35/8GOB4Jopw1JPK9caHX06b/pvNAN0
         LW9UIg8skeWTjs7E/VkUiq26PVQmcVWZJhvpSMqxzOrDTxN5F234dbDkZ3H9GP59/U41
         SUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Xy52PRACUVRAi/EeL5U14+2V0g7yxYaQLc34AKUVqN0=;
        b=Y00EU1QXFpV6uc8CxN+y/LHZU0Syhp9cj8/P51zswmNbQxvrTCpoq0qMF+oVIpGor7
         U7oP1qYdLhKCrhOkVfE6pnlzeX2p+H++ybLbf4hCkL2tXouwkgE8rxxlPiuAYlYllsmT
         B118p/8aA7nnMSaOO+YSRA0U1ZU2s/WHQZrzlzntzb7knmq/I0eq5zuP2CPgsawNREzK
         CbqKj922VmoWFeol+7q508N8bZd+ds06cn1HO2oPzB6sy8kHiwze2I3+XQLGQZUciXJp
         AkyIdQ5Y7QA8XuKj40Uag3+fB/L6OFPNT6T4Uf9HCPFeIkh/p1CnWDSLFT+qIIQKlW/O
         cFLA==
X-Gm-Message-State: ACgBeo3C5bCs6FF+QEbzFEE9dEX3T/EGTzHb1um8H6rFMh+i/UjKOyQC
        MMF7FLAnqNUxx19DVudAOpU=
X-Google-Smtp-Source: AA6agR5DxReBKapAtlRKhtS587zxIgPQPwNdV6kZ6+KMStUsGSQpmmlPaQG72mtyzTlvvdZzZY5pOw==
X-Received: by 2002:a5d:6348:0:b0:225:2ec7:81d9 with SMTP id b8-20020a5d6348000000b002252ec781d9mr4996897wrw.693.1660931533227;
        Fri, 19 Aug 2022 10:52:13 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm11432311wmg.5.2022.08.19.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:52:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP6AF-000ph0-2F;
        Fri, 19 Aug 2022 19:52:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/20] builtin/bundle.c: let parse-options parse
 subcommands
Date:   Fri, 19 Aug 2022 19:50:03 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-11-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-11-szeder.dev@gmail.com>
Message-ID: <220819.867d346rzo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:


Nit: I wouldn't mind keeping this variable:

>  	};
> -	int result;
>=20=20
>  	argc =3D parse_options(argc, argv, prefix, options, builtin_bundle_usag=
e,
> -		PARSE_OPT_STOP_AT_NON_OPTION);
> +			     0);
>=20=20
>  	packet_trace_identity("bundle");
>=20=20
> -	if (argc < 2)
> -		usage_with_options(builtin_bundle_usage, options);
> -
> -	else if (!strcmp(argv[0], "create"))
> -		result =3D cmd_bundle_create(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "verify"))
> -		result =3D cmd_bundle_verify(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "list-heads"))
> -		result =3D cmd_bundle_list_heads(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "unbundle"))
> -		result =3D cmd_bundle_unbundle(argc, argv, prefix);
> -	else {
> -		error(_("Unknown subcommand: %s"), argv[0]);
> -		usage_with_options(builtin_bundle_usage, options);
> -	}

Then just doing:

	result =3D fn(argc, argv, prefix);

Which would eliminate the need to change this:

> -	return result ? 1 : 0;
> +	return !!fn(argc, argv, prefix);
>  }

I wondered about why !! v.s. 0/1 for a second or so, but realized you
were just golf-ing an existing pattern.

FWIW I *think* if we're changing this we could just make it "return
fn()", as the functions themselves seem to return 0/1 or a !!'d
variable.
