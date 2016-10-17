Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC571F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 19:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758280AbcJQTc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 15:32:57 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11781 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758211AbcJQTc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 15:32:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3sySz93lqNz5tlC;
        Mon, 17 Oct 2016 21:32:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4D66A5311;
        Mon, 17 Oct 2016 21:32:52 +0200 (CEST)
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
To:     Junio C Hamano <gitster@pobox.com>
References: <20161010175611.1058-1-sbeller@google.com>
 <alpine.DEB.2.20.1610121501390.3492@virtualbox>
 <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
 <alpine.DEB.2.20.1610131255001.197091@virtualbox>
 <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2aa41392-a7ed-cd48-2737-bd852757ab35@kdbg.org>
Date:   Mon, 17 Oct 2016 21:32:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2016 um 09:10 schrieb Junio C Hamano:
> And I agree from that point of view that having to spell both sides
> as $(pwd) would mean you are not testing that "Unixy input to
> Windowsy output" expectation, but at the same time, I think you
> would want "Windowsy input to Windowsy output" combination also does
> produce correct result, which is not tested in the three tests shown
> above.  IOW, probably you would want to test both (at least on any
> platform where $PWD and $(pwd) textually disagree) for all these
> [*1*], and the pair
>
>     "../." taken relative to "$(pwd)/." must be "$(pwd)/."
>     "../." taken relative to "$PWD/." must be "$(pwd)/."
>
> test, because of the limitation of your bash, cannot have the latter
> half of the pair, so you'd need to comment it out with in-code
> explanation, perhaps?

No, we do not have to test both cases. Git, the program, never sees 
Unixy input. It cannot distinguish the two cases. If we did both tests, 
we would just test that *if* the front-end of git is an MSYS program 
(such as bash), *then* that MSYS front-end has converted the Unixy path 
to a Windows-y path in such a way that the end-result is also as 
expected. It's similar to a test that grep produces expected output.

I think that we could reduce the confusion by converting all $PWD to 
$(pwd) in these test cases. I don't remember why I suggested to use $PWD 
for one of the arguments of the test cases (the second must be $(pwd)), 
but the most likely reason is only that we save a process.

-- Hannes

