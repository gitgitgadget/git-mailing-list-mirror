Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785C3C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C71613B7
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhGEH4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhGEH4L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768EC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 00:53:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l19so4570549plg.6
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IF+KkyzLamto+vpJbvYYnJBlF4rBup73lIgWZzgV65w=;
        b=mY8jgH0YYPNXpPNoQDF+RUtwXwiXK/oGXzS3VvKMdQy+avFfRu/cDEqOG0u4LQ2yBD
         E6UdhXBRKS6T19fRK0Z4virpksACrkBgDEY4wawlczBJ7Ow0T3Uxug6vns1euH73cIn8
         NmrbhBqxScCW5tLxlFvi8mlFIIVI6ERnvtvv/kjvC5JEu8sKKnRqzCRCdy5LKFHDpXiY
         vuee6FRBNY7//QXCiUkxlhBaVcJ+ESD0JeMtARZ2wtccUT49MLEFP39XskBuJ54V8RaS
         mHIjZrfn+ZtWkaRpkPwAcztQSwJt768DqyOqBWXtqF05kGLeFV+wPKK7URR/kekn25it
         mpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IF+KkyzLamto+vpJbvYYnJBlF4rBup73lIgWZzgV65w=;
        b=VMUeRkIplrNirxGkHiwM2FidpmmuUnRgpFFzXaFuXIQdM7cntrptiOtwDg6fZaYK1+
         uGxNmdX3ZUpl8moDZCiNsFy6gFm2Pi2X1zt01rjxumbc16LFj5yBHHcOz5oP0ds2TydH
         kWiabUJZ0yXxDP9rysW7jMKVGMAAfsnQtL1/IinLLW7dZcmwZ51bHUzVndn/VbLSHIY5
         N9b2f8mBUabEub/FZeI3uXLW0PWzlhtonw/BIYX2OWpaTmzv4q80d4XkKqeuyYkLcWbo
         ly8+BE9Jpcz3YxIM2X29WuFC21QngLYZYAiPAN6EqUgdOCH19aB4dpKd9J7o6eLfMCzx
         wgvA==
X-Gm-Message-State: AOAM532aqRdcDX1C5FUMFgLjntO/B+N4/GAHNiPolRck8kjsLD8CGiLw
        +RSJ20K8f5CLB9/UGR5HB64=
X-Google-Smtp-Source: ABdhPJzBCpB+1Hc5a1KVj+KOUv1lz9KxdEE01CE3BfzoF3HXqjzZb4wJH0at3j9vp0R6H3El5ofTug==
X-Received: by 2002:a17:90a:5647:: with SMTP id d7mr13762148pji.115.1625471613929;
        Mon, 05 Jul 2021 00:53:33 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.56])
        by smtp.gmail.com with ESMTPSA id p11sm11653789pfh.196.2021.07.05.00.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 00:53:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_7?=
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CACdWUYWzasvU4MGjk5TEQLcO9zQ2w6nRrtQanSRmXEVMORHmzA@mail.gmail.com>
Date:   Mon, 5 Jul 2021 13:23:30 +0530
Cc:     Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9617B510-F7CB-4AC4-8950-6132F5C2FBA1@gmail.com>
References: <3F42C674-B5FA-4BC1-8F8B-B15C24839929@gmail.com>
 <CACdWUYWzasvU4MGjk5TEQLcO9zQ2w6nRrtQanSRmXEVMORHmzA@mail.gmail.com>
To:     Shourya Shukla <periperidip@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-Jul-2021, at 17:01, Shourya Shukla <periperidip@gmail.com> wrote:
>=20
>=20
> > I have also finished *some** work
>=20
> I think you added an extra asterisk by mistake.=20

Thanks, I'll fix that.

> > The last point is very real=E2=80=94many people repeat code that is =
already found elsewhere, because in a project so big, it is easy to =
miss.
>=20
> It would be lovely if you could describe/mention other examples of =
such repetition(s).

I have noted this, and I'll update it when I have the time. In the
meantime, I hope the link to my conversation in the sentence that
followed suffices.=
