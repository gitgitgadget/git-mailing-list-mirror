Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F51F202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbdF3AHa (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:30 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33769 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdF3AH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:27 -0400
Received: by mail-pg0-f51.google.com with SMTP id f127so55146123pgc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGcmNupeDJrKVnj7/r52Ck2IFtSOzfgdpBoKqmiwkyQ=;
        b=nyMR1CIUOHHl4EW0R9r5ibmM9Dp5nm/pvx2+wtVP8ZZf7LPoii18G/98wEZNaD34RM
         nQTxRbHK1Bf4QOKnO83hsT7XBIVGiFgTm1zdSbXQpI3KYN2MfrBkdVfzR90QzBAlCGrt
         4QdF9OhFtP/ajAFM+YxdlOxEk7n9DTfNFMdE7i7zcWpck89PxRu8eM7mCTerirHb9fZJ
         3vnyS85DNTj6u3ONbeNGEbgYoi3j+/Lag/oYDbyV/zYjQunjMuYjadJcvYdgxLau7F7w
         6jIev+jwdEMq2X0mwppLZCMsypjgL9gBciKbbeAYnY6SrUS+D6q2Juo5t35+koZ7/ZY9
         xYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGcmNupeDJrKVnj7/r52Ck2IFtSOzfgdpBoKqmiwkyQ=;
        b=MBIVmSlEKAwTjkJ9fwjwkyddhvsmWy58N+xqZ9GfFlOUsyGT3FWgGmo7+HdT9Mr/5Y
         MogWGxRX5oXeOSxJb91Zv69saslBxCFntxeWENTmFAUXFqmIbSFtMy1fYK7nP5xNmUSS
         yn4Fk1KlEqWO/FKExjSovGKVNYIYobIoqoG7ys/P9DmFHw/Q1HimF57AFoSlwUWChKoC
         zYpDaLl1qhmvX9XFkggUHpDkC9wsNBj+ZRpiwT8P5Y+eXXzyeiovdxKIiUqW8umqS+xt
         qZm7+MXb53N6fu05/MkUasMNIDAgr2I4azpi3hDZjpJV2qKR5ac9G+h1WlU832RI8lB6
         Oo3A==
X-Gm-Message-State: AKS2vOwC9UMP7kmoYM7FFGdnux2nuMfVyql3AX3jhepy8tapY8vjiJ7t
        4yY655pg+2KHfavv817S4Q==
X-Received: by 10.84.171.197 with SMTP id l63mr20776211plb.167.1498781247046;
        Thu, 29 Jun 2017 17:07:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id l85sm12744147pfj.130.2017.06.29.17.07.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/25] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Thu, 29 Jun 2017 17:06:48 -0700
Message-Id: <20170630000710.10601-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to do more things before and after all filepairs
are flushed. So factor flushing out all file pairs into its own function
that the new code can be plugged in easily.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 94fdb57927..77ef56a6e4 100644
--- a/diff.c
+++ b/diff.c
@@ -4734,6 +4734,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(_(rename_limit_advice), varname, needed);
 }
 
+static void diff_flush_patch_all_file_pairs(struct diff_options *o)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_patch(p, o);
+	}
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4826,11 +4837,7 @@ void diff_flush(struct diff_options *options)
 			}
 		}
 
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_patch(p, options);
-		}
+		diff_flush_patch_all_file_pairs(options);
 	}
 
 	if (output_format & DIFF_FORMAT_CALLBACK)
-- 
2.13.0.31.g9b732c453e

