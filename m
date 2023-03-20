Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C926C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 18:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCTSYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCTSXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 14:23:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A81C5A3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:16:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso17348136pjb.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336188;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J20TUR6PUemHKjuDcCnulHb+pIyoxPkIffT03f1sj9k=;
        b=kWZR+pwrnTKAwu/VpFE474o781XYQsp+ze2wf8ux+7AyFPQ+UsvmISJKAmDoLo3gPc
         Ry7AanmftYeIqBG40nYgyln9hERlGRtJtVMWl+Iy5/UXn7YH+FzToAA/cumonnCE4ITj
         8xEt4UUvMLsIHpJ39YB20A58CqSqpe8YsiZEOehUBqmsDiw51xuGwVatPpqzgtWXtLSU
         L9lB+KYbqKJlRUDuC6Ch/3ZcdVObfENdtgIdmmJaGAW+o7SaU9excMW23SCUMWfwcEa5
         KhM1OrmDrW4yfFhQm7Ar5e9r5A4WiRMmrfX+rwlGjqY8jMxLaxTyPigZyf5//3pQp0VD
         +YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336188;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J20TUR6PUemHKjuDcCnulHb+pIyoxPkIffT03f1sj9k=;
        b=jYV8iCLtywg7rW2oewrwmjXSadCwQOrevEDiQGHq5PNfGZNSsU19OoJEY2A2tkWQEa
         W8gjEMuw3p6m20x85Y0/f3pNnspN0B+YGqYHNT9MA/QJQ+Bqpc9GVGe25cW4N7r4xlu9
         AoCBLsgmSe/FGW8BcU252qy6cWaO8//HEHe5mZ/6/G1Zk7+xhpGZmgwv87+0TNV50C1X
         ol8/mOrdXsnbXyDGI8H39Ape5d67odpBjWFlOY+zVz73o1Uk1Vp1HqalktUjJ1zXUNTt
         hd1M5Lpb0wT4Eh9FYt6vp7cbHWl4T3vdTMS8SSz6Jn2ID2XWUwD9IeNgnUplWSrhidYb
         /Tpg==
X-Gm-Message-State: AO0yUKVpWZuu3SsqnsZ9wQ+I2Q25trVh1FlvZpCb6QtUdZnt4mCedSF6
        DiuYGEDzpANE5Ei3Wgcm4oA=
X-Google-Smtp-Source: AK7set8hz45Yy5j7zdLzlv3HKh+9SChjXAeeA1Rp31/pTlRqoaQWNayoL9OEeh5GPvoM2QrsqxSZ0Q==
X-Received: by 2002:a17:902:ea09:b0:1a1:d0bd:6e5a with SMTP id s9-20020a170902ea0900b001a1d0bd6e5amr5510980plg.57.1679336188167;
        Mon, 20 Mar 2023 11:16:28 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902b09400b0019c2cf1554csm7046560plr.13.2023.03.20.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:16:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse-options.h: rename _OPT_CONTAINS_OR_WITH()'s
 parameters
References: <20230319165648.656738-1-szeder.dev@gmail.com>
        <20230319165648.656738-3-szeder.dev@gmail.com>
Date:   Mon, 20 Mar 2023 11:16:27 -0700
In-Reply-To: <20230319165648.656738-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sun, 19 Mar 2023 17:56:47 +0100")
Message-ID: <xmqqr0tjl24k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Rename the 'help' parameter as it matches one of the fields in 'struct
> option', and, while at it, rename all other parameters to the usual
> one-letter name used in similar macro definitions.
>
> Furthermore, put all parameters in the replacement list between
> parentheses, like all other OPT_* macros do.

This step when taken alone smells like it is going backwards in the
readability department by going from a set meaningful names to
another set of more cryptic names, but together with 3/3 where the
designated initializers clarify what these cryptic args with short
names correspond to, the end result gives us a pleasant read.

Thanks.

>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  parse-options.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index 34f8caf369..7e99322bab 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -381,9 +381,9 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
>  	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru }
>  #define OPT_PASSTHRU_ARGV(s, l, v, a, h, f) \
>  	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv }
> -#define _OPT_CONTAINS_OR_WITH(name, variable, help, flag) \
> -	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
> -	  PARSE_OPT_LASTARG_DEFAULT | flag, \
> +#define _OPT_CONTAINS_OR_WITH(l, v, h, f) \
> +	{ OPTION_CALLBACK, 0, (l), (v), N_("commit"), (h), \
> +	  PARSE_OPT_LASTARG_DEFAULT | (f), \
>  	  parse_opt_commits, (intptr_t) "HEAD" \
>  	}
>  #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
