Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD1C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E858760720
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhD1EKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1EKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:10:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE8C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 21:09:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr7so13918078pjb.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OWIjgNEYG/tyv/0z1Gn9E0Ah0iNRR0gD4rd+Vs15kLg=;
        b=Px0LcssyLcFGFl00pkbaxrqkcvikpRobvMiczHv6nYWOVTthoB/2T977RBwxXFLTEX
         GNolHOvBiNyh5CfQUt79Bll+K7dlDDcH9yj/qex3UZHxMEkX8iUUXsPiKh2hsoz21c/l
         pgMJCIEzfpIkFdnaSHpB0j8FTS254LVovQFrxVeq5v1lVWv9ufjRV/4sVDIrJgsZbeH1
         J+qS5Af/ruiod1q6fLZBMxUPDEap+fK8l7eY9rhfxtFivYiPGnw6BxWdvnrE/CdQ5Ton
         rZX/OSnw8EXrmrsaQd/ocFcfSpHgZOgZYoJDvnQGSyg0PJ6VQM0hIWsXGwwFe+j2a8TR
         BbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OWIjgNEYG/tyv/0z1Gn9E0Ah0iNRR0gD4rd+Vs15kLg=;
        b=lbggucZ2/4ERBo5MuRh3vRtRSz+D6Uzi3etfYxzP/ieoiQy4uZjXmvJlxOsrmhAbHZ
         DuU7lwwjFkQKmidG8+0B2WZWjuTRBAkXHtb9SUAiPvuK7lMEabDFYdJ1ks8u9G1SXE5X
         iWoHhOPA5S55shU6siOKJCGEqRiS3iaNGEiALdJ0QooPSPsprF1iDYv+/5O9gOtme6gh
         hkNQ86dkNCXP7swu+GRExvh0DehAfEjzqaRvIaME/7wZo0//L8kDccRmiA4/gYBxjSrA
         TRyJIowpCNV51585F35jpd6i7l/BeKS6byDjQxWsiSsPSGLCbRsvlKVdgI8KW03F5R7d
         NSKg==
X-Gm-Message-State: AOAM530dow76LagqrxzDbLmJvJ7MNBnY0uHGHKYIiDiXgslMYnE6ZW92
        sojF8vyMR3doOdkoIuWN12wVaLvsOtzyig==
X-Google-Smtp-Source: ABdhPJzn+MaJom7eFG+2lp03Deik+gayKgA4WfJMsxekO3BuDekCR5FHky462OJjasw54b7Gj4lfOQ==
X-Received: by 2002:a17:90a:c404:: with SMTP id i4mr1826722pjt.10.1619582964041;
        Tue, 27 Apr 2021 21:09:24 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id y195sm321428pfb.11.2021.04.27.21.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 21:09:23 -0700 (PDT)
Subject: Re: [PATCH] bisect--helper: use BISECT_TERMS in 'bisect skip' command
To:     Christian Couder <christian.couder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Trygve Aaberge <trygveaa@gmail.com>
References: <fd40e12f-9649-1327-4bdb-dce5b5eed619@ramsayjones.plus.com>
 <473a11db-cbb5-58b9-b05d-cab2072d5d2f@gmail.com>
 <CAP8UFD3hOqeF04Xdjn-o2FShuTPQ9ZUEVCWnhfzCqV6MtbvU4g@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ffd80d10-9939-d31c-324d-3e32c37d2eaf@gmail.com>
Date:   Wed, 28 Apr 2021 11:09:20 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3hOqeF04Xdjn-o2FShuTPQ9ZUEVCWnhfzCqV6MtbvU4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/04/21 14.06, Christian Couder wrote:
> Thanks Bagas for your test! I will take a look at it soon.
> 
> My opinion is that it would be best if both patches (Ramsay's and
> Bagas') were in the same patch series or even perhaps in the same
> commit. If you prefer separate patches, maybe the first one could be
> Ramsay's, and the second one Bagas' where indeed the instructions to
> replace test_expect_failure with test_expect_success have been
> followed.
> 

OK. Review ping

> It might not be the best API for this (or the set_terms() and
> get_terms() function could perhaps have better names), but anyway the
> current situation is that set_terms(&terms, "bad", "good") is setting
> the current terms to "bad"/"good" which is the default, and then
> get_terms(&terms) is reading the terms stored in the BISECT_TERMS file
> and using that to set the current terms. Also if the BISECT_TERMS file
> doesn't exist, then get_terms(&terms) is doing nothing. So it seems to
> me that Ramsay's patch is doing the right thing.
> 
> If get_terms(&terms) was used before set_terms(&terms, "bad", "good"),
> then the current terms would always be "bad"/"good" even if the
> BISECT_TERMS file contains valid terms different from "bad"/"good".
> 

OK, thanks for the explanation.

-- 
An old man doll... just what I always wanted! - Clara
