Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C18C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4431A20866
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB7LfZqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgACNHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:07:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46733 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgACNHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 08:07:46 -0500
Received: by mail-qv1-f67.google.com with SMTP id u1so15342787qvk.13
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcXCUc+W21aAnff7n8zuE2BRKgubW1+7R53/KSkGRS8=;
        b=aB7LfZqLD5CFB8EUM8K21JPobwMQzmGXTVumDhquTbrBZ9MshEGvRil/mitkz4BaFu
         Pb82ouWnfvNTDtvcBCAbINRFLL9YNdJBz5p4SMYfBhSD9zJxs4w+BQElnkVkgc8ABHiZ
         LhqNosWCly1TXcleYp4QgMpjgCnBq7iuX7OEYu1y7x7ZDAPCJXYLXnROz4PFM1h4Hzts
         zYP3Cqtt17v51xvLV10r2n1fHQykTTS1NXW9c00/fWn+TYbhfZzGqrqIPtaUZCx74SR3
         wLSYAdTNGeDoXBuqPfEnq/0g9TWTs68/UBWOBtUpeL5q7xBKcz4pUdj/ft9QLpaw4jf1
         oUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcXCUc+W21aAnff7n8zuE2BRKgubW1+7R53/KSkGRS8=;
        b=NJOp2XBKlPPzhNnSQXlFPlkR5HRAVqbeZMZW8DiQtCSCnN+nGllLNDm4x/CHkdX9lN
         NZSKtniIJzEKlDysX3rJBVdU/Z9waG+LpIojiB1wxgklNKjh60XEifKlXhqaQ60ALcWI
         +33zuEwMMOSFjPdUYyHxhEw5ScupzWr7GIY1gerbWL5mruxdr5NXmaNNFPcKTsrO6Bh2
         yptzdHtbT1fGE8ZQdL0FzHn7eH63JibadfDLpnBYp3YZhF77ATWZ3qXFYXLPc1bK5LEO
         3g+ZrQOTJP0Em8stezOCeLN6RkeSmocjvw1anYkDc5jgBnn9vSLc+yntwCJpHd3UeeEB
         PPMg==
X-Gm-Message-State: APjAAAVAxTR0chBZjhThg2LQS4i6WDW5AC40uUg+jPX9ivk6YOkCfuN4
        ZXoS46l9zpqshndLD2jPQ98=
X-Google-Smtp-Source: APXvYqy7o7PxFzG1kfDhxa+lLwL0tI5/2uB1Hos0xQSA4VaNUoiBst4CmwYekEIYLPAFh97Vi/JMbQ==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr69101806qvs.177.1578056865583;
        Fri, 03 Jan 2020 05:07:45 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a438:4a34:2dfd:4bc? ([2001:4898:a800:1012:556c:4a34:2dfd:4bc])
        by smtp.gmail.com with ESMTPSA id q73sm16285853qka.56.2020.01.03.05.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 05:07:45 -0800 (PST)
Subject: Re: [PATCH 1/1] fetch: set size_multiple in split_commit_graph_opts
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.509.git.1577981654.gitgitgadget@gmail.com>
 <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
 <xmqq7e29edfd.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6a6547b-495d-9929-daff-9c0069428703@gmail.com>
Date:   Fri, 3 Jan 2020 08:07:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqq7e29edfd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/2/2020 4:49 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This problem is due to two failures:
>>
>>  1. It is unclear that we can add the flag COMMIT_GRAPH_WRITE_SPLIT
>>     with a NULL split_opts.
>>  2. If we have a non-NULL split_opts, then we override the default
>>     values even if a zero value is given.
>>
>> Correct both of these issues. First, do not override size_mult when
>> the options provide a zero value. Second, stop creating a split_opts
>> in the fetch builtin.
> 
> OK, so there is the hardcoded default 2 in the code, and split_opts
> structure *can* override it, but 0 in the field of the structure is
> meant to signal "no, I do not have any value to override the
> default", not "I do want to set the multiple to 0"?

Correct. The multiple 0 makes it so we never merge layers of the
chain, and this was happening accidentally. A caller could still
accomplish this by passing -1, but that is not recommended.

-Stolee

