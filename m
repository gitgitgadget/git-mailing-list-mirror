Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24734C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 16:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED12020829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+382MT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgG3Q5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Q5X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 12:57:23 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE7C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 09:57:23 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r19so4322759qvw.11
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zxqcfukoj3np4/Y+7H/F1mW2i3odag6pvbL83LCgsbw=;
        b=e+382MT6tt48tThBQhprFoJg6odnEUMTiOr7kemkcXADRpdTtrYGty2crf+LdAAzKa
         DAJB9j8ORO9HxGtf4p6ZsWRoE241vvGY60CGM9v92y/6S0rOABwKIz4aDYMxCqKcMn+M
         WFr2yf9XgilCyECPCNu3T2mRh+1umkI1oPkLaYSG6GZ3r85U2yVyb63+b6Q7jln8ijeR
         Ed50qLOTZvzDaZ7kLjf8369k1jkBPMWERjvOXxssYoa+vyfmuFk/7lGSNHU5+zBQmj2e
         qoKpPA0OVW3wVg1j/pq9+RmosljP+RvcntNN0j3c2WxYx4aYFE/Z2iyhGaAAx+XFvA/L
         Dn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zxqcfukoj3np4/Y+7H/F1mW2i3odag6pvbL83LCgsbw=;
        b=i46LY/SP/WTkt7d1ftEvnXudMeseDIhcYUo/ezP2KazufllA6+AdOMJcX5fcUfJ1Tv
         Vm/5WmXKYdAGoZUcd0JIvVqH+TPvjrlMGlRG7zmtduvX5jeUnjVtMHUjhaKbzxHvS5rO
         8bsXzGwKEJomsGi9Temn430HMwN2gzY7CqUlW62NN7FxDTcW4J6SI6La6J+NYoS011Wd
         b1lSXF25W5pFmoPS1S8VhJStZnQYkik8+uuBZzp9VeTYkEYeXDV5p9HPcHsMiP2N1uYD
         FYeNd1pHXU+xozW+B8aHJ2EdVwpFYyGcwgZuBGV2KIfSBLPhnbc4uH01W0ZaKQMLjt28
         bcKw==
X-Gm-Message-State: AOAM532wXiagVVAGt3Y/lqtMza2+UGtm27YYEJrjQj7LQEFmNB73S/Sb
        D5gtKMPcy5DV9PiDsbez5fM=
X-Google-Smtp-Source: ABdhPJw82gDA9RzM4NZLksDIbhBV1c7LR6JEluUid4QvQ5wBSXE0dK+Bsp9/+dQIJb0KjaNr6rFWnw==
X-Received: by 2002:a0c:ec02:: with SMTP id y2mr29209qvo.140.1596128242051;
        Thu, 30 Jul 2020 09:57:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id n90sm4818408qte.21.2020.07.30.09.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 09:57:21 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <20200729222334.GE2965447@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b374cb3a-f681-d514-c465-6b3f0b674bcf@gmail.com>
Date:   Thu, 30 Jul 2020 12:57:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <20200729222334.GE2965447@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/29/2020 6:23 PM, Emily Shaffer wrote:
> On Thu, Jul 23, 2020 at 05:56:33PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index eb4b01c104..889d97afe7 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -1021,19 +1021,65 @@ static int multi_pack_index_expire(void)
>>  	return result;
>>  }
>>  
>> +#define TWO_GIGABYTES (2147483647)
> 
> [jonathan tan] This would be easier to understand if it was expressed
> with bitshift, e.g. 1 << 31

This is actually ((1 << 31) - 1) because "unsigned long" is 32-bits
on Windows. But it's better to not use magic numbers and instead use
operations like this.

>> +#define UNSET_BATCH_SIZE ((unsigned long)-1)
> [jonathan tan] This looks like it's never used... and vulnerable to
> cross-platform size changes because it's referring to an implicitly
> sized int, and could behave differently if it was put into a larger
> size, e.g. you wouldn't get 0xFFFF.. if you assigned this into a long
> long.

Thanks for catching this cruft.

>> +	for (p = get_all_packs(r); p; p = p->next) {
>> +		if (p->pack_size > max_size) {
>> +			second_largest_size = max_size;
>> +			max_size = p->pack_size;
>> +		} else if (p->pack_size > second_largest_size)
>> +			second_largest_size = p->pack_size;
>> +	}
>> +
>> +	result_size = second_largest_size + 1;
> [jonathan tan] What happens when there's only one packfile, and when
> there are two packfiles? Can we write tests to illustrate the behavior?
> The edge case here (result_size=1) is hard to understand by reading the
> code.
> 
>> +
>> +	/* But limit ourselves to a batch size of 2g */
> [emily shaffer] nit: can you please capitalize G, GB, whatever :)

I suppose I could (get_unit_factor() performs case-insensitive matches
on the size suffixes), except that would be inconsistent with the
following error message in parse-options.c:

	return error(_("%s expects a non-negative integer value"
		       " with an optional k/m/g suffix"),

or these options in Documentation/git-pack-objects.txt:

--window-memory=<n>::
	This option provides an additional limit on top of `--window`;
	the window size will dynamically scale down so as to not take
	up more than '<n>' bytes in memory.  This is useful in
	repositories with a mix of large and small objects to not run
	out of memory with a large window, but still be able to take
	advantage of the large window for the smaller objects.  The
	size can be suffixed with "k", "m", or "g".
	`--window-memory=0` makes memory usage unlimited.  The default
	is taken from the `pack.windowMemory` configuration variable.

--max-pack-size=<n>::
	In unusual scenarios, you may not be able to create files
	larger than a certain size on your filesystem, and this option
	can be used to tell the command to split the output packfile
	into multiple independent packfiles, each not larger than the
	given size. The size can be suffixed with
	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
	This option
	prevents the creation of a bitmap index.
	The default is unlimited, unless the config variable
	`pack.packSizeLimit` is set.

Perhaps that's not really a good reason, but upper vs lower case
seems to be arbitrary. Any tie breaker seems valid.

Thanks,
-Stolee
