Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1511C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjEHV75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjEHV7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:59:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244BA114
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:59:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so27434160276.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583184; x=1686175184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVGVfIy9Ojd38BYwc+JC4zC+NIIpENkuSEPRcWWSKuY=;
        b=RXXICgOgrxisOY4hSz8OIQf9Yzg+pk0SXuRRSleWmKEqmJKTa5u3/gY0Fw9fjl0Hof
         U4h3LPQtRmbJH4Dsd+1M/xA433y7FDhOVinGFWOyGY+Q9ABO8daaNShFXrFJkG8FzWXX
         xrZOBN+H6SrFyrZfoKFyS2d3ZqE0vfNnFup7GEgq0JS0zfxEOmS2mBgxQH5DAbOHgV8F
         YQH9D9GlVq8eJ1ACmIr5khl7an45nIS21h3kipozAwS2sCPul/ZDNFirL21yOjID7kfA
         +tlj/T5loItxBEIxc3mw5AaN8xjIYiR/L/H7pPtkyU9rD0HZC9wtoQBlywtslwQGwn6a
         dhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583184; x=1686175184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVGVfIy9Ojd38BYwc+JC4zC+NIIpENkuSEPRcWWSKuY=;
        b=BAQFuAx18nsZnADKoUY2GT5xTZ++3Q8H/pNJa1LCSRoD5Kt+Rr27WFDjjU7T+OMeEW
         EgSlRwWJyN6WUHZQm2nF8m9qbKAuitqGC89FKYHk9It/d9R0344L006Ag3VH+An3k68S
         NPwRXRSQJ/0OfQnyF3px9mZo5CkuIY3Uy/YtCUOO6+TxCyHzAAin3+O+3naihUhv2MNm
         q0+c0oqbV9fmsts6hYcgiovCDDfa0iDP5LJfQGiiqjhD41zNgL95XnPXXR2Kw84+00CK
         Hy4NkZbfQfhG5Xa6SDF8MeXw1MAvRT+FEXlofgNDfySQv7zuHI79p73hmNQUVM05bHxF
         KpnQ==
X-Gm-Message-State: AC+VfDyIGuSyTOVKBOUMZfvJ46n32GVi41OKPXLHRordXWTheez1/HCh
        1bmGScIJP6etIZNs6LseixJS1+msPVFUX5FenMWnxQ==
X-Google-Smtp-Source: ACHHUZ5n0DNHOQTEugIEuAvcjmZLZuXb8oocO1HFGKMYBA/4JL8C+06BkGwK8Hico8tuGzL74Qrj8w==
X-Received: by 2002:a81:12d8:0:b0:55a:89a2:e99c with SMTP id 207-20020a8112d8000000b0055a89a2e99cmr13666612yws.3.1683583184210;
        Mon, 08 May 2023 14:59:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n1-20020a0dcb01000000b0055a503ca1e8sm2777243ywd.109.2023.05.08.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:43 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/15] refs.c: rename `ref_filter`
Message-ID: <2225f799410687ae72f6f64daaf93809e7c9b380.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
index d2a98e1c21..b9b77d2eff 100644
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
2.40.1.477.g956c797dfc

