Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2075B20193
	for <e@80x24.org>; Thu, 27 Oct 2016 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965019AbcJ0SWj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 14:22:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:26092 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964794AbcJ0SWi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 14:22:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t4ZxR3620z5tlD;
        Thu, 27 Oct 2016 20:22:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5FBA8145;
        Thu, 27 Oct 2016 20:22:34 +0200 (CEST)
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20161026215732.16411-1-sbeller@google.com>
 <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
 <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
 <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
Date:   Thu, 27 Oct 2016 20:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.2016 um 19:01 schrieb Stefan Beller:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> This is the pessimization that I am talking about. I would not mind at all if
>> it were only for the attribute subsystem, but the proposed patch would
>> pessimize *all* uses of pthread_mutex_lock.
>
> It would only pessimize *uninitialized* mutexes? For initialized mutexes
> the added burden is super cheap (one additional condition).

It is not possible to mark a mutex uninitialized on Windows without an 
extra piece of data. A solution would become quite complicated quite 
quickly, and at the cost of additional operations that are in the same 
ballpark as an uncontended mutex. I'm not enthused.

> The positive aspect of this way the patch proposes would be that any
> future contributor not knowing the details of how to do mutexes right
> on Windows, would not totally break the whole system, i.e. this seems
> to be more maintainable in the future as it reduces the friction between
> pthreads mutexes and the way we can do things in Git in a platform
> independent way

This is a non-argument. Coders have to know their tools.

-- Hannes

