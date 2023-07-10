Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A4EB64DC
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGJVMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGJVMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:08 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F23DCE
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57a551ce7e9so56119897b3.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023526; x=1691615526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqHIkzCAZCvGA5l56boxPOHKvA3YoAZGs8rTZ0txMjI=;
        b=LotRoI2NU23Kd04KjKiEamyvHmqKR3mfebVN3BNJ4sme/t5zluM8bPywrOj/mkCrDL
         7enPeINmAszV9nI+z4LfKIfhl5//O4e5iR+hfVElO4J2+ytcZwB/rqPcG8T0fhe7kR0U
         alhZOfn3EERQCIOjrFJGIR03aKQlvfeahopPp3A2jukQsuH9//dBtj035FJZG+TdIdHX
         UEc8xYZdFqm3qov/shrJYAhKaLMvzJRmXItF8zdmEwYvNP6RtnzWapEQCltVX23qlTDy
         DuxBGda+8wxIeD65AhpnNrnHngTnhgWuDEZFO9fPoz+wjve8CCs5NoEoWQPKOB79XqkF
         A3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023526; x=1691615526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqHIkzCAZCvGA5l56boxPOHKvA3YoAZGs8rTZ0txMjI=;
        b=RN7Fto2WAGbJyWke6zYZd1Wc5GMI1Ih2GXckd3TqJHK+HKGQOBSwpxu6jEWnUqLq2z
         yNK8dLX4q6wvH+o2BQCdPQKxo5MB3xucBMDJ8DFBXQTBkR8v5cm72WqTwFcWQJX30nA/
         Dnza/CVCIrQ9sZw78dY+YRHDOTpXorBwS5UwA+ylMmYasl34cCEWQX8sSM5oOLlII1vQ
         fFaQ/PTLicmmrqiB8BM5EgekuWIIeYE9jqUQ9HOkONkxqgFeBRUecHHMw97JCn46O072
         3P5Qn1N4oAJi99H5GHb/4+ZkvODG3VROUFDZxwJs0qgEogjuOLztzy2i1LvH2NnAHk9l
         f5BA==
X-Gm-Message-State: ABy/qLZcd8aceD3QVkc5/Eo9fZSWfE+t+cg3xMvVBki2lYtz132UwBtC
        goxNNLOq77zaeDmpWL6RVd2k3MZ4xVHTiE5uE3Yy2A==
X-Google-Smtp-Source: APBJJlEtRYa4e/tb7ryOPX0OAn80fiKQLzLQMiUrMpoo1AhoLCq/3LBzOZPuVlNtGHzbTZt6etKOKw==
X-Received: by 2002:a81:4642:0:b0:561:d1b0:3f7e with SMTP id t63-20020a814642000000b00561d1b03f7emr12684924ywa.44.1689023526216;
        Mon, 10 Jul 2023 14:12:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v145-20020a814897000000b0057a8de72338sm184496ywa.68.2023.07.10.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:05 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 01/16] refs.c: rename `ref_filter`
Message-ID: <5b5ccc40d6b87f0011fc1a88b99a7dda03b36886.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The refs machinery has its own implementation of a `ref_filter` (used by
`for-each-ref`), which is distinct from the `ref-filter.h` API (also
used by `for-each-ref`, among other things).

Rename the one within refs.c to more clearly indicate its purpose.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index c029f64982f..876df4931f6 100644
--- a/refs.c
+++ b/refs.c
@@ -377,8 +377,8 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 				   oid, flags);
 }
 
-/* The argument to filter_refs */
-struct ref_filter {
+/* The argument to for_each_filter_refs */
+struct for_each_ref_filter {
 	const char *pattern;
 	const char *prefix;
 	each_ref_fn *fn;
@@ -411,10 +411,11 @@ int ref_exists(const char *refname)
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
@@ -571,7 +572,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
-	struct ref_filter filter;
+	struct for_each_ref_filter filter;
 	int ret;
 
 	if (!prefix && !starts_with(pattern, "refs/"))
@@ -591,7 +592,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	filter.prefix = prefix;
 	filter.fn = fn;
 	filter.cb_data = cb_data;
-	ret = for_each_ref(filter_refs, &filter);
+	ret = for_each_ref(for_each_filter_refs, &filter);
 
 	strbuf_release(&real_pattern);
 	return ret;
-- 
2.41.0.343.gdff068c469f

