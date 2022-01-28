Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A14C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 09:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbiA1JNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiA1JNF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 04:13:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF4C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 01:13:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so9551873wrg.11
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 01:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=/ADaKdt8dnCXmLZ1pV/YMd5Rq1cAz09e+n0p3ckn8kA=;
        b=Zbb9nMGHS0rCDomcC36X3exk01gM4Vr/SBuNp7oHI/J5cV7au6nDc6J7Fl8q98Iur2
         GcmXIstlc1+0YMOf0BtyPwD/JsiUoHXE2fXDVk3SSBh5lT2j/8t9ZblURvrsGO6Oq4+c
         V3lT2BVj0r/4WTi8Ahb+7M68FOvaGNVTSSP7BiufwlpNFxfX3eQVqboe4uswjKbLbMk5
         0th0Ly5O96LiUV473lMoWHza0ZVQvgrJS5VbamkTLfCUACiI5347J0GF4igT3y0ODZnD
         H4EDo2W6nmbht/ycP9LbHkc49V8OVxUibm0od+vtvHqf2JDg/FNNlJz5MFSMiX03ioF7
         AK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=/ADaKdt8dnCXmLZ1pV/YMd5Rq1cAz09e+n0p3ckn8kA=;
        b=762LWL2ZCTYPtSJFTF8QO9SGgf+GEfk1gb9j8g8wG795+MVKDvcoGnthos0kXTuW3j
         EKdiCygL4+T3fgl6/aokS/J/7NJL0yCCcOmwDiBJei3H3cvN61VSj4F/aoUGwR1I3Wex
         /YjATXdLFXo2IFRMSKAVdjZBIYg7wuOrYFwdGVlpUq7EcdXSb+VhTt9LUy+pvdB8o3P/
         d2qVGIO8OFV502hisLQ+uNMKuGmYPK9Npqf3UWfEq+/9JWoHpFS0JMqTp9O6C6CDGIVo
         MV1bl8CYsjfTklpu8m7REC1WPP6vPuAQWA5fbeNNLBnlp+LPwgxzHaRBoppAStOiKd2j
         z4eQ==
X-Gm-Message-State: AOAM531AIryeH9p3I/tkeZ86sydxMv/xoxQronSIbmOncCly+UKSSSmm
        yN0Z+/lMo6zKGjQtAH+xzaOl1w==
X-Google-Smtp-Source: ABdhPJw60LLvxFQbFdctUAei4ViZx7tYF1cVV1SIDU9Tt0iyfSJrk2qPeFVkI//XhWESxGuCMZMytQ==
X-Received: by 2002:adf:ee4b:: with SMTP id w11mr6425018wro.248.1643361183617;
        Fri, 28 Jan 2022 01:13:03 -0800 (PST)
Received: from localhost (2a01cb000f483e003b320a5f125af7b5.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:3b32:a5f:125a:f7b5])
        by smtp.gmail.com with ESMTPSA id m29sm1464895wms.34.2022.01.28.01.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:13:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jan 2022 10:13:02 +0100
Message-Id: <CHH6X4XFLKXQ.3KKGJCADRTZZ7@diabtop>
Subject: Re: [PATCH v3] receive-pack: check if client is alive before
 completing the push
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
X-Mailer: aerc/0.7.1-30-g7edcc9f79409
References: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
 <20220127215553.1386024-1-robin.jarry@6wind.com>
 <xmqqy230y7vc.fsf@gitster.g>
In-Reply-To: <xmqqy230y7vc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Jan 28, 2022 at 02:19:
> Yes, as long as sideband capability is supported (which is true
> everywhere these days), this would be good.
>
> Simple and sensible.
>
> Thanks.

Thank you for your patience :)
