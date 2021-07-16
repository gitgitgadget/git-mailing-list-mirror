Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685CCC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427BB613F8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGPTI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPTI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:08:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4EC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:06:01 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id w2so5065946qvh.13
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5ehDGWtkqgI5cIEy6xxMNiw5HarncBsti9O8PZhYizg=;
        b=C2XBGAmwfGIE90Y8IebtOw94koDkW1RLJzet05fm74rcn19oVYpd4an7tUFZS03Wbj
         AUQ/aKcDY9UGv6FedFL0xxpV0PDeEkZIjS9RGAYk0ZZgeq0YPSXmDbBNG1aIhIDvqFu3
         wIHullp0XrEH/cfxfq/dq+a596/x0AZepjZrLMIN7H0d/TTsiir1lFTtD1PkfufGGnGZ
         SdEtMAHyAt5Ls9Edm+w+st1vz0HMWj2rGAqybUVBy/Ll8AU91bJ/ogU4GHj42Jy2ybJW
         DP6vAAZy9S08nuE7wGpwLsV8F2ekQejz3GA+UwtWTPjyJC/YnNpQ9HaAv85jyEcZU9k+
         96bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ehDGWtkqgI5cIEy6xxMNiw5HarncBsti9O8PZhYizg=;
        b=KdQjdbMc9unKIsXKryX3KKU8BkSjBaQ6Y/pM2/FdUjoC8k4xkN7gOgGu5WU9xm1vqh
         Xi1QOtgMYOL9rOgUMbeWcbYGcak4v6P6ZHQ8RNgCOPXXmnmK/+g1/x55rTWRbtZvqQb6
         PCkKfNP4aN763tot0/5qLsqsUhLs56zGN76n/otPnxSgaPspxhIeVOZeZ5ar09YR9/Kb
         jFAN2naFSFSYnTgUG2GuMZoGHyHrJHo+r0UvnCjdlQuDBVr0+smPLak5PbJW9O1FmrKc
         rlhiTKbR2hD56T8RkvII/uFicF77+n1+duYTRB72exU461Tes2qY2XhiTdtVGrUmIvTM
         edwA==
X-Gm-Message-State: AOAM530+6w3jKnQO5yLelTT5tyqxWMogfAvf8uExV9TMzAThGQnDidM5
        bnApE48TQRuOmCuVFy1QMD0ORWt6W8l3Mg==
X-Google-Smtp-Source: ABdhPJxlKjtRINANMgPW4oRC7BBk1zJIBzk0sqj66DPYNN55jDsdYqy6K37I3wowmpeQALu+I5ty9A==
X-Received: by 2002:a0c:e849:: with SMTP id l9mr8160819qvo.41.1626462360443;
        Fri, 16 Jul 2021 12:06:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65b0:b974:e7b0:818c? ([2600:1700:e72:80a0:65b0:b974:e7b0:818c])
        by smtp.gmail.com with ESMTPSA id u11sm4313086qkk.72.2021.07.16.12.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 12:05:59 -0700 (PDT)
Subject: Re: [PATCH v2] CodingGuidelines: recommend gender-neutral description
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
 <xmqqv95aqeyh.fsf_-_@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f39c467-1d95-8f74-5e4b-6889c4352f9b@gmail.com>
Date:   Fri, 16 Jul 2021 15:05:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv95aqeyh.fsf_-_@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2021 2:41 PM, Junio C Hamano wrote:
>  The only change relative to the previous one is that this
>  explicitly calls out that some are taught that 'they' is only used
>  for third-person plural.  As we already say that some foreigners
>  find it ungrammatical and unnatural to use 'they', I actually do
>  not think it is necessary, but I'd prefer not to leave easy loose
>  end hanging untied, so let's close this round and let others polish
>  on top if they wanted to after the dust settls.
...
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned that "they" is only used for third-person plural, e.g.
> +    those who learn English as a second language in some parts of the
> +    world.

Perfect. Thank you.

-Stolee
