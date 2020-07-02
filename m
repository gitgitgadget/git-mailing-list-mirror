Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E1C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122932088E
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tI3J6WEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgGBUGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBUGY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 16:06:24 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30274C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 13:06:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so13316242qvn.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VHjQQvjLvnTP6bgCUi8/1pjYXinQAj7ArgIl/GxoQbs=;
        b=tI3J6WEFN2uMip5pCVGeJaXurs0fHLFX0bCXkCn2fFaHPzsMq+3sZBNa9F0Ug28deK
         ojY+JuGWspuFn4Eo8hj+LoAWC5IuWK1rpMhZLmzME0Rjb+lWY46T7dqEN9p2gGZe5hEf
         n+ifllRooFXmCiQVlI7El+xJJvINRliTqiBJ+uRRhZgI7oB12wliA52Ha0MMgr06Z22W
         nvHTio+UTEshJ0EDeoRU75Q4E/5NKzWL3cZ8ZPQQJ4LHCZW4wz+6nwdVvUXM4zLzZRCL
         tHHBCfPZWDkBAfzTAyzmV1YNA20yzFFEklHLjLmn+KukbP4rMDKtRjmmwFBBRzGoZ3Ij
         23Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHjQQvjLvnTP6bgCUi8/1pjYXinQAj7ArgIl/GxoQbs=;
        b=DzULYU9BP9Pf6fqf7fppN3MpzM6YGh3RQsCP5IeEhfqXJy4TMXHUmB5jB6S11JBd+9
         EOG9J6l1pKeg+WAi3p5vAoJ/EqV4pmg4N7dH/etUQbiY5p5HaaUuSH6LHXoxGdNZwNWi
         yLljZcaHe4NRTgbvUT+ZE8fZ2mM8RZ2KTGwP2pfIyl7etjuWi4ABCPUf0qDbGDgcS7hb
         +y/NncPtjLFnSgWu/3DgXWVxMn910wsDNdrqP0/u1jAbCSCMSYOzpjDa4vSqFP0xLW8o
         gIibBNdCmIx1OTs7WuiVhPcLcvqlWOJ56KSkgM+CTDE9AlO+gsy5Ud/16Oukl7mJ2yhL
         wjFw==
X-Gm-Message-State: AOAM531AypNrZytk1e8B7oIVsB80szZUsKdprSlUNJqfcuaD3z6x6C4c
        khCeAW0g659BB82x+EyJSrr28A9ccAibOA==
X-Google-Smtp-Source: ABdhPJyFTcXiyVwN9eX2LoLUvPVuxT/mf2ttyJoBo7Mhp/QAJjD28WV1GY6GaPI1oAfo6olYmZd1Lw==
X-Received: by 2002:a0c:e554:: with SMTP id n20mr31534442qvm.14.1593720382898;
        Thu, 02 Jul 2020 13:06:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:650d:8c1a:48a0:61b2])
        by smtp.gmail.com with ESMTPSA id q28sm9962548qtk.13.2020.07.02.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:06:22 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:06:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 1/4] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <738d97be4645435c333111a06560926a701a5bea.1593720075.git.me@ttaylorr.com>
References: <cover.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593720075.git.me@ttaylorr.com>
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
2.27.0.225.g9fa765a71d

