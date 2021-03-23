Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6DC433E1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEB4619C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhCWOVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhCWOUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E8C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o5so14431895qkb.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wqRHpX/Y/qBjqxPYaRa5qF+S1sSb08MDfuRqljXIkA=;
        b=T/f1/irC+mnAHbDVv1KW9sdjvDA55Np+reEzD3xUG4V3U5F7u2o7irLo/aJBJMloVT
         GDz49+zgAlR0Mp95F1w8zuQsWPNm7XVWca5LvVHGO9KDFWqagF/Tk/8H9XIDuVIgdk5A
         IMAAEYzupVl4Fa6rycg9opjeUjkBpoDA8nTkFfB8vfxlmYa7tQWCmHFitAjWAUjKhWYi
         sDKYNVjcCiqoIa5OyN1j9rl6iMtv6s0YbI4ZYHu214kWNQwZMusKzeGtMhPxk/W8Urlc
         D/RysPpw6JbZYgOMRlvluJ6Y0ImmK5awjxTP/o06ERDBLqE8Ezgj2GqKbjX+9sLjqA3F
         m4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wqRHpX/Y/qBjqxPYaRa5qF+S1sSb08MDfuRqljXIkA=;
        b=N6CH858T/R8lCn+rt2gduHSnha6W92qf5nkjf/PdcHnoxuD+qaVaaWZdxJx/wvhWNM
         mN1oFv2rlbwaBlpP5Kc1qFri8TFt7JDFStZTsDJxSFZVyXYdEL4TuAcSIYTlihugFn5P
         DiPMCRMt5njZlgOaV4fSI7wnqpHEPrZbrtfeJQJyH14bB/SP28V0UUUe399Q9Dk/WRL2
         SQyK25bfDi4qB02OEDxkgrrHj4rG7vYInY5P+DaTbI8PjZ/QSOZii62G/BD07QWiiKNn
         fgktgZP9QkOsu4c8MgEdvhCJX62buL06zOKQwgnrs/WDRPW411iIzuP7uXK4mF7VC2d1
         +rRA==
X-Gm-Message-State: AOAM5311AjAJ6zLi+Mj0b3xdz9SI44EHa6mns1JGSstPFndAti++OpO1
        /HVCDbsbu/wPXh+mr/3E6Yq9cKMFsG2Jeg==
X-Google-Smtp-Source: ABdhPJz3hfzrTNw2fejBJMOdGah+nllkthPKjpYoDvyQuFXAR0y61fhOdrTMyh+kUlNFGHYlyNymJw==
X-Received: by 2002:a05:620a:40e:: with SMTP id 14mr5572413qkp.200.1616509229323;
        Tue, 23 Mar 2021 07:20:29 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:28 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 3/9] convert: add get_stream_filter_ca() variant
Date:   Tue, 23 Mar 2021 11:19:30 -0300
Message-Id: <ab1bf85b75118a205cb47db29143f997a08a931e.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
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
index f2be014af8..3f39c62cac 100644
--- a/convert.c
+++ b/convert.c
@@ -1941,34 +1941,31 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
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
@@ -1976,6 +1973,15 @@ struct stream_filter *get_stream_filter(const struct index_state *istate,
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
2.30.1

