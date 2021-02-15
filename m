Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D7C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF44164E34
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhBORO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 12:14:28 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47196 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232054AbhBORNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 12:13:45 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 4C1C31B276;
        Mon, 15 Feb 2021 18:13:18 +0100 (CET)
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
Date:   Mon, 15 Feb 2021 18:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-10-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> Fix a regression in the test framework for userdiff added in
> bfa7d01413 (t4018: an infrastructure to test hunk headers,
> 2014-03-21).
> 
> The testing infrastructure added in that change went overboard with
> simplifying the tests, to the point where we lost test coverage.
> 
> Before that we'd been able to test the full context line, or ever
> since the feature was originally added in f258475a6e (Per-path
> attribute based hunk header selection., 2007-07-06).
> 
> After bfa7d01413 all we cared about was whether "RIGHT" appeared on
> the line. We thus lost the information about whether or not "RIGHT"
> was extracted from the line for the hunk header, or the line appeared
> in full (or other subset of the line).
> 
> Let's bring back coverage for that by adding corresponding *.ctx
> files, this has the added advantage that we're doing a "test_cmp", so
> when we have failures it's just a non-zero exit code from "grep",
> we'll actually have something meaningful in the "-v" output.
> 
> As we'll see in a follow-up commit this is an intermediate step
> towards even better test coverage. I'm structuring these tests in such
> a way as to benefit from the diff.colorMove detection.
> 
> The "sed -n -e" here was originally a single 's/^.*@@\( \|$\)//p'
> pattern, but the '\( \|$\)' part had portability issues on OSX and
> AIX.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t4018-diff-funcname.sh                      |  7 +++---
>   t/t4018/README                                | 22 +++++++++----------
>   t/t4018/README.ctx                            |  1 +
>   t/t4018/bash-arithmetic-function.ctx          |  1 +
>   t/t4018/bash-bashism-style-compact.ctx        |  1 +
>   [...and so on...]

This is what I meant by "without burdening test writers with lots of
subtleties".

I'm not a friend of this change :-(

I think you are going overboard with required test precision. To have 
useful tests for userdiff patterns that demonstrate its features, 
authors should write *many* tests. The right balance should be on the 
coverage of userdiff pattern features, not on the subtle details of each 
and everyone of it. Requiring that many additional context files makes 
it *really hard* to comply.

-- Hannes
