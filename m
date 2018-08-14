Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8CC1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 13:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbeHNPtC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 11:49:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:27258 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbeHNPtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 11:49:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 350023F4023;
        Tue, 14 Aug 2018 09:01:56 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E42F13F4002;
        Tue, 14 Aug 2018 09:01:55 -0400 (EDT)
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
To:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
 <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5a7e7ed1-da0b-20a4-147d-a24ca7da5832@jeffhostetler.com>
Date:   Tue, 14 Aug 2018 09:01:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/13/2018 3:02 PM, Johannes Sixt wrote:
> The Windows CRT implements O_APPEND "manually": on write() calls, the
> file pointer is set to EOF before the data is written. Clearly, this is
> not atomic. And in fact, this is the root cause of failures observed in
> t5552-skipping-fetch-negotiator.sh and t5503-tagfollow.sh, where
> different processes write to the same trace file simultanously; it also
> occurred in t5400-send-pack.sh, but there it was worked around in
> 71406ed4d6 ("t5400: avoid concurrent writes into a trace file",
> 2017-05-18).
> 
> Fortunately, Windows does support atomic O_APPEND semantics using the
> file access mode FILE_APPEND_DATA. Provide an implementation that does.
> 
> This implementation is minimal in such a way that it only implements
> the open modes that are actually used in the Git code base. Emulation
> for other modes can be added as necessary later. To become aware of
> the necessity early, the unusal error ENOSYS is reported if an
> unsupported mode is encountered.
> 
> Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>   compat/mingw.c | 41 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 2 deletions(-)
> 

[...]

This looks good.  Thanks for following up on this.

Jeff
