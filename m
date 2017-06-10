Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91371F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 04:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdFJEwp (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 00:52:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35509 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdFJEwo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 00:52:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so10510650pfd.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=03DDU4wGiytiJo9t7li63YZ+9Xx6QBlDa5/0uNfxrdM=;
        b=CJSm0SKibVxYHMFEGcSBY1VHKipuKtKpjGA6FD5WSaAVB01XZv5WuMaYkZKPi3Kskr
         YHIr+ZxaFc+zkKnCak906lHFjpaXFLJU3u+jYXm0Sd9oI4BCARRBd//CUeWI3K4cTsZ7
         ah1U07iv9c/VUQDAJRJp+6yjWRXoAyPQWs38i5YXbG5CR4htLPQHKq7mNEqtJ8qiUkgd
         Xtf2I6ncP0n8c2+Wo+i0lKIhkTXJJ8mWr5SrfAUGlX3BPTLtMOpR6aRDLpdgI2JU+YR5
         7k1Pvi8mar+584HdaboBiOWJyMzI4Dt0BV3zzAbqUnOUbjVmUQnvdoPwh1ycCtF/mwSa
         GYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=03DDU4wGiytiJo9t7li63YZ+9Xx6QBlDa5/0uNfxrdM=;
        b=OiUYV8DFFHYkACvkUZowaaGlylT6N1Kifk7DZpkSNmjifGuM2NlyBlmT6BzAKS9eeg
         CgP8GVM+Rxy7uTxBA4wJlMNsN5fJBmcutaRkk5+HkaueDF8IW9Bz8Vx6qKYMee5W1GBq
         nj2oKmqbokPuT0llYSTqWR9AIysRL1is6vFE9ywFrTL2ydl4mtHg1yhSdD9ZZ0/n8F0R
         dEtACFbZivA3MLpLNX66v0939OcM+gF8zX0W5uFshFG8uFH9bYbligFRNPdkP9ZZ0j3P
         XLHDsLifxHr1E+6TtM8kjyipInsuTyf91jyehLprNWH941hnilGMv4mzTnmm9Z+Iw0Qn
         I2aA==
X-Gm-Message-State: AODbwcC6+ROF2BGl6OvhxsqLksomqEwUR0B+afTBz6eLSPeK9gxq8qSJ
        7ZnSy9pgQcBBMMDKKkY=
X-Received: by 10.84.241.11 with SMTP id a11mr45126530pll.117.1497070363267;
        Fri, 09 Jun 2017 21:52:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id z79sm2746964pfi.43.2017.06.09.21.52.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 21:52:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCHv2 3/5] revision.c: stricter parsing of '--early-output'
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
        <20170609181733.6793-1-szeder.dev@gmail.com>
        <20170609181733.6793-4-szeder.dev@gmail.com>
Date:   Sat, 10 Jun 2017 13:52:40 +0900
In-Reply-To: <20170609181733.6793-4-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 9 Jun 2017 20:17:31 +0200")
Message-ID: <xmqqy3t030mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The parsing of '--early-output' with or without its optional integer
> argument allowed bogus options like '--early-output-foobarbaz' to slip
> through and be ignored.
>
> Fix it by parsing '--early-output' in the same way as other options
> with an optional argument are parsed.  Furthermore, use strtoul_ui()
> to parse the optional integer argument and to refuse negative numbers.
>
> While at it, use skip_prefix() instead of starts_with() and magic
> numbers.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  revision.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 2f37e1e3a..68531ff5d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1785,16 +1785,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--author-date-order")) {
>  		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
>  		revs->topo_order = 1;
> -	} else if (starts_with(arg, "--early-output")) {
> -		int count = 100;
> -		switch (arg[14]) {
> -		case '=':
> -			count = atoi(arg+15);
> -			/* Fallthrough */
> -		case 0:
> -			revs->topo_order = 1;
> -		       revs->early_output = count;
> -		}

This shows how correct patch 1/5 is, huh?  It's kind of surprising
that nobody complained about the breakage since May 2011 which in
turn makes me suspect that early-output might not be missed if we
dropped it someday, but that is a separate issue.  This series makes
it work as the feature was envisioned to.

Thanks.


> +	} else if (!strcmp(arg, "--early-output")) {
> +		revs->early_output = 100;
> +		revs->topo_order = 1;
> +	} else if (skip_prefix(arg, "--early-output=", &optarg)) {
> +		if (strtoul_ui(optarg, 10, &revs->early_output) < 0)
> +			die("'%s': not a non-negative integer", optarg);
> +		revs->topo_order = 1;
>  	} else if (!strcmp(arg, "--parents")) {
>  		revs->rewrite_parents = 1;
>  		revs->print_parents = 1;
