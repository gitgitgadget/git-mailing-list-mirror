Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C642082E
	for <e@80x24.org>; Fri, 23 Jun 2017 19:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbdFWTN6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:13:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35309 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdFWTN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:13:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so8654327pfs.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g3pFCstNmbHCKIfgDXdVkdw3jOfNUZwEX07TrCDjtRc=;
        b=C8wzWPKrygfVMOpqri7Ro4m8cahpBy85L0xMYdXBdmo7NE/1DeZ5RPZ5XsSobVBTkv
         33tNuh2Vg4FfHTAm/jpnyobUWw3Rkp1G0KAeUsPOB+VrCzSvmClTMnW1ij/0AogKFCmG
         35kGEJo0R6EMOo7SLJcCzgJkYDId7W+I8hMQhYdrsJvZmEPuJGyR2WMDA/qpDishdm7d
         oZLmBxhgMLM/3hR3JmFrM/Pc8nyRbVCzCnK/GPTdSWGHvGKk2q/KAQ5wA15I94me4Vmy
         j8f0BsSvN9t3sHYM7JwdHqLUQ3QBVbmj3Rhd/E7F2w990IiWuhRW16bDEwS1Ro8tctr3
         5aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g3pFCstNmbHCKIfgDXdVkdw3jOfNUZwEX07TrCDjtRc=;
        b=X8Xke9ZU3ToTGkwKrO9W64OpWWS8pfLa8H5S/ycrQRUbXpXNA///bdUJ6mzRsAmGHH
         eKE2HCnF8xezIXbI9pfCjYlEFVkPP7ZGCRxCjGk3HuA6hzcHdJ1me4suHNYueE2eVJNd
         mMiOR/3dHM/aHRSixN8RomBnfvNcgXECkeI/w1nh5mEcrDiH3LGywSkQj53foTxPcUiL
         hrLeJrnetCdTux5pxwPzxGIMhWVNIktMVGaL6GCvgZ1H/3FYfq3/Ch3vQpFcK0eccR1W
         LFH/it0Go0qpPFofflS0DayR3LoEu5YUbwGcMbxYDn81EfdQAyRtknoIJQv2h5Q+Mw7O
         EZLQ==
X-Gm-Message-State: AKS2vOx16dvf0zIPBbHiMx0JaGdQ+FAhFaH5Vfes5Efj4eu6BB8mxvS+
        pp4859/2n+Us4Q==
X-Received: by 10.84.214.150 with SMTP id j22mr10638668pli.137.1498245236694;
        Fri, 23 Jun 2017 12:13:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id 66sm11992034pgh.59.2017.06.23.12.13.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:13:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Hahler <git@thequod.de>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] xdiff: trim common tail with -U0 after diff
References: <20170623103612.4694-1-git@thequod.de>
Date:   Fri, 23 Jun 2017 12:13:55 -0700
In-Reply-To: <20170623103612.4694-1-git@thequod.de> (Daniel Hahler's message
        of "Fri, 23 Jun 2017 12:36:12 +0200")
Message-ID: <xmqqinjmecuk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Hahler <git@thequod.de> writes:

> When -U0 is used, trim_common_tail should be called after `xdl_diff`, so
> that `--indent-heuristic` (and other diff processing) works as expected.

I thought common-tail trimming was a hack/optimization to avoid
having to pass the whole thing to have xdl_diff() work on it?  What
would we be gaining by unconditionally passing the whole thing first
and then still trimming?

> It also removes the check for `!(xecfg->flags & XDL_EMIT_FUNCCONTEXT)`
> added in e0876bca4, which does not appear to be necessary anymore after
> moving the trimming down.

The code was conditionally disabling the hack/optimization; with it
unconditionally disabled, of course it wouldn't be needed, no?

I could understand if the motivation and the proposed change were
"tail-trimming outlived its usefulness, so remove it altogether", or
"trail-trimming negatively affects the output by robbing useful
information that could be used by indent-heuristic, so disable it
when the heuristic is in use".

But neither is what this patch does, so I am sort of at loss.


> --- a/t/t4061-diff-indent.sh
> +++ b/t/t4061-diff-indent.sh
> @@ -116,6 +116,16 @@ test_expect_success 'prepare' '
>  	 4
>  	EOF
>  
> +	cat <<-\EOF >spaces-compacted-U0-expect &&
> +	diff --git a/spaces.txt b/spaces.txt
> +	--- a/spaces.txt
> +	+++ b/spaces.txt
> +	@@ -4,0 +5,3 @@ a
> +	+b
> +	+a
> +	+
> +	EOF
> +
>  	tr "_" " " <<-\EOF >functions-expect &&
>  	diff --git a/functions.c b/functions.c
>  	--- a/functions.c
> @@ -184,6 +194,11 @@ test_expect_success 'diff: --indent-heuristic with --histogram' '
>  	compare_diff spaces-compacted-expect out-compacted4
>  '
>  
> +test_expect_success 'diff: --indent-heuristic with -U0' '
> +	git diff -U0 --indent-heuristic old new -- spaces.txt >out-compacted5 &&
> +	compare_diff spaces-compacted-U0-expect out-compacted5
> +'
> +
>  test_expect_success 'diff: ugly functions' '
>  	git diff --no-indent-heuristic old new -- functions.c >out &&
>  	compare_diff functions-expect out
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index d3f78ca2a..a7e0e3583 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -125,16 +125,17 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
>  
>  int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *xecb)
>  {
> +	int ret;
>  	mmfile_t a = *mf1;
>  	mmfile_t b = *mf2;
>  
>  	if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
>  		return -1;
>  
> -	if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
> +	ret = xdl_diff(&a, &b, xpp, xecfg, xecb);
> +	if (ret && !xecfg->ctxlen)
>  		trim_common_tail(&a, &b);
> -
> -	return xdl_diff(&a, &b, xpp, xecfg, xecb);
> +	return ret;
>  }
>  
>  int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,


