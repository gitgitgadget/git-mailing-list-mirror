Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D749E94134
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjJFWBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjJFWBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:01:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D77BD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:01:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7740c8509c8so163496385a.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629711; x=1697234511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2mVs/HGyl66PZJ1g77jzYqsJ5AKC++VawlUe5Kc/y8=;
        b=uW05FIG+y6nKEISnUAgCRMCxJg5UTWctT8UsqMJsgcG89999oonmlkpiNjJDU4ZDcY
         T6oU/Wp0CvqnkyMxGVCQvnUX+upnZbmQXQ8FcbzJXFg3l3RtqyGaHMUNotNRPSHNNrdY
         Nr9d/xse88Y97+KcbmSkO3TLZIYezWSZIlrioNc0X2Z39AYQ+3bP0RLRnj9Yj8NAXq1e
         pIi/mwNowoBgrECbJG5k52fGLmFoUjxL/Qn97S6EIKxFX145FDo6y3UgU4FoeMf8de8G
         BAl5pUx78wlPgy+jDFLM2exBptp/KEx4gBapJ+DKQr8Q1+JHj1WzuHQmnB7ZMNmcFVP9
         yG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629711; x=1697234511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2mVs/HGyl66PZJ1g77jzYqsJ5AKC++VawlUe5Kc/y8=;
        b=VmUS09niq2QDyAGj5xIDuc8D+xVwALue6+RCB506g/rp6RighvnLrmesu6fiy4AscA
         TSKBuMh2gqsmd9kZnAQ0yE+GP1Za+uS54JmANsuGS6fIRGegzmxpmO8qeEtFwAQ1+fsw
         Q+NGEZ1cKrvxrBLleh9JyBx7E7RsUbpkmwJB0NsImF+uGJ8aK2wuxfO7omtFtfgwwyAz
         2HkBDtYEaaSFaj3MKvCbwhg23dTluuCU21m4dKFTddIKjClre6fwdjSsS011oq16xqCu
         atKsZSAUZ0kR5FMfAgZ1eo0tVeqRrQiwwOaq5Q4PdEnbjGBXFnXrEyD1FhvhkgfrkVSk
         v+Uw==
X-Gm-Message-State: AOJu0YwKyyZOtx4agqihS9m2HFk+mieYZ3+OYb7u8cGs3xWg2ZB68bgq
        cy2muMkMjy0d3VWD5X89BTkrKtbnodLJVh6lZFAFVw==
X-Google-Smtp-Source: AGHT+IEA8oPNUvgREcd5dEjQV2YzgHq2UvdzJKm6/PR0khKlp6FjaaUG3Z6srcLyKhlry599ZSciWw==
X-Received: by 2002:a05:620a:3915:b0:76d:a00b:84f8 with SMTP id qr21-20020a05620a391500b0076da00b84f8mr10946707qkn.57.1696629711199;
        Fri, 06 Oct 2023 15:01:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o16-20020ae9f510000000b00765aa3ffa07sm1614058qkg.98.2023.10.06.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:01:50 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:01:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] bulk-checkin: factor out `format_object_header_hash()`
Message-ID: <37f407281596dd596e49c847c35fdf163977b479.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before deflating a blob into a pack, the bulk-checkin mechanism prepares
the pack object header by calling `format_object_header()`, and writing
into a scratch buffer, the contents of which eventually makes its way
into the pack.

Future commits will add support for deflating multiple kinds of objects
into a pack, and will likewise need to perform a similar operation as
below.

This is a mostly straightforward extraction, with one notable exception.
Instead of hard-coding `the_hash_algo`, pass it in to the new function
as an argument. This isn't strictly necessary for our immediate purposes
here, but will prove useful in the future if/when the bulk-checkin
mechanism grows support for the hash transition plan.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 223562b4e7..0aac3dfe31 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -247,6 +247,19 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
+static void format_object_header_hash(const struct git_hash_algo *algop,
+				      git_hash_ctx *ctx, enum object_type type,
+				      size_t size)
+{
+	unsigned char header[16384];
+	unsigned header_len = format_object_header((char *)header,
+						   sizeof(header),
+						   type, size);
+
+	algop->init_fn(ctx);
+	algop->update_fn(ctx, header, header_len);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -254,8 +267,6 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 {
 	off_t seekback, already_hashed_to;
 	git_hash_ctx ctx;
-	unsigned char obuf[16384];
-	unsigned header_len;
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
 
@@ -263,10 +274,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, size);
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, obuf, header_len);
+	format_object_header_hash(the_hash_algo, &ctx, OBJ_BLOB, size);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
-- 
2.42.0.8.g7a7e1e881e.dirty

