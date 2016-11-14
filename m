Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE1420229
	for <e@80x24.org>; Mon, 14 Nov 2016 19:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934486AbcKNTpV (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:45:21 -0500
Received: from avasout03.plus.net ([84.93.230.244]:33661 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbcKNTpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:45:20 -0500
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id 7vlG1u0050zhorE01vlHSK; Mon, 14 Nov 2016 19:45:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=zg2bXJHVhrVIbSjLoAgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
 <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
 <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
 <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
 <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611121237230.3746@virtualbox>
 <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
 <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
 <35d3a07d-5d2f-aedd-94bc-4d92e5aa4661@web.de>
 <20161114170105.btnohk2777ddaiul@sigill.intra.peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        pranit.bauva@gmail.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <27949dcc-e25b-3a4a-15e5-71245670c0f4@ramsayjones.plus.com>
Date:   Mon, 14 Nov 2016 19:45:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161114170105.btnohk2777ddaiul@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/11/16 17:01, Jeff King wrote:
> On Mon, Nov 14, 2016 at 05:35:56PM +0100, Torsten Bögershausen wrote:
> 
>>> Git 'pu' does not compile on macOS right now:
>>> builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used uninitialized 
>>> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> 
> The next step is to make sure that the topic author is aware (in this
> case, one assumes it's pb/bisect).

[+cc Pranit]

Yep, I had a quick squint, and it looks like the compiler is correct.
It should be complaining about the 'bad_syn' variable for exactly the
same reason: namely, whenever the if condition is true, the only exit
from that block is via 'goto finish' which bypasses the initialisation
of 'good_syn' and 'bad_syn'.

> Better still is to make a patch that can either be applied on top, or
> squashed as appropriate. 

No patch this time, but it simply requires those variables to be
initialised to NULL in their declarations. :-D

>                            I know that Ramsay Jones does this, for
> example, with some of his sparse-related checks, and I'm pretty sure
> from the turnaround-time that he runs it against "pu".

Yep, the idea being to catch these simple problems before the topic
reaches 'next'.

ATB,
Ramsay Jones


