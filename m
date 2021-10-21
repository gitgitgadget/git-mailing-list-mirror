Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBAC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1260F9F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUWtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:49:32 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47815 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUWtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:49:32 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mdgq9-0004KH-By; Thu, 21 Oct 2021 23:47:14 +0100
Subject: Re: [PATCH] unpack-objects: unpack large object in stream
To:     Han Xin <chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <aeb1c7cb-7e01-8a21-5f7a-d27bd43d7604@iee.email>
 <CAO0brD1CXhuAwQe5mmjWcD1dF-cdRdk4o1rm0wyygbhEjRR84g@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>
Message-ID: <07e7e056-7f50-4a1b-5ca4-b9994b846e7b@iee.email>
Date:   Thu, 21 Oct 2021 23:47:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAO0brD1CXhuAwQe5mmjWcD1dF-cdRdk4o1rm0wyygbhEjRR84g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/2021 04:42, Han Xin wrote:
>>> +static void write_stream_blob(unsigned nr, unsigned long size)
>> Can we use size_t for the `size`, and possibly `nr`, to improve
>> compatibility with Windows systems where unsigned long is only 32 bits?
>>
>> There has been some work in the past on providing large file support on
>> Windows, which requires numerous long -> size_t changes.
>>
>> Philip
> Thanks for your review. I'm not sure if I should do this change in this patch,
> it will also change the type defined in `unpack_one()`,`unpack_non_delta_entry`,
> `write_object()` and many others.
>
I was mainly raising the issue regarding the 4GB (sometime 2GB)
limitations on Windows which has been a problem for many years.

I had been thinking of not changing the `nr` (number of objects limit)
as 2G objects is hopefully already sufficient, even for thargest of
repos (though IIUC their index file size did break the 32bit size limit).

Staying with the existing types won't make the situation any worse, so
from that perspective the change isn't needed.
--
Philip
