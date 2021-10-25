Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861E4C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FC460E8C
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhJYRyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:54:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:45944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230398AbhJYRyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 13:54:35 -0400
Received: (qmail 6393 invoked by uid 109); 25 Oct 2021 17:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 17:52:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21647 invoked by uid 111); 25 Oct 2021 17:52:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 13:52:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 13:52:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 08/10] generate-cmdlist.sh: do not shell out to "sed"
Message-ID: <YXbuy3Lk0ZS+8sFQ@coredump.intra.peff.net>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
 <patch-v2-08.10-83318d6c0da-20211022T193027Z-avarab@gmail.com>
 <YXbfdEqKHc5b19u9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXbfdEqKHc5b19u9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 12:46:45PM -0400, Jeff King wrote:

> It's like spawning processes is somehow faster on your machine than
> mine. I wonder if it's a CPU governor thing. This is a laptop, and those
> numbers come from using "powersave". Doing "cpufreq-set -g performance",
> I get:
> 
>    'sh generate-cmdlist.sh command-list.txt' ran
>    14.35 ± 0.23 times faster than 'sh generate-cmdlist.sh.old command-list.txt'
>    33.15 ± 0.50 times faster than 'sh generate-cmdlist.sh.master command-list.txt'
> 
> which is closer. But most notably all versions are 3-5x faster than
> their "powersave" counterparts. I wonder if that has been driving some
> of the confusion in our timings in this thread.

BTW, I should have mentioned these governors are used with the
intel_pstate driver. So "powersave" here is not the default "use the
lowest frequency" governor in linux, but the pstate-specific one which
is more like "ondemand".

Not that I expect anybody to look into or pontificate on governor
issues, but I wanted to make sure I didn't confuse anyone.

-Peff
