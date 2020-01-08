Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB5C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4427F20692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYp67fDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgAHNk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:40:28 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44245 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHNk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 08:40:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so2569226qkb.11
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MhA3X+B9u617kvzvMoU/KF8dNFWAhZBphVhLvpnMulM=;
        b=qYp67fDTFlqRPgMGJ6Ow7H/kaG7nwSLLoUH9BojTfczGVVqIBxsa1jxaInYOqNoatA
         rht+VY0a4Og1lPIoK7b2EEs9P5gCVJUsV+d1LntQFtRTTp+zMq2Gi2Y0OphR+V7lL6sq
         ElYA9Ql63sxXjI8GG9jq0Z7oApWHOPfUTF5wlFrrRpH3sNpeC9CESKp1kvt8Ie1nq+FI
         gwt3Y/vDcZ5ieyBhUDEIi/CNqI2dn1jBQGwEAqU5zizUWLNc8rTDEABaERQx5x7A/ewW
         An7qOi8k+N/nXsGGSKM6+MPbq47LKYnWDF5xL2q6J3/czOFNQTpoijJSfPPgbzo/QBiV
         33QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MhA3X+B9u617kvzvMoU/KF8dNFWAhZBphVhLvpnMulM=;
        b=lHRuI7tNd04qjh9FuhzH5r0PZWcNs6VOzrQtn7SA5KGKgP4jgZ9NOteEVt4wP3AgvE
         mg/r34mlpN5k4o79XfkCFFiGfjQm+TNKyuPuggD2vE0L3+pfIG93uebobeGVjO0hoNnf
         iDGgJW6P98w9AWV5ZSyXu38nIHvAjrC91NHF8nHdWE4ffzDVb96a8CMnDJ7H6E0glPuk
         EqDZOqdlXrnoIwXKDDMPjjOizvP77GXl9e0Cx7GIRJAgY92XtVQLo9gY/8pgJrwKCHR0
         FlNr2w52WT8ntkK0r2g0aZ04rRBTaQdAF5f2eQhIO3e/ZwXea7hrsMl4IH0tL+V4ts+x
         6hsQ==
X-Gm-Message-State: APjAAAXc3ovb4YMGbgCkbI1ZuLGkvYHlg9okT7gBr3KwEt0cpL3rI1Zb
        Yc4edqNjIue6f6gVpV0oQSs=
X-Google-Smtp-Source: APXvYqyGT2PAxrQb0fg4Fc6i34Ud7xn8c9UOdM9SrkFJQKXDE1QOuBhDdupPAwKpjla+UCpKlD+UKw==
X-Received: by 2002:a05:620a:1005:: with SMTP id z5mr4341619qkj.26.1578490827312;
        Wed, 08 Jan 2020 05:40:27 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3d10:d3f7:2db7:a1e2? ([2001:4898:a800:1010:ee45:d3f7:2db7:a1e2])
        by smtp.gmail.com with ESMTPSA id i6sm1388321qkk.7.2020.01.08.05.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 05:40:26 -0800 (PST)
Subject: Re: [PATCH 2/2] graph: fix collapse of multiple edges
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
 <12abb32531ed7125293986dc139a7ffed3839065.1578457675.git.gitgitgadget@gmail.com>
 <20200108072541.GC1675456@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a0e4637-85de-589f-df31-915b4603e45a@gmail.com>
Date:   Wed, 8 Jan 2020 08:40:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200108072541.GC1675456@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2020 2:25 AM, Jeff King wrote:
> On Wed, Jan 08, 2020 at 04:27:55AM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> Before this change:
>>
>> 	| | | | | | *
>> 	| |_|_|_|_|/|\
>> 	|/| | | | |/ /
>> 	| | | | |/| /
>> 	| | | |/| |/
>> 	| | |/| |/|
>> 	| |/| |/| |
>> 	| | |/| | |
>>
>> By adding the logic for "filling" a horizontal edge between the
>> target column and the current column, we are able to resolve the
>> issue.
>>
>> After this change:
>>
>> 	| | | | | | *
>> 	| |_|_|_|_|/|\
>> 	|/| | | | |/ /
>> 	| | |_|_|/| /
>> 	| |/| | | |/
>> 	| | | |_|/|
>> 	| | |/| | |
> 
> Hmm. Your description and your diagrams make sense to me. But one
> curious thing is that the earlier test you added for 6_* does not need
> modified. Because it continues to show:
> 
>           | | | | * 6_F
>           | |_|_|/|
>           |/| | |/
>           | | |/|
>           | |/| |
>           | * | | 6_D
> 
> rather than adding a horizontal component to the second-parent line.
> That seems inconsistent.

The issue here is that there is not enough room for a second horizontal
line. The horizontal line can only start after the previous has completely
terminated, that is

           | | | | * 6_F
           | |_|_|/|
           |/| | |/

at this point, the first horizontal line has terminated.

           | | |/|
           | |/| |

The remaining movement for the second line has no room for a horizontal
edge. The logic that I added is hit, but the for loop (over j) terminates
immediately without a single execution of the loop body.

If there was one more row to the example, then we would have:

           | | | | | * 6_F
           | |_|_|_|/|
           |/| | | |/
           | | |_|/|
           | |/| | |
           | * | | | 6_D

Thanks,
-Stolee
