Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F1C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbjFGKlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjFGKk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:40:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951CA1712
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:40:57 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-566586b180fso79906127b3.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134456; x=1688726456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxm4wZcZ0x73i7IXJKnida+6znYDlPCjYJcCLbVAnXM=;
        b=n8mKsPtnuWfpEQEvt5+kWHE6Z4fyW3kEYCp/cA6+7iV/LtfHK9+6smeCwDcHMiJDfy
         pBp8J3WbGIGKaKZQ2v9slCy02zsuiEGDs2PSG6RCSng9rJNfYmtEIwOIsa2bL8Z2/zbO
         lM09DZ5BtMElXbeo62ltA39SXHQ+Yjy/nPW1Al9NtXyQ+iyE+s4pyBt7/YWj0vNSwyjQ
         CZOScO6MXzNpYOMQHr7gFZaqJ78sTs2i7PgEbK/QQBLKMobSV3Mx+o27e5e93+WhENQM
         0250a0Mz7AzSi7w9aLSll1trlrevhLHPkcSI9qFpfaivsWw+VeSIyTB7JswftN92MFse
         LHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134456; x=1688726456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxm4wZcZ0x73i7IXJKnida+6znYDlPCjYJcCLbVAnXM=;
        b=l9aftXOo3KGw06MLry/pDa9Wond10IHyvPXSs6QdzUxRxxZf4U9fpcJ7wsZK2J6Xk0
         pdtHV4vSUrtK2l9sNXUth+xd1wJaf+WWKldogbQNrfXOvFlc1EJW0GeL4m45cMgKnI0v
         xypUHPdTSKzPdCA8IrB+JiIFgCWlOp0UUkLQwZdqiqPy/HTfYdME+xWRqLa3SYMGI54+
         gHaYublv400gS+sI+DjIrGS7Brranjw0AqIrz8oub6MMGiW/Y1tholQjkzg8QEJj6465
         t7IlN5NeBMLijy6g007pZrfjxDMzprtviaX3jHn3UMtUEzhyWjHQWp48amPt2yYpD+N9
         knxA==
X-Gm-Message-State: AC+VfDx+ar+kKZrd6ipXx0TXCef+ONzXlglQN8HBiSaA1jBY5d6zdkjz
        SSUn6K7slsLqDc4EcKWvXEOebK0s83E4gtWTtupWj64N
X-Google-Smtp-Source: ACHHUZ7TiaWqNIjk6V9R/YMfmPRIszxTn6r9ScGzemx2aDQBtRPgaxsBqn5y12E6VV2N9B9oQlQz8A==
X-Received: by 2002:a81:6d4a:0:b0:565:798b:949e with SMTP id i71-20020a816d4a000000b00565798b949emr6437716ywc.20.1686134456634;
        Wed, 07 Jun 2023 03:40:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y184-20020a0defc1000000b0056944c0b016sm959258ywe.76.2023.06.07.03.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:40:56 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:40:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 01/16] refs.c: rename `ref_filter`
Message-ID: <afac948f04dca5cd532ceea08fbc646184336311.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
2.41.0.16.g26cd413590

