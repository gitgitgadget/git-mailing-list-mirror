Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D372047F
	for <e@80x24.org>; Thu, 21 Sep 2017 08:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdIUI1U (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 04:27:20 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60005 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751485AbdIUI1T (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 04:27:19 -0400
X-AuditID: 1207440f-a43ff70000007960-f5-59c377e67430
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FC.FB.31072.6E773C95; Thu, 21 Sep 2017 04:27:18 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCB74.dip0.t-ipconnect.de [87.188.203.116])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8L8RFvI023253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 21 Sep 2017 04:27:16 -0400
Subject: Re: [PATCH v2 14/21] read_packed_refs(): ensure that references are
 ordered when read
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <5bb362d9cb74c7386cd072e3ecd49b22cea1d8d2.1505799700.git.mhagger@alum.mit.edu>
 <20170920185047.6fzuspaseofb7r5x@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d16e3003-e10e-6767-4d00-65e264a4a548@alum.mit.edu>
Date:   Thu, 21 Sep 2017 10:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170920185047.6fzuspaseofb7r5x@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqPus/HCkQddVPou1z+4wWTxff4Ld
        outKN5NFQ+8VZov+5V1sFt1T3jJa/GjpYbbYvLmdxYHDY+esu+weHz7GeSzYVOrxrHcPo8fF
        S8oenzfJBbBFcdmkpOZklqUW6dslcGV8/hpa0CVZMePDBuYGxlvCXYycHBICJhKnJy1g6mLk
        4hAS2MEk8XL+LEaQhJDABSaJC6tqQWxhgQSJP5t7WUFsEQFZie+HNzKCNDALPGOSeH1zHhNE
        wyFGiR032EBsNgFdiUU9zWBxXgF7ic0zJ4PZLAKqEqff7wSrERWIkOh7e5kdokZQ4uTMJywg
        NqeAi8TqhXvB4swC6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo8AsJO2zkLTMQtIyC0nLAkaW
        VYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxgh0cG/g7FrvcwhRgEORiUe3hdm
        hyOFWBPLiitzDzFKcjApifIeKQQK8SXlp1RmJBZnxBeV5qQWA0OBg1lJhHdCGVCONyWxsiq1
        KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTB+wmkUbAoNT21Ii0zpwQhzcTBCTKc
        B2j4JbDhxQWJucWZ6RD5U4yKUuK8+SAJAZBERmkeXC8seb1iFAd6RZj3KUgVDzDxwXW/AhrM
        BDQ4e8MBkMEliQgpqQZGHfOqCSZPOQ/0XVhSs2f11BkzuUUDAqbFcf4Veunix7zZWHLhsb9F
        C5oTfgUuTD18svCdBNPfr7af20V6v+1hylfbN61zj0H654Qp7v8Cc00+n+7L0f66gWfl48Rj
        8m9WLzG15udlfnH/Z+xtawHX5VuWXmiXurwipkZQ1sdXNEOidduz/G5ZJZbijERDLeai4kQA
        Eh4NXjkDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20/2017 08:50 PM, Jeff King wrote:
> On Tue, Sep 19, 2017 at 08:22:22AM +0200, Michael Haggerty wrote:
>> If `packed-refs` was already sorted, then (if the system allows it) we
>> can use the mmapped file contents directly. But if the system doesn't
>> allow a file that is currently mmapped to be replaced using
>> `rename()`, then it would be bad for us to keep the file mmapped for
>> any longer than necessary. So, on such systems, always make a copy of
>> the file contents, either as part of the sorting process, or
>> afterwards.
> 
> So this sort-of answers my question from the previous commit (why we
> care about the distinction between NONE and TEMPORARY), since we now
> start treating them differently.
> 
> But I'm a bit confused why there's any advantage in the TEMPORARY case
> to doing the mmap-and-copy versus just treating it like NONE and reading
> it directly.
> 
> Hmm, I guess it comes down to the double-allocation thing again? Let me
> see if I have this right:
> 
>   1. For NO_MMAP, we'd read the buffer once. If it's sorted, good. If
>      not, then we temporarily hold it in memory twice while we copy it
>      into the new sorted buffer.
> 
>   2. For TEMPORARY, we mmap once. If it's sorted, then we make a single
>      copy. If it's not sorted, then we do the copy+sort as a single
>      step.
> 
>   3. For MMAP_OK, if it's sorted, we're done. Otherwise, we do the
>      single copy.
> 
> So this is really there to help the TEMPORARY case reading an old
> unsorted file avoid needing to use double-the-ram during the copy?
> 
> That seems like a good reason (and it does not seem to add too much
> complexity).

Yes, that's correct. A deeper question is whether it's worth this extra
effort to optimize the conversion from "unsorted" to "known-sorted",
which it seems should only happen once per repository. But

* Many more Git commands read the `packed-refs` file than write it.
  So an "unsorted" file might have to be read multiple times before
  the first time it is rewritten with the "sorted" trait.

* Users might have multiple Git clients writing their `packed-refs`
  file (e.g., the git CLI plus JGit in Eclipse), and they might not
  upgrade both clients at the same time to versions that write the
  "sorted" trait. So a single repository might go back and forth
  between "unsorted" and "known-sorted" multiple times in its
  life.

* Theoretically, somebody might have a `packed-refs` file that is so
  big that it takes up more than half of memory. I think there are
  scenarios where such a file could be converted to "sorted" form
  in `MMAP_TEMPORARY` mode but would fail in `MMAP_NONE` mode.

On the downside, in my benchmarking on Linux, there were hints that the
`MMAP_TEMPORARY` branch might be a *tiny* bit slower than the `MMAP_OK`
branch when operating on a known-sorted `packed-refs` file. But the
speed difference was barely detectable (and might be illusory). And
anyway, the speed difference on Linux is moot, since on Linux `MMAP_OK`
mode will usually be used. It *would* be interesting to know if there is
a significant speed difference on Windows. Dscho?

Michael
