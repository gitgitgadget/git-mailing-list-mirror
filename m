Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3361C1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 07:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405990AbfBNHA0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 02:00:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59602 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405695AbfBNHAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 02:00:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE3AB5A09A;
        Thu, 14 Feb 2019 02:00:20 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=dEfz0UDBHhXsa7/U1JcD6Ouf0kY=; b=JpauHry
        WyYbm1mbGmxvcLH1TtTeA7p7ym3jgdIBvKYgwXUZO2vT8LG0Ngx9ibKInym7RLpd
        c3zF/iqObcsYLEYkjzO0ISNq/W/AAWhJk3/m044+V7Ta52O09MPXgxIShuqzABwv
        aci+Q/vatkPQjm+jo2ViYVmpP0A9fKuN9uaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=uzU2wPzIe4A/wVDsl/y0inG9Zjx4vbY+P
        TaJzDsgC6CgoaES3APxqLxjS7+dH6KPTwGPbJEUymI6TtDSMzi4GjlzCW8M6dtPu
        GPuN7Oz181YbAWDzk2j6C0M2ay+uon7IBNXLjFKhcOtiMHY4PYU+gjQ+ySRITWrJ
        EEL1geHt2E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B607D5A099;
        Thu, 14 Feb 2019 02:00:20 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FEA25A098;
        Thu, 14 Feb 2019 02:00:17 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 14 Feb 2019 02:00:14 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: pass GIT_TEST_SIDEBAND_ALL through Apache
Message-ID: <20190214070014.GF16125@zaya.teonanacatl.net>
References: <20190214063513.32041-1-tmz@pobox.com>
 <20190214065226.GA22932@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214065226.GA22932@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 2FAA00EE-3026-11E9-A052-D01F9763A999-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Feb 14, 2019 at 01:35:13AM -0500, Todd Zullinger wrote:
> 
>> 07c3c2aa16 ("tests: define GIT_TEST_SIDEBAND_ALL", 2019-01-16) added
>> GIT_TEST_SIDEBAND_ALL to the apache.conf PassEnv list.  Avoid warnings
>> from Apache when the variable is unset, as we do for GIT_VALGRIND* and
>> GIT_TRACE, from f628825481 ("t/lib-httpd: handle running under
>> --valgrind", 2012-07-24) and 89c57ab3f0 ("t: pass GIT_TRACE through
>> Apache", 2015-03-13), respectively.
>> 
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>> ---
>> I missed this with rc0, but poking through build logs I noticed a number
>> of 'AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined'
>> warnings.
>> 
>> I think exporting this in lib-httpd.sh like we do for GIT_VALGRIND* and
>> GIT_TRACE is the way to go, as opposed to in test-lib.sh, as we do for
>> things like GNUPGHOME.  But I could easily be wrong about that.
> 
> Yeah, I think this is the right place to put it (and this approach is
> the right thing to do).

Excellent, thanks.

>> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
>> index 216281eabc..0dfb48c2f6 100644
>> --- a/t/lib-httpd.sh
>> +++ b/t/lib-httpd.sh
>> @@ -91,6 +91,7 @@ HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
>>  # hack to suppress apache PassEnv warnings
>>  GIT_VALGRIND=$GIT_VALGRIND; export GIT_VALGRIND
>>  GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
>> +GIT_TEST_SIDEBAND_ALL=$GIT_TEST_SIDEBAND_ALL; export GIT_TEST_SIDEBAND_ALL
>>  GIT_TRACE=$GIT_TRACE; export GIT_TRACE
> 
> I applaud your attempt to alphabetize, but the existing list is already
> out of order. ;) I don't think it really matters much either way,
> though.

It's like a tar pit for catching people with a little OCD.

I debated whether to add it at the end, sort them all in a
prep patch, or just add it after GIT_TRACE.  I'm not sure if
I should even admit to spending as much time debating it
with myself as I did. ;)

-- 
Todd
