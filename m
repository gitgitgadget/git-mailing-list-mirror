Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E8A1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbcHXSmX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:42:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33951 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755292AbcHXSmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:42:19 -0400
Received: by mail-qk0-f193.google.com with SMTP id r128so1833646qkc.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hoTrY6+FKS81TRYzm2zDV956uopQAKdn48xJJpEdfSo=;
        b=TVn5TWwIGmyfko4NRwMa/edB3+uPYwsfbrlcCx1pC5X7l1pV1F0hX1ptopOkHO4zWI
         lo3yMhvqIMtOTuo6HlJ3q+uVHRBW4nDMht0mhVVeVv4Pg7zECaPhjzFqYJcIv6vxA9VC
         U/pFdDqBGDhpVB53X19RNoKuxD12ccxPGJenIa0CIUGa8aSJ7tpxMKHWgPymQVMksfdN
         guGXMa8mDUcnWStYh4tVzNNE0hukPmWaIxfKkRkflnGTKxiSZXuuvFq/Hwy8xKycTLUI
         CCPznruDuY8nig0fY97VP8h0RicIO7YqCSqSQruPRYX1+ocf98xzjTrrECxf/sIjrq2U
         n/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hoTrY6+FKS81TRYzm2zDV956uopQAKdn48xJJpEdfSo=;
        b=iRcPcGC7/XlGC5HzmKSL1AySMtfyyBb4/AjIwhnHqJOVqfK+nWZM+fhY6sOaJkQkf9
         CZsQmAQ2swIAehRRMhFzcWJrJAYst/Dvwb+/fxGs0FocgqBzHXRihemplbrQU4rwP0z6
         nrDNB5hYL5iJW+wdEtSeQbCsKLAQ9/lJQy1y4CuQ4ovVIqd9YMsmQQt2Sk/1hJZPaZRs
         bbT5pO5A2MEnX0FxXgBG/ysCHhFbHWz2CUQx3cTD997Pa/hKse9/Cz9VrsUBifbPLfBI
         kFk8GDEal1xy7c4XRthwEgv4P7yckYsnqGI6/ZFQ+41vCzMhK8gwlFprZAaGU0Vepd56
         cAKA==
X-Gm-Message-State: AE9vXwMb8U1Jn/LMdOqI5acW7q01bv0fz72EdK972X/JcaiUULOrr07dkbtkcAlDCzSEwg==
X-Received: by 10.55.147.1 with SMTP id v1mr5449203qkd.107.1472064134109;
        Wed, 24 Aug 2016 11:42:14 -0700 (PDT)
Received: from christian-Latitude-E6330.event.rightround.com ([75.98.193.200])
        by smtp.gmail.com with ESMTPSA id k20sm5412874qkl.2.2016.08.24.11.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 11:42:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/3] unpack-objects: add --max-input-size=<size> option
Date:   Wed, 24 Aug 2016 20:41:56 +0200
Message-Id: <20160824184157.19264-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc1.3.g93be2b9
In-Reply-To: <20160824184157.19264-1-chriscool@tuxfamily.org>
References: <20160824184157.19264-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When receiving a pack-file, it can be useful to abort the
`git unpack-objects`, if the pack-file is too big.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-unpack-objects.txt | 3 +++
 builtin/unpack-objects.c             | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 3e887d1..b3de50d 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -44,6 +44,9 @@ OPTIONS
 --strict::
 	Don't write objects with broken content or links.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 172470b..4532aa0 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -19,6 +19,7 @@ static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]
 static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static git_SHA_CTX ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
@@ -87,6 +88,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static void *get_data(unsigned long size)
@@ -550,6 +553,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				len = sizeof(*hdr);
 				continue;
 			}
+			if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoumax(arg, NULL, 10);
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
-- 
2.10.0.rc1.3.g93be2b9

