Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BBC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437BF61357
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFKQnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:43:31 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:22190 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhFKQn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:28 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4G1mnZ1Hxbz5tl9;
        Fri, 11 Jun 2021 18:41:21 +0200 (CEST)
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net> <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org> <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org> <xmqqo8cc3maq.fsf@gitster.g>
 <875yykipq2.fsf@osv.gnss.ru>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dd5a1b6c-f0d3-f135-d03d-5d1f9205503d@kdbg.org>
Date:   Fri, 11 Jun 2021 18:41:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <875yykipq2.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.06.21 um 13:51 schrieb Sergey Organov:
> I don't get it. Once you have diff3 output, and you want something
> simpler, you just kill the inner section, right? RCS merge output style
> is simply inferior.

There is an important case where RCS style is not inferior: When the base is

 123456

then our side makes it

 12ABC56

and their side makes it

 12AXC56

then diff3 must display the conflict as

 12<ABC|34=AXC>56

to be technically correct. RCS style can coalesce A and C outside of the
conflict and display it as

 12A<B=X>C34

and *that* is the helpful part of this simpler style. You encounter
these kinds of conflicts *a lot* when you juggle fixups in a rebase
--interactive session.

The thread mentioned earlier upthread explores whether diff3 can do a
similar simplification.

-- Hannes
