Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0BC76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjDDBH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDDBH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:07:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82095269E
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:07:56 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17683b570b8so32782737fac.13
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680570476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qpGvufRL21Qgh/K6vS9SQYjOD5hNXpcU2M8DyK23pQ=;
        b=CKDZYmc0msmHg/I5U/sqq7nb8Eh28vhVCXYpYO1pBjPVjh6LpVRl2g46mhLrwaHflz
         71Ycn9mNiNDFBJQbpJLoc1vyOJAnGVZ2xjs1QNTzvyDvyqmSmKY9/FfmMX+e2mnZMH+H
         DEaj+QMmkGeNJJvyV/T8gn1HaXnWq+cTH14p2NieXCupYU2cmFKOg7cXm0J8oj1Z6qSh
         T4XSy4OBMu9fL9GAEXXiHUTuK2TqS9/vINcgfXuekSK4SfLPA7xoMNOjseT0qPGd6Hml
         qjX7lYz/pLVWbw1tabtGF3RzwCG7byaQjy/RjspMTIqutZ4hYxZnLCDmXqAtKyl4+1eS
         Jo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680570476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qpGvufRL21Qgh/K6vS9SQYjOD5hNXpcU2M8DyK23pQ=;
        b=c/Pgs9OkuZDJnoqDY9d2k7Y6n/V5DDAULiUpBFHASBV/8NdutzktgPuC2/Z3MK+G9+
         7ER1r25YsKjn1M+gK/1dh18Kt47vyZLr0HcIoI+TFMWkeNgEl14j6FvlEBuF2N0+OCYH
         CaV3s6hxM2l/GSEuv2hDqUXvXLIxK5avoUAUnEwjGSwcmQ3l2KPmyEeV8mPENH/9CoIC
         scFLT8Pu7s+uWliATHdTKsRiShwvZKnbve1Ra4Uof0qxvkkVS984aP4EMMwXmx4ouTg3
         LLL3pvMvINZumR8pc4SYqiz2zbYt/1KLxDTAXTIP1ET+HFM5Uj9bHakrkkdvE4b+qdvy
         ie+Q==
X-Gm-Message-State: AAQBX9d/8jnpUOC2SPYAPLlytqMul5iuBJVfdsSsqegVLwioCHfR49h7
        H1itmqMzk11oy71e2IWj3dJqJvlVVzNCQGJlklo=
X-Google-Smtp-Source: AKy350arZSc8powkSpIdXPuONpjvmwdVG3MJ6B/hnhL9Q1mGDIbyQglb6u2pktxFEwGW+a7qmuu/23hznXXuDE6WgEA=
X-Received: by 2002:a05:6870:12d0:b0:17e:2ddf:b23c with SMTP id
 16-20020a05687012d000b0017e2ddfb23cmr488079oam.0.1680570475807; Mon, 03 Apr
 2023 18:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230402130557.17662-1-worldhello.net@gmail.com> <xmqqsfdg7wif.fsf@gitster.g>
In-Reply-To: <xmqqsfdg7wif.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 4 Apr 2023 09:07:43 +0800
Message-ID: <CANYiYbHB9AMpahiULEF=PoVG6y_ogDvVQvWY=ThKUdERmVbQyg@mail.gmail.com>
Subject: Re: [PATCH] object-info: init request_info before reading arg
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Bruno Albuquerque <bga@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 12:36=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > When retrieving object info via capability "object-info", we store the
> > command args into a requested_info variable, but forget to initialize
> > it. Initialize the variable before use to prevent unexpected output.
>
> Good eyes.  We read the request packets to decide if we want to flip
> the .size member of the structure, but the result would not make
> much sense if the structure starts with a random garbage in it.
>
> I wonder if we can tell our compilers (or runtime checker) to help
> catch a mistake like this.  Did you see our sanitizers complain, or
> something?

I accidentally came across this issue when I wanted to implement a new
similar capability. I'm curious why adding "-Wuninitialized" or
"-Wmaybe-uninitialized" to gcc fails to spot this case.
