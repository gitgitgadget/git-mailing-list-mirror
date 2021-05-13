Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD303C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8AD613F7
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhEMHsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhEMHsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:48:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14181C06174A
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:47:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v5so18881349edc.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+gJyusXM6pkxygywtXq44Im8wDNLcUkwRljG/z0R5i4=;
        b=airfuJ3cK2DtlTFscSH9x6V9XcSDrfPnZkNfsT5EthPDu9epojuCyTKvumLjKqEzDd
         qGgsSFl6sK5qrAk80x8ZCHYrCqK9nT43VuYqi9xtXHEnKmFzotDaW+OtCgikk6WlFdkt
         B0N8fFF0DQRXeIkmsVBAf5zM4HeuuK81A5zzKO1UxnfOYdeaQ/Dss4m+7ew7oTMXvzNy
         MCJiHpmKGh80XclMHr4r2Hcr4wpgR/SJdNFwvX3pqk+I0uU2xDG14IY1xj8QB+h0Gqie
         rdFojW5Z2V99VMWRpIOe70RuO5P9NSPO8+T/l9sCugvKT1UFK9kdq8b0mSRznwAWkILB
         662Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+gJyusXM6pkxygywtXq44Im8wDNLcUkwRljG/z0R5i4=;
        b=lfV3/arY1AT73iSirG2sGix1uw/cpcd3HNamHv5pMXkCdsy3kKoBkPoGfntCEfA+b8
         NRMxPwk35IhKrDowUX4QVpkHlbyKCPPI7xAWcmfCCV3b3VCMy3U6d2wJFVYC/xRvLlhi
         vCm0o4G1V2Ty82gYFudPRwtMdobVy9FpO2x7+AeHjr5VXu/HwR6SYxMo0C3gfPcNNQkm
         gABl4gUOrbJKV0ICC/h89/PFrVLpwLkd37NroD4U4QaNTL+az/msXUBmNyqaR2TAi2+V
         peGV5nx7ZcgEtM4ojQFp+uT/itcXkQLgMv382yC1rY6RdgWowUYmd1QkpaGhaMqRgK3m
         dBdQ==
X-Gm-Message-State: AOAM531mOkeMnBoQn3k5nREzeDR2FjkGhg4ekgsdrHeniVJiZELUlRK9
        YfHPSedM+XcJZozZ5mOGBpEP0+tXp9BBQQ==
X-Google-Smtp-Source: ABdhPJznCliusmLVdRbEMsBfffuLy8K/WSXIs7pJU1k4VxrduoeRZP2+Hf/2htaAzRVuiKJMS0Ei2w==
X-Received: by 2002:aa7:c691:: with SMTP id n17mr31796643edq.243.1620892033556;
        Thu, 13 May 2021 00:47:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b12sm1867768eds.23.2021.05.13.00.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:47:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v6 11/11] test-lib: split up and deprecate
 test_create_repo()
Date:   Thu, 13 May 2021 09:45:18 +0200
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
 <patch-11.11-217c5aed491-20210510T141055Z-avarab@gmail.com>
 <609ccaf67710b_3293208be@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609ccaf67710b_3293208be@natae.notmuch>
Message-ID: <87pmxvrs73.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 13 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1243,21 +1243,10 @@ test_atexit () {
>>  		} && (exit \"\$eval_ret\"); eval_ret=3D\$?; $test_atexit_cleanup"
>>  }
>>=20=20
>> -# Most tests can use the created repository, but some may need to creat=
e more.
>> +# Deprecated wrapper for "git init", use "git init" directly instead
>>  # Usage: test_create_repo <directory>
>>  test_create_repo () {
>
> If this is deprecated why not add a warning?
>
>   echo "warning: test_create_repo is deprecated in favor of git init" >&2

Because like test_i18ncmp, test_i18ngrep or whatever this is in the
state of "don't use this for new code", but annoying everyone who runs
the test suite with loads of this output under -v would be too
distracting.

The attention of the developer community is much better spent on one
person doing a s/test_create_repo/git init/ patch than having everyone
see this warning until somebody does that.
