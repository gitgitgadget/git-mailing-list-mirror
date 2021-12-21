Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B9C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhLULno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhLULno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:43:44 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7854C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:43:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu9so7146293lfb.7
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fMvwLUxIkHDxl/T0tVDt93d+RIVH5wwgPLxAhJ9Svmo=;
        b=qOYBW++ljq7zJ/POlmJ0Rsps5WUskmogwpj2bZTJkQvuMeyxm+aCcoRWNie+p/phlG
         Ohrt35LvzAZU0PgUQD+rcFoc1x3sL/hhD+8GGUyOLihSMu8YYVviAxWbi4ImdGD+3cz5
         QLM0VBZqHl8vDdeov4ATH+wtZeccLudqrjbapIQ2qkTjPeLLEmbkGGIndatmUjZ/jZAs
         ULV3puWMYXm3HOUyFl0JQfLzU1RrC/VO/q/LQc6+7YGvZSruT7d1i4BYp2Gand1iT8si
         L0//F9ThNv9SEjINUnVdM7/qJoOoQ1//qI7gxL43lAgNLpQbcwPqfBJdsrbrQ3HS/w9j
         yuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fMvwLUxIkHDxl/T0tVDt93d+RIVH5wwgPLxAhJ9Svmo=;
        b=c4fuU3H5bDzB6wZAZ8ifOOR4AEdby3sFNCqMZEXJ+9UcKn62RUgKF1pzXacPLeZDYh
         J4KuQ9Y8ervJB+k5227P6q4by0AQq9V/bPAlYzKfpqcNeFvaKwWWoKJIwNEwnRkNlOFA
         Xf5d6/lrh3d2+3/8sYe3oWszkzKvBzk+jZIsy2UhqeSBLzORtMv6sSDvCgnsMxz55shD
         gY+It7sBFcRdS8bfKxXZK9VrfzjhPD1Th96MYKsrGsrsvijazPclJtx0qL+H/SxS/F84
         fSS2OFX/Gua440P1g0d0Tm4eUoa+2L8A68qfmWlt63rHVw/3qg24Ql8tgOswVgyzWuAi
         EKug==
X-Gm-Message-State: AOAM5303OsHmjyZ0IhE80SJwdN35dLmGB7Up9ezsg84DGCipKNqCgIvq
        EqY/KGCC7QPWmMtTAevSLJpDJZq2DlutcQJXXBw=
X-Google-Smtp-Source: ABdhPJzheJwoP3ntmTpt3ngP9rBusDfnLm0EXWIXZ624ZedoQol4UAc1rv+zQJhC0JvD6DTg/GA2/1p8RMjO8eq0haA=
X-Received: by 2002:a05:6512:130e:: with SMTP id x14mr2773042lfu.366.1640087022054;
 Tue, 21 Dec 2021 03:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-3-chiyutianyi@gmail.com> <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 21 Dec 2021 19:43:30 +0800
Message-ID: <CAO0brD0KLM7wiZJUSLTxieov1BM347iitkMSF4_+XG5C-aBAyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] object-file API: add a format_loose_header() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 8:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I came up with this after my comment on the earlier round suggesting
> to factor out that header formatting. I don't know if this more
> thorough approach is worth it or if you'd like to replace your change
> with this one, but just posting it here as an RFC.
>

I will take this patch and rename the function name from
"format_loose_header()" to "format_object_header()".

Thanks
-Han Xin
