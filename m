Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4DD20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 19:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbdK0Tjp (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 14:39:45 -0500
Received: from siwi.pair.com ([209.68.5.199]:19608 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbdK0Tjo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 14:39:44 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 20DBD844DE;
        Mon, 27 Nov 2017 14:39:44 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C2DE0844DD;
        Mon, 27 Nov 2017 14:39:43 -0500 (EST)
Subject: Re: [PATCH v5 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171121205852.15731-1-git@jeffhostetler.com>
 <20171121205852.15731-5-git@jeffhostetler.com>
 <CAGZ79kZR-W-_JJi7zptiGgv=W7KpNMaSEbmmxrXcKovznK9E7Q@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <21fbd685-2c96-91b9-700e-8902a6e99c08@jeffhostetler.com>
Date:   Mon, 27 Nov 2017 14:39:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZR-W-_JJi7zptiGgv=W7KpNMaSEbmmxrXcKovznK9E7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/22/2017 5:56 PM, Stefan Beller wrote:
> On Tue, Nov 21, 2017 at 12:58 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> +       assert(arg);
>> +       assert(!unset);
> 
> I count 16 asserts in this patch. Is that really needed?
> Either omit them or use BUG if we want to rely on user
> bug reports when these conditions trigger, as assert is unreliable
> due to its dependence on the NDEBUG flag.

Yes, there are a few asserts in the code.  Old habits....

I could remove some/all of them, but personally I feel they
have merit and hint to the mindset of the author for future
readers of the code.  Are there other opinions?

Personally, I think it might be awkward to keep repeating
something like:

     if (!c)
         BUG(msg);

Do we want to think about a macro that builds on BUG() and
does the test?

Something like:
     #define ASSERT_OR_BUG(c) do { if (!(c)) BUG("%s", #c); } while (0)

Jeff
