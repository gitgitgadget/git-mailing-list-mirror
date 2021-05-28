Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D20C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1D8613E5
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhE1QPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhE1QPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 12:15:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3803CC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:13:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so4720506oic.13
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GR5MGBq53/n/C2Nz6IgyOAMjNO7VbfTZwj2NWzNLFIU=;
        b=OofkZeRCui/Ca6qeh6/6qgn1G9Wzp0sQnQM42ECGL8gGI71/xuNtirnkX11xhTfaF2
         rlGYQKOEgL18vmnFzASd+SKXEYla5n+Q6P4zqkIaEq7tZQ6FL0gmGi6kH+lztMchpkBx
         Ln0L0X45h4WcuaLtJhG7oZLjj27DB9DI/RKT8jRVFR3fv1VWA8zyJIE8bZUNcGqY+UM2
         B8w8qKWqDFVjfyPnfc4sLUuTqRRplq6Ytv7pGlKDJlOGPq/KFIpSKcGcdalbkn2h+ZBC
         K1o+ZU68bfvkxodI+l3trkvzj3j70MO1D2VpIsgOUBfPEysCU075iLdQlgxiEQRFwb7t
         7e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GR5MGBq53/n/C2Nz6IgyOAMjNO7VbfTZwj2NWzNLFIU=;
        b=YqqoStjLpUFNcBAadWJwpc2BVG8nlBHM4l6XLG4RyNwFJ9W79jkCs9Gy/v8OKAKnUH
         hVCgVnFAvt3UheLbClDwwW6hi+qkkOn8xacWUVd1AA9t9x2LZcCAV8sk1u/bm/R1ePIX
         pDoO4crSj2PTZ5wFeEsVE9b4z/O5Z0mH9VmLQAGo7DOwmKrSuBJvplpQYhDQ7ABrjZEk
         7X88RObWhEKxkBNc6srzNK5K0yGSKkdki6Zv16nU6PRuUP1eLe3MQ/brlISOoegq9hog
         FLTiqCtBGrcrqR/b1HgU5HB8X8uLkGxgK0HR5I7EKGzBReBVyweKHEGcNAXpOIlZcXG+
         RT3w==
X-Gm-Message-State: AOAM533mwh56/qvl3WcpPZXZOp4LGTgQpeiEqiV/BPzw56U/nQR7ft1W
        Nv89kjf/CoaccM2h0Kx2+0k=
X-Google-Smtp-Source: ABdhPJz7YsFKrFgjfG8kabRJxzh9sJjENz9Hv6WWMK6uRUfwcuIoKSJUuORr1WGdS4rf0FsgKGDDOQ==
X-Received: by 2002:aca:1001:: with SMTP id 1mr6571376oiq.59.1622218423622;
        Fri, 28 May 2021 09:13:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a18sm1192635oiy.24.2021.05.28.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:13:43 -0700 (PDT)
Date:   Fri, 28 May 2021 11:13:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60b116b5c15b5_4b03220811@natae.notmuch>
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
Subject: RE: [PATCH v5 00/13] send-email: various optimizations to speed up by
 >2x
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Hopefully the final iteration. Updates a commit message to explain why
> I moved away from File::Spec::Functions, rebases on master, and
> explains and deals with the "undef in config" issue Jeff King noted.

The series looks good to me, except the one comment about splitting one
patch, but not a deal-breaker.

For what it's worth:
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- =

Felipe Contreras=
