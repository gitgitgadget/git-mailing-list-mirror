Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CFC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7E20829
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgJZVAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:00:02 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56350 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgJZVAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:00:01 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kX9ax-000CDi-Do; Mon, 26 Oct 2020 20:59:59 +0000
Subject: Re: Feature request: Exponential search in git bisect
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Manuel_B=c3=a4renz?= <manuel@enigmage.de>,
        git <git@vger.kernel.org>
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
 <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
 <b1adedaa-5809-9ea1-f664-3a7cabaf0d14@iee.email>
 <xmqqpn54etyp.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5559c9b5-07d5-c25d-7c28-4091de34584f@iee.email>
Date:   Mon, 26 Oct 2020 20:59:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <xmqqpn54etyp.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 26/10/2020 18:13, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>> Ok, but the conclusion of the above discussion is that the problem
>>> with this idea is being able to distinguish between a commit that is
>>> bad and a commit where the feature that you want to test cannot be
>>> tested for example because it hasn't been implemented yet.
>> Does any of the proposed improvement in the "bisect: loosen halfway()
>> check for a large number of commits"
>> https://lore.kernel.org/git/20201022103806.26680-1-szeder.dev@gmail.com/
>> assist in this.
> I doubt it.  
>
> If you cannot say if a rev is testable or not, it would not help you
> much if Git asked "is this good, bad or untestable?" question 5
> times faster, I suspect.
>
>
I was more thinking along the lines, perhaps, of a narrower condition of
"Too_Old" for such historical commits, rather than saying some
mid-history commit just happens to be untestable in a rather
indeterminate way. That would be distinctly different from the generic
'untestable' condition where a commit needs to be skipped.

It would still need an update to bisect to exponentially find the
suitable start (good) zone for the real bisection.

Clearly if the user badly codes that 'Too_Old' test then they will get
pulled up short, but that would be expected.

The other point was to highlight to Manuel that if the halfway check
improvement was relevant to his situation then it may be that simply
saying those 'Too_Old' commits were 'good' anyway, and just use the
improvement it gave.
