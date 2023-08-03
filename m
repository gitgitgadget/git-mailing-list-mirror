Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50F3EB64DD
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjHCPYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjHCPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 11:24:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480ED3581
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 08:24:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-585ff234cd1so12005817b3.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691076275; x=1691681075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mg/DTpNsz1/xqOo6V60pfhLXRsqeNtezn9gw/MKFv0s=;
        b=MCNXOEGANV0S8gq8+MgAPAFODc6eW/EMheAFM8/NJQqxNmSDcEISRocKRQeDgM+MWR
         Xh7bVFiIb4+imcJ2zxft/RSLnpOJfRf3c8F+99fbzeD2t7X/UU4LDIprcbMQEHMUb9r7
         wNchzjnottFrQXZ1dc7AlZ3mPXljD/D1nB4at26G9Sz44uAEIwDqUZhDC0nsf6vy8/yn
         RFn5SYi3RrjxbR2QSSwZMKrja2hohgiVIp/oNPEujVss9TIsPJYsrj1SWbc3AgFpAcl3
         rqebI+LueoHPTOe9g68iV23b7adi8FHJJnoSpSr7fxtOO6AGmI7HB4KOT54OLqfr6NJh
         ZE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076275; x=1691681075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg/DTpNsz1/xqOo6V60pfhLXRsqeNtezn9gw/MKFv0s=;
        b=aLZBOC3bWyzZDHrpiw9G2F6W6Arii/LNqvGK1bGfh6HOn0MyUXQmuU2d6yIPW8ax/0
         GkccaNEQVi0IhQtAbF6zBr4GDX+Rtr5bYe3wfMXHYPmPKuK1r21sWmJ5eXHozjEmikBL
         WUXbMZS5dSEULvCzJZ0/mlMjMazhTMfEnXcVx/UuTtUz8/xYSJHvp1rvm1VY1EeOiFBW
         MMFbOsKH/y7qyWMGE9yc6NSnmc/zqzwIos8phPPBYM9MO6dIvmr2R2bhITpg3bellIf5
         0B91xoPc7woS50QIpXJu8p2JaE/SIBjFJ2o2y/ONA5xgfT0vpClbSZ9s+XFOtUlsCpJU
         QQ4w==
X-Gm-Message-State: ABy/qLYBRTpeS3fKIbfaTG6SvyqvVwG2bO/qjjsbH8BtPX+l3b6Z6NGa
        78vcEqT5Uv+MIbAWcZs6cejpxg==
X-Google-Smtp-Source: APBJJlGD0cdjcd22UOk19pUTAsZq3CurvCXWtEpurAak83WPsRidz4ew0bP5Xk+Xl7LREVXbaJrzNg==
X-Received: by 2002:a81:9152:0:b0:54f:ba89:225d with SMTP id i79-20020a819152000000b0054fba89225dmr20456193ywg.19.1691076275487;
        Thu, 03 Aug 2023 08:24:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h123-20020a0df781000000b005777a2c356asm33757ywf.65.2023.08.03.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:24:34 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:24:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [QUESTION] how to diff one blob with nothing
Message-ID: <ZMvGsYSystLu6oBY@nand.local>
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g>
 <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g>
 <ZMKtcaN7xYaTtkcI@nand.local>
 <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
 <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 03, 2023 at 01:16:02PM +0800, ZheNing Hu wrote:
> > Here, it is necessary to compare multiple versions of blobs while also
> > considering the situations of creation and deletion.
> >
> > Well, what I need is the "diff" content, with lines in the diff indicating
> > '+' or '-' signs. This can be achieved by manually adding them, but it is
> > not very compatible with the original logic.
>
> The native diff command itself supports comparison with an empty file.
>
> #diff -u  /dev/null a
> --- /dev/null 2023-07-25 16:47:50.270094301 +0800
> +++ a 2023-08-03 13:14:16.980262362 +0800
> @@ -0,0 +1 @@
> +a
>
> So I believe this feature would also be useful in git.

Sure, you can easily diff any file against any other, including if
either one or both are empty. I think the main difference here is that
/dev/null exists on your system without additional configuration and
the empty blob does not exist in a Git repository without additional
configuration (in this case, `git hash-object -w -t blob --stdin
</dev/null`).

TBH, I don't know if /dev/null existing by default is necessarily a
solid argument in favor of having Git repositories come initialized with
the empty blob by default.

(To be clear, when I say "initialized", I mean that a Git repository
would recognize the empty blob object's hash for any value of
`the_hash_algo`, not that every repository would be prepared with a
loose object by default.)

Thanks,
Taylor
