Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C952AC433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7EB52071A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TCrBKwKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgGWBtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBtC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:02 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E574C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z15so3975496qki.10
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJrFU+75QPJCoYigEyOKR4oxa0fQ98NHJ7TU05rAv8E=;
        b=TCrBKwKemG35vAzpMGn965tpORxTwgvZr8ogX+ggxEntFkPc5UVPScOYARRyViIUTn
         A7+zIkOMmnw5byGRq4m3dAcNYTiomx6TeEfm6j1ucWjZgfLYvodswbbUO7k+UbLDuvMM
         +gRerCEngVBwoAxYbazo8oR9mAe6pMi6sm6tlSO7dBM9xbQk0GZRJk2wNQRlbC2ySHhd
         V1NS9Kar7NEy6FzHCjgGEFbQ9PolT2hhS3CNEZ/GioBHdZotMrc64nffEYO0NsdpDU2f
         edlldPb9gjpfIl9O/Be+0Xewjm3MoxDTUQvZ1mmgF18H0+tWJ9rpU1A/kAWcfTp5PHiC
         jz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJrFU+75QPJCoYigEyOKR4oxa0fQ98NHJ7TU05rAv8E=;
        b=kRH2jw7nD52LJ4XH6sNlZYzjQIz3IqTkqU60c46TMKuKIzSxBvf8sZhUhbLW3k71Ha
         HCfXPnfmdeAvbSzF85384o9FdC9oBJUu7xOFgc+xM06bG/WBoJOS2qdcJU/wORzcMfBg
         sawN1tjbAESkxHx0YsrHwR2EA4bC3qUawYn+akBgUUBsqcbISOSbBIZUBWkT/s2mhhnx
         WOB8hHFCZd2E7WGmMwju/VXrEuwf7UM7kJ3GUJHANVAQXOJ7Xv9ei3Mcg5GAqLa+aort
         f8uvp+ehUKTJTCKIN3lB59fsaT4zTRfHTR/fSNxtjaNtWzmwOC+FAqkim8foTH8zGORv
         9wNg==
X-Gm-Message-State: AOAM533zRqJFix8Ci8J9RwpFKGk3Fu4GD+fMT2oOAPNBpc2/eYSegXsU
        fPmtmSGo7nrrEnhldwW70vHHvocwXyuJoQ==
X-Google-Smtp-Source: ABdhPJxg/XhC8VWDNAAVjAXP26rzAXI6ryovuujZvCnQCFSCMDLBn/1xtrwWkubv+ib/xihHR8aG/Q==
X-Received: by 2002:a37:48c7:: with SMTP id v190mr2857088qka.153.1595468941078;
        Wed, 22 Jul 2020 18:49:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id t127sm1379762qkc.100.2020.07.22.18.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 18:49:00 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:48:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v2 1/4] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <69605299bb38a678338365cf05178ce0735c7c67.1595468659.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1595468657.git.me@ttaylorr.com>
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

