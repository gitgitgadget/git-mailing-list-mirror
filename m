Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E632027C
	for <e@80x24.org>; Thu,  1 Jun 2017 08:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdFAI2z (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 04:28:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:39423 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbdFAI2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 04:28:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 239AAAD4F;
        Thu,  1 Jun 2017 08:28:53 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     git@vger.kernel.org
Subject: Unaligned accesses in sha1dc
CC:     Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Yow:  I guess you guys got BIG MUSCLES from doing too much STUDYING!
Date:   Thu, 01 Jun 2017 10:28:52 +0200
Message-ID: <mvm4lw0un5n.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sh1dc implementation is making unaligned accesses, which will crash
on some architectures, others have to emulate them in software.

Breakpoint 4, sha1_compression_states (ihv=0x600ffffffffe7010, 
    m=<optimized out>, W=0x600ffffffffe70a8, states=0x600ffffffffe7328)
    at sha1dc/sha1.c:398
398             SHA1COMPRESS_FULL_ROUND2_STEP(e, a, b, c, d, W, 21, temp);
(gdb) n
403             SHA1COMPRESS_FULL_ROUND2_STEP(d, e, a, b, c, W, 22, temp);
(gdb) 
408             SHA1COMPRESS_FULL_ROUND2_STEP(c, d, e, a, b, W, 23, temp);
(gdb) 
413             SHA1COMPRESS_FULL_ROUND2_STEP(b, c, d, e, a, W, 24, temp);
(gdb) 
418             SHA1COMPRESS_FULL_ROUND2_STEP(a, b, c, d, e, W, 25, temp);
(gdb) 
291             SHA1COMPRESS_FULL_ROUND1_STEP_LOAD(a, b, c, d, e, m, W, 0, temp);
(gdb) 
git(21728): unaligned access to 0x600000000009f8d5, ip=0x40000000003336d0
423             SHA1COMPRESS_FULL_ROUND2_STEP(e, a, b, c, d, W, 26, temp);

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
