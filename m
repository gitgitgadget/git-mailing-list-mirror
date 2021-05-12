Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941CC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7CD61628
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhELDDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhELDDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:03:50 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F254C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:02:42 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so4658099oot.6
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=575LtBSgLQU6P1uV3zTJcTOKI01/B/kUdpVj0Qjjym8=;
        b=Lm32xKTybduCdyNuNHHfEeSTSk770INn+FpaueipcCyWTuSBvn/2oe/WKen2U1xG/3
         on5LHW6/OwTgfdgr1kjVeOEePNglXVqA/eHrD5tG08hQL3LiUQ+6+dAX/fNq4VyaClk9
         E824B44Dtk5+plbYnB3u96cfxHLo+iaw7oit6f7iwzY3SREIiAGfKH7WRVtAqbIyYhUb
         mkhjsDiI43mBOa9qbTg4Ot1wDgh5OvbY6jK8yU0oSLqzMiOsV1R/uGcYmn8qfFY+7qhn
         P+WBRljAikjXAdd7eejjZd7azxwbO4yiiZN9WsXXKEWsRjb+WZqOFPZm2Or5VxHboDwf
         UEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=575LtBSgLQU6P1uV3zTJcTOKI01/B/kUdpVj0Qjjym8=;
        b=I4KfilxpdVXgZ3WD5zbW/o1QxscDGKyVFAlELl4jB29xxO/lw4mdYzQ8RHCHpNrF82
         +rsYmZp5MxEpJRqN6xoQNJj+IqKWElcwoNFYJzYZqGHOhT9HyznDzYC7YLWmIaLBe0ZK
         X6sMpoJ0N5IJTUGc1ci8CAekuNiQjNbvljAbGqojfDtB2s6Cgu8vtIqVDe+SgVhTjr7z
         96bj4FqaGk4CrdZpDOug0TObL4PcFnMnH8XDfU0TwAVnKS3LofIW4CQOyn1q/mwh8iNI
         YELtjvyzp0MpQZrot4qkAaYmp3CdwoNcH3Oe418T33yt9zxx2iFEvqZJoBU4b3HL3iNf
         NkAw==
X-Gm-Message-State: AOAM532xt52qrPFVoW0J61hiAvmt6V9SW3juMSo7vcqiDaXuZEOxrwak
        ojuwOHwF+0C+SrQjYJh1q5o=
X-Google-Smtp-Source: ABdhPJw6DkHkBjS6P4TN4dvLNQQ07M9928wB3WLRVbiK8wrOcHK8r/6j9QSrE5sJXpEVpQC97EAHCg==
X-Received: by 2002:a4a:e61a:: with SMTP id f26mr26122695oot.76.1620788561748;
        Tue, 11 May 2021 20:02:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l11sm3690882ooq.44.2021.05.11.20.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:02:41 -0700 (PDT)
Date:   Tue, 11 May 2021 22:02:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Cc:     Varun Varada <varuncvarada@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Message-ID: <609b454d33df2_678ff208f9@natae.notmuch>
In-Reply-To: <xmqq35utmmll.fsf@gitster.g>
References: <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
 <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
 <20210428085838.GN6564@kitsune.suse.cz>
 <CAD2i4DASL-ZAsLm=_U53zvqMaAC_AOsGnTe-H=XQsfnftgb=rA@mail.gmail.com>
 <20210428184956.GS6564@kitsune.suse.cz>
 <CAD2i4DCLpvAuwp5UEDcPA0wzr4Eg_qhs_xXDW1eLiOwYkUvL1g@mail.gmail.com>
 <20210430075924.GB6564@kitsune.suse.cz>
 <CAD2i4DBSajgNFCwMMDv_tyQwuKDU095avmHs=BHcrAY1GbCqwA@mail.gmail.com>
 <20210510173502.GH12700@kitsune.suse.cz>
 <CAD2i4DBrERhtE5Br22s-bSt7C3SAvcHG62EZ=61COcnBGtUh-g@mail.gmail.com>
 <20210511104326.GJ12700@kitsune.suse.cz>
 <xmqq35utmmll.fsf@gitster.g>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> As you said, lack of a specific example of what is universally
> confusing, or at least confusing to a not-so-insignificant part of
> the readership, was why this change didn't gain much support.

The original version doesn't necessarily need to be confusing.

It's sufficient that the new version is better.

> There might be one or two such places where the updated text does read
> better, but it is not a very good use of reviewers' time to find such
> needles in 700+ line haystack of a patch.

As a reviewer I will decide where I to allocate my reviewer's time,
because it's my time.

-- 
Felipe Contreras
