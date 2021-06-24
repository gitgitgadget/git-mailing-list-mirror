Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F95C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 13:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958A4613C3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 13:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFXNM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:12:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:41290 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhFXNMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 09:12:55 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2A8163F40E4;
        Thu, 24 Jun 2021 09:10:36 -0400 (EDT)
Received: from azhci-node1.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F1C773F40D9;
        Thu, 24 Jun 2021 09:10:35 -0400 (EDT)
Subject: Re: Windows: core.useBuiltinFSMonitor without core.untrackedcache -
 performance hazard?
To:     Tao Klerks <tao@klerks.biz>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet>
 <CAPMMpogeWeQujG0UL80REOsaBJipxhQyOpBTuWD9U9_jg=FMMA@mail.gmail.com>
 <81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com>
 <CAPMMpojKMZmorKPgMASkHsvKcQTaaGyWURsgDS+KTGVeuBh1ww@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <596386e9-f9bf-c465-ec5e-dcf4356b6194@jeffhostetler.com>
Date:   Thu, 24 Jun 2021 09:10:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPMMpojKMZmorKPgMASkHsvKcQTaaGyWURsgDS+KTGVeuBh1ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/24/21 1:25 AM, Tao Klerks wrote:
> Hi Jeff,
> 
> On Mon, Jun 21, 2021 at 8:41 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>> We're currently looking at a problem that we believe is in the
>> untracked-cache code.  This is causing some of our Scalar tests
>> to fail on Windows when the untracked-cache is turned on.  This
>> is independent of whether FSMonitor or FSCache is turned on.
>> We're still tracking this down.
>>
>> And yes, the best possible solution is to turn on FSMonitor *and*
>> the untracked-cache, so that the "untracked" status code doesn't
>> have to do anything.  So I want to look at tracking down the above
>> problem before doing anything else.
> 
> I got a bit excited about a possible clean path forward to getting
> -uall to work well with untracked cache, and submitted a patch along
> those lines, but rereading the above I should probably have been a
> little more patient.
> 
> Is there anything "we" can do to see/understand the
> scalar-test-suite-error you describe above, or is this
> microsoft-internal?
> 
> Thanks
> Tao
> 

Thanks for looking into this.  The untracked-cache code is pretty
dense and having another set of eyes is good.  I apologize that I'm
still working thru the backlog from my vacation and haven't gotten
to spend any "quality" time with the untracked-cache code yet, so
I need to do some homework and study the questions/issues that you've
found so far. (Thanks again)

All of our work is done in the open, so yes you should be able to
see what we're doing and the errors that we're getting.

The source for our Scalar functional tests is in:
https://github.com/microsoft/scalar

My test branch 'test-no-fscache' is in my personal development fork:
https://github.com/jeffhostetler/git

I have a PR against microsoft/git (a fork of git-for-windows
which is a fork of core git) which turns off a bunch of things
to try to isolate the failures:
https://github.com/microsoft/git/pull/383

Output for a recent run can be seen here:
https://github.com/microsoft/git/pull/383/checks?check_run_id=2884524819

Let us know if you have questions.
Jeff
