Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480FC1F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 20:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfJSUP0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 16:15:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39902 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfJSUP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 16:15:26 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iLv8F-0006zs-7C; Sat, 19 Oct 2019 21:15:23 +0100
Subject: Re: [PATCH v2 5/9] pack-bitmap: introduce bitmap_walk_contains()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-6-chriscool@tuxfamily.org>
 <dce8e0b5-c4ea-f4f6-6275-1322f2d7200b@iee.email>
 <CAP8UFD2dLPguCnUhTu+F4SNPxFZ7YT5io0qXkVwvSNP-sA8Jxg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c1764a23-15d1-cbef-a675-0f4242bc41f4@iee.email>
Date:   Sat, 19 Oct 2019 21:15:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2dLPguCnUhTu+F4SNPxFZ7YT5io0qXkVwvSNP-sA8Jxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On 19/10/2019 19:55, Christian Couder wrote:
> Hi Philip,
>
> On Sat, Oct 19, 2019 at 5:25 PM Philip Oakley <philipoakley@iee.email> wrote:
>> Hi Christian,
>> can I check one thing?
> Yeah, sure! Thanks for taking a look at my patches!
>
>> On 19/10/2019 11:35, Christian Couder wrote:
>>> +int bitmap_walk_contains(struct bitmap_index *bitmap_git,
>>> +                      struct bitmap *bitmap, const struct object_id *oid)
>>> +{
>>> +     int idx;
>> Excuse my ignorance here...
>>
>> For the case on Windows (int/long 32 bit), is this return value
>> guaranteed to be less than 2GiB, i.e. not a memory offset?
>>
>> I'm just thinking ahead to the resolution of the 4GiB file limit issue
>> on Git-for-Windows (https://github.com/git-for-windows/git/pull/2179)
> I understand your concern, unfortunately, below we have:
>
> idx = bitmap_position(bitmap_git, oid);
>
> and bitmap_position() returns an int at least since 3ae5fa0768
> (pack-bitmap: remove bitmap_git global variable, 2018-06-07)
>
> So I think the fix would be much more involved than just changing the
> type of the idx variable. It would likely involve modifying
> bitmap_position(), and thus would probably best be addressed in a
> separate patch series.

So, IIUC it is mem-sized, so I should at least note it and pay attention 
to it for my >4G series, which like you say is "much more involved than 
just"...

The patch to flip over all the affected locations is a bit humongous 
(big), plus it's a bit of a moving target...
>>> +
>>> +     if (!bitmap)
>>> +             return 0;
>>> +
>>> +     idx = bitmap_position(bitmap_git, oid);
>>> +     return idx >= 0 && bitmap_get(bitmap, idx);
>>> +}
Philip
