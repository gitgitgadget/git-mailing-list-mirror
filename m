Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048B62079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdAOSre (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:34 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34762 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdAOSr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:28 -0500
Received: by mail-qk0-f193.google.com with SMTP id e1so13856255qkh.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Umh/ULOQMFLarFibzmEArALjWS8QhQFUKixbhL1WPY=;
        b=d5YZQbuupN91gIhFBVkV4WCKItQj6bFxyOCNLBo19rfjj0Z26rYO2AVOihthPM4vhE
         g3JEL+t/1eXrx1WCfSnE7K3PZJf5hyly3ePvxf5+i1iRNBrBW10AWiFVTk31SzFYBUP2
         HQmgQGL/s/JHXEa0skMhzvV9FQtMDLz7EBfoJtoQVAsKFTvRS++eFWKZSgc/7yqclbMi
         /ALrzeuAvytojGJ29zlEsnpPFOp+nd+bgiGKThuIHb8+jnbEmRRQFtiLOR1FxSj8HGaC
         irZFGOgJWY42mmV40xEw90UCzBQjG5DdvSjBvZXyAVhuzgbOItSEpzLpN6D8TRdLmGrV
         xumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Umh/ULOQMFLarFibzmEArALjWS8QhQFUKixbhL1WPY=;
        b=TjMTdD3XVnxyN63v95SKzi9NsIcaQei8pvUcCJZaLl39NjgRLd/dhYq6zr5waQGKDn
         iBP0ONuA+6RAHE3itOo4ASXF7yECr3Rf/bbVGWbE4cDD4V9SJ/w8n+w3OvzOGTm7oQOf
         ZegmkSGSS9vtoGudzVKPnyUm0TY+kcAGa1vRh0vo2UcdyxNPuQYNBsM/EmDA6B/EgtCz
         A2tlTlpRkUh8faod7mBFPsqpRkjhYXK3o6Z3FeVTJOf1O1eO8K5QZsaVPHyHevYn0OAe
         QGJNiBvsFPtFbWpz3Q0jF76v7LDzoBV3+DlTanPepDqSiGhhon+XOMr4n0XngzsY0LJM
         hHjw==
X-Gm-Message-State: AIkVDXJaJhQxpqhTZJYUx8Hfh0KB2mVNidgPlzsxcjEEvxu7h3JBmcLeZEd1GdtzzQoh7bJT
X-Received: by 10.55.33.136 with SMTP id f8mr15727256qki.132.1484506047021;
        Sun, 15 Jan 2017 10:47:27 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:26 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Date:   Sun, 15 Jan 2017 13:47:01 -0500
Message-Id: <20170115184705.10376-4-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Calling functions for gpg_verify_tag() may desire to print relevant
information about the header for further verification. Add an optional
format argument to print any desired information after GPG verification.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 tag.c                | 17 +++++++++++------
 tag.h                |  4 ++--
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 73df72811..880677df5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -105,7 +105,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
+	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 99f8148cf..de10198c4 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -51,7 +51,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		const char *name = argv[i++];
 		if (get_sha1(name, sha1))
 			had_error = !!error("tag '%s' not found.", name);
-		else if (gpg_verify_tag(sha1, name, flags))
+		else if (verify_and_format_tag(sha1, name, NULL, flags))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/tag.c b/tag.c
index 291073f6e..d5a7cfb20 100644
--- a/tag.c
+++ b/tag.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "gpg-interface.h"
+#include "ref-filter.h"
 
 const char *tag_type = "tag";
 
@@ -33,8 +34,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
-		unsigned flags)
+int verify_and_format_tag(const unsigned char *sha1, const char *name,
+		const char *fmt_pretty, unsigned flags)
 {
 	enum object_type type;
 	char *buf;
@@ -44,21 +45,25 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
 	type = sha1_object_info(sha1, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
-				name_to_report ?
-				name_to_report :
+				name ?
+				name :
 				find_unique_abbrev(sha1, DEFAULT_ABBREV),
 				typename(type));
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
-				name_to_report ?
-				name_to_report :
+				name ?
+				name :
 				find_unique_abbrev(sha1, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
 	free(buf);
+
+	if (fmt_pretty)
+		pretty_print_ref(name, sha1, fmt_pretty);
+
 	return ret;
 }
 
diff --git a/tag.h b/tag.h
index a5721b673..896b9c2dc 100644
--- a/tag.h
+++ b/tag.h
@@ -17,7 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern int gpg_verify_tag(const unsigned char *sha1,
-		const char *name_to_report, unsigned flags);
+extern int verify_and_format_tag(const unsigned char *sha1, const char *name,
+		const char *fmt_pretty, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.11.0

