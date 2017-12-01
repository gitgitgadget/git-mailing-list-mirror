Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB3A20954
	for <e@80x24.org>; Fri,  1 Dec 2017 15:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbdLAP2G (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 10:28:06 -0500
Received: from siwi.pair.com ([209.68.5.199]:11765 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbdLAP2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 10:28:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DD71C8455F;
        Fri,  1 Dec 2017 10:28:03 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 581728455E;
        Fri,  1 Dec 2017 10:28:02 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Vitaly Arbuzov <vit@uber.com>
Cc:     git@vger.kernel.org
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <192f4b69-0f71-3c3b-8666-b04655a532aa@jeffhostetler.com>
Date:   Fri, 1 Dec 2017 10:28:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/30/2017 12:44 PM, Vitaly Arbuzov wrote:
> Found some details here: https://github.com/jeffhostetler/git/pull/3
> 
> Looking at commits I see that you've done a lot of work already,
> including packing, filtering, fetching, cloning etc.
> What are some areas that aren't complete yet? Do you need any help
> with implementation?
> 

Sure.  Extra hands are always welcome.

Jonathan Tan and I have been working on this together.
Our V5 is on the mailing now.  We have privately exchanged
some commits that I hope to push up as a V6 today or Monday.

As for how to help, I'll have to think about that a bit.
Without knowing your experience level in the code or your
availability, it is hard to pick something specific right
now.

As a first step, build my core/pc5_p3 branch and try using
partial clone/fetch between local repos.  You can look at
the tests we added (t0410, t5317, t5616, t6112) to see sample
setups using a local pair of repos.  Then try actually using
the partial clone repo for actual work (dogfooding) and see
how it falls short of your expectations.

You might try duplicating the above tests to use a
local "git daemon" serving the remote and do partial clones
using localhost URLs rather than file:// URLs.  That would
exercise the transport differently.

The t5616 test has the start of some end-to-end tests that
try combine multiple steps -- such as do a partial clone
with no blobs and then run blame on a file.  You could extend
that with more tests that test odd combinations of commands
and confirm that we can handle missing blobs in different
scenarios.

Since you've expressed an interest in sparse-checkout and
having a complete end-to-end experience, you might also
experiment with adapting the above tests to use the sparse
filter (--filter=sparse:oid=<blob-ish>) instead of blobs:none
or blobs:limit.  See where that takes you and add tests
as you see fit.  The goal being to get tests in place that
match the usage you want to see (even if they fail) and
see what that looks like.

I know it is not as glamorous as adding new functionality,
but it would help get you up-to-speed on the code and we
do need additional tests.

Thanks
Jeff
