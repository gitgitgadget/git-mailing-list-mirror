Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBEC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F1B2087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="csvfID7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgGaU0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:26:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B482C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so23187553qkb.8
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJrFU+75QPJCoYigEyOKR4oxa0fQ98NHJ7TU05rAv8E=;
        b=csvfID7YFSoANJcxeuMijGx1tw6c4kOjLaYxU5Fp61ZphCilLcwT9LoMQSL141B8/E
         hsiL9w8m0u38dSi9sBg8DibvYAqYE68Kpv+Sdw/CzwVNByVwm+f5dnZEKWLgpdxgJ4vv
         tUpsv/Eas3lvo53fHex8DZx90Dd3X1uaXOTrqbGNepJvUJYmkXGzbFVwCuLXD9e6+Wk4
         NVh9ohRJj+/5DdL0ZvHLSEMSp7wvLLTQ6y8jX/m4zIJf45QWsVHMe6rEyl7aJ6SIVZ0E
         5vQSOsM/V4MPQUg42ZhOuoKReaAN7+GZSIGeF2LaCLHKZ1V4EpjwPjlaqC80esRDkLeI
         dbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJrFU+75QPJCoYigEyOKR4oxa0fQ98NHJ7TU05rAv8E=;
        b=fanffB5vm2Rr/qrroePMtJ/jEizDb7dzbejJhaAn8eG78TaxUXTKkIHrOmE1ET1WCs
         JeMPoSwkK2GS2yzh5UoVSfdQecFe+gABpZbYMwn/2j3sqK+VoJ/bB8Epwka24YiFJddx
         JUw9sa2PUn2myFTde+9HuQT8Frlv2b3QavmWPTZ+p9WGHFQQFo3l2VhxD6Suxfa6hhTx
         63t7mPJ7I3tTNbJhxfhMIylzvgvDAp93slN3/M26p5Fm2ixMvmI4KHeHaprqo7wsz3E7
         sg4gQxZDb0C7z4WstLZeEFoMJUW4RVHlQbIGfoJvqynNSYqICv1NFL6EDtSYOHRnzn+O
         MLDA==
X-Gm-Message-State: AOAM530eN6E5RHCxR3Jhq7Ez6LBfoVJ9hHhbf1nhQt3fz/AfQq8yzWT9
        bL055z+tCCRpfScVRAU5qKBUtm9ZhGapXA==
X-Google-Smtp-Source: ABdhPJydTs3/6HFQ4pUN8iw3LsAe95utQMQmNnvH4u4FAGQImHKyXXqfFGQFWbTSNFwKL6FszfXzQA==
X-Received: by 2002:a37:d201:: with SMTP id f1mr5771946qkj.188.1596227189014;
        Fri, 31 Jul 2020 13:26:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id d143sm9612151qkc.59.2020.07.31.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:26:28 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:26:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 1/4] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <b1b3dd7de985dd12911ba2086048623097e96e3d.1596227003.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596227003.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we will add configuration options that are
specific to each kind of object filter, in which case it is handy to
have a function that translates between 'enum
list_objects_filter_choice' and an appropriate configuration-friendly
string.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects-filter-options.c | 23 +++++++++++++++++++++++
 list-objects-filter-options.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 3553ad7b0a..92b408c0c8 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -15,6 +15,29 @@ static int parse_combine_filter(
 	const char *arg,
 	struct strbuf *errbuf);
 
+const char *list_object_filter_config_name(enum list_objects_filter_choice c)
+{
+	switch (c) {
+	case LOFC_DISABLED:
+		/* we have no name for "no filter at all" */
+		break;
+	case LOFC_BLOB_NONE:
+		return "blob:none";
+	case LOFC_BLOB_LIMIT:
+		return "blob:limit";
+	case LOFC_TREE_DEPTH:
+		return "tree";
+	case LOFC_SPARSE_OID:
+		return "sparse:oid";
+	case LOFC_COMBINE:
+		return "combine";
+	case LOFC__COUNT:
+		/* not a real filter type; just the count of all filters */
+		break;
+	}
+	BUG("list_object_filter_choice_name: invalid argument '%d'", c);
+}
+
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 73fffa4ad7..01767c3c96 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -17,6 +17,12 @@ enum list_objects_filter_choice {
 	LOFC__COUNT /* must be last */
 };
 
+/*
+ * Returns a configuration key suitable for describing the given object filter,
+ * e.g.: "blob:none", "combine", etc.
+ */
+const char *list_object_filter_config_name(enum list_objects_filter_choice c);
+
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
-- 
2.28.0.rc1.13.ge78abce653

