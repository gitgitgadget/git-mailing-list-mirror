Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA6C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245710AbiCJTFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiCJTFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:05:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D458710B5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:03:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w7so11132433lfd.6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBRpDI6uSB7xAh+dITffDkyhasRX8x3goB2yQIeNdu4=;
        b=EMbqHult4gc+rFUl/OWEDhogKWblz2+lgHyCjhD/BOcmEqOdybelYkKU1ejX5Ej/uA
         kW0odwrgly7TYcEHImYppdU1LUrgMfs3kYxLKArnc+jVtikynB+UjxVl9AugSsQ+Jkfg
         ZJlCzdmNxHEetndKMKmkny1mbpfwGPAvs4Z2g/43SE2aKV1n1b2qolq8zfnMKeuRpgVL
         9OwINLu/Kyu15THsaP00ZbG/3iDcl+ZBY5CFoAH7OLkvScy5aewB42MGAni3wyfFizIA
         xoL3AyE0qralQzrn2KgbgVThrby6YnjSMwLffITTmoSn/PUFHE2Xzpe+igdtBVnt0C7M
         AOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBRpDI6uSB7xAh+dITffDkyhasRX8x3goB2yQIeNdu4=;
        b=QgV8rs3FISdAFMuzbZZh5Uh6NoiksBB9j7A3rRf3hBRICRexGloUBQWup7qgAGikLx
         AFVbgT+lv5GcxprMiqV5Wn98oBQREndkWhX1BR8xPY1bXcK4+iJ8sNVI3r3jKT0J5Auy
         y77Ckw40L/DFb5wfQjf8WcKOhetKYv9N3GzBfNYxUsXpayE5UdvzPnff4kHR4pQvdh4X
         xfQ80w8vFGl+CHdl7qem5nc3tsXbcs+RPNtVnm8mYsfgptFlZ9frqCsInzghJhHlt/Ov
         O23pGVFz6Nbk1ujkKsF/azTv/FiTRTF2+soUMo03JUKDyzaRFUVSo56fjzUGxoxpkH4Z
         oNVg==
X-Gm-Message-State: AOAM532sHtW3MjWOFqLkPHiBamXthfIG+2glD3kL1B45lIo2j5xygS5B
        boiNqWMXBVnA50BiYVR2itXtEUu2WRNXHG8kr6Y=
X-Google-Smtp-Source: ABdhPJxpXHQI2oVTeQkyM8wM8IPrxPgu70/f0nePjSXBXYFxkff2d5fMJ0WvFEKiY8rDKYHoeEK72xMkVZz32mmKKwE=
X-Received: by 2002:a05:6512:32ca:b0:446:4262:e29 with SMTP id
 f10-20020a05651232ca00b0044642620e29mr3868041lfg.522.1646939038013; Thu, 10
 Mar 2022 11:03:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im> <xmqq4k45fyvc.fsf@gitster.g>
In-Reply-To: <xmqq4k45fyvc.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 11:03:47 -0800
Message-ID: <CANQDOdeOu3iWqQr_m0vL0DAfDAaGgFc6eeHP2112Veh8yNu=Gw@mail.gmail.com>
Subject: Re: [PATCH 7/8] core.fsync: new option to harden loose references
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Good illustration how the new helper in 6/8 is useful.  It would be
> nice if the reroll of the base topic by Neeraj reorders the patches
> to introduce fsync_component() much earlier, at the same time it
> introduces the fsync_component_or_die().

Will do.
