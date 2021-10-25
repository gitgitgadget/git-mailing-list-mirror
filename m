Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC76C433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400E661040
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJYL4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:56:11 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:52531 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231835AbhJYL4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:56:10 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4HdCyx3Bqkz5tl9;
        Mon, 25 Oct 2021 13:53:45 +0200 (CEST)
Subject: Re: [PATCH v4 8/8] progress.c: add & assert a "global_progress"
 variable
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
 <patch-v4-8.8-06124e8ac5e-20211025T111915Z-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c65c0a54-b66f-a043-01d9-192f9ca1efde@kdbg.org>
Date:   Mon, 25 Oct 2021 13:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-v4-8.8-06124e8ac5e-20211025T111915Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.21 um 13:25 schrieb Ævar Arnfjörð Bjarmason:
> Once we have a
> global current progress object we'll be able to update that object via
> SIGALRM, this will cover cases where we're busy, but either haven't
> invoked our first display_progress() yet, or the time between
> display_progress() is too long. See [3] for early code to do that.

This can't be a goal. You cannot do serious stuff in a signal handler.
Don't proliferate complicated signal handlers.

On top of that, our SIGALRM handler on Windows runs in its own thread
and can't do more than set a volatile sigatomic_t (and even that is
undefined behavior, strictly speaking).

-- Hannes
