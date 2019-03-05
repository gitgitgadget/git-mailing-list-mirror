Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6507520248
	for <e@80x24.org>; Tue,  5 Mar 2019 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfCEPm6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 5 Mar 2019 10:42:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40887 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbfCEPm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 10:42:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so9995327wrp.7
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 07:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ai4nqhGngIMoJy8JCX4f1wkdyl/Rk1S+7Xq3CV2bITI=;
        b=bnIjG4A8nT0SK9qTw4axKAGzC0SNnz5FrTOueGDKmn5gYOY09gqe/e2Q0UdIpHv1Yp
         oc/bxKv3PJHW77TQKaR68yK4JltmCHd9dpiZcqNtAM4FwnDY3S59EFQdW2bxCLmfLVjh
         6DYvcI5Hq7Ogz/RaRfMQtapIsNsuks6a6mwayyBs7bW7UImZ3G4mWJTxfXuSToIVjCxm
         OqUVhbjlJgjw2gXm3/jBY/K7W8tbux1Qjrh0UI+lUcLRUtZ3M7gNListbnwZsVoAyJR+
         6FIhdjCvcyTXrCHgZrc8J7/jKDxjxwBiRZIfV9cuczyRDs/MA7COuW1QZ4IVmO/4bqeP
         My7Q==
X-Gm-Message-State: APjAAAXeiB+EDryb1Y/vB/T/2bjQRGtwufn+TVq/4Dz4Yq3hi6yMu4xl
        cLR77bu1f8DaBf/UsSbkucZ2qEmy1tdQS5sCa+c=
X-Google-Smtp-Source: APXvYqzvUDFqmVvTJMYaya2qMoLfI130if12BPkl9I4qdSprbxdVDKNbPMVzVeWrqlKvnHqN/Y9eVScDz9PFdqjkfeQ=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr16483541wrg.217.1551800576464;
 Tue, 05 Mar 2019 07:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20190305123026.7266-1-pclouds@gmail.com> <20190305123026.7266-17-pclouds@gmail.com>
In-Reply-To: <20190305123026.7266-17-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Mar 2019 10:42:46 -0500
Message-ID: <CAPig+cR-efk5esa9=5j+Fu0eWxAkFnohkSL4eabrP44K_AkdCg@mail.gmail.com>
Subject: Re: [PATCH 16/20] diff-parseopt: convert --quiet
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 7:32 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> diff --git a/diff.c b/diff.c
> @@ -5299,6 +5299,8 @@ static void prep_parse_options(struct diff_options *options)
> +               OPT_BOOL(0, "quiet", &options->flags.quick,
> +                        N_("disable all output of the program")),

As a reviewer, I was wondering why you didn't use OPT__QUIET() here, but...

> @@ -5348,9 +5350,7 @@ int diff_opt_parse(struct diff_options *options,
> -       } else if (!strcmp(arg, "--quiet"))
> -               options->flags.quick = 1;
> -       else if (!strcmp(arg, "--ext-diff"))

I guess the reason is that flags.quick isn't necessarily about
verbosity/quietness.
