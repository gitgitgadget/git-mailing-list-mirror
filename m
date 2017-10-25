Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F569203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 18:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbdJYSuq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 14:50:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:52662 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932354AbdJYStR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 14:49:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id e64so615893pfk.9
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTb6daQqou68Ei13RMC8gfHxdAyjLsB58gO3ITCMqrA=;
        b=XfnJpMyLD1JTbvQOAVVcE83NTHPX6ckaeMFmrlaIybSWRtwigTCu0ctq1e3ZjgXi8M
         oMyfFJS5oM9XsroWhyA475PKELxEwnzVDop/pAox91nUrv1C4cy03hi3Gq0e0t0XewV2
         wcHC2Df/rgQy7L1TB9tGmMc4Kcqai5T2HwMm7wR/ZMQQ3l39ph5LOe8FT+eSaR9/27iO
         8e0jRe5L5efgHeVm9kYicCUHNCQpM62NI4VV9nCLknoO7tOoyoWFqXXfMJIWcWnGFAMU
         pUyFTTSPuOHNVNIrMyK4csTSe/1V3Cp//U8FWHY/Fgoilhy+jUoAn4EB5iZuxUY0MC/R
         4JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oTb6daQqou68Ei13RMC8gfHxdAyjLsB58gO3ITCMqrA=;
        b=Aqez9m9TR+DwKc1/UrViJ2tJ2FZNQovolzyCb9NkE3LO04YTow0ShYAWcL9O52kWLW
         XbO2kNqPlf4Q9sUd8Vwn3HyjSAMV3Mk58QLhiSNxxdhvu3UfikrLK/Wj7gR/t1X84x0K
         NFLFYenEgRQjX27+S4Uk4K9yzX0Ld9lMtEUrlCeXJ60mXFak8UPfDncZ2K70CuDTwCJL
         tj5S3qcnclg8RYLGBEzEBDAkMoUyiKBVV6WBJiIO+xg8ghnIL5BGCvB/hXthLPqfeu8/
         Sy8HqCV5sCtRTUkZ/dQSnhv3ljzsnan0oKPaaSlorO98KgAKJP8AOJ1Pnfz9wrYV7CXx
         pncw==
X-Gm-Message-State: AMCzsaWltVTUUv2k41YTB7yof1BHwC/vpI/+BSFoTgVEBNMl0+bbtk6m
        O5KEKzZU1rf8S0U69D4qsLCpKg==
X-Google-Smtp-Source: ABhQp+SuF6JShOGVKMyMRVQQ6gnVyJvPgzCN2LcAX00ePRzTKJu52liTK9ab6KyWK2GBQKdl4l/49A==
X-Received: by 10.98.163.193 with SMTP id q62mr3069864pfl.276.1508957356264;
        Wed, 25 Oct 2017 11:49:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d7b:dd00:69b5:edeb])
        by smtp.gmail.com with ESMTPSA id r18sm6026393pfe.99.2017.10.25.11.49.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 11:49:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        peff@peff.net, sbeller@google.com
Subject: [PATCH 1/2] xdiff-interface: export comparing and hashing strings
Date:   Wed, 25 Oct 2017 11:49:11 -0700
Message-Id: <20171025184912.21657-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171025184912.21657-1-sbeller@google.com>
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
 <20171025184912.21657-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will turn out to be useful in a later patch.

xdl_recmatch is exported in xdiff/xutils.h, to be used by various
xdiff/*.c files, but not outside of xdiff/. This one makes it available
to the outside, too.

While at it, add documentation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff-interface.c | 12 ++++++++++++
 xdiff-interface.h | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 018e033089..770e1f7f81 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -5,6 +5,7 @@
 #include "xdiff/xdiffi.h"
 #include "xdiff/xemit.h"
 #include "xdiff/xmacros.h"
+#include "xdiff/xutils.h"
 
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
@@ -296,6 +297,17 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
 	}
 }
 
+unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
+{
+	return xdl_hash_record(&s, s + len, flags);
+}
+
+int xdiff_compare_lines(const char *l1, long s1,
+			const char *l2, long s2, long flags)
+{
+	return xdl_recmatch(l1, s1, l2, s2, flags);
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 6f6ba9095d..135fc05d72 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -29,4 +29,20 @@ extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
 extern int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
+/*
+ * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
+ * Returns 1 if the strings are deemed equal, 0 otherwise.
+ * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
+ * are treated for the comparision.
+ */
+extern int xdiff_compare_lines(const char *l1, long s1,
+			       const char *l2, long s2, long flags);
+
+/*
+ * Returns a hash of the string s of length len.
+ * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
+ * are treated for the hash.
+ */
+extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
+
 #endif
-- 
2.15.0.rc2.6.g953226eb5f

