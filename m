Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77ADD1F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdHHH6K (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:58:10 -0400
Received: from 1.mo176.mail-out.ovh.net ([178.33.254.253]:33297 "EHLO
        1.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdHHH6K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:58:10 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 487026A26C
        for <git@vger.kernel.org>; Tue,  8 Aug 2017 09:48:30 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 8 Aug
 2017 09:48:30 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCHv2 4/4] imap-send: use curl by default
To:     <git@vger.kernel.org>
References: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com>
Message-ID: <ee64e0d5-49e7-9e6f-a1f0-fea42557e44e@morey-chaisemartin.com>
Date:   Tue, 8 Aug 2017 09:48:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX4.indiv2.local (172.16.2.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 7840204002461870045
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedvgddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that curl is enable by default, use the curl implementation
for imap too.
The goal is to validate feature parity between the legacy and
the curl implementation, deprecate thee legacy implementation
later on and in the long term, hopefully drop it altogether.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 5e80edaff..138d776f7 100644
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
2.14.0.rc1.16.gcc208c97c

