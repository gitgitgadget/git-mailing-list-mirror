Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D94C433E1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EDD2192A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e27ENUSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgFRBhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbgFRBhe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 21:37:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE3C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:37:33 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so3249119otr.12
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VTpZID4DhQ5ZAAASRqRTfx7zxjbml9/ZjEkbZgLslMI=;
        b=e27ENUSHs8iC6veDaLZF4wPeCUaK8mQKHfeRceOtnCYBofegBMocC3X/CMtuEs2jEG
         NC6ktZ1nOMfHcfvjxQKX9Q0z1XjpZW7Q8qnksuX8/c5Hl6xGE4ff6zbtpz/srusVkZng
         0zz6F8japz2WBtiH6Xdmv3HRM2s5tKU5M6T7tY80zwoWK1+JrRK5CSMQkDPQodnfPJXF
         24nNhv5dFpNJy7ikh1Ho49LhZrOzuE6wY7dBAWoylA9Z9vJ/KBwc58Bd/v5R0etqcRal
         FI8cSziNOgLbnzVXkTdVLYAGweRGgvsTBt5fL6mnX/sGvUjN1SujP8hEqvuS9+QgK4if
         cimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTpZID4DhQ5ZAAASRqRTfx7zxjbml9/ZjEkbZgLslMI=;
        b=ZlnevTDJ27vlk7TIsAWSYVDouFFk8Pwkf74vqa99WWS0H9I2m7X9KjOFuFUXX9tIAZ
         mUn+y82woBT3BWW4TZwrkfgoKHCn2zY83SrjpFrbt/7iCb50ddo/7LBtLWFMTnG7/P3o
         902kf4me4QcvcIfyuMFGDAjTAoiCsb9h0YSbreGl7EGrikQ11YZH5RZCNAZbSsQoLoVM
         pgevGIXj5v5A/pLO1fTkWGYUpD+T5FPEQHSO1W3SBVopBocDpGH0bGkK/MYgNiWOCI8l
         dOp3iyxL9HriUQm9lEqOChQfyAZh3tN2VBFfIY2wW2nYvpexNUpBkuCxl+TWS5STBf9l
         k6/w==
X-Gm-Message-State: AOAM530wXQmxezaSoZLqEGX31zEQj2LnjyoLwvQ95hvt7Z1BJwjj27Vf
        pN5z7ZvqndrYNf3TzWIMKGM=
X-Google-Smtp-Source: ABdhPJx4tUVCSRjW817DqzBiDHkBqkQRKIqcVlmxwG/7a0O95juc8z9MfUVaKlHqjJBkn59Hv06w9A==
X-Received: by 2002:a9d:333:: with SMTP id 48mr1628359otv.160.1592444253155;
        Wed, 17 Jun 2020 18:37:33 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a9sm404255otr.15.2020.06.17.18.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 18:37:32 -0700 (PDT)
Subject: Re: [PATCH 0/2] Accelerate "git merge-base --is-ancestor"
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
 <xmqqzh91s9mn.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9bdbd5f7-7c12-e71a-4e1c-747d247abdc9@gmail.com>
Date:   Wed, 17 Jun 2020 21:37:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh91s9mn.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/17/2020 4:46 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> It was recently [1] reported (and not-so-recently [2] reported) that "git
>> merge-base --is-ancestor" can be pretty slow. In fact, it is regularly
>> slower than "git branch --contains" or "git tag --contains", which are
>> answering a "harder" query.
>>
>> [1] https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/
>>
>> [2] https://lore.kernel.org/git/87608bawoa.fsf@evledraar.gmail.com/
>>
>> The root cause is that the in_merge_base() implementation is skipping the
>> fast can_all_from_reach() implementation and using paint_down_to_common()
>> instead. Note that these are equivalent: a commit A is in the set of
>> merge-bases between A and B if and only if B can reach A.
> 
> OK, so in short, this codepath was not taking advantage of the
> generation numbers and that was the difference?

Correct. We now use generation numbers more often, when
available. All callers of in_merge_bases() will become
faster, which includes callers in these builtins:

	- branch
	- fetch
	- log
	- merge-base
	- receive-pack

and these libgit files:

	- fast-import.c
	- http-push.c
	- merge-recursive.c (several!)
	- pack-bitmap-write.c

Thanks,
-Stolee

