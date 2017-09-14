Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0BB20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 07:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdINHwQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:52:16 -0400
Received: from 3.mo64.mail-out.ovh.net ([46.105.34.112]:48980 "EHLO
        3.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdINHwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:52:15 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 0067693E06
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 09:52:13 +0200 (CEST)
Received: from [10.0.2.127] (86.200.198.152) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 14
 Sep 2017 09:52:12 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH v4 4/4] imap-send: use curl by default when possible
To:     <git@vger.kernel.org>
References: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <ee4cb3a1-3219-411f-cc05-6874da202b32@morey-chaisemartin.com>
Date:   Thu, 14 Sep 2017 09:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.198.152]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 3832000334462707677
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrgeehgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set curl as the runtime default when it is available.
When linked against older curl versions (< 7_34_0) or without curl,
use the legacy imap implementation.

The goal is to validate feature parity between the legacy and
the curl implementation, deprecate the legacy implementation
later on and in the long term, hopefully drop it altogether.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7e39993d95..af1e1576bd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -35,11 +35,11 @@ typedef void *SSL;
 #include "http.h"
 #endif
 
-#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
-/* only available option */
+#if defined(USE_CURL_FOR_IMAP_SEND)
+/* Always default to curl if it's available. */
 #define USE_CURL_DEFAULT 1
 #else
-/* strictly opt in */
+/* We don't have curl, so continue to use the historical implementation */
 #define USE_CURL_DEFAULT 0
 #endif
 
-- 
2.14.1.461.g503560879

