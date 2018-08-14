Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56571F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeHNVRd (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:17:33 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:34413 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeHNVRd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:17:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41qh2971jyz5tlF;
        Tue, 14 Aug 2018 20:29:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D41251DB0;
        Tue, 14 Aug 2018 20:29:04 +0200 (CEST)
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
 <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
 <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
 <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
 <87eff2rmgt.fsf@evledraar.gmail.com>
 <20180813223701.GC16006@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <313beb50-f5bd-ace6-8d6d-5f2a9e7cb6e7@kdbg.org>
Date:   Tue, 14 Aug 2018 20:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813223701.GC16006@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.2018 um 00:37 schrieb Jeff King:
> And then you can do something like:
> 
>    for size in 4097 8193 16385 32769 65537 131073 262145 524289 1048577; do
>      >out ;# clean up from last run
>      echo "Trying $size..."
>      timeout 5 ./write $size out
>      if ! ./check $size <out; then
>        echo "$size failed"
>        break
>      fi
>    done
> 
> On my Linux system, each of those seems to write several gigabytes
> without overlapping. I did manage to hit some failing cases, but they
> were never sheared writes, but rather cases where there was an
> incomplete write at the end-of-file.

I used your programs with necessary adjustments (as fork() is not 
available), and did similar tests with concurrent processes. With packet 
sizes 1025, 4093, 7531 (just to include some odd number), and 8193 I did 
not observe any overlapping or short writes.

I'm now very confident that we are on the safe side for our purposes.

-- Hannes
