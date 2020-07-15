Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E027C433E3
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A7420657
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/uStrwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgGOIzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGOIzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 04:55:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A78C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 01:55:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so1541001wrv.9
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3qbhL/jvswSQofI0ftKaAdocaoR/VGu7yyWnQe7lac=;
        b=E/uStrwCkNTe0EYMKBGFhjsHv9WlHz4KIkR5JrjovVGzjN702RQU5Uv4KbtRkDJgIU
         03uM5hURqI7D6GUU9VDbptJ6rCqKTYEl+LKrg2xX0haknsi0xIGpJGUDmw619j+4BFak
         u8A00hqxTWuzI7aUYTNW/r9kOMg3gS2uWPIl7d8IBJc9CT9+8M+DfnCnkHuXh+v2sw7s
         sYEVKPj5z8cVHKhCC+x0LtA+bs5u8Ue/bm7hDkoUu6ZnnLMPLMZJ8CROqb4HDpFQBNbg
         6qxXKhzK5LPh1/cPXw6fwPC5whyY4CVXarDZq9Uk5LwsMznNGEwoYGRYQE5J62CUqrVA
         f4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x3qbhL/jvswSQofI0ftKaAdocaoR/VGu7yyWnQe7lac=;
        b=d41fD2YPjHMEnvFVAjfAszgmU75wywTq/qAGnKbXY3MrUpvBdoT1K9ZGKgswu1amxC
         pqbDo+CRvowhjkqJQ53V/Bd4AppoloGfmzgjV2qwTYvBB3UxSmsYXaAVZFw21eciTB0E
         EyLvRZ/oaALbfG6hFIjUyL0F4aX6RumrheF3//9ZDrQNnShgG2X0+jWw/ra2eSsDlngr
         9CfF6KCOSfzz2Jhq60gYDk+exyYFQmFUE/cLE76zUDrRJ2V76xDVDeTrBWczSpswSvxD
         gWrifqygKCvBmtFjnKmA9zuWFdF6Vc3Yht2U82ASZAJVzyobusykH4DRjrb241VbElEe
         LSog==
X-Gm-Message-State: AOAM5336EMrjBFUYKHGjWomui00z6xB1JeVrtdU6zpcwqB2DbM1l1mJz
        hVXQOsTtf/AhCrtc2Ata3SKW18vE
X-Google-Smtp-Source: ABdhPJydh4Hyx/qsMWRz6F+XmxW4fAvCLSWHXg7RA3ZWF/bmABzGIJy5ZABXxzG95Uh7LYH62VLHTg==
X-Received: by 2002:adf:c551:: with SMTP id s17mr9825225wrf.330.1594803321496;
        Wed, 15 Jul 2020 01:55:21 -0700 (PDT)
Received: from [192.168.1.240] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id l1sm2792913wrb.12.2020.07.15.01.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 01:55:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/5] fixup ra/rebase-i-more-options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
 <xmqqo8ojo2ml.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e0cfe987-1b47-6b5e-b4e9-10223b73fe22@gmail.com>
Date:   Wed, 15 Jul 2020 09:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8ojo2ml.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2020 16:28, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Phillip Wood (2):
>>    rebase -i: support --committer-date-is-author-date
>>    rebase -i: support --ignore-date
>>
>> Rohit Ashiwal (3):
>>    rebase -i: add --ignore-whitespace flag
>>    sequencer: rename amend_author to author_to_free
>>    rebase: add --reset-author-date
> 
> Thanks for polishing them further.
> 
> Will queue; with help from others, this can be one of the early
> topics to be merged after 2.28 gets tagged, hopefully?

Yes I hope so, I'm not aware of any outstanding issues (lets see if the 
reviewers agree)

Best Wishes

Phillip

