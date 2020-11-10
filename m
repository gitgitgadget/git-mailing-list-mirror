Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649AC4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2B4206B2
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hE9TYciy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgKJNd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731787AbgKJNd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 08:33:56 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31AC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:33:56 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id z17so2112737qvy.11
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TF/xc130A/A/IVFI7az+lHUJDCneVlv2EMsCcx7VXuA=;
        b=hE9TYciyaTQyXRDO/aauGw/blTE9ftX7dc6PKyrxfBHlS89O1xepURwVdk9DTGf0FS
         JRuTYFO9YaH8jKx68vri9NtPggsz7OfkQg8DcvfVLwVQxC3VUcrlgeE7n1GoJDC9RyZO
         aA1PIlbc7AQWFDNn8XAA4CgEVHItpSzEVL+CeX991jekRhjO9UOmzBjQ4WWNIcVgIKuw
         l2z2c2R8/ocYErcWpOJ+cAOl03ojhUyPULTULszr3VzxA3/OuKIW75aEE20X51UVbbNY
         DHLtyIQ/pYD+Y9hrlwdsV/GTx5Psa5Oy6mt3BvSXZe49CqehVMadjS4Mvx2cobFOXvSa
         17RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TF/xc130A/A/IVFI7az+lHUJDCneVlv2EMsCcx7VXuA=;
        b=eYyVX51sUuetJ4gM3+cu1rPqcKRGB18CtqaYZlaLyzbMgiTjnTLCBUg38xQBav0MSv
         vTyF8ib4shwr2Esfq2Bh9H6AW22jgDTgLpTDo/LA4K+Ixp6WB82R9suTu0TSbXEYpbmm
         b7oi2SZEjaeJxaEbIhPG0Isw24FiYbmAGdM0ojrla0SiLpVEWnBk+p8eupoILfFYQE5J
         0PMY2Lnjs5BRlROlIi3PQHANnp3H9R6BO8jZaTzalU2T6pl438miacqSJJKP0jaX37gm
         0BqP8K6cUfJalAhlHmP4NA9bWs0m7Ji04X9vQWFqr4OBQx7bmo3ENTOAZm4P954kX4MK
         6YsA==
X-Gm-Message-State: AOAM5317T90vIXwbBOK/qgCD1XVX5lm3Vp86a8OnicLodA432NH3FYtO
        +rqvHK1J58iZtdFEIyHt+Gj8rQ==
X-Google-Smtp-Source: ABdhPJwlUItNgm7AaMfMV/4BzMpIp0IHoL5yJYDRcuYx/XrY95MdlzFQ67luvi0uV+aXEQEjEK2/TA==
X-Received: by 2002:ad4:4bb2:: with SMTP id i18mr7560774qvw.52.1605015234999;
        Tue, 10 Nov 2020 05:33:54 -0800 (PST)
Received: from [192.168.0.103] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id j63sm4207076qke.67.2020.11.10.05.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 05:33:54 -0800 (PST)
Subject: Re: Request for change 610e2b9240 reversal
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jean-Yves Avenard <jyavenard@mozilla.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CA+phgpFS_MOKOib5+yAE7U2QPMqMD_t+yXhR29UG9aSO4pgk+A@mail.gmail.com>
 <171b9a99-d48a-babe-168b-a7cd410e4635@web.de>
From:   Barret Rhoden <brho@google.com>
Message-ID: <416a4e32-f813-cb7f-406d-30c5d48034b3@google.com>
Date:   Tue, 10 Nov 2020 08:33:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <171b9a99-d48a-babe-168b-a7cd410e4635@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 11/10/20 6:38 AM, René Scharfe wrote:
[snip]
> Reported-by: Jean-Yves Avenard <jyavenard@mozilla.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>

patch looks good to me.

Reviewed-by: Barret Rhoden <brho@google.com>

Thanks,

Barret


> ---
>   oidset.c                     | 5 +++--
>   t/t8013-blame-ignore-revs.sh | 4 ++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/oidset.c b/oidset.c
> index 2d0ab76fb5..5aac633c1f 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -72,9 +72,10 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
>   		if (!sb.len)
>   			continue;
> 
> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0' ||
> -		    (fn && fn(&oid, cbdata)))
> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>   			die("invalid object name: %s", sb.buf);
> +		if (fn && fn(&oid, cbdata))
> +			continue;
>   		oidset_insert(set, &oid);
>   	}
>   	if (ferror(fp))
> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index 24ae5018e8..b18633dee1 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -39,10 +39,10 @@ test_expect_success 'validate --ignore-rev' '
>   	test_must_fail git blame --ignore-rev X^{tree} file
>   '
> 
> -# Ensure bogus --ignore-revs-file requests are caught
> +# Ensure bogus --ignore-revs-file requests are silently accepted
>   test_expect_success 'validate --ignore-revs-file' '
>   	git rev-parse X^{tree} >ignore_x &&
> -	test_must_fail git blame --ignore-revs-file ignore_x file
> +	git blame --ignore-revs-file ignore_x file
>   '
> 
>   for I in X XT
> --
> 2.29.2
> 

