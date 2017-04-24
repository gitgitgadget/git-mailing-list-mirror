Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D6B207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S977003AbdDXSjb (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 14:39:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:24815 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S976993AbdDXSj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 14:39:29 -0400
Received: from [10.181.8.102] (cpe-76-182-13-114.nc.res.rr.com [76.182.13.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9BBAA8448B;
        Mon, 24 Apr 2017 14:39:28 -0400 (EDT)
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170414203221.43015-1-git@jeffhostetler.com>
 <20170414203221.43015-2-git@jeffhostetler.com>
 <870a8a36-fc6c-6b07-d09e-eec8a9f46a5c@kdbg.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8bde0b54-c0f6-364d-1f08-ce5207eb6c86@jeffhostetler.com>
Date:   Mon, 24 Apr 2017 14:39:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <870a8a36-fc6c-6b07-d09e-eec8a9f46a5c@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2017 1:26 PM, Johannes Sixt wrote:
> Am 14.04.2017 um 22:32 schrieb git@jeffhostetler.com:
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 33a51c9..677e15a 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -689,4 +689,17 @@ test_expect_success 'bogus head does not 
>> fallback to all heads' '
>>      ! grep $blob out
>>  '
>>
>> +test_expect_success 'detect corrupt index file in fsck' '
>> +    cp .git/index .git/index.backup &&
>> +    test_when_finished "mv .git/index.backup .git/index" &&
>> +    echo zzzzzzzz >zzzzzzzz &&
>> +    git add zzzzzzzz &&
>> +    sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
>
> sed on a binary file? Sooner or later we are going to run into 
> portability issues.

In v5 of this patch series I used "perl" and it was suggested that I use 
"sed" instead.
It doesn't matter to me which we use.  My testing showed that it was 
safe, but that
was only Linux.

Does the mailing list have a preference for this ?

>
>
>> +    mv .git/index.yyy .git/index &&
>> +    # Confirm that fsck detects invalid checksum
>> +    test_must_fail git fsck --cache &&
>
> You should ensure that this failure is really because of an invalid 
> checksum. The failure could also be due to an extra LF at the end that 
> sed inserted, no?

I suppose we could, but I'm tempted to wait on that for now.

Jeff

