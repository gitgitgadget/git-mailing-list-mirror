Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B26E207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755212AbdEDNzo (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:55:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:59590 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755167AbdEDNzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:42 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lurin-1e5loY0zj7-0108Dk; Thu, 04
 May 2017 15:55:31 +0200
Date:   Thu, 4 May 2017 15:55:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 02/25] winansi: avoid use of uninitialized value
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <7e3a788caec040f9ec907969c01dc2bc7be4b490.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BntcqHd/9M6Vlt5EJ6a/iPsalN7XWJRGiju43wQo2HtaJBFou3r
 t5D05pG9HOTd25gDWuH043CTt4iNkRKL9iENE+6cdRgJpYG7pKgVm7ovVmNHEGHXSQk1oid
 C9QgEx8bALt2w/mBVmny3w/qA7N3ZveJfMPVX1HLGBvxT/wCjp6LSBC5Wc4gBTInJk5pXUN
 fpr4aTo+t2AvmfZBuSbhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yl3r6dew6do=:E8xxAxrurgrCySB4nqqiIW
 MFhgysPQL9C4w9GbfFUzQnOQeuNTCb0mNovX0RJQJo1w/Yjg6o9f/wUDfBBt1MOBfuJY0ODPo
 KXGcUXPNDHWD9W2ZPSaarpJTe33fMTdvRJZ0mRPHOo6YshjYJX+4YfM4tmXMJBbIDIeRBuouc
 j+Ip4/8Qq/qq2g4g9NNTGrSEZ3WY1hgDP6RYdCCt5tNAm3cZU38fudQRpwZFnyQuPxb6rJ6Ev
 ZtQ5TuC0kADB838pKmbnTLSuY3nZRh/qA4pYUu94TNR2Lklrt+ylqtk6dAQ6VkN2XdGBR1btv
 UDNcwyJl5bR6YecNRGLmyRMvz/g74n6WlGiZrnLvZ7MF+H2bzFsUbMLGvHBJDLqxxLN69g1S1
 T+vV55G+DM/0V9gcm3e379F/OFN4TRRsyrNJsbmSKGUw3FB/fmdowJNXXgyVMMYWtBUlFR8ab
 9IpjuisLt1rJMSPt2QSz/eYeEF6shAn5Bj9J+1lewsfjOa5YUT7sjBfi+yx0Sgo3VNciHsaob
 ox/t1UUe//z4VtMvciKTspWfnCqfkwzTsaAf0O1DsyNOrdsUh6kC2ughnbd5CHi2MAkcBAnN/
 3vdDsTPHJjDNKuHSQSlO7EqGzAfOHQCWe0bnX/kxlViEciADn89xElcMgOtM8JGJILwt6P67J
 s8h+t6S8ZIyMvczhU+k9OG0/Zrpjyn/aS09ej0Bnqb/4z1efB39Wc3jG0g4eyfidm6emMFMIj
 QctI6CR6ZvVQ/GtlprskO5N0/AqyUS5trDMaxCQyELLsskiO39TiHkdQlGxpjBMKNIh4bF6B1
 BkiN4yu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To initialize the foreground color attributes of "plain text", our ANSI
emulation tries to infer them from the currently attached console while
running the is_console() function. This function first tries to detect any
console attached to stdout, then it is called with stderr.

If neither stdout nor stderr has any console attached, it does not
actually matter what we use for "plain text" attributes, as we never need
to output any text to any console in that case.

However, after working on stdout and stderr, is_console() is called with
stdin, and it still tries to initialize the "plain text" attributes if
they had not been initialized earlier. In this case, we cannot detect any
attributes, and we used an uninitialized value for them.

Naturally, Coverity complained about this use case because it could not
reason about the code deeply enough to figure out that we do not even use
those attributes in that case.

Let's just initialize the value to 0 in that case, both to avoid future
Coverity reports, and to help catch future regressions in case anybody
changes the order of the is_console() calls (which would make the text
black on black).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index 793420f9d0d..a551de90eb0 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -105,6 +105,13 @@ static int is_console(int fd)
 	if (!fd) {
 		if (!GetConsoleMode(hcon, &mode))
 			return 0;
+		/*
+		 * This code path is only reached if there is no console
+		 * attached to stdout/stderr, i.e. we will not need to output
+		 * any text to any console, therefore we might just as well
+		 * use black as foreground color.
+		 */
+		sbi.wAttributes = 0;
 	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
-- 
2.12.2.windows.2.800.gede8f145e06


