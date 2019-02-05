Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB161F453
	for <e@80x24.org>; Tue,  5 Feb 2019 20:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfBEUaf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 15:30:35 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:32629 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEUae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 15:30:34 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43vGRX45w7z5tlD;
        Tue,  5 Feb 2019 21:30:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C599730F;
        Tue,  5 Feb 2019 21:30:31 +0100 (CET)
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
 <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ef5f66fb-7467-93be-00fd-7900ce961f72@kdbg.org>
Date:   Tue, 5 Feb 2019 21:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.19 um 12:06 schrieb Johannes Schindelin:
> The real examples are much more mundane, and very different from what you
> suspected, e.g. inserting the tag header before the tag message in
> `create_tag()` in `builtin/tag.c`. Basically, it is building up a strbuf
> for the sake of calling `strbuf_insert()` to insert that string elsewhere.

I had a look, and this example does not convince me at all. If
separation of concerns were applied well around the launch_editor APIs,
you would not need strbuf_insert() in the first place. But, alas, these
functions focus more on DRY, and that is often the opposite of
separation of concerns.

> In any case, the mere existence, and use, of `strbuf_insert()` is a pretty
> clear counter case to the idea that `strbuf_vinsertf()` would encourage
> invalid code flows.

Nobody wants to get rid of strbuf_insert(). I have worked with at least
3 string APIs. All have insert operations, and some have string
formatting capabilities, but none of them conflate the two operations
into one. Maybe, there is a plan behind it? strbuf is the first (my 4th)
API that does, and it was non-trivial to get it right...

-- Hannes
