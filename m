Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99DC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 01:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD252084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 01:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMJ4pXko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAPBXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:23:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37095 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAPBXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 20:23:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so17929231otn.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 17:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6V6t1IWNMfZFqjjf18u1DaxEQN4NaPKiMuo7+jVA3nI=;
        b=uMJ4pXkoVxmh7TObmRBwSVX6H1vGICl2RyRc5kyzE33npcxml+72hCVsxE0Sg/pyeQ
         iZH+LssnD4s9u87BxojGGo9j6p0ZJtHTlvzcVSf0MlyK+3l7Jck1oTw3k2dFTKAPHvjI
         742FPkTmL+SG6pqw82fxB85GqwWDUhM7Lfg/KTtIgdGuI4Ey0Yo6yF0CJLFFfyNe+kBQ
         uaAkNN+c0LD+nx/pVO/tkXELaAwXzuDHQWu+iXYlrz+olHy+6B0uqvBHgRBI6fXx3E93
         LJ+b8aiUL986BU2zTmyJTXMbzhVzyhmeT+QaRednWc2nAojR5Bk7HyLMoPDAsYt/iqBb
         d4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6V6t1IWNMfZFqjjf18u1DaxEQN4NaPKiMuo7+jVA3nI=;
        b=GFPgRvd6K46i9gAqObSFfxYAGdGicH+Q4/3DtYepge/cSsY7vrcyAtGDipEgfwubxS
         lwpd9mUZTgqcVtLVYMIlB7ckhum51H9qmR0t/VrIikw/mBEQA2zq/Ezgm0usB/+0LG4c
         e+E+73+59hKbgwKIVo+IddKAIVRQ8m49h46U6G4I/9uLZiQ9a5FU5VJIBioDNr3iMiur
         4Tuda6Cn7x2UX2aiQGojZn4lbs0X9wkzttgSjLqsACcbGj3vUTTUl/CYQHD+7vXQGibs
         Otv3Kiv436hRj1nw9MK9iYrcM1NJVPevJpdkOfBGaSZGATcrcebZ924ZC2OxXTqBuRnj
         DyYg==
X-Gm-Message-State: APjAAAVTe3L6FSs8NcCdqmCp6QyalAmS4adELVAMGSaONIrx70lneyS9
        1G8q5YpSyNHzxSBkXc5aA20=
X-Google-Smtp-Source: APXvYqwAB4fA3Wik6KadwWG4qMus59M+8Tw4OQ/BfZ8fyxuoO5JpdPb5o8RIj7OFyNwpM1xu2SmQVA==
X-Received: by 2002:a05:6830:1503:: with SMTP id k3mr114378otp.213.1579137818377;
        Wed, 15 Jan 2020 17:23:38 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q5sm6262311oia.21.2020.01.15.17.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 17:23:37 -0800 (PST)
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
 <CABPp-BHywo5Js0YGwDykV8G+=Y6-M_Wh3sE5BvC-7zArJd1rLw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e008da66-defe-d2b0-410b-64b7754b9c6e@gmail.com>
Date:   Wed, 15 Jan 2020 20:23:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHywo5Js0YGwDykV8G+=Y6-M_Wh3sE5BvC-7zArJd1rLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2020 7:38 PM, Elijah Newren wrote:
> Is there an inverted phrase corresponding to "the gift that keeps on
> giving", something like "the punishment that keeps on punishing"?  If
> so, it would be a very appropriate description of dir.c.

At least we will continue adding tests until we converge towards
correctness, and the behavior issues are even more contrived and
special case (like this one).

> Yeah, I still have context.  I even think I've got an idea about what
> the fix might be, though with dir.c my ideas about fixes usually just
> serve as starting points for debugging before I find the real fix.
> I'll try to dig in.

Thanks! I'll try to review it carefully when it arrives. Good luck.

-Stolee

