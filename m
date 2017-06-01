Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A972027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdFAJcK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:32:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:50236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbdFAJcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:32:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2680AAAF2;
        Thu,  1 Jun 2017 09:32:08 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <20170601091856.r3oaddwzsndniyfa@genre.crustytoothpaste.net>
X-Yow:  Where's the Coke machine?  Tell me a joke!!
Date:   Thu, 01 Jun 2017 11:32:07 +0200
In-Reply-To: <20170601091856.r3oaddwzsndniyfa@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Thu, 1 Jun 2017 09:18:57 +0000")
Message-ID: <mvmr2z4t5ns.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 01 2017, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On Thu, Jun 01, 2017 at 10:28:52AM +0200, Andreas Schwab wrote:
>> The sh1dc implementation is making unaligned accesses, which will crash
>> on some architectures, others have to emulate them in software.
>> 
>> Breakpoint 4, sha1_compression_states (ihv=0x600ffffffffe7010, 
>>     m=<optimized out>, W=0x600ffffffffe70a8, states=0x600ffffffffe7328)
>>     at sha1dc/sha1.c:398
>> 398             SHA1COMPRESS_FULL_ROUND2_STEP(e, a, b, c, d, W, 21, temp);
>> (gdb) n
>> 403             SHA1COMPRESS_FULL_ROUND2_STEP(d, e, a, b, c, W, 22, temp);
>> (gdb) 
>> 408             SHA1COMPRESS_FULL_ROUND2_STEP(c, d, e, a, b, W, 23, temp);
>> (gdb) 
>> 413             SHA1COMPRESS_FULL_ROUND2_STEP(b, c, d, e, a, W, 24, temp);
>> (gdb) 
>> 418             SHA1COMPRESS_FULL_ROUND2_STEP(a, b, c, d, e, W, 25, temp);
>> (gdb) 
>> 291             SHA1COMPRESS_FULL_ROUND1_STEP_LOAD(a, b, c, d, e, m, W, 0, temp);
>> (gdb) 
>> git(21728): unaligned access to 0x600000000009f8d5, ip=0x40000000003336d0
>> 423             SHA1COMPRESS_FULL_ROUND2_STEP(e, a, b, c, d, W, 26, temp);
>
> What architecture are you seeing this on?

It doesn't matter.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
