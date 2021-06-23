Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9878C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EF3610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFWBiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFWBiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 21:38:02 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABDCC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:35:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so363509oth.9
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7CdxuB24JgFO3pXERDoKIech7RfDAiiFEVAGk9Xv7RI=;
        b=ogko43ln93XvqhSYJ3+ApUZmod9WqeD3gcq1OHUEiDo2D/UD5Bo2idKZR+AAKoBePP
         Yae62HAqLWZ6cT46OuYEGMx3GG7o0GkI6c+UO/wVkwWqBGOSTkbloo66BhfNynaN4oDB
         cyS+frZO71jVmBNhyKVJ68OJ/hNhGTHdArdCcN4xnbCQW4KETNLYjvB6WVFS7/O+Gs2k
         irrJesXhLPNjg5MwqTzM8U99YPeEFYr7zJPontCfJ1JXwkKTv5vlyr+zMM0JiTc23a5s
         X1eSNdYqEmC4wbIfFF3nJZqfnBxwRXVcz5bT2q+B9Osks2SIPPotxK2OgPHAQxHJS85s
         w6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7CdxuB24JgFO3pXERDoKIech7RfDAiiFEVAGk9Xv7RI=;
        b=qoS1ZBKa35FW4obbumAun/fTnRH6xt0uwqRnOpTvSqNmVZPJ7Fes/4M+SfpcDIqiTv
         /ztK4cquK839C9yUrd6HY8ZdgHQCW8YXjlCd0Z432rlAATefxu8HqxsTyO+vLUSZzXlc
         A1TRAUNh8HN58V8I0QcIoZZ5Q02Wjs5ss9vPVxgNU3ipdx6yjTtQzpkVIW/oxkGgaS1C
         kaISeA6E4bltLQn/S+sFaRiacmCqZHSXzh96XxVwg7HOJQehnwdDKTmft9ysKdZ5Dk4+
         +l45vkroBEcgu9QuPBzxjs9HjIiKE0OH1wRtPqc26anovGHngiKKQ9As5R+Zc4hkmJVH
         YdSQ==
X-Gm-Message-State: AOAM532LqTw5TfBaBnVxFTs2oMyS1k6UgVgWh3t2mbCCcm7B6hq2I6Q0
        jT0uEM1CMA3vtYgOozEYMao=
X-Google-Smtp-Source: ABdhPJynG4OVoEGEPFG6QBphln9lYE48tIcyAA7PBlbRYfmuVkSLEfy2AYBGwa9htHO1mdpxetDptQ==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr5412922otd.71.1624412144166;
        Tue, 22 Jun 2021 18:35:44 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id p17sm241278otp.73.2021.06.22.18.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:35:43 -0700 (PDT)
Date:   Tue, 22 Jun 2021 20:35:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <60d28fee6e914_3122083f@natae.notmuch>
In-Reply-To: <cfa20758-ac40-1fbf-a8f9-411e795c77b7@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
 <20210621163110.1074145-16-felipe.contreras@gmail.com>
 <cfa20758-ac40-1fbf-a8f9-411e795c77b7@gmail.com>
Subject: Re: [PATCH 15/23] doc: use asciidoctor to build man pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 21/06/21 23.31, Felipe Contreras wrote:
> > +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
> > +# instead of building manual pages from DocBook (using xmlto). Has no effect
> > +# unless USE_ASCIIDOCTOR is set.
> > +#
> 
> Why not just USE_ASCIIDOCTOR_MANPAGE implies USE_ASCIIDOCTOR?

Personally I don't see the point of USE_ASCIIDOCTOR_MANPAGE at all. The
only reason I added it was because Martin requested it [1].

It would be nice of you and Martin could make a decision about this, and
I would just implement what you decide (or other people willing to
collaborate on this).

I don't have an opinion on this.

If no decision is reached, I'll make USE_ASCIIDOCTOR_MANPAGE imply
USE_ASCIIDOCTOR as you suggest.

Cheers.

[1] https://lore.kernel.org/git/CAN0heSpX53tK8Z4XSx4sp79b+XWKZg5+ABW8pmzBSHPZ+qy+oQ@mail.gmail.com/

-- 
Felipe Contreras
