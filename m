Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D6B20987
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756453AbcJGVIX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33145 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755303AbcJGVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id n66so3245863qkf.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RRFIaRbjMbh0nJgq2nbbIRN3vK5z+spkS/zkStW/ZVE=;
        b=WQz8pkB3TS42L/VIRzbtHIqkgGq2tFHVtaHuBtMg1j7gfPby6lOn7GTun/4xZR3YCW
         dGPymE1sGVnPNXLhfQQBCegtfqdXeAt4aL1R6O5foVtCMVrSz77ZKW7GBr3trFe81UF6
         7HYvcZFsuBJ7cSnbfmWTrJ4BF7LyJVeSAY+NrtLudQOutbLQdv9rfPy6OsFvizXClwBH
         HXjjByirxMdbnlM9+ns1AlOck2TZoolu+G7Oy0AlamNWF/nAT0Bll4TZKLuxlYc1FSuj
         UjZ1P2Cqmy+GcItqE9gi1pPlXOVTKnuO3NJf/7RZLuU2BCBzIyRYPgeRLaxHg07sFmvk
         jrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RRFIaRbjMbh0nJgq2nbbIRN3vK5z+spkS/zkStW/ZVE=;
        b=BxgmLFC49jOWwm2xKA3fcArH6lAACHX2a/IhzswU/YZwhj2pOuJFWA91TNX29vpXKu
         e+pUFvQLIwH6n13ZxUBSE+frMhXLUFOJbk4BIEERbWZt8akS+UhirswJyj3Q4Ph9rYLQ
         uFvf3W72qQE8MCk7kpywbYLJ3/480N4aOcB9XUhWhelbuumNUnAGV3L74ieJKBRFNofv
         bR3yVWMm3jTPDtiFxFJNRoRCl2q/C8ajBJvR5TOJ9kAfIRMV+e5E9F0Qow5Q27jOMA8b
         YlJKiX3be3St/22v++PGtPxRwzm9T/GeuB3YV6LIekexqlV4jpnt8JOB9cLj8GxnVhLn
         8R0A==
X-Gm-Message-State: AA6/9RkV83yS/8bKdM91t/WgAQOyliV5GbiHY4u/P5azuw3nItCx2bafFvLyMEdtgXsfarFI
X-Received: by 10.55.195.142 with SMTP id r14mr20836235qkl.165.1475874449736;
        Fri, 07 Oct 2016 14:07:29 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:29 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v4 3/7] tag: add format specifier to gpg_verify_tag
Date:   Fri,  7 Oct 2016 17:07:17 -0400
Message-Id: <20161007210721.20437-4-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
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
index 50e4ae5..14f3b48 100644
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
index 99f8148..de10198 100644
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
index 291073f..d3512c0 100644
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
+		pretty_print_ref(name, sha1, fmt_pretty, FILTER_REFS_TAGS);
+
 	return ret;
 }
 
diff --git a/tag.h b/tag.h
index a5721b6..896b9c2 100644
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
2.10.0

