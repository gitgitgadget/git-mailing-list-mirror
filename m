Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0557921847
	for <e@80x24.org>; Wed,  2 May 2018 13:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeEBNmx (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 09:42:53 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:39533 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeEBNmq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 09:42:46 -0400
Received: by mail-qk0-f169.google.com with SMTP id z75so11220273qkb.6
        for <git@vger.kernel.org>; Wed, 02 May 2018 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iAnbyO1BqiXOn3D0SZPn3Sdi7WlXF3IoV1I61zpGO4c=;
        b=YVunXm65mI34SzEeVpSQYjh2jEa04Qi4YPy6UhwBIFJlo8A6hc0gx4KNv/7bRtGU6S
         3bwotzu0MKlIT2wBAWXCP1yE8fosKfJvfnwTd7KAk9/wwOF02Z2ybizjbRiQiP+F0zIR
         QKUq03BworEie/qTmTvkQSEUxpOHjSaeQl97R4WlWiyKluF/sahJk7c6TOcBaxVkcFnT
         XQ7ExT14d3u5BQJtU4I8ZD5YMKAJ8jpi4at+RGUaA/a071PO55xmqZRiwe6plBFMf++H
         t4BKDuxtRasK9dAsTNBgF3vHxsLNlxAUBZZL4MyY4RcqZZ/a345GBxH+yo5pIbkxM3p8
         5mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iAnbyO1BqiXOn3D0SZPn3Sdi7WlXF3IoV1I61zpGO4c=;
        b=WQcshrO9KWcnXYGONDUEAoy1s5Dx5RBSD5TSKcz8nfPGZwSpR+mltsXxbWfnRJ78Ob
         oMexMi/yVZHWBkojFYbDMNTRg1B/ygvihUpI4tEBmgD1jjwCG/JQvOk4QWE7F72+2LZV
         LUFlcI/uxlkBJ+tVinu9hO0kA7G+MEcv8CekR0wjLTLe6A2qZzQ7TAazR3hP6iYF0KBG
         XQ5PGVCe9sKHQzRK+mnCQFy6dtr+seXFB4joTvEzPxACcdGTlCWJcxfQsG1q821Z+ChB
         6Ew/+7Eve59ftJ9s1Irf+gieDqCCfrVNGf5pGU7L0+FiAyj4/zmH2GhThVP7V/EZR9c0
         3a9Q==
X-Gm-Message-State: ALQs6tAbr8OCB/JB24onjRhOlyTg0m3xoeLkUungauJ9muveZHoGewYQ
        T95vSZz5qo26ARvJe1mSLdo=
X-Google-Smtp-Source: AB8JxZoARCqcjEVNQTUqIpllGGezwbvNx1BjeYpb8DUX0zxtxZFuzAg5zWgVecygvxQOp7NjmOVOpA==
X-Received: by 10.55.143.131 with SMTP id r125mr15896163qkd.163.1525268565091;
        Wed, 02 May 2018 06:42:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id g64-v6sm8434307qtd.5.2018.05.02.06.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 06:42:43 -0700 (PDT)
Subject: Re: [PATCH v4 08/10] commit: add short-circuit to
 paint_down_to_common()
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-9-dstolee@microsoft.com> <864ljsgwx1.fsf@gmail.com>
 <3e3ae7e4-9efd-3046-c0c2-7b3bf12d0d81@gmail.com> <86a7ti1a4h.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a440cce-76ab-3d62-5a06-cf411fe35b48@gmail.com>
Date:   Wed, 2 May 2018 09:42:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86a7ti1a4h.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/2018 9:05 AM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>>      For a copy of the Linux repository, we measured the following
>>      performance improvements:
>>
>>      git merge-base v3.3 v4.5
>>
>>      Before: 234 ms
>>       After: 208 ms
>>       Rel %: -11%
>>
>>      git merge-base v4.3 v4.5
>>
>>      Before: 102 ms
>>       After:  83 ms
>>       Rel %: -19%
>>
>>      The experiments above were chosen to demonstrate that we are
>>      improving the filtering of the merge-base set. In the first
>>      example, more time is spent walking the history to find the
>>      set of merge bases before the remove_redundant() call. The
>>      starting commits are closer together in the second example,
>>      therefore more time is spent in remove_redundant(). The relative
>>      change in performance differs as expected.
> Nice.
>
> I was not expecting as much performance improvements as we got for
> --contains tests because remove_redundant() is a final step in longer
> process, dominated by man calculations.  Still, nothing to sneeze about.

One reason these numbers are not too surprising is that 
remove_redundant() can demonstrate quadratic behavior. It is calculating 
pair-wise reachability by starting a walk at each of the candidates (in 
the worst case). In typical cases, the first walk marks many of the 
other candidates as redundant and we don't need to start walks from 
those commits.

A possible optimization could be to sort the candidates by descending 
generation so we find the first walk is likely to mark the rest as 
redundant. But this may already be the case if the candidates are added 
to the list in order of "discovery" which is already simulating this 
behavior.

Thanks,
-Stolee
