Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07CB51F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeIMDIT (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 23:08:19 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:45266 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeIMDIT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:08:19 -0400
Received: by mail-yw1-f46.google.com with SMTP id p206-v6so347386ywg.12
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4RqoqyiaMI9Ug+jtpuEkFKlBjbi/F+Y87VXegRiC+4=;
        b=lho9Zhxwv7iQTb0K8xFRuBuNEAcP1a5gwQrqMaovgBt1L18+OHlfOPelLLaMoxzWix
         +JMDefyML4SlxJdjvl/NUzwf3EJgLf4hfG60WFbIlhiu6zLESzwW+uIba3zX3iD7xhK/
         FyLSWrzNaovCrnlv/pFh6dd8YODJ898rE0N/PpxIVHAZg01suej5WSqJrAM8WDz2f2SN
         5zD/UsKl5m1eJyhUNZZmKsyPVkxyjkUGHW8OJ+Oh++dxTZzFcCiokXyDBAPi/VGJ3W9N
         rPy9vn+WEjo3lukUwT/JMSWGs/tVteGFgyHWaoMt4xgQnZT1o/YJLLQGxbVNJFvHGBZK
         fryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4RqoqyiaMI9Ug+jtpuEkFKlBjbi/F+Y87VXegRiC+4=;
        b=GDvOAHSVY8BqcquCKW8x8fcmuNKl3OGdFSdYzpv2jvNmrrxLo89c5REBjp8nR0xTSC
         c2NBJPHAlsB80UZc9NzniPO38XTBikvkmp0ju6AOKAkPRpOhYZFwp1SNYq44jWfUvfBL
         3W7KwxGrNpOQcRMqjRHlcjnvwJWflycxzLPT/dsvrGT0LLX+AHRdB9mcvnWm3v2jYksJ
         mc/nBn3WJpv5mzGR7ypFTqNwmpFVxCMKc4sZkI91QMPuGtZ+NX1F7gHRlsSYeQrHW/2/
         YblnSRM13miCseXHqe4V1PcVHUdpwiMQZf95sKZgjO1Pwa3DUtigmAUm0IPoRjSil+Ax
         RG3g==
X-Gm-Message-State: APzg51BKYTbMDoUMWFxrEI4HB6JX7wxQpLUAZJPzSBRbTBuZktkVw68S
        7hPyStn2E4xMm2n2iYfZGdSnfLYSmcglughSYuYWsQ==
X-Google-Smtp-Source: ANB0VdYPrK1QZ5qZJqgWphKF/rKcEwseZCHqfPaB6FpGfsJRtBgIVI4Oi+6BCXzrcLArJ/fqhCwgqUae7rn4gjLk4wM=
X-Received: by 2002:a81:5bc6:: with SMTP id p189-v6mr1966956ywb.370.1536789708757;
 Wed, 12 Sep 2018 15:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180912053519.31085-2-steadmon@google.com>
In-Reply-To: <20180912053519.31085-2-steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Sep 2018 15:01:37 -0700
Message-ID: <CAGZ79kb2Z71YL0o06eFC_POH0DWKOc2r=xZ1Mjc7Mxg-3OsHDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] archive: use packet_reader for communications
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 10:35 PM Josh Steadmon <steadmon@google.com> wrote:
>
> Using packet_reader will simplify version detection and capability
> handling, which will make implementation of protocol v2 support in
> git-archive easier.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
