Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF452C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9CF61107
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhIUBpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhIUBlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:24 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ABAC04F368
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 13:56:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a20so20244755ilq.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wrT6YLcvtAmrOlS54Q1gMZ2Qmg6XlL89F8hs/Qk7ApY=;
        b=K4SXAlhzgJB/MGRJEDDBn5KVnYgm2FwNmThkIInyK/QOeJFBYgqtWtzKJGtIT2nWjL
         oox7qiWfNkyY+eB/2kkfEbWX98Wpzr/ce4X7M/gcGYscChJesvq6ULvoIt089nb+br44
         HtuKz5d/cIVm/YMHo67LdMGFVCqqT1vwpXrtxAGQ1ttVGsBoffLWnje0HFNIwV06fdzo
         AmETy2MrYO8ya5NHu6RP/KEtmwCshBZ82xOOZ9tEZcE/XUmB6Jwnwq8Aif5tXwccY2qF
         oNHRDjZhxcsTO015wwQuGHEZXIk1i9pNAULTz7WEzw9ihkqtrZn2YVcBYXzYXguDrjAF
         daDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrT6YLcvtAmrOlS54Q1gMZ2Qmg6XlL89F8hs/Qk7ApY=;
        b=dVmgVPePdyz1m1JeLiEnzRKyXPA/fTy82WuotUg0J7hWfQVU5tNdLsS6MwgIl+oQlw
         vanqtO1SLnp6h2iplTR1j0IEJLKPaJHKLiVlQYhEq7yxaY8RLn9fstIpvBd2Y+pmfCfX
         pK3fZrNCcSyzj2uFn5iF82NFeegbJ5VO8Ag0i+j/X6WvnD3j8wYqFgmQ+jbqUDJW8UX7
         Dge5U2i28z9zDp1fcVDJMLgXMloZyNfTesaitScrMcBJiDNrbvQrn4LfReE+HCc1/DWP
         ZwX55JHItoqfThSBM7+UyM4xPl+jpwiIXCZvzLnG0BSeXIPo2J3w6p1nYCTNUKssjFfx
         CRGQ==
X-Gm-Message-State: AOAM533hC0zYjInOt3ad7apaiR0EjZkmwwW/aeqAf26XPXj7+YWmQGtw
        rLHhjOAEB/pQK/NvI3Puw0xP+Lf+mIa5Tg==
X-Google-Smtp-Source: ABdhPJzGyu8WU0BpNH3d5Om36MptNX2mCmI/d9lryE8xNLJwVVAA5AXz8sLi2gbkQntpzN4HhdGbdw==
X-Received: by 2002:a92:130e:: with SMTP id 14mr18899556ilt.129.1632171409349;
        Mon, 20 Sep 2021 13:56:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id e10sm8728315ili.53.2021.09.20.13.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 13:56:48 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
Date:   Mon, 20 Sep 2021 16:56:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUjcMu7Z094eaFRA@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2021 3:08 PM, Taylor Blau wrote:
> On Mon, Sep 20, 2021 at 01:27:25PM -0400, Derrick Stolee wrote:
>> On 9/20/2021 1:25 PM, Derrick Stolee wrote:
>>> On 9/20/2021 12:42 PM, Taylor Blau wrote:
>>>> We would probably want to perform this check both during initialization,
>>>> and when adding patterns in cone mode. It may also be worthwhile to
>>>> check the validity of the cone before running 'list' or 'reapply', too.
>>>
>>> 'list' definitely seems like a good idea, since it is expecting different
>>> output than the literal patterns when cone mode is enabled.
>>
>> I double-checked this to see how to fix this, and the 'list' subcommand
>> already notices that the patterns are not in cone mode and reverts its
>> behavior to writing all of the sparse-checkout file to stdout. It also
>> writes warnings over stderr before that.
>>
>> There might not be anything pressing to do here.
> 
> Hmm. I think we'd probably want the same behavior for init and any other
> commands which could potentially overwrite the contents of the
> sparse-checkout file.

Could you elaborate on what you mean by "the same behavior"?

Do you mean that "git sparse-checkout add X" should act as if cone mode
is not enabled if the existing patterns are not cone-mode patterns?

What exactly do you mean about "init" changing behavior here?
 
> Those may already call list routines internally, in which case I agree
> that this is already taken care of. But if not, then I think we should
> match list's behavior in the new locations, too.

"list" interprets the 'struct pattern_list' in two different ways,
depending on the use_cone_patterns member. They are static methods in
the builtin code, not used by anything else.

Thanks,
-Stolee
