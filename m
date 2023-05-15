Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E8C7EE25
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbjEOTXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbjEOTXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:18 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C2A15244
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:13 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a79671a4dso194820687b3.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178592; x=1686770592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVc/88wfQhiMMJ+DSmT8cvyXoa0RTgflr/uznf2LK2c=;
        b=sypgIjiPvLscnm2ZU3noJspc9z2VcDMwY6Qmu4cWIM1rwx7nFcF2rbnv4Wh5wqOmJ6
         j5M278FbOf4+YJpFARO53pdIWTGQxAvTxH2ha7/XVJyxm/OvMwtXfnpVHiLf9HZCXBJr
         xXmvTHcNYpIpqXo/52UwO/ZmFF4zmL6itgOKuBsTSWZOQxU3oYaSnABhKrEA+909ytBA
         YcdSSzvDQWnwNb2GR3QgBqxIqR2oQ3rPg2O14omESbGkMDz/Zr7wVMVtA5Mw1O5FawNI
         gZgP4jChJL9NL0Ww/HRT1l2D5knhuFE97kfUekUjgO3mCjUCH0lHXOPYSwkMNc5H+PzJ
         LhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178592; x=1686770592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVc/88wfQhiMMJ+DSmT8cvyXoa0RTgflr/uznf2LK2c=;
        b=QtHN8y8emX1tgrSl6uh/hiDteChUsThJtDQQD1xVvDcJIv/i3wqD1CM/c+NpmBQ6/Q
         j1LrR0tIj40b9YUe1OYQwW6UdOxSr6xh7MPc8XZe3r0HbfqMc+zq2f4G2w7BhCRNg9JG
         YMI2LI6a4mBX0BMVST8P5emBF5KvAQN55m2/Vgib+8UeEcUdsAad/2FmRgQu+NxKcnDz
         36kq9bZysedIES9zhpdFZUryLy/t0KIT6NVuJrDUlbKM0sM+GezgxjAizIvntaA6ow58
         uUWBn9SfK0Jb6S1YPVhuBPmal9PKCJdYi30WqogCWB6T+DSQaU1q8QNMlElZu8VIRhkv
         LSLg==
X-Gm-Message-State: AC+VfDyxqE9jC+4vFNuoZJkyEXH3wts2wkZO2fqzIjDiVGfGVLvK7s4l
        gs98Li4c+/1QUI52RMslHGMUkCoegE5xaQNHUg9fEQ==
X-Google-Smtp-Source: ACHHUZ6Lxklz0M4k6xUw+G5dNu1bT3A0CA8C+FXfzm2zx9aBbN2JrCFmYagV/ZZsq1oy2GmcF707Tg==
X-Received: by 2002:a0d:c641:0:b0:54f:23a:4c64 with SMTP id i62-20020a0dc641000000b0054f023a4c64mr32744630ywd.2.1684178592140;
        Mon, 15 May 2023 12:23:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n12-20020a819c4c000000b00556d4aac066sm6744ywa.133.2023.05.15.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:11 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 01/16] refs.c: rename `ref_filter`
Message-ID: <6cac42e70e9c1901761bd3068a9e22e60fe4deae.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
2.40.1.572.g5c4ab523ef

