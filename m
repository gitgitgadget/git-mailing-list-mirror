Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA70CC1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A3D20752
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 20:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MVCIKrXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCQUjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:39:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38432 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQUjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 16:39:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so12367207pgh.5
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EhAQon/8KnanJMc2Pp8cqSIahARuk8u7i7Uiygqt3RY=;
        b=MVCIKrXH9RDBeex9aI3P5DYRfL0rJMSAo3dhlc6xMnLmInnWf9YP77q3stm/44E1EU
         DsGwp8xUdJrH5uei0tdduP2Eu921vKxdbRNTyJMmyHm8jmE0e8s8MEXTIHexiRr7J9Xh
         hTxYGEVTdoDVZfM3ExSIdKrJC5apr/uWtQ9/+501UYtqFdg77s8vMb5OpF/BA1CrCjCo
         UOv7sKKGTgA6wFICGaj3+/GTz5q63jWOiZ+fNc38Z1GncMTOJ8FoXN+23Z5n3RQa1ipF
         dHMzH42S+MG6HhtmNoFYMuAhYRjvJQ2hqja1KGmCHv976EyWxpxjbSuHd53TDf8axf0+
         0I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EhAQon/8KnanJMc2Pp8cqSIahARuk8u7i7Uiygqt3RY=;
        b=DpvMWJP/yy7gGWSh6s1vKS68U0tema6/izZYzp5cw+O+xCyNHGzMYDzng27Q9e6ah/
         NMt6BiLGe90iD2UvBtVW4dYRORD+fUJUk+5ksYFIyDuDBZTH8AFe7qbG1lzTZooO/ile
         kwHaGhkCVwM0xjSvAZNUGCQ39kKF/s2vs731IaXoIM8r4I806pdawCNHshzt14JZ4BK6
         +ktfvCqR/owa4sHHxcvyoS5dUs0xRUrPsE/YmBfJZW+AEVcm6SjajckEnI9GOe2kYE3/
         RhT6lGQq9U7PbVIo/WzVqOP1Jq/TBKbjy9kzjxjLu3uf/A3mmgPDaULX8e24i0c4diVY
         f8Fw==
X-Gm-Message-State: ANhLgQ0tvbFoO+aFH8GvHMujfkAWVlb2yucZUvvEUd7KlqVPVKir6OuB
        aY9aXjr+Oy9/sBkV/wLrq750zEPemY0=
X-Google-Smtp-Source: ADFU+vuoIWRMZu2KGqBghYWS9npfH9yxn2jzoM4XBoQ1AcMXxOZWVFcml9Sq7bahJEqw8wMwgh0QJQ==
X-Received: by 2002:a62:15d3:: with SMTP id 202mr606821pfv.231.1584477550361;
        Tue, 17 Mar 2020 13:39:10 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k189sm3582816pgc.24.2020.03.17.13.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:39:10 -0700 (PDT)
Date:   Tue, 17 Mar 2020 14:39:09 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, james@jramsay.com.au
Subject: [RFC PATCH 1/2] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1584477196.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we will add configuration options that are
specific to each kind of object filter, in which case it is handy to
have a function that translates between 'enum
list_objects_filter_choice' and an appropriate configuration-friendly
string.
---
 list-objects-filter-options.c | 25 +++++++++++++++++++++++++
 list-objects-filter-options.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 256bcfbdfe..6b6aa0b3ec 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -15,6 +15,31 @@ static int parse_combine_filter(
 	const char *arg,
 	struct strbuf *errbuf);
 
+const char *list_object_filter_config_name(enum list_objects_filter_choice c)
+{
+	switch (c) {
+	case LOFC_BLOB_NONE:
+		return "blob:none";
+	case LOFC_BLOB_LIMIT:
+		return "blob:limit";
+	case LOFC_TREE_DEPTH:
+		return "tree:depth";
+	case LOFC_SPARSE_OID:
+		return "sparse:oid";
+	case LOFC_COMBINE:
+		return "combine";
+	case LOFC_DISABLED:
+	case LOFC__COUNT:
+		/*
+		 * Include these to catch all enumerated values, but
+		 * break to treat them as a bug. Any new values of this
+		 * enum will cause a compiler error, as desired.
+		 */
+		break;
+	}
+	BUG("list_object_filter_choice_name: invalid argument '%d'", c);
+}
+
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 2ffb39222c..e5259e4ac6 100644
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
2.26.0.rc2.2.g888d9484cf

