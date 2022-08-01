Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A4C19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 11:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiHALhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiHALhd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 07:37:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC4031918
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 04:37:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f5so6969796eje.3
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=uswEtlxyePeoFmvyJ/E4Fp4+HTh/WMojV+/p0hfEvMA=;
        b=gcBSTooTJKMehpQZRc0EGKhhuIXnPWChXJ8OxQDC4mf3iLPpNFDeBPBKYs4cCX2BS/
         UUHXOJxL6pqIN7vHtgmKixxLhGmSBrCNAIq8DwPlgAR9KULHnJ22YGIXOMshQ/t5oL+g
         jI42tyKMlSdgknGbOv4Nt7FJyBEGJeMpwG6mHupmnRUawAK4IZvD9bGvh3x69ODIRuZq
         RPbYTH7T5gF8vwFNP1UD1IHb8fBQG7zv8vH4ep0Vs5gzDvnuGJ7x49dvdnrhWs1ToCQR
         hvdOaS2oP42PGjeBl70f2MArwzL9zq5b2TwY8G7IKDbiDhu6V/I0KX7imUxwiSCLqymc
         VfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uswEtlxyePeoFmvyJ/E4Fp4+HTh/WMojV+/p0hfEvMA=;
        b=hpwPFRWNxgLd42hxsz79rfuzMSNYpey0dffajv4QLjELvEDPzJ/K/DTaa/HJZGPEeZ
         gtvD7pkI9lgGXBwbny+377R8lfjtCS0a43rnQe9/1fMJtQI9gLSVej/dlHsuHDMNkuAa
         +9f7MiI76sVRshajKgRXd1Ca3lyIjs89Yruct8qlx+vgtK3HcwbflaNKIomVwawtcNVJ
         zNwIj6M5V0SkN+gb9IZY7BIGr6DG2SEwk/Lyghq0qrdOncFhYvsFRWwcxRnrXPdvx8K1
         1Az1Lnm1S1+SgRvJYxA4oZI41ZczoHHNrDZkKdDMUKnqZwK8mT9U5F6h8GWZMAZ5tkT1
         FD6g==
X-Gm-Message-State: AJIora/CSNCFoj/3yrsHBLn9tCaJlbuwpZ2HJdxZqwXnMsPVI0INDc63
        HTNmb9YhMyOzKbP8uIrugCI=
X-Google-Smtp-Source: AGRyM1upsSDokK1Zb2mW67/pB38aELbOwbJLD2C9iwq2u21qNcmaGBdcgDNaTiT15Bvoa317j+xqBQ==
X-Received: by 2002:a17:907:3f97:b0:730:1b33:7788 with SMTP id hr23-20020a1709073f9700b007301b337788mr12182888ejc.644.1659353849398;
        Mon, 01 Aug 2022 04:37:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sy13-20020a1709076f0d00b00722d5b26ecesm5044448ejc.205.2022.08.01.04.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:37:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oITji-008keD-Ar;
        Mon, 01 Aug 2022 13:37:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
Date:   Mon, 01 Aug 2022 13:33:36 +0200
References: <cover.1659291025.git.matheus.bernardino@usp.br>
 <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
Message-ID: <220801.86les8i495.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 31 2022, Matheus Tavares wrote:


> +static char *rot13_usage = "test-tool rot13-filter [--always-delay] <log path> <capabilities>";
> +
> +int cmd__rot13_filter(int argc, const char **argv)
> +{
> +	const char **caps;
> +	int cap_count, i = 1;
> +	struct strset remote_caps = STRSET_INIT;
> +
> +	if (argc > 1 && !strcmp(argv[1], "--always-delay")) {
> +		always_delay = 1;
> +		i++;
> +	}
> +	if (argc - i < 2)
> +		usage(rot13_usage);
> +
> +	logfile = fopen(argv[i++], "a");
> +	if (!logfile)
> +		die_errno("failed to open log file");
> +
> +	caps = argv + i;
> +	cap_count = argc - i;

Since you need to change every single caller consider just starting out
with parse_options() here instead of rolling your own parsing. You could
use it for --always-delay in any case, but you could also just add a
--log-path and --capability (an OPT_STRING_LIST), so:

	test-tool rot13-filter [--always-delay] --log-path=<path> [--capability <capbility]...

> +
> +	for (i = 0; i < cap_count; i++) {
> +		if (!strcmp(caps[i], "clean"))
> +			has_clean_cap = 1;
> +		else if (!strcmp(caps[i], "smudge"))
> +			has_smudge_cap = 1;

In any case, maybe BUG() in an "else" here with "unknown capability"?

> +	fclose(logfile);

Perhaps check the return value & die_errno() if we fail to fclose()
(happens e.g. if the disk fills up).
