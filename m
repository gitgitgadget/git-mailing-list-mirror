Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE43C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C881964DBD
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhB1LFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 06:05:20 -0500
Received: from [93.83.142.38] ([93.83.142.38]:38210 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230019AbhB1LFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 06:05:19 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 007EC321F5;
        Sun, 28 Feb 2021 12:04:57 +0100 (CET)
Subject: Re: [PATCH v3 00/35] 20210215154427.32693-1-avarab@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-1-avarab@gmail.com>
 <c2e90134-35bb-24b2-a334-7c6abdd6dc6f@kdbg.org>
Message-ID: <3519e86e-d9eb-a9e0-ed28-72d32271d2bf@kdbg.org>
Date:   Sun, 28 Feb 2021 12:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c2e90134-35bb-24b2-a334-7c6abdd6dc6f@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.21 um 08:47 schrieb Johannes Sixt:
> Am 24.02.21 um 20:50 schrieb Ævar Arnfjörð Bjarmason:
>> Addresses feedback on v2. Since Junio & Johannes expressed a desire to
>> keep the existing test scheme in t4018/* it's still there, but it's
>> also possible to add *.sh tests in that directory to use the more
>> familiar test framework used elsewhere in the test suite.
>>
>> The tests added here make use of it to e.g. supply custom -U<n>
>> arguments, set config before the tests etc.
>>
>> I also improved that existing test support so you can have N tests in
>> one file with (mostly) the existing test syntax. See the "userdiff
>> tests: add a test with multiple tests in a LANG file" patch.
> 
> I've read through all patches and had a comment here and there. I like a
> lot that we can now put more than one test into a single file.
> 
> However, I do not like the shell script version of tests, because the
> syntax is so hard to read. Also, it looks to me that they are only
> needed for a few tests that could just as well be coded as one-off tests
> outside the framework.
> 
> I've now pulled avar/t4018-diff-hunk-header-regex-tests-3 from your
> github repo and will check again if I missed some cruicial points.


I've now looked through the patch series again.

I appreciate that you dug through the history and discovered and fixed a
few deficiencies and loose ends. The way to throw all test cases for a
language driver into a single file I like a lot, too. The way to specify
expected results is manageable (modulo the dependency on the test
number, t4018, that Junio mentioned).

But I do not see the need for the framework provided by the new
test_diff_funcname. At the end of the series, it is only used by Perl
and custom driver tests. (I discount the new ADA and Ruby tests as they
can easily migrated to the simple test scheme.) But then the Perl tests
do not do anything special, either. The multi-line pattern test is just
a nice add-on but not strictly needed. In the end, the Perl test is just
as straight-forward as all others.

That leaves the custom driver tests. I don't see the need for a new
framework just for that. It would be sufficient to integrate them in
main test file t4018-diff-funcname.sh if needed, or leave them in the
existing framework if possible.

-- Hannes
