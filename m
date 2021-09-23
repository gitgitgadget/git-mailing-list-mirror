Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA9BC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F9B60F6F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhIWCHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbhIWCHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:07:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FCC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:06:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx4so17585621edb.4
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BGzjV6tRBV6q6jrQQbWKsVWU2mavKCW9BbTOsvsLvUI=;
        b=f3xPe6AuAejc7hMz16nLlujd+yYMT8W72ft/aWiJt3vHtgoyhWNvRs8YVDSoAX2gto
         V9sIjYdWe6o9EtmgWtgvqGdgm5go/r3NcSKEAdCYeTeEcuwGcs7K4dw3ngsLb1UQLvm3
         ltPtnYQelqzLJiYyZlq/APvv0CV51/ZDNsqxFvHhndAw/LdVoFJy0UX/98TUz4hGJhAf
         UFFifIGdMBkRVd6sXu9Tde5KiwBUnlCsdsAAS3imYJqwg3wBR++pUFpFjIU6i2/E4cT4
         8Vr9uCbHbMtrK0ZBJ45V0kF5hAn+uMfDFeLeAAW39d/v6QomXz9XkrdOH9SeHj1Lzd3F
         BOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BGzjV6tRBV6q6jrQQbWKsVWU2mavKCW9BbTOsvsLvUI=;
        b=aoRzrLpqmFEC4tb5oJsklom8TwC9VqoZjJW+lD6KBSW9DUqpMOGiJOrxfNL1kkzvIR
         BfSeRW5RY5jPpcbq4kakdBItMd2Hs2G6HSQFAeY/S3yrlIhy7G99aLwGhQqFbytmgiEs
         L4Hfe+3PQcOXR//vo4ieXF6yDBGjvi1W0+2RXn3owts50h6X3eYKhEAjqju7BRO5HnfT
         O68V43H+0WG4r2PSYuRAQpQhGUHAWsqGS12q04cxjLsyCXRNAWO2pi77RXcJ4/W/kQvT
         GWL/3wrS37OTbeAOh4ttnf7ViG6t/F5TxJGpWxTqW9/jHDCPxDamAVfdS8taE7NLhkNL
         qr5w==
X-Gm-Message-State: AOAM533WPJtn5vV60V1aONruISggwVuLuCTqG0Yp0yz7jYg/+h/2dICG
        P0Mkyg13EHV3dLqpB3i3HHyEk1OHpxeh/A==
X-Google-Smtp-Source: ABdhPJzvRj44T3qGwIxdBua6dpg6TwO9v85HLO7rO5GyQWtvYDwRPr2wPBOnNLVcZqYrB94eKTPKMg==
X-Received: by 2002:a50:da07:: with SMTP id z7mr2676470edj.301.1632362769857;
        Wed, 22 Sep 2021 19:06:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qc12sm1975262ejb.117.2021.09.22.19.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:06:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] fixup! tests: add a test mode for SANITIZE=leak, run it
 in CI
Date:   Thu, 23 Sep 2021 03:50:19 +0200
References: <patch-v7-2.2-56592952db5-20210919T075619Z-avarab@gmail.com>
 <20210922111741.82142-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210922111741.82142-1-carenas@gmail.com>
Message-ID: <87h7ec59m7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> runs cleanly in seen as shown by :
>
>   https://github.com/carenas/git/runs/3673976105
>
> previously failing in the extended checks as shown at at least by :
>
>   https://github.com/git/git/runs/3657308323

Thanks, it broke because it combined with sg/test-split-index-fix,
running the test with GIT_TEST_SPLIT_INDEX=3Dtrue reveals a memory leak
that we weren't testing until then.

Junio: I think just applying this fixup is the right thing for now, are
you willing to do that or should I submit a re-roll with it?

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t0016-oidmap.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> index 0faef1f4f1..f81aa9ea03 100755
> --- a/t/t0016-oidmap.sh
> +++ b/t/t0016-oidmap.sh
> @@ -2,7 +2,6 @@
>=20=20
>  test_description=3D'test oidmap'
>=20=20
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>=20=20
>  # This purposefully is very similar to t0011-hashmap.sh

