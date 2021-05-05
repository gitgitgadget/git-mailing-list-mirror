Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F233AC43460
	for <git@archiver.kernel.org>; Wed,  5 May 2021 17:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04AE6105A
	for <git@archiver.kernel.org>; Wed,  5 May 2021 17:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhEER2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 13:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhEERI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 13:08:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E9C034630
        for <git@vger.kernel.org>; Wed,  5 May 2021 09:42:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j19so1670200qtp.7
        for <git@vger.kernel.org>; Wed, 05 May 2021 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rUt6aqk5kPlQViShiFcj5wX4j39mpcyzq/urBNeaT4=;
        b=JJpn9wXKSSgXr67DhSCToEemUemsNzJ1Lk3Iyo9QjOw5QoNBlx0X79t4IMe2odbGyF
         auoBAemgRTY0F+/oWj95Qmu9pWhNhFa3R7I/i/qnSZm6K77yGT5Mss11QVRhD4LQvLAp
         iUEDj2Ql3IhqSorwiE/oS7iMi48X/iy7gKpRnUma4VkWiiaNR1lerIEfmsQ43yHVYJkV
         1hJt07sqBoZFHlxLF0WjS9ZJ00MRmh3vClX4U62veKRu1oyiHu3PAfbohlM583GRyYhf
         EecZOHutW+QrsFLWqt+grBrxB23DcVdbg1LJl5ryP3lWKXsQKlf/UfSzh1tFC4hfwjIS
         AnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rUt6aqk5kPlQViShiFcj5wX4j39mpcyzq/urBNeaT4=;
        b=fxLVwthWjD4/wIoTQ9GdIAZwA5A7aoSn1XdSAtJM9GAmc4YYyv6utnv7K9zmAb3eqK
         tQtkc0IT3Xc/kVvCH12ENx8VAy49hn1mhBeyJtJbpOqBxhmRdWpeHuBa1COwdbvU06I1
         47k/G7M9jQj861BgIfo9N56ERAEPANdymk0dkwUF7jeW2Zeuy+9P9uS9cV3JJQQYakF9
         6R03Tr53pik2oSVkksmxBKADjRf3JQ1BSliTxDRvKSvKnJrbM9ZqKdA/5hdPTPQDesVN
         QDmrsMV1+qiQpOQE5MGmsUTdiqvPUYbfYrSxezwR/DUhsV0ZoneDOt/CUx8Wu+kWftRS
         thBw==
X-Gm-Message-State: AOAM530PHNLuHTS++bpfh1MvqmI2qrKwdF8SJBrk4rrfP+L4inOOnB1y
        qt9pRWWM+oGErNVc39rHZLbqgEwIwsHunQ==
X-Google-Smtp-Source: ABdhPJzXtNfcM440g1oFCCTu2o/TTdEicSvMWzSJYpusgwV0biV0iRbuSvGjOd8uX0dXoFkfapnqMQ==
X-Received: by 2002:ac8:5fd4:: with SMTP id k20mr4204716qta.239.1620232932491;
        Wed, 05 May 2021 09:42:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ecd5:a409:e9b9:b043? ([2600:1700:e72:80a0:ecd5:a409:e9b9:b043])
        by smtp.gmail.com with ESMTPSA id j13sm5231768qth.57.2021.05.05.09.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 09:42:11 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] fetch: teach independent negotiation (no packfile)
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <cover.1617929278.git.jonathantanmy@google.com>
 <cover.1620162764.git.jonathantanmy@google.com>
 <1de34a6dced3f5477162dd675615342bc2dec05f.1620162764.git.jonathantanmy@google.com>
 <xmqq4kfi54kb.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9f650594-c8a6-4d89-2686-49de48aabb62@gmail.com>
Date:   Wed, 5 May 2021 12:42:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kfi54kb.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2021 9:53 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> +static int add_to_object_array(const struct object_id *oid, void *data)
>> +{
>> +	struct object_array *a = data;
>> +
>> +	add_object_array(lookup_object(the_repository, oid), "", a);
> 
> Moving to lookup_object() made me look around, but at this point the
> object in question (which comes from the negotiation_tips) has been
> instantiated, so it is OK.
> 
>     Side note. The big difference between lookup and parse is what
>     happens when this process hasn't seen the object yet---the
>     former will just return NULL instead of instantiating the
>     in-core copy; for that reason, it is easier on the readers to
>     use parse_object() if we know we want an in-core object *and*
>     when we use it we want to see it parsed already).

Please forgive my incorrect recommendation here. I was expecting
lookup_object() to behave like lookup_commit(), which creates the
object if it is not already in the cached set.

>> +static void clear_common_flag(struct oidset *s)
>> +{
>> +	struct oidset_iter iter;
>> +	const struct object_id *oid;
>> +	oidset_iter_init(s, &iter);
>> +
>> +	while ((oid = oidset_iter_next(&iter))) {
>> +		struct object *obj = lookup_object(the_repository, oid);
> 
> This one obviously is OK ;-)  The fact we are clearing by definition
> means we already do have in-core objects.

Thanks for your careful eye here.

-Stolee
