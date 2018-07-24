Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7A01F597
	for <e@80x24.org>; Tue, 24 Jul 2018 14:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeGXPtx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 11:49:53 -0400
Received: from siwi.pair.com ([209.68.5.199]:12068 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbeGXPtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 11:49:53 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 78F733F4104;
        Tue, 24 Jul 2018 10:43:04 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F1FF73F40F3;
        Tue, 24 Jul 2018 10:43:03 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, larsxschneider@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1] msvc: fix non-standard escape sequence in source
Date:   Tue, 24 Jul 2018 14:42:49 +0000
Message-Id: <20180724144249.2857-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Replace non-standard "\e" escape sequence with "\x1B".

In commit 7a17918c34f4e83982456ffe22d880c3cda5384f a trace message with
several "\e" escape sequences was added.  This causes a compiler warning
under MSVC.

According to [1], the "\e" sequence is an extension supported by GCC,
clang, and tcc.

[1] https://en.wikipedia.org/wiki/Escape_sequences_in_C

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 56cfe31..52092be 100644
--- a/convert.c
+++ b/convert.c
@@ -335,7 +335,7 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(
-			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			&trace,"| \x1B[2m%2i:\x1B[0m %2x \x1B[2m%c\x1B[0m%c",
 			i,
 			(unsigned char) buf[i],
 			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
-- 
2.9.3

