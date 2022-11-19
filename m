Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CAC433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 08:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiKSISR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 03:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKSISP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 03:18:15 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C29038C
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 00:18:14 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4NDmkB1MnNz5tl9;
        Sat, 19 Nov 2022 09:18:09 +0100 (CET)
Message-ID: <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org>
Date:   Sat, 19 Nov 2022 09:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <Y3B36HjDJhIY5jNz@nand.local> <xmqqv8nbkg77.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqv8nbkg77.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.22 um 00:15 schrieb Junio C Hamano:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> One thing that the commit message doesn't allude to (that is covered in
>> the earlier discussion) is why it is important to pass
>> `--ignore-cr-at-eol`. I think that is worth mentioning here.
> 
> Isn't it because Git on the platform is expected to use CRLF in
> certain places, unlike on other platforms where LF is used, but the
> platform port hasn't adjusted tests to match that expectation?  And
> vice versa, where Git is expected to produce LF terminated text
> everywhere but the expected output is not "ported" to force LF
> termination and instead produces CRLF terminated text on platforms
> whose native line ending is CRLF?
> 
> Use of "ignore-cr-at-eol" may allow such tests that are not ported
> correctly to prepare expected output with a "wrong" line ending and
> still pass, and I do think it may be an expedite way to make tests
> appear to pass.

The reason that mingw_test_cmp exists is not that Git isn't ported
correctly, or that tests aren't ported correctly. The reason is that
tests assume Unix LF line endings everywhere, but there are some tools
that are outside our control that randomly -- to the layman's eye --
produce CRLF line endings even when their input has LF style.

For example, when we post-process Git output with `sed`, the result
suddenly has CRLF line endings instead of LF that the input had.

> When Git is expected to produce platform-native line endings,...
There is no such requirement or expectation on Windows. LF style is
acceptable.

-- Hannes

