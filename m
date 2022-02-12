Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112D6C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiBLOYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:24:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBLOYo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:24:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B139D
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:24:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id e7so24307054ejn.13
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XOwJRSOrg10hZHxYKC+Wyvw1Wh0f+sbGKt5jX7/NRPM=;
        b=HQHT1SLo9uAqvMYQboSNAdL8eQ2OypWhtwrZfB5VWJXQfS64XPTH4cGPuwq6a2X2se
         9he9xIAk2/eWK2BoD8527STsKl33SeOZcfuI5TWzZd9VBm16sYg7F4Y6okWVhOphizhn
         P7aV8AaghYkzjVVMnz9PAnUc9T2cbdSdevHGZWGIXXCh949Z9mjuMkBt3Xl+n+YQt5AX
         2XwaD9jKKn/5MABqbDkR+7VxNhta1JI3P7/k+uyPlZkWrdTfyx3YePsBWXoVYec0OUV8
         8oLVSUaJihAk7Su97Bx/PAgfUS4xwX8ExNrcK8OIOgM61rf/+vNNmMyJ/zLjVwxHy8VP
         rqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XOwJRSOrg10hZHxYKC+Wyvw1Wh0f+sbGKt5jX7/NRPM=;
        b=4F3rfn1Ihz1oK0hMq18UXNakKOPalpBZEYWxv3U9fYHB8EW6ABuLA2NtZjPAAqNDGE
         piN6QjNsKX4kPngjDDG8I2GHM3P3Cm2E/J2/DOD4yLldqwAF0Quwdq2hmngnEoXgKNKP
         XTMapjs2fDNAgraWt0i3hSlTngWcheJ+2FE5s3bflWhgwMcv8YcLW5GnSSqT7hGGspPN
         wwahZdUcLJ+KLJePjHGbsViHZEJokmDAuUdiMY7rzWptFsAs+YMs8fk42lyRLaZHJoIA
         qSWgbndDSuS5K/ntGn2ZB7OSoG6mgm+flORZM3Yz+9i+s5mzDTvf31obv+rwaDwatZRq
         ZHEw==
X-Gm-Message-State: AOAM531taCHcNFNjwW3GzXAISkEOlQM/KksFOGGccAPNkyG+6+vngoOb
        rDDPq/LXfeZ7uU5AlQkP/0FKPvskiwQavA==
X-Google-Smtp-Source: ABdhPJwQnQzxLQjgu1FL1S0b+LOcH3ZNKtS8l6zkjd4ONvRYqfB7HwxD9TtEnurFjYdqswMqT3aMiA==
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr4952399ejc.704.1644675879019;
        Sat, 12 Feb 2022 06:24:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eq6sm7980517edb.83.2022.02.12.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:24:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItKH-000R7h-Kh;
        Sat, 12 Feb 2022 15:24:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 02/20] submodule--helper: refactor
 get_submodule_displaypath()
Date:   Sat, 12 Feb 2022 15:24:11 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-3-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-3-chooglen@google.com>
Message-ID: <220212.867da0yxga.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> From: Atharva Raykar <raykar.ath@gmail.com>
>
> We create a function called `do_get_submodule_displaypath()` that
> generates the display path required by several submodule functions, and
> takes a custom superprefix parameter, instead of reading it from the
> environment.
>
> We then redefine the existing `get_submodule_displaypath()` function
> as a call to this new function, where the superprefix is obtained from
> the environment.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4c7c1e1432..5efceb9d46 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -261,11 +261,8 @@ static int resolve_relative_url_test(int argc, const=
 char **argv, const char *pr
>  	return 0;
>  }
>=20=20
> -/* the result should be freed by the caller. */
> -static char *get_submodule_displaypath(const char *path, const char *pre=
fix)
> +static char *do_get_submodule_displaypath(const char *path, const char *=
prefix, const char *super_prefix)

Nit: overly long line (also in my v5, but since we're applying some
final polishing touches...)
