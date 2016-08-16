Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566341FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbcHPIRu (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:17:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33806 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcHPIRs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:17:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so15045802wma.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 01:17:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UymfiVPkouXbUhQ5xmMW+zD/J41SeNMJAVBDfWlvhNg=;
        b=1Gh6wNMF5phNieSENd86hMhkVmo/FkRcvFUOxHr0wP7mJJie82maMBtFZk8V0n76+Z
         1m8DjhMcgh+ITHAQVL6E0XAduIf8q5KN1vQQTRNltj74Nb6PXfj6iMkbnke6HxNDFrhw
         K1FrZouIKJqL0Ivu3xS1n2n/WuDNU2lSgRUkbysrj+EkjOcF+tcZR137h7mGcVHiMNqr
         PEBi0vFNntlIUWY8SnZ6pIRQIGZ6rAQhaqBzcnEybF75BERlVNdR8i1GwYnLtJWzbXp0
         KHkycBWmfmlpohX5bdZENkGHdrlcSKW2bRw5LWYOIiOTfZdmoTpcJAzUw8u7JXwA4Ikk
         l1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UymfiVPkouXbUhQ5xmMW+zD/J41SeNMJAVBDfWlvhNg=;
        b=J7X4Eru9IOS4gSnUTL/kjnIqWZrw989SxxyZt1c2sB/EwNqkx4j4E6VorXacQFeXEA
         JxRy12wVOaTO+ek/3FCXWOyH6ku7YnRLetCgnrb7/UnEYQTOUwO337KQB3rSsnWHYZtZ
         x5mHboIfRANaiI/lyvlCfEAz9BFvc0mvSpYWwGcIukiNkXcNmzFnJaSeo6irodf8qpPz
         YEFbO6mQC6qPkTh9QIhI79znDfOlteBmtzEe01GLAJTTtAElOcFCw9YWi+wmBqYyGqlx
         uVtzAN9Yic5LxU28IrZU/mU2cZ1w+fzMq9ZqgvWDfXWcrypokfxey6zwWNRCwiYBLxtV
         3VUA==
X-Gm-Message-State: AEkoouv0qBQU7gON8MuuYeNuTy+AAwSkeLI7CKd7XHibOClBjj6DCmCsclzkV+dWZb0oqQ==
X-Received: by 10.28.130.208 with SMTP id e199mr20898269wmd.14.1471335467109;
        Tue, 16 Aug 2016 01:17:47 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id 142sm20461121wmh.12.2016.08.16.01.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Aug 2016 01:17:46 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] index-pack: add --max-input-size=<size> option
Date:	Tue, 16 Aug 2016 10:16:59 +0200
Message-Id: <20160816081701.29949-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.g8535b4c
In-Reply-To: <20160816081701.29949-1-chriscool@tuxfamily.org>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

When receiving a pack-file, it can be useful to abort the
`git index-pack`, if the pack-file is too big.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-index-pack.txt | 2 ++
 builtin/index-pack.c             | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..1b4b65d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -87,6 +87,8 @@ OPTIONS
 	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and use maximum 3 threads.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
 
 Note
 ----
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1d2ea58..4a8b4ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -87,6 +87,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
@@ -297,6 +298,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die(_("pack too large for current definition of off_t"));
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static const char *open_pack_file(const char *pack_name)
@@ -1714,6 +1717,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					opts.off32_limit = strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoumax(arg, NULL, 10);
 			} else
 				usage(index_pack_usage);
 			continue;
-- 
2.10.0.rc0.3.g8535b4c

