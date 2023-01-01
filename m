Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9BEC4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 03:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAADDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 22:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAADDF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 22:03:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4740E62F9
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 19:03:04 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so9156860pll.9
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 19:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDsULaof14bZMZUUC+XMSEsPZ94eEcLySRhMLDNBSCo=;
        b=f6vTVNwDpHvTNP0NkB38xCRTxyevGyaIjYHtfHrAJKDgj4W0XsZ0sJa0uKpVWhTv2Y
         CeHk7roasM2V4GCG/VlHKL3lrtZu1NZmTsi9dFN/VbefdaDTQlcCzMhfeB25otQv44N2
         wN8txsW77qoEQqvX9wRsSkX72W/Uaov8gMf+1/eOz4QuUhiUhK9FPWimSAzkHwV7xjh8
         jRVEN2A+33jcenGw9tpoKpDZyMBFAsOLbLHC6l+OAj64eZQYPfMlPOMOgbR3IEqGW+fR
         BxA8b6njyAw25rlPfeNeFQOygQAwknacSSXqoQIeCJ8k+goJ1rR78t+soAA7+rUCR7B5
         RUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDsULaof14bZMZUUC+XMSEsPZ94eEcLySRhMLDNBSCo=;
        b=esgt5l1equnvncCuWGph2OD2oU+F4F1uit2wHrYqyDXxlkN8w4vQU+L4MpyAWfd329
         eqtIya+ta89MbVwwYygwvlCiXKI8v84TakndCzLc2sftbHegF/V44DxXZpCM33VI9X4N
         K3Mb0JeWfvu5ikJT/uDFPF8jLkGhmq337Tr/Trj4IPgSUHbq5aJmrMhKtHkOD8710+bU
         gujWU5hfeQ9pqWNWWHFa5lzrjwkUWSLr+A3naBBD0A5CNwcdHeoUgnYNizhbevyxvgJQ
         vmsEPYhfWeaDdLRh/DZZHvC4vBySbn/KnuTkWUgRq3h8rNqTDSZJITW6UO/Q22/2dLpC
         w87g==
X-Gm-Message-State: AFqh2koyAveujAJQGHSRlnp/3K/0PloPFslOVSZnJMh4ioihxrQUhq5z
        BBb2zwR6/zTyHgWQxQjoxAM=
X-Google-Smtp-Source: AMrXdXsijDXzZokwUYOTuQU41NVRDDWLh8CSDp1JvJWI85Ca9QRyC7e2DhdVJZ1eaDNrNpDnUvn4aQ==
X-Received: by 2002:a05:6a20:2d99:b0:af:c871:c723 with SMTP id bf25-20020a056a202d9900b000afc871c723mr41645240pzb.33.1672542183588;
        Sat, 31 Dec 2022 19:03:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x124-20020a623182000000b005779110635asm16095177pfx.51.2022.12.31.19.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 19:03:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
        <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de>
Date:   Sun, 01 Jan 2023 12:03:02 +0900
In-Reply-To: <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 30 Dec 2022 22:56:44 +0100")
Message-ID: <xmqq8rinhs7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Extend the element size comparison between source and destination with
> a full type check using an assignment.  It is not actually evaluated and
> even optimized out, but compilers check the types before getting to that
> point, and report mismatches.

It is not actually evaluated and is (even) optimized out, which is a
neat and clever trick.  The above made me read it twice, though, as
I misread on my first read that you are saying that the code is left
in the binary but in an unreachable form (i.e. "it is not (evaluated
or optimized out"), though.

> The stricter check improves safety, as it catches attempts to copy
> between different types that happen to have the same size.  The size
> check is still needed to avoid allowing copies from a array with a
> smaller element type to a bigger one, e.g. from a char array to an int
> array, which would be allowed by the assignment check alone.

Do you mean

	int *ip;
	char *cp;

	(0 ? (*(ip) = *(cp), 0) : 0); /* silently allowed */
	(0 ? (*(cp) = *(ip), 0) : 0); /* truncation noticed */

Presumably we cannot catch
	
	int *ip;
	unsinged *up;

	(0 ? (*(ip) = *(up), 0) : 0);
	(0 ? (*(up) = *(ip), 0) : 0);

with the approach?  I think what you ideally want to enforce is that
typeof(dst) is exactly typeof(src), or typeof(src) sans constness
(i.e. you can populate non-const array from a const template)?

>  #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
> +	(0 ? (*(dst) = *(src), 0) : 0) + \
>  	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
>  static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
>  {
> @@ -1102,6 +1103,7 @@ static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
>  }
>
>  #define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
> +	(0 ? (*(dst) = *(src), 0) : 0) + \
>  	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
>  static inline void move_array(void *dst, const void *src, size_t n, size_t size)
>  {
> --
> 2.39.0
