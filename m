Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E04C2BA2B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 23:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39552064A
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 23:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6ftqpNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgDHX7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:59:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43152 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgDHX7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 19:59:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id n25so6069400otr.10
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AhrfaIuE3z4lEKCyz1M91TfHuTeTy6GlI1ehaSndFp4=;
        b=Y6ftqpNeI5f13bJKn0Sgq8iKf/qomOXsVOQyLvq48oE54e1nwzbvqEGu4fJAq5PraV
         zIID5RoltkVLWDLhQuiQIxLX4PmeybzJHOcz4Yl9Vlb0DUkrAY2+SYYoog4g4KHjM45E
         mF2MSIo5ny2SnVuLykgVY9wnMzA01gGmdT5WWopOjn7hlelDa5RpgK8MuUvMN/iDkf3n
         gtcmJ6xuPvPs8Rb1WTDIDtOQuM5TL0pUTmXFo2ICgbk1CxzudEuGeaVjwGmrHWhjrOQn
         SrM+09iyUt8FB+q5zcT+EqTBnw7yE/ATPLTEwb3ehWYGIqnXdHtR4i+QauetmY7a7HN4
         H7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AhrfaIuE3z4lEKCyz1M91TfHuTeTy6GlI1ehaSndFp4=;
        b=pVN9N7nR3KkvJSxqxzZ6X4czzEvdz37Oq7Xv1kfmuHh21DtwiBj2gBOFCOyCAPpgVL
         90sya/9sdrZe4vvJIe0x7mHQDVpMMhrc9B+DGxPXBgPVN6gqmF+pG12jH5ZzRiMiWV+X
         z1EE1l3jrbR7IyXtgu/UKr1D/PWYT3cUzSYXmcOVyYuhYfS6qnT4l5DhFFdG2LkOZX+g
         W3r16kDMjcDMXsyXcIqMJ1Ow+lbXpnMwTzUwLurHGh59G4H49XuoPePG20RnaNsdsfvl
         Sq0vj4QBnlEIJI6PqfBid4juT7H1xpTDnnmndA6er2QRF7GVi5KYzKnGdKy7P0lnG8wc
         xJFQ==
X-Gm-Message-State: AGi0PuaNMmicxCHOnR1DLFbb+EI0pu70jzk99ID5b8gO3cJek4HR+Amb
        AH1HRbXlH2drg5OV0pv2PGQ=
X-Google-Smtp-Source: APiQypJrXGdBz6hUf2lMRdQuNJ6r7fVJGf6t55WzAvp34LJEy6gJ8sYGufH6vVyRRoHGhLK1rqhGhw==
X-Received: by 2002:a05:6830:15d4:: with SMTP id j20mr1887145otr.303.1586390359345;
        Wed, 08 Apr 2020 16:59:19 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p137sm1066728oop.45.2020.04.08.16.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 16:59:18 -0700 (PDT)
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
 <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
 <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
 <20200408200526.GA2270445@coredump.intra.peff.net>
 <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
 <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
Date:   Wed, 8 Apr 2020 19:59:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2020 5:35 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Then I suppose we should focus on naming merge commits with this property:
>>
>>   A merge commit that is not TREESAME to its first parent (but is TREESAME
>>   to a later parent).
>>
>> The part in parentheses may be optional, because a merge commit that is
>> not TREESAME to any parent will be included by every history mode.
> 
> A merge that is TREESAME to its first parent does not introduce
> anything new to the mainline (as far as the paths that match the
> pathspec are concerned).  We are trying to find names to call merges
> that are not those no-op merges.  Hmph...

There are three situations for a merge commit:

1. TREESAME to _all_ parents. These are not included.
2. not TREESAME to _all_ parents. These are already included.
3. TREESAME to some, but not TREESAME to others.

The third mode is the one that default mode will drop, but --full-history
will include. The new mode will include some of these (the ones that are
NOT TREESAME to their first parent).

>> In my latest attempt at documentation, I called these merges "diverters"
>> yet still used "--include-diversions". Here are a few other words that we
>> could use:
>>
>>  * diverters or diversions
>>  * redirects
>>  * switches (think railroad switch). Synonym: exchange
>>  * detours
> 
> ...none of the above tells me that they are not no-op (in other
> words, they do something meaningful), so I must be coming from
> a direction different from you are.  What redirects from what other
> thing, for example?

The merges do something meaningful: they "merge in" a "real" change.

I'll just submit my v2 as-is, which includes a significant change to
the documentation that should make things more clear.

Thanks,
-Stolee
