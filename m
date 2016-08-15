Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D35D1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbcHOT7F (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:59:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34297 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbcHOT7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:59:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so12840054wma.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 12:59:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4RuC6qIPEL4JwSrPwJ/jzl0E0vcwda05uuZVc+tqvg=;
        b=abvLWpdOohTbkkEQPYomYysXmAEbfP/O9ise+ap/UJRmZXcriOoly+DZlXtwKNcQK9
         DOlHQLbadTS2i89G2IwIeYRUGxIN1xM2x/5byJIdDBH0edh36DQtakzEltkRmTbiywTa
         ZSIPU3G5uqvFm+SeDGxOcNFALXvCx6RB0S+8/hhk34n2sXVM/G6UfbSsTV5OwuYDQ/qo
         d5G8HLYTRvM67oF8MHr8rDBtLaSLdOCU4CgtX3KtIiN1RjbxywqN5Yo7K7thMJUh1HBD
         c04n/ZTeLg/rXmikjmISZ8nmwGCJqoUavTPYocCrj6yFlF0CWO2/f6P8KGkVQZsw7FP5
         YAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4RuC6qIPEL4JwSrPwJ/jzl0E0vcwda05uuZVc+tqvg=;
        b=MLYVNUPq69G4RqNAnQXF5Wx3/r7wS+HcpmGcpBe2sI3MaKW0fffh8Fr+tJtY0431BL
         H9a2eHazQ2pFICf7JUyyjCk60tn4jwuii4m9+Fqxld11CXQDpkBtki/hj6YNN4SLY7mo
         dOKoe6pbswG7HiwVFu1nWDQcXFvJ785xEE3B5hS22E9HT3CDf6gaxtWKWNcjnOmulhLB
         ieMaGjcPq2EsGfq+4ZRSx7FB8K6jbgPg60blCpUXPxF54U5TMQAhxZ0e6Vst7bznDCh8
         moyXa1UI/Llv6Zs+K8iCvaxmTGCZaUledzvZKHB1i5SLwUm0bAmK70w/GuFjXU06P9Dg
         Axfg==
X-Gm-Message-State: AEkoouvPtEjwzyXCgzkSawG+QkzlEhsxse/74fORB8BPvvhqnBPtqjfq9PjG02l0kO5lvg==
X-Received: by 10.28.32.77 with SMTP id g74mr15721461wmg.45.1471291142894;
        Mon, 15 Aug 2016 12:59:02 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id p1sm23065623wjd.37.2016.08.15.12.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 12:59:02 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/3] unpack-objects: add --max-input-size=<size> option
Date:	Mon, 15 Aug 2016 21:57:28 +0200
Message-Id: <20160815195729.16826-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.4.g229e32c.dirty
In-Reply-To: <20160815195729.16826-1-chriscool@tuxfamily.org>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When receiving a pack-file, it can be useful to abort the
`git unpack-objects`, if the pack-file is too big.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/unpack-objects.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 172470b..59b1f39 100644
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
+				max_input_size = strtoul(arg, NULL, 10);
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
-- 
2.10.0.rc0.4.g229e32c.dirty

