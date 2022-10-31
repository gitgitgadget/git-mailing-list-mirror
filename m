Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D771EECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 13:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJaN7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJaN7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 09:59:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F01006C
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:59:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so29682843ejr.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whKRPz4QirpAFz54ytkwnLtdD/EOnHEA4sUCDSVT6+I=;
        b=aVDAgk+A+wDr12E5UYf9dHQKDZntJku+w4T7GcXtZ86p57yPdM6wRu5PWGnKUaJubY
         0VANCjwW1vhEF54Lz0E0oaFGVhI0Oa9Sd6Ck4Mi3p7yMuKsGFnjqU/PeMiUqffEXeaYz
         K6i/c3QpgVX8QG2iOXBqmi1hRIIpGn2JNm6FALugqkQttHkc9wcK/pw++DfZ7r5aJ8wt
         MI/WZ+gG68F75yOza9AHq6i2oCajOfPd4WzAsGdtb98alxvJMa2ahcfMiyxxIyYVNzAU
         hrZ52rUYfMP1PKkaygTxg6EkNnSknVg87QeFKwBv36oeQfMz7iKu3+KbWu1xDjQEyuJC
         yJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whKRPz4QirpAFz54ytkwnLtdD/EOnHEA4sUCDSVT6+I=;
        b=E1qnzJZk8X2HkArngqq2+8OfS/M9ovZdzd3r9y6OLw2es7BmFAR1Xu86vCxVMGJfWj
         qBGkL9Q7ywS8EVwOSxyBbfEFH627rbwCxW2/E+HyzppR282oKyRC//QTcBnBh4P4E7Mi
         mPM38yeQy96ekAqKS0yHXcv0V+fzqIg7vu4Leg72h9iX9il1XY4izDNC+mHU7zA6G++X
         kCr6CQ2pIkqTK/Z/eTRS/EAo40fTn08X4liXZCiPB64SW0/6y8TAvkmSI8sXPyWBuREQ
         v0GvpdTSFlQ3JtzAwdurr1Z7DFUT2eonMwNAZuWWbVyJdHhFHSJz1AEpWuQJT/kyu40P
         MNaA==
X-Gm-Message-State: ACrzQf2xq5DFaAskbfONBfxbkjV/Vb1wZcvJIu8NRgJv4LlZBKxAZUVe
        BnX5noWea4Q7ADJ64H1t0CTn7klfq2WTonCJWxBsbzt/
X-Google-Smtp-Source: AMsMyM6A5YWrpM/Tp+bGrHRORvZmmvOpAsenpomA7ZN0hvZtH7lhLPX2UqDkr3HsY5N+62XpV0Z1kma8knDO23OaJPc=
X-Received: by 2002:a17:906:b08d:b0:782:d526:3e36 with SMTP id
 x13-20020a170906b08d00b00782d5263e36mr12810905ejy.358.1667224787813; Mon, 31
 Oct 2022 06:59:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:9549:0:b0:1e5:3af2:fdb8 with HTTP; Mon, 31 Oct 2022
 06:59:47 -0700 (PDT)
In-Reply-To: <CA+PPyiGvrmXoeZkaQKwwNU3SV+jZHatsC=FMhb9wX5-s0tNjTQ@mail.gmail.com>
References: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
 <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com>
 <CA+PPyiHQgkaN66DWOuO9UaGqhx4Gcyou_hdMnVrD9AVFmreqpA@mail.gmail.com> <CA+PPyiGvrmXoeZkaQKwwNU3SV+jZHatsC=FMhb9wX5-s0tNjTQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 31 Oct 2022 19:29:47 +0530
Message-ID: <CA+CkUQ81nDvKOYiMQXC_jJkVF+-t1+jyWmdEWfR6L2jyfQnziQ@mail.gmail.com>
Subject: Re: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/31/22, NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com> wro=
te:
>> maybe s/stopped from/stopped/
>
> Can I know about how this format of writing works? I have similar
> comments in the previous proposal, but I do not understand how this
> works.

In simple word, s/xyz/abc/ means:
Replace =E2=80=98xyz=E2=80=99 with =E2=80=98abc=E2=80=99 in the sentence.

You can read more about =E2=80=98sed=E2=80=99 command on the Internet.

Thanks,
Hariom Verma
