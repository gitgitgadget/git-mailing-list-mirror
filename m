Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC3DC25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiHDU2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiHDU2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:28:32 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01611704C
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:28:31 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10d845dcf92so774882fac.12
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=x0vhxKe2AcV9FWtznAqDQSkjlCtoA0I5TeU4BjcnSaw=;
        b=hMk+WE2TKtFGy0QwIio8GXV5WOIh6NxUXp2ukNloPQ/9Fdfs8xBXSWKuIW25oivaJN
         erFX1L/KCfcv61JTUpmkkZCXtRG5CeE6c3CN7i6TIi73iUeXRqg51qBRCatjs7uOGp3g
         LO2Gr1Cp+p6VF7ikYaBK+1ZDU/lYy1EPBM5Y5r91KQ27ddPe62I+Mgp2XWPoEiUWKI01
         ffQyiFuS/0IG3U2lc23R/lGqHlBna6tQbZr2nrP7OVeXhH7r+gpr3ozx1f8IQqDU+Jh1
         lNZrVJVD0wdZ9j1R8wu9E8KMMxh0fAGJC5ZtVPFGeZJU+aoM7WgcUBLH156oaniahq0R
         tO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x0vhxKe2AcV9FWtznAqDQSkjlCtoA0I5TeU4BjcnSaw=;
        b=tXuyluvycler3ryVDUx6+6abXP/agp5iz1wmxkmX4tXl5flh40Lfx6OB1wvwWtqm1X
         jncKpbixTX8kZkfUbktN4YBDVqyox4+xUtvrhXGF2FkIXvjPYvb7Qk1UQZcmOBuxOqY3
         VEGLc1qnwmi08pMRzxeNCrjZ74iCNkLbwZlWVbkNzvKOB+iDKdsiEqIBuqtnhk6+bV9x
         1TTYWFien2l5+twEyj/3rCPjz0yq6/5Cc4kzHNPHwkRupY7RoFUZ1umL7eI/uzdahPWa
         n7McAGvlffxhVK0dP0IIBKGtIDt4rUST/6TkSh1uy6ldYKrhhTgVieTZXdXGs8raUBFW
         mDSg==
X-Gm-Message-State: ACgBeo0VDgUDYqfh4avh5ImBzybYQAzhVXWlOv6quwacAwMZqNiRiq63
        TvZIjJNfcyAM2rsihVMSCr89R1z6D1Ght6c4QyETqw==
X-Google-Smtp-Source: AA6agR67IdF9AGJKHNQGdwdk4zWYIhgYnq19RR6R07YLu9RfBULKCTe5Qyun/j8bK2HKpGeME2SzPE8sZAgKkENRKWY=
X-Received: by 2002:a05:6870:8328:b0:10c:fdf5:3be2 with SMTP id
 p40-20020a056870832800b0010cfdf53be2mr1703328oae.4.1659644910989; Thu, 04 Aug
 2022 13:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-6-calvinwan@google.com> <xmqqbkt77q07.fsf@gitster.g>
In-Reply-To: <xmqqbkt77q07.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 4 Aug 2022 13:28:19 -0700
Message-ID: <CAFySSZAJMUw30GCs8Etvi1D0hm3Rna2C8K_EMxKQtXea9fqVcg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If !args->oids then we say "we want to request object-info to learn
> size and type for the following objects: oh, there are no objects we
> are interested in".  I wonder if an early return
>
>         if (!args->oids)
>                 return;
>
> at the beginning of the function that turns it into a benign no-op,
> may make more sense?  Calling "send_X()" helper and seeing nothing
> come out on the wire might make it look awkward, though.

If I add this change, then I should also add a check to ensure
args->object_info_options is also not empty. The question I think we
should answer is whether checking for oids and options should
happen inside this function or not. I'm leaning towards outside
the function for the reason you stated above about nothing
coming out of the wire being awkward.

> > +     struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));
>
> Style: no SP between "sizeof" and "(".

ack
