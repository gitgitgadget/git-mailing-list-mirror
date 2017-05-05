Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AB7207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbdEEP2h (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:37 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36751 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdEEP2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:36 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so1299257qka.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZQYX3ernlq9CHAf6gbCAhGc/ZVfwi09W2VVtH46fMXo=;
        b=FZ6/tfKthJltWdpF4YnapbyrwbvNthvGI0TmSKZWp/JGVmrlY0BxMdtUyCeRP1TalE
         4sz+GGaKPRtALU/syxF0/8nQ2WBC5mSVqpi4A0CsaPfdUziZfqJ40pvjv5bzUxBgxrBj
         dtR9nJP9PtWQiWxSy2pnUeLBFCkTPXHNCxPG2p4uBxKyjhNytMcqCfc19NDtg4hTsjdh
         3PnmWsAIRjB0qhp/GI5loNd1fKZkusLgYhAaiakBFqptQ8bTWvN54EgBCuIZzCUucu1v
         Qs8fKrNS4miNPO6NARtfxk6ajAXHnH4+KAPzkpdoYuoWgkEYf1yz9D9nmIS5gys2YuUu
         GK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQYX3ernlq9CHAf6gbCAhGc/ZVfwi09W2VVtH46fMXo=;
        b=XcrPXe2FqpcqcwWm+AFGIG0C/9RFaVlSEjW3nMrXIjDu67WfJVH0kusTzKTaE3rVc1
         v3SgI/735C1Wraf8IEJvkP89FZVqXx5jd9sLryxRatOa8XcJN4Vawf9szni6P/YGb/l/
         3pKkDPTNAutUYx5WkwOipQWD0hsbYssCbGwzPrNFGp1D2beyDka1FY3RdRi9ukX8PJV1
         jT6OfyA2nuX6nqVGviFjeoSc59JCtru8chdcGTY2tC0xW02fxjADqrqGUtiGEdWUDD8Q
         lRo6JBGtDXhcPWA+Fwf8WbYJN+y9+fEuYAddEmWCtO627WHjbvb6DuQ8mE80DoUzLZtR
         bOhA==
X-Gm-Message-State: AODbwcDGg9m/G4GTGaAvO/t0KFF4wLc0Kx9Yx+ZFN6ztuAQYYSaRjjcX
        9LXpTmSsHHEHfg==
X-Received: by 10.55.203.65 with SMTP id d62mr13479478qkj.245.1493998115943;
        Fri, 05 May 2017 08:28:35 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:35 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 01/10] convert: remove erroneous tests for errno == EPIPE
Date:   Fri,  5 May 2017 11:27:53 -0400
Message-Id: <20170505152802.6724-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

start_multi_file_filter() and apply_multi_file_filter() currently test
for errno == EPIPE but treating EPIPE as an error is already happening
from one of the packet_write() functions.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Found/Fixed-by: Jeff King <peff@peff.net>
Acked-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 4e17e45ed2..bdd528086f 100644
--- a/convert.c
+++ b/convert.c
@@ -661,7 +661,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
+	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
 		kill_multi_file_filter(hashmap, entry);
 		return NULL;
@@ -752,7 +752,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
+	if (err) {
 		if (!strcmp(filter_status.buf, "error")) {
 			/* The filter signaled a problem with the file. */
 		} else if (!strcmp(filter_status.buf, "abort")) {
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

