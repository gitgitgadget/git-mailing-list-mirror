Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618AA20966
	for <e@80x24.org>; Wed,  5 Apr 2017 18:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbdDESJy (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 14:09:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:34528 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755797AbdDESIt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 14:08:49 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 281D4846BC;
        Wed,  5 Apr 2017 14:08:45 -0400 (EDT)
Subject: Re: [PATCH v5] read-cache: force_verify_index_checksum
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <20170405145510.2324-1-git@jeffhostetler.com>
 <20170405145510.2324-2-git@jeffhostetler.com>
 <20170405170336.GE8741@aiede.mtv.corp.google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <18953c00-0eb0-c1e0-0d29-070e0ec60280@jeffhostetler.com>
Date:   Wed, 5 Apr 2017 14:08:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405170336.GE8741@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/5/2017 1:03 PM, Jonathan Nieder wrote:
> Hi,
>
> git@jeffhostetler.com wrote:
>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>  builtin/fsck.c  |  1 +
>>  cache.h         |  2 ++
>>  read-cache.c    |  7 +++++++
>>  t/t1450-fsck.sh | 11 +++++++++++
>>  4 files changed, 21 insertions(+)
>
> Yay!  I love this version.
>
>> --- a/builtin/fsck.c
>> +++ b/builtin/fsck.c
>> @@ -771,6 +771,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>>  	}
>>
>>  	if (keep_cache_objects) {
>> +		force_verify_index_checksum = 1;
>
> nit: now that there isn't a config this is overriding, this isn't
> "force_verify" so much as "verify".

good point.

>
> [...]
>> +++ b/t/t1450-fsck.sh
>> @@ -689,4 +689,15 @@ test_expect_success 'bogus head does not fallback to all heads' '
>>  	! grep $blob out
>>  '
>>
>> +test_expect_success PERL 'detect corrupt index file in fsck' '
>> +	cp .git/index .git/index.backup &&
>> +	echo zzzzzzzz >zzzzzzzz &&
>> +	git add zzzzzzzz &&
>> +	perl -pi -e "s/zzzzzzzz/yyyyyyyy/" .git/index &&
>> +	test_must_fail git fsck --cache &&
>> +	rm .git/index &&
>> +	mv .git/index.backup .git/index &&
>> +	rm zzzzzzzz
>> +'
>
> This is great.
>
> optional: you can do the cleanup commands in test_when_finished to
> make sure they happen even if the test fails.
>
> Tests don't seem to use "perl -pi" anywhere else.  This instance could
> be simplified by using sed.
>
> With whatever subset of the changes below look good,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> [...]

good point.

I just pushed another version.
Thanks,
Jeff


