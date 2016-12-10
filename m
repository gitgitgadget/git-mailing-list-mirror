Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URIBL_BLACK shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AA9203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 06:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbcLJGry (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 01:47:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60012 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751827AbcLJGry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 01:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46A1D4A20F;
        Sat, 10 Dec 2016 01:47:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=Hh1Rb7tbGI/q
        j6f3B4tb3wn0WYM=; b=DJmv+oiGInkHG6owdm3pUuuqk8byPFZfVLSLX9HJjCrI
        QxLhaL/qZuiAApUDLI5NrEn4UwJM/66ytEgiSwtT2ZyFlZOjacLYzoRcPTkh+egJ
        kBqv6om7UbZga60v8IA1EfX0My55+lvkmYzOglptcbIeLd5yNmJPgUXX18tQ4dA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E5714A20E;
        Sat, 10 Dec 2016 01:47:52 -0500 (EST)
Received: from [192.168.1.200] (unknown [207.161.55.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB2814A20D;
        Sat, 10 Dec 2016 01:47:51 -0500 (EST)
Subject: Re: [PATCH] describe: add tests for unusual graphs
To:     Junio C Hamano <gitster@pobox.com>
References: <20161209131141.3096-1-quinn@quinngrier.com>
 <xmqq60msr92w.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Quinn Grier <quinn@quinngrier.com>
Message-ID: <dfc5172d-e87c-2c2f-dc7f-a6f7ccf0028e@quinngrier.com>
Date:   Sat, 10 Dec 2016 00:47:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq60msr92w.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 9238DABE-BEA4-11E6-A184-E98412518317-75739717!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-09 17:12, Junio C Hamano wrote:
> Quinn Grier <quinn@quinngrier.com> writes:
> 
>> git describe may give incorrect results if there are backdated commits
>> or multiple roots. This commit adds two test_expect_failure tests that
>> demonstrate these problems.
> 
> I am not sure if this is a good patch to take.  test_expect_failure
> is to demonstrate an incorrect behaviour that we wish to correct
> later, but I do not think these demonstrate incorrect behaviours to
> begin with.
> 
> For example, the latter one seems to expect that by asking to
> describe D in this picture
> 
>> +#
>> +# A---B*--D master
>> +#        /
>> +#       C* other
>> +#
> 
> you seem to expect the description is based on B.  
> 
> It is not at all clear why it is incorrect if the description were
> made based on C.  If D were described relative to A, ignoring B,
> then I understand why that result is incorrect and I would agree
> that describing D in terms of B is more correct.  But I do not think
> that is what the test is trying to demonstrate.
> 
> But it is hard to guess only from looking at the test and the
> proposed log message, because it does not say what makes you think
> the behaviour you saw was incorrect.
> 

I thought the behavior was incorrect because of the following paragraph
from the documentation for git describe:

      If multiple tags were found during the walk then the tag
      which has the fewest commits different from the input
      commit-ish will be selected and output. Here fewest commits
      different is defined as the number of commits which would be
      shown by git log tag..input will be the smallest number of
      commits possible.
