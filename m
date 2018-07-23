Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB0D1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbeGXADT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 20:03:19 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:45627 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbeGXADS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 20:03:18 -0400
Received: by mail-yb0-f195.google.com with SMTP id h127-v6so917887ybg.12
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWx03nVD4pQRLqdYjcln5DnbOI3BoYp0ykufGjkWuC0=;
        b=cCPHST77yEFCFzAbdrgOA12ViFWAkCAetIrypRm7Ac9IiVvObRdlYlAz9RPD8BY33t
         RqNEscHmeveYEyOq5a4c9vM6ELzl8O/7SVdAPbawmV1PGuVys5lBLDHRlc500N0CBc3+
         Ied8iGyAEsYXjXI5elApUBzkvOLVymYu3Z4kReKE3v9fAaTQhbaquERGGHmd6Uf5+eOw
         7ZTdoyxE5jIWSsTWlOO71uJ31YO7x6dfsbSY+RLnvId0UlDsQPDSX33V9/N39oK059rM
         hEX0KSMrTZ8yXISQ8pVI1k6OtlW04iwixiujWLFXvV977yi7RNBAjxsedGSWdqJMaaXn
         fW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWx03nVD4pQRLqdYjcln5DnbOI3BoYp0ykufGjkWuC0=;
        b=Up3kUkNuV01arVCIEhptYFnuwNkfhwVRE5iTggqld9wKepz0BUWdyhCwEQ676kdRNP
         GHzlFwjeAby7R5tVZm2QFSLl2KnILeZGNMS6aJSMH26uc+AE4EAyxadSZtRJ4ZQCiY9X
         jM0HD5hAaVuXRKXznbX0hg6t6XEiSGWPQGRWk/IVpBg6x7eiDEDibMNck9CEnaEk9eNN
         xyv9edOvMt/ibhDfYvEgLUH7RaAR+R8J+2f7fJq4xdTrs9QW8P5Cd78zpxKjHtCmB+0y
         kQNX/PvJLMkTrxTeI2f8u0rZCUHny8MmbnM3llQL8uuXOry9ytsIVnyBC0wYks5D7/Xw
         Qltw==
X-Gm-Message-State: AOUpUlFL+Gm8lkP/aWmBCiS2zqIlzmBlKSNAh8jdbhjtMyoauDTxHhKo
        r+XTA4uYP5wxnhCla+MQAa0dcX+rReFec9cIgxwDow==
X-Google-Smtp-Source: AAOMgpdNRRuFn9qIbApeZEqlmWstndEkgrnYM573HTkbdSF0UKaWdWfVRmrINKkwb+wa2glvKnvs0XZ7PbORliczAWA=
X-Received: by 2002:a25:dc47:: with SMTP id y68-v6mr7686480ybe.515.1532386790387;
 Mon, 23 Jul 2018 15:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <20180722095717.17912-8-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-8-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 15:59:39 -0700
Message-ID: <CAGZ79kZ0OMrU_O5_rPdG7bNHRWQxVV1RguEg3g-pOa+kkgPCaA@mail.gmail.com>
Subject: Re: [PATCH 07/14] range-diff: respect diff_option.file rather than
 assuming 'stdout'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 2:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> The actual diffs output by range-diff respect diff_option.file, which
> range-diff passes down the call-chain, thus are destination-agnostic.
> However, output_pair_header() is hard-coded to emit to 'stdout'. Fix
> this by making output_pair_header() respect diff_option.file, as well.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

Depending how much the range diff series has progressed
already, it might make sense to squash it there?

Thanks,
Stefan

> ---
>  range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 347b4a79f2..76e053c2b2 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -328,7 +328,7 @@ static void output_pair_header(struct diff_options *diffopt,
>         }
>         strbuf_addf(buf, "%s\n", color_reset);
>
> -       fwrite(buf->buf, buf->len, 1, stdout);
> +       fwrite(buf->buf, buf->len, 1, diffopt->file);
>  }
>
>  static struct userdiff_driver no_func_name = {
> --
> 2.18.0.345.g5c9ce644c3
>
