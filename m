Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB9C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 17:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352258AbiHSRwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352397AbiHSRvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 13:51:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDCA2AC56
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:25:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n7so5929434wrv.4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=ATuFmKmG2wuZbyuAQZfq6Z5gdc1L3NIX93jAEayQKzI=;
        b=XcdZB4kwC0DBL4rugHF1MfssqRqX+iYqqTeWl+pqTh81cb6GMHscfDTZdEwbf9Bs8W
         2ubhpxFE+JyrsdafwKSjLvw3s1LzEXMO+lW+teiAtWjgT6/PBESJuMZkNeUd/C9H3X9M
         40PUWZ6cL2+v3/rEu87lCEAkZ62bz7GvzQd0Ay+1iZHx9t7jJOgeYZ0nYc0muypOB32F
         tp5qgzJbWK1FZbozx/uZeqJOVn1I2Z6YghxtixFqzF4siD4dPVc21hlCA/G83j/Dr3uJ
         zTMOgbenXzgKeNmZnOwpIt8a1ZLmH7ksKKUNxz1l8aF6kdb0j6Ricg7T9MiIfgnvNzy2
         KzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=ATuFmKmG2wuZbyuAQZfq6Z5gdc1L3NIX93jAEayQKzI=;
        b=ePNfxZ7mjr3dbLKSdm9WKMfybeRbgSFlTr82OHeamZlUCGg8SgnCM0gek4sp4c33tS
         QSUzxjWNN+BN6OH+WN4gh9s1CMxulLq2V5CK8MdCN9QHkTZApjEpx0ZUOQ3xyNJHqVnF
         E2oDBsiLn5ORXsipXMeQcFmqxttAlQKtc7f5pkw9nk6EgY8E3PiaVjg54+jpuvGo3p1q
         0/f12ubJSdMQ9wVO7PvdqEPu9JBl3IoHTm9I+hlo1So7Qvu1wBsSi3nLGuAvoiHAeFpf
         OabARv3CIu/7ZGKQl3vqmfXdjjydfl7KclK1cpLsljXEfzHFuMko43jkz+NYZXxO2yrE
         rtCw==
X-Gm-Message-State: ACgBeo2YuFgPhZ1kwQj1oRdjegGIoXnoBbGpqnpFHXhDSLJxp9ThPglQ
        qYctap0WAa4vtS1q+XcgQSU=
X-Google-Smtp-Source: AA6agR4GCZaU8nGXMMdXovt8qvWWmlycyVI+tT+dLBoDAcBVOC5RyD/BiTgeHgmTyoq6rqsSfQq0pw==
X-Received: by 2002:a5d:5601:0:b0:220:7144:2938 with SMTP id l1-20020a5d5601000000b0022071442938mr5084406wrv.50.1660929942685;
        Fri, 19 Aug 2022 10:25:42 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a540fef440sm9694885wme.1.2022.08.19.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:25:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP5ka-000ovs-1p;
        Fri, 19 Aug 2022 19:25:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/20] t0040-parse-options: test parse_options() with
 various 'parse_opt_flags'
Date:   Fri, 19 Aug 2022 19:23:44 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-5-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-5-szeder.dev@gmail.com>
Message-ID: <220819.86k0746t7v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> +	for (int i =3D 0; i < argc; i++)

See
https://lore.kernel.org/git/CABPp-BHvQwct2WRRYGyzm=3DYVkjmwBqoe1DUtCicuQW=
=3DjrQ2hdA@mail.gmail.com/;
but maybe nothing to to be done here...

> +	if (argc =3D=3D 0 || strcmp(argv[0], "cmd")) {

Nit: !argc
> +		error("'cmd' is mandatory");
> +		usage_with_options(usage, test_flag_options);

I think you want usage_msg_opt() instead.

> +test_expect_success 'NO_INTERNAL_HELP works for -h' '
> +	test_expect_code 129 test-tool parse-options-flags --no-internal-help c=
md -h 2>err &&
> +	cat err &&

Stray "cat", presumably in error..

> +	grep "^error: unknown switch \`h$SQ" err &&
> +	grep "^usage: " err
> +'
> +
> +for help_opt in help help-all
> +do
> +	test_expect_success "NO_INTERNAL_HELP works for --$help_opt" "
> +		test_expect_code 129 test-tool parse-options-flags --no-internal-help =
cmd --$help_opt 2>err &&
> +		cat err &&

ditto.

