Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4A0320A10
	for <e@80x24.org>; Fri, 29 Sep 2017 02:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdI2CUj (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 22:20:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54292 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdI2CUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 22:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0906DAE67D;
        Thu, 28 Sep 2017 22:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YqqBZKh+Vl/tHLAOMlFXCZbw/eY=; b=oVfHSy
        pTvLCSpjrPM5LGgj7FPldxA+JPuWBq40u1G9Pknxv3sOBuv1Lq+t4mgHPP+uTqRP
        jWvfhYA9EmbhkP01pH43bH5LkAkiE0xIBGuHHMjHhMdl5mJV1bRxWlfDnrT2gy2e
        oJS7xvfsFece/lvejtrsIPAlKNxhJyE5sC8H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qofm4wiCf2Ctdw65d5sUM/N5dofFd8Hj
        iuct/Q902WNNkYdyE9Wikgn/+SL7qJIZkxoVkd80VtGsdP2wqMNII8TLp6izDmhf
        Vk85Dk8oGqwiBduvv6MyVVMrGp7ES25txb2yFS66a7AhmqOGslVphZ1M/vnwm94k
        McQrwL3pkXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3CDEAE67C;
        Thu, 28 Sep 2017 22:20:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63422AE67B;
        Thu, 28 Sep 2017 22:20:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
References: <20170919192744.19224-1-benpeart@microsoft.com>
        <20170922163548.11288-1-benpeart@microsoft.com>
Date:   Fri, 29 Sep 2017 11:20:36 +0900
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 22 Sep 2017 12:35:36 -0400")
Message-ID: <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C808D672-A4BC-11E7-A263-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> The only behavioral change from V7 is the removal of unnecessary uses of
> CE_MATCH_IGNORE_FSMONITOR.  With a better understanding of *why* the
> CE_MATCH_IGNORE_* flags are used, it is now clear they are not required
> in most cases where CE_MATCH_IGNORE_FSMONITOR was being passed out of an
> abundance of caution.

The reviews and updates after this round was posted were to

 * 01/12 had an obvious pointer-vs-pointee thinko, which I think I
   have locally fixed;

 * 08/12 forgot to add a new test executable to .gitignore file,
   which I think I have locally fixed, too.

Any other review comments and suggestions for improvements?
Otherwise I am tempted to declare victory and merge this to 'next'
soonish.

For reference, here is the interdiff between what was posted as v8
and what I have on 'pu'.

Thanks.

 compat/bswap.h      | 4 ++--
 t/helper/.gitignore | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git b/compat/bswap.h a/compat/bswap.h
index 6b22c46214..5078ce5ecc 100644
--- b/compat/bswap.h
+++ a/compat/bswap.h
@@ -183,8 +183,8 @@ static inline uint32_t get_be32(const void *ptr)
 static inline uint64_t get_be64(const void *ptr)
 {
 	const unsigned char *p = ptr;
-	return	(uint64_t)get_be32(p[0]) << 32 |
-		(uint64_t)get_be32(p[4]) <<  0;
+	return	(uint64_t)get_be32(&p[0]) << 32 |
+		(uint64_t)get_be32(&p[4]) <<  0;
 }
 
 static inline void put_be32(void *ptr, uint32_t value)
diff --git b/t/helper/.gitignore a/t/helper/.gitignore
index f9328eebdd..87a648a7cf 100644
--- b/t/helper/.gitignore
+++ a/t/helper/.gitignore
@@ -5,6 +5,7 @@
 /test-delta
 /test-drop-caches
 /test-dump-cache-tree
+/test-dump-fsmonitor
 /test-dump-split-index
 /test-dump-untracked-cache
 /test-fake-ssh
