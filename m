Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6BEB64DB
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjFTOVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjFTOVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:06 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F6410C2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:05 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5728df0a7d9so37573947b3.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270864; x=1689862864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYg1mwSQ+hvOcdrffZ2rkTMJf9PtRpKeOH1n/IWfjsM=;
        b=fmfvuPIrOXdcIM1YDIhD5KbTVjLcj6sGYs/TFqTDceRN9VjUz8KBNny1UGR7Byky4q
         seuDDy5MV4bFXqTcALHkVPeuMtXGvfhCu2AdP7KECht8j3Nl9j2KmUKOuGxdEO7eAyst
         YpaZXNp9W7Vn+3sQlK3/V6K0CiTCaf8aqlkjw8XrRl71BjJKpkk23/gBIysiMv+M5oWw
         tNRv1dF4zK/sz8L45PkHZa7TH2eGHQRIatLjlpDi3PJ4Hi/SpqM1rZEdXAJxygyGzMl+
         M5kTQZQtwXNV9HcJY8B2URTNFn7Ek+Qw7Mx0yzh4sTqR1mSIrQwRNvyk3QiokEmNJtUv
         vJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270864; x=1689862864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYg1mwSQ+hvOcdrffZ2rkTMJf9PtRpKeOH1n/IWfjsM=;
        b=BvNKrq0XSzxzrgqxygkyBXvQDIcbunWm2KupAh+YohViu2u350jWej8unWAW7phfyB
         bTQEUv3zEqYis80Pa8n/arQZ575VUHAVu39xkFln7o0O2BxXCq3GHG9PM0fTs27Ht3tv
         Zt/yDbAMem8qeyzXGkJOmwh2JuLg0FRhkAKSR0P9QEoTD2A/tv8GbJA8RkgXrY2B7We9
         yRcqy70KASgfIlSoiFZ0uDcaDLWfvIRIt/RPpnm4JrLc2zQeR0km0Uyisl9igdhl195P
         qRn2iHIJMycXPjfBjCsNLOVIEvFnLTekmSvHdt7/XhKFfVeRjMdcu7M1jHSMJUm9nGpu
         INoA==
X-Gm-Message-State: AC+VfDwLXkLIw/f9+fwQ7m6HIoNs32B9kbm6g3h9VkTGycJ8jDfh6FAh
        vMi1zSlP7V8MemtxvHEPcu8lRs96cowqvaG0bQIDS3NP
X-Google-Smtp-Source: ACHHUZ79Bgs7vZF9SMjSb3x6eZjz6kReV8KHqpkRBeMVMedVksdbbICkGZrgdWcIEEQuMVkYcccCKQ==
X-Received: by 2002:a81:480c:0:b0:570:6667:1cfa with SMTP id v12-20020a81480c000000b0057066671cfamr12504940ywa.47.1687270864154;
        Tue, 20 Jun 2023 07:21:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v128-20020a818586000000b005704a372ce7sm499764ywf.125.2023.06.20.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:03 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 01/16] refs.c: rename `ref_filter`
Message-ID: <c12def5a30a671590835b70ee3dbd158d1eb5e61.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The refs machinery has its own implementation of a `ref_filter` (used by
`for-each-ref`), which is distinct from the `ref-filler.h` API (also
used by `for-each-ref`, among other things).

Rename the one within refs.c to more clearly indicate its purpose.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 881a0da65c..ba63b69090 100644
--- a/refs.c
+++ b/refs.c
@@ -375,8 +375,8 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 				   oid, flags);
 }
 
-/* The argument to filter_refs */
-struct ref_filter {
+/* The argument to for_each_filter_refs */
+struct for_each_ref_filter {
 	const char *pattern;
 	const char *prefix;
 	each_ref_fn *fn;
@@ -409,10 +409,11 @@ int ref_exists(const char *refname)
 	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
-static int filter_refs(const char *refname, const struct object_id *oid,
-			   int flags, void *data)
+static int for_each_filter_refs(const char *refname,
+				const struct object_id *oid,
+				int flags, void *data)
 {
-	struct ref_filter *filter = (struct ref_filter *)data;
+	struct for_each_ref_filter *filter = data;
 
 	if (wildmatch(filter->pattern, refname, 0))
 		return 0;
@@ -569,7 +570,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
-	struct ref_filter filter;
+	struct for_each_ref_filter filter;
 	int ret;
 
 	if (!prefix && !starts_with(pattern, "refs/"))
@@ -589,7 +590,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	filter.prefix = prefix;
 	filter.fn = fn;
 	filter.cb_data = cb_data;
-	ret = for_each_ref(filter_refs, &filter);
+	ret = for_each_ref(for_each_filter_refs, &filter);
 
 	strbuf_release(&real_pattern);
 	return ret;
-- 
2.41.0.44.gf2359540d2

