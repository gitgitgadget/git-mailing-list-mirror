Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16886C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CE961245
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFOJWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhFOJWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:22:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8CCC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:20:17 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x196so17538033oif.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=afLIF140Us9GP7JayWW9a6ttnKrfaa36M1g+xQUhT48=;
        b=l1bkMv3lB2YP3e0YTcPOKC/MQnBcywv/YJ1JuoG88C8vCdChaoLV3SzLcxFgy5vnlj
         H++7sHtmRWf9sqBiYthvAB8W7vrDZeE8KcOjulg6G79X0hgl7UU4e3MJBKCetfE6wl8G
         lxo7CO7SUyJ2wNOqdeBz31GBiqWGyBtwMgbEHbZkaG7Xrr0MK6NkemXpPdyZ0N5sPwag
         TIJBRj+v6PfVQNhSlSP54U85uKyc0Lr2mQqo31EuTXcJuPr5V9O9UZWC0d1SaN0OH5nW
         IIQTMmKU6KZwqyFe/A04aBOFtau74ve0rdYh8nApc5hU7X6Dso66f+Tltdug+mmkuVV1
         CPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=afLIF140Us9GP7JayWW9a6ttnKrfaa36M1g+xQUhT48=;
        b=KqZ/WXOwNVLoV7GjujW93uTyE2Wml4K2BCfJSqyS5wezEJo6s5WKjlCbynUWtdgQoF
         JnPJ3o6Gu0Rohgpcoa9P57LqrUBRke7TWlGYc3HPsrf72VetaiGOuqqRNAP8PrElWghD
         Gda+ywyPpzL53wPMZc6ld84aV0CDeQaYjveo7yzAfft6RLOxoPtApDvDp9GHiseTvcau
         1jtwXz668p5EBQGk3jwrT9mMP+w4v10Aa0FJRWBN2SP4N/cfzBhoqPlBobG60rKLB1cA
         RWdsg5U1rgvJ4bQo7fBc3ZRVAii2q5RiqlXjh6z1oZ8GBiZiinmcRRmFni60RG74680l
         bEVA==
X-Gm-Message-State: AOAM530eIcLI6YZtjrDoOzuBtcJRytZXgRnbkHZKh0ZjTUXYvgjNZU+k
        wo2PnjkYlBs5O73ydX8Grzc=
X-Google-Smtp-Source: ABdhPJyDCWqMoKY3fZQ066pt+UuVDcZqMyO0xPuES5ne+JXw8gGRHcZvep45arHgmW8aKdTIoRZeFg==
X-Received: by 2002:aca:2206:: with SMTP id b6mr2507116oic.121.1623748816708;
        Tue, 15 Jun 2021 02:20:16 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k84sm3568174oia.8.2021.06.15.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:20:16 -0700 (PDT)
Date:   Tue, 15 Jun 2021 04:20:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <60c870c4a1bc1_e6332088f@natae.notmuch>
In-Reply-To: <xmqqr1h3wz8j.fsf@gitster.g>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
 <60c677a2c2d24_f5651208cf@natae.notmuch>
 <xmqq7divzxrr.fsf@gitster.g>
 <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com>
 <xmqqr1h3wz8j.fsf@gitster.g>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > This is going to sound harsh, but people shouldn't waste (any more)
> > time reviewing the patches in this thread or the "merge: cleanups and
> > fix" series submitted elsewhere.  They should all just be rejected.
> >
> > I do not think it is reasonable to expect reviewers to spend time
> > responding to re-posted patches when:
> >   * no attempt was made to make sure they were up-to-date with current
> > code beyond compiling (see below)
> >   * no attempt was made to address missing items pointed out in
> > response to the original submission[1]
> >   * no attempt was made to handle or even test particular cases
> > pointed out in response to the original submission (see [1] and below)
> >   * the patches were posted despite knowing they caused segfaults, and
> > without even stating as much![2]
> >   * the segfault "fixes" are submitted as a separate series from the
> > patch introducing the segfault[3], raising the risk that one gets
> > picked up without the other.
> 
> Fair enough.  Thanks.

I didn't know some people's opinions on this mailing list were
automatically promoted to facts, but FWIW the vast majority of the
points stated above are simply not true.

-- 
Felipe Contreras
