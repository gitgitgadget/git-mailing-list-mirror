Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B303C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7BB233CF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgLPOvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:51:46 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091DC0617B0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:06 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c14so17353320qtn.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ5g2NKZ+Yl4EQAQ6TBQG1KnM7jiljUTLWq2F/EKKVs=;
        b=vxEDIusMCnkU6I5ppQPdOFbZKryqk3k7iDGFeJToYTScy9FQdfGZpcgDOivi86i8cg
         2mzrjsspAxwo/fP6Bc0e1bAurAeK8gdQa5NdaKo6NTVHY7k7ff2BPL5yfPnYpYTJZmR7
         Tl7FY7SAuIj64WMEmLGAiIyG/BudQyLVUwOReJmz8bL82cVWdIgYzjM5J6k8KiNjNo8b
         h6xloXrVp2tQTTxeg3yXNC4lzY0+13gyuSrkMziwybb2AG+fRPnbSjxh72V5jst1PgUR
         Z9SIJzJAAKqx7/62ocbVZO9T6dKJtw8/4nIok03OiutPLzyAOvtlaLV36wDNY2WeGMxT
         JO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ5g2NKZ+Yl4EQAQ6TBQG1KnM7jiljUTLWq2F/EKKVs=;
        b=Ay7OyPFKxpwkDFcaeYTkIVPNFIFERKaG1kPteGVWqKWpOCOCHQ3QBLtr5GCyWZxiCI
         /Oh99hcaN04LSWgWLNqxbKCoaz6m00Fe+/lIV4ubhIL7fUh0nEdrArb/IbCrqdOr3GUk
         a/xvHoghz0e6V8ETmH2N3Ql+TLs5zPI/TRkEbwJnMIuZdE+d8zmsGSWIiKM+5ToyTwgC
         IvmZgpw835pSCwB6G8KD9JSWr9IiZzyEVOtVfEsWWJkDv+YOIocHXCtRdzyVL9Py7iOI
         sPJEyWXyy5m8KF4/xkYsrLCZ4mJCg4tQinukcxeYbWTjPQZMFxb2+pfkc0X1UuZsA6v4
         LAPA==
X-Gm-Message-State: AOAM533OodFqccyNhAnqwxDBYlWaPTJTORzzTLrW/4zUzc/Qv/qJKIkP
        WJYNa/2qNHtAWv6qp9ZriluyZRwtugrmqg==
X-Google-Smtp-Source: ABdhPJzFyAsnIje0uMjAwUbzQePAT95O9tBUMNf57JA1s3ipPuuBatQk8lHuUQidntjUVnbU0LUZKg==
X-Received: by 2002:ac8:5956:: with SMTP id 22mr42930900qtz.63.1608130265382;
        Wed, 16 Dec 2020 06:51:05 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:04 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 3/9] convert: add get_stream_filter_ca() variant
Date:   Wed, 16 Dec 2020 11:50:32 -0300
Message-Id: <8af17f6a9b613b73050f59a480302f04bf733b73.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Like the previous patch, we will also need to call get_stream_filter()
with a precomputed `struct conv_attrs`, when we add support for parallel
checkout workers. So add the _ca() variant which takes the conversion
attributes struct as a parameter.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 28 +++++++++++++++++-----------
 convert.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/convert.c b/convert.c
index 0307374241..9af6aafc5a 100644
--- a/convert.c
+++ b/convert.c
@@ -1942,34 +1942,31 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
 }
 
 /*
- * Return an appropriately constructed filter for the path, or NULL if
+ * Return an appropriately constructed filter for the given ca, or NULL if
  * the contents cannot be filtered without reading the whole thing
  * in-core.
  *
  * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter(const struct index_state *istate,
-					const char *path,
-					const struct object_id *oid)
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid)
 {
-	struct conv_attrs ca;
 	struct stream_filter *filter = NULL;
 
-	convert_attrs(istate, &ca, path);
-	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
+	if (ca->drv && (ca->drv->process || ca->drv->smudge || ca->drv->clean))
 		return NULL;
 
-	if (ca.working_tree_encoding)
+	if (ca->working_tree_encoding)
 		return NULL;
 
-	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
+	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
-	if (ca.ident)
+	if (ca->ident)
 		filter = ident_filter(oid);
 
-	if (output_eol(ca.crlf_action) == EOL_CRLF)
+	if (output_eol(ca->crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
 	else
 		filter = cascade_filter(filter, &null_filter_singleton);
@@ -1977,6 +1974,15 @@ struct stream_filter *get_stream_filter(const struct index_state *istate,
 	return filter;
 }
 
+struct stream_filter *get_stream_filter(const struct index_state *istate,
+					const char *path,
+					const struct object_id *oid)
+{
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return get_stream_filter_ca(&ca, oid);
+}
+
 void free_stream_filter(struct stream_filter *filter)
 {
 	filter->vtbl->free(filter);
diff --git a/convert.h b/convert.h
index a4838b5e5c..484b50965d 100644
--- a/convert.h
+++ b/convert.h
@@ -179,6 +179,8 @@ struct stream_filter; /* opaque */
 struct stream_filter *get_stream_filter(const struct index_state *istate,
 					const char *path,
 					const struct object_id *);
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid);
 void free_stream_filter(struct stream_filter *);
 int is_null_stream_filter(struct stream_filter *);
 
-- 
2.29.2

