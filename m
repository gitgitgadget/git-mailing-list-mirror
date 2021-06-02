Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26076C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D98613BF
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFBEGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 00:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhFBEGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 00:06:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE6C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 21:05:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so1313419oth.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JbByIwGZC+nl1hSXqEi83cmJBbHLY4tLhxyW2/pyri8=;
        b=AMF0x02PCQBceMqPtMKUOLVDexc7Qk+CMyELBZXS3sCMUfZA/TF2ej4FF6P11UuDfS
         ZPKw1zdE0Dd74Zaoe6acjGI/h79C1q4JwHtvhp4RWd2MAlISTyibcEJhMF5FwGEaMakD
         O6USDJC/zJNP3GNxmhHaR9sr0XJkqg2wDqoKVS91KthX9A3+2Ary6u+k2c9yJWMxbnvW
         kL+c6TMUhN9pnMTyZKh2kZAyGn/gKKNpUllF18RhDo/hfIS5b84lQ0Sd+elzumt8avae
         IkQln4VPvhV+IgASPnPpk6Z2eit83hs5ZkTDUmw3w/zDzgpLazdFOswufKUhA1Vb4+9d
         XSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JbByIwGZC+nl1hSXqEi83cmJBbHLY4tLhxyW2/pyri8=;
        b=n1fPHVLE45ZHEjkejxgxhRSebf0+t8iP83TXX9E39l5phgsQLv53vNg8nSXFMj32c8
         nb8OIAGAtnmGeTf8H4p7oNqluqY45/Tygo3mnbTXdkXbEVFYVEGA06hr4oZYVrkutDJC
         ziH6XlrWx+EJz/nkmKGZxOJZE3kQcNdQBsVKxtc56n73RgGKdr1aIkwYkmbT1ndv1Ywk
         LYcHfZ/5jCV0Sm9wPXAehDxKdMcbXzrMu7C1Em5uLhaUa+WkJSvYVIi+Bcoi0zJycLvR
         HittTSt0msSDq56a6oKdbe4C3xxTaMeB9Fp7jQBz5IQfGPl3B7M8xcAzmKsFLzraNrHY
         9WJg==
X-Gm-Message-State: AOAM533W4c7eDl5EoWU9gfVVdPq+rT1cOVFQZFLMav6QCnRhehoRyfGm
        JR3duXTEc74N+ssL//brRQ0=
X-Google-Smtp-Source: ABdhPJyWTGuDhHYWfhL2gx2igEq7QicOUJkaTrGWbPHyyRu0pHHau4Yra4PUUUbju44SbvG6dzyl2g==
X-Received: by 2002:a9d:3675:: with SMTP id w108mr24101955otb.58.1622606704078;
        Tue, 01 Jun 2021 21:05:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f1sm802128oto.40.2021.06.01.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:05:03 -0700 (PDT)
Date:   Tue, 01 Jun 2021 23:05:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Message-ID: <60b7036e8eaf1_511920821@natae.notmuch>
In-Reply-To: <xmqqr1hlqd5v.fsf@gitster.g>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
 <xmqqr1hlqd5v.fsf@gitster.g>
Subject: Re: [PATCH v2 00/13] push: revamp push.default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The end result is almost identical to v1, only the way we get there
> > changes (plus there's an extra cosmetic break).
> 
> Good.  The endpoint matches exactly to what was queued, with the
> SQUASH??? fix for the "break" thing, which is necessary to make
> "make sparse" happy (so it is not just "cosmetic").
> 
> IOW, this series allows us to drop the following.

Indeed.

> commit c1964311c404afaadffd57d14d769a4051281c2b
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon May 31 12:41:06 2021 +0900
> 
>     SQUASH??? fix compilation breakage
>     
>     make sparse found these:
>     
>     builtin/push.c:221:9: error: Expected ; at end of statement
>     builtin/push.c:221:9: error: got }

Is it really a "compilation breakage"?

Documentation/SubmittingPatches doesn't mention sparse. I do remember
setting up sparse when I worked with Linux in the past, but it's not
precisely a standard thing. At least in Arch Linux it's not even part of
the main packages [1].

Cheers.

[1] https://aur.archlinux.org/packages/sparse/

-- 
Felipe Contreras
