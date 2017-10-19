Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7905C202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 15:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdJSPMK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 11:12:10 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:49363 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbdJSPMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 11:12:06 -0400
Received: by mail-qk0-f181.google.com with SMTP id q83so10737787qke.6
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iqd+ObGZkq5uTat/6Y9OMjQ5tToyL/A7v9LxWT1XULc=;
        b=R2x5ztz4XaaxLOHLJsN1S5hDgvGBHu+61nb5SFCXlFOoQbqar5ICRYPn0DPEKz/YqC
         dZ43np7BzZhC7lH3ujwGzU8ATpIz1Drv5c3+9dNTP2V3X/j1Kc71F7IBlic0ZXQt6ync
         9zZi3ZRoQX2c+cguZFq42ViG/5xiy0soBxYHXU9dBqDWDmvazYU/iEwJFrJhfu0N2QF0
         RWxDvLVD0KBiBiIqgFnhZh37lX73Mb+0QIx9QCLa1ArNbzrjbegny1M8bBTxAoP/YlMO
         SDUlePqHZ1FDMUHz0XFI13PaSUDg7mq28bGf1UATlkRnvcEPRumAj3QAZl57H/Ic1EVu
         V1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iqd+ObGZkq5uTat/6Y9OMjQ5tToyL/A7v9LxWT1XULc=;
        b=BxLYvHVYdzwlxGAiwH/lZbcZqLyyrhXZ6nfAXM8rOeSackVu4hTvCwMGAAFHomBkeZ
         ZCEBTWIL6tmESrfwcs4iibKQoSlFs9r0jCTSzeXDUJ1J5vNvMT0v+vFQgd5P6EQrbZve
         GxHSks+ILCEdZho+xqhkhhZz/CDj+Ld1Bl5/ieF+wmWo0esfBrAwNFRjW70ni4NzghEe
         5ndktekYzyCjHfzIA9tOLuq8r7dVp9FZXgostInA4bGZm5dALxb+cssNE+37PhlbVKq3
         8WE88Trn9+NupRA1EbOsGA9sdaHTH9jwdgAfQFK1U9T3FR6LTC7gZ+QOLU+iDvLWhw4w
         U82w==
X-Gm-Message-State: AMCzsaU/Jwx3jFlMirwgC0NGkS/+4RQZOCMWnPnrkkX/xGW97+EUTtYU
        QaWBg2YPka88z1F/sRq1oUmeQGpC
X-Google-Smtp-Source: ABhQp+ShiSoxTZKOlspzGVRTu2/pzhC7nN3B3bc8Kkv+X+8dIe9de5Xl8S0peEOm/693t1G+RNyjzw==
X-Received: by 10.55.100.14 with SMTP id y14mr2244942qkb.242.1508425925424;
        Thu, 19 Oct 2017 08:12:05 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s22sm9745775qta.67.2017.10.19.08.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 08:12:03 -0700 (PDT)
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache
 entry order to speed index loading
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, t.gummerer@gmail.com,
        mhagger@alum.mit.edu
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
Date:   Thu, 19 Oct 2017 11:12:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/19/2017 1:22 AM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> There is code in post_read_index_from() to catch out of order entries
>> when reading an index file.  This order verification is ~13% of the cost
>> of every call to read_index_from().
> 
> I find this a bit over-generalized claim---wouldn't the overhead
> depend on various conditions, e.g. the size of the index and if
> split-index is in effect?
> 

I tested it against 10K, 100K and 1,000K files and the absolute time 
varies with different sized indexes, but the percentage is relatively 
consistent (after doing multiple runs and averaging the results to 
reduce noise).  I didn't measure it with split index so can't say how 
that would impact performance.

> In general, I get very skeptical towards any change that makes the
> integrity of the data less certain based only on microbenchmarks,
> and prefer to see a solution that can absorb the overhead in some
> other way.
> 
> When we are using split-index, the current code is not validating
> the two input files from the disk. Because merge_base_index()
> depends on the base to be properly sorted before the overriding
> entries are added into it, if the input from disk is in a wrong
> order, we are screwed already, and the order check in post
> processing is pointless.  

The original commit message doesn't say *why* this test was added so I 
have to make some educated guesses.  Given no attempt is made to recover 
or continue and instead we just die when an out-of-order entry is 
detected, I'm assuming check_ce_order() is protecting against buggy code 
that incorrectly wrote out an invalid index (the sha check would have 
detected file corruption or torn writes).

If we are guarding against "git" writing out an invalid index, we can 
move this into an assert so that only git developers pay the cost of 
validating they haven't created a new bug.  I think this is better than 
just adding a new test case as a new test case would not achieve the 
same coverage.  This is my preferred solution.

If we are guarding against "some other application" writing out an 
invalid index, then everyone will have to pay the cost as we can't 
insert the test into "some other applications."  Without user reports of 
it happening or any telemetry saying it has happened I really have no 
idea if it every actually happens in the wild anymore and whether the 
cost on every index load is still justified.

> If we want to do this order validation, I
> think we should be doing it in do_read_index() where it does
> create_from_disk() and the set_index_entry(), instead of having it
> as a separate phase that scans a potentially large index array one
> more time.  And doing so will not penalize the case where we do not
> use split-index, either.
> 
> So, I think I like the direction of getting rid of the order
> validation in post_read_index_from(), not only during the normal
> operation but also in fsck.  I think it makes more sense to do so
> incrementally inside do_read_index() all the time and see how fast
> we can make it do so.
> 

Unfortunately, all the cost is in the strcmp() - the other tests are 
negligible so moving it to be done incrementally inside do_read_index() 
won't reduce the cost, it just moves it and makes it harder to identify.

The only idea I could come up with for reducing the cost to our end 
users is to keep it separate and split the test across multiple threads 
with some minimum index size threshold as we have done elsewhere.  This 
adds code and complexity that we'll have to maintain forever so is less 
preferred than making it an assert.

