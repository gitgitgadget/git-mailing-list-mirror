Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104E1C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 23:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLAXGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLAXGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 18:06:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E75B2779
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 15:06:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id td2so7785863ejc.5
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QqMav/w4uGx1vPjzvo5DQszhoG5xriDS8JJEFSHbsUs=;
        b=i3Q+mXGchWRYp2NKhM5vuNrZGZqAljZR6oRyG3OEZ893718W0UbFq7qZnT6LUkC0X9
         BcKAKfZCrkNceaVD9e8whQ1Ej+PRj222v2NPMxfZQMuj8xC7KMhAvg1g48DVjmlEzVUN
         0RAOgCWBLDrgapbRfjLqBO9uxr0Xy0VstPL4KX0BsyZmHSdsrGoFVjcbMHDdBDfvd6il
         MSDrc/Hd+g2J+a6nHLIbd1ed3Cw6rMfz1+sgbhK3/Q/+vp+kbDZr17P/FHX+zThXcYsW
         Q1JMqieeF+eA6SkXLsIryzIO0/5FZ+g/L4fUDS97YSu8MLf8kV99KMy88QnWPoeSLxGD
         sN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqMav/w4uGx1vPjzvo5DQszhoG5xriDS8JJEFSHbsUs=;
        b=W855C8VD+cDrliBRH7PlmlIhGaasDmlqi5kqzje/qnLHXYXDX2QHN6js3uTEZRzm/2
         VfHTZbLulznELkaHU2NDPFYQh41C4Ag6bSMU9tSAF4X/EOQTIBv/VA5JwbGB4wWySdHR
         y/RfU0l2yoEWvkhiZPJmLfd2y+8F/ss81SxYGa8yxsCxn7Aka25kDlMCCxcf+u15lqIC
         vPn8vxSdguZ9/0Usxg+DctCswxYCQGw1eFYe8spCy0NvLwgWPBKP3N8MZVwo3N6fuAUb
         9dLRo8FSvdWdlkQYPcGxCqM1nSl02wQK3ITIN0jthGIZ2dFb5pG1oaxpbGRICzB8aP0r
         f1Jw==
X-Gm-Message-State: ANoB5pldgzbXv8rOumhVf8c6G6TJczceknDNT3EtT7oZGrVZU00x6OBr
        Re3gYWQsQKxQCU2yc230qg4=
X-Google-Smtp-Source: AA0mqf5+p2AuskgY4s92A7Yc5zt7SYrnv5NXFA0G57388I3OE76Jb4ZuX5bDp4QtS797thZCm1cvCw==
X-Received: by 2002:a17:907:7611:b0:7c0:9bc2:a7c8 with SMTP id jx17-20020a170907761100b007c09bc2a7c8mr8961703ejc.384.1669935990427;
        Thu, 01 Dec 2022 15:06:30 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906a00800b007ad69e9d34dsm2327782ejy.54.2022.12.01.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:06:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0sdR-002LQI-10;
        Fri, 02 Dec 2022 00:06:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4205: don't exit test script on failure
Date:   Fri, 02 Dec 2022 00:05:45 +0100
References: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
Message-ID: <221202.86edtihgga.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 01 2022, Ren=C3=A9 Scharfe wrote:

> Only abort the individual check instead of exiting the whole test script
> if git show fails.  Noticed with GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Formatted with --function-context for easier review.
> ac52d9410e (t4205: cover `git log --reflog -z` blindspot,
> 2019-11-19) added the exit call.
>
>  t/t4205-log-pretty-formats.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index e448ef2928..0404491d6e 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -154,12 +154,12 @@ done
>  test_expect_success 'NUL termination with --reflog --pretty=3Doneline' '
>  	revs=3D"$(git rev-list --reflog)" &&
>  	for r in $revs
>  	do
>  		git show -s --pretty=3Doneline "$r" >raw &&
> -		cat raw | lf_to_nul || exit 1
> +		cat raw | lf_to_nul || return 1
>  	done >expect &&
>  	# the trailing NUL is already produced so we do not need to
>  	# output another one
>  	git log -z --pretty=3Doneline --reflog >actual &&
>  	test_cmp expect actual
>  '

This is also 6/6 in this series to submit a bunch of these sorts of
issues, which I submitted back in July:
https://lore.kernel.org/git/cover-0.6-00000000000-20220721T064349Z-avarab@g=
mail.com/
