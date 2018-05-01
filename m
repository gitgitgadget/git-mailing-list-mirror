Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE8D215F4
	for <e@80x24.org>; Tue,  1 May 2018 16:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755979AbeEAQ7p (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 12:59:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33252 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755276AbeEAQ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 12:59:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id f20so717685pfn.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7mM4nPu9GILWJaPsrDbGxWHJSbFw8tHD0afeX6VpRAM=;
        b=yfTVqPm/VjAl2HOYrutsk5YU9HDoAR53o9U7wrVFJZ1LzYE+xIeE5xgUghXnTwKpDV
         xgc64KbNoGyGLrAgJH25k02aUuwP1DvmkKDx36Tm6bOzI+5e5XZSGoqpq4v4GX0YjLeu
         97ySVES1G66DY6S4+RZYj8pzDQuxQJmS/9BGd+ZTJv7zaSV7eQpHZ/wC5FsnkKKtkO2b
         uk6An+Hek0j0otAshlKb3sLYItx0Vb1ycWaBCIMjO7ltmY0lUInEFzP0+XffSivQln0J
         YKOyvIXL6NANc4UDhZP+95QKGaT9CSDR2HUgiAwBAU6G+ubZjIJXaJ+2mhrKyJY0CO81
         IQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7mM4nPu9GILWJaPsrDbGxWHJSbFw8tHD0afeX6VpRAM=;
        b=Hc071uzebp5FRsiCice/OxeE22mrMAJQUcwEGV/3lPGfK65kbip4DZnTsyTW+Y8/rj
         cUmt5+QeMKn/1dNEJd+FUXzEN/BTt/T243/KKqzT138ppH8XOkCxWqibssCt5O3412cS
         Hc+SFFT1IEVOrtiGRai9N8IsPsJLLNUwatvazERjsztlng6ejdzZpUrl0ehxCo10+t+2
         iyszOt4eq80VqP7iVt0AmgHgxuWXTzM5YEFcAYziKdWjiFGCCnFOXknayH7XWOayXIMf
         EKN4iCJLe6siCNsm6KciGBn14agff9kUEiZEnM6t0DvlkxsMI7ScTeREfZGhlG5+k684
         eczA==
X-Gm-Message-State: ALQs6tBgCcAWgZEcrGt6LI5vetFqJTl030SmXEtqpvzSwpRG1eEF/5rf
        7KtpQV34BYdclaFmTRIfRrlVNyUr9fk=
X-Google-Smtp-Source: AB8JxZpDtf9TWRtL2C/mtfkWbCznpxBPg6Yn3tnNrtvB5a+3x5Z/9LbqRbPUgnGM4digbDFFzgtYkQ==
X-Received: by 10.98.150.92 with SMTP id c89mr16422186pfe.37.1525193981274;
        Tue, 01 May 2018 09:59:41 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:6e43::93dc])
        by smtp.gmail.com with ESMTPSA id r81sm22313311pfj.79.2018.05.01.09.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 09:59:39 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com
Subject: [RFC PATCH v4 2/3] Teach tag to list remote-tags
Date:   Tue,  1 May 2018 09:59:30 -0700
Message-Id: <20180501165931.25515-3-wink@saville.com>
X-Mailer: git-send-email 2.17.0.393.g4573f5e134
In-Reply-To: <20180501165931.25515-1-wink@saville.com>
References: <20180501165931.25515-1-wink@saville.com>
In-Reply-To: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add FILTER_REFS_REMOTE_TAGS to allow tags to be to identified as a
remote-tags and then list them without displaying refs/remote-tags.

Signed-off-by: Wink Saville <wink@saville.com>
---
 builtin/tag.c |  2 +-
 ref-filter.c  |  9 +++++++--
 ref-filter.h  | 11 ++++++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 46a5c6a1da..9ac85f0ff8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -57,7 +57,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
-	filter_refs(&array, filter, FILTER_REFS_TAGS);
+	filter_refs(&array, filter, (FILTER_REFS_TAGS | FILTER_REFS_REMOTE_TAGS));
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
diff --git a/ref-filter.c b/ref-filter.c
index ac82f9f21e..1fcaa2ea33 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1682,6 +1682,7 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
 	 * for matching refs of tags and branches.
 	 */
 	(void)(skip_prefix(refname, "refs/tags/", &refname) ||
+	       skip_prefix(refname, "refs/remote-tags/", &refname) ||
 	       skip_prefix(refname, "refs/heads/", &refname) ||
 	       skip_prefix(refname, "refs/remotes/", &refname) ||
 	       skip_prefix(refname, "refs/", &refname));
@@ -1866,7 +1867,8 @@ static int ref_kind_from_refname(const char *refname)
 	} ref_kind[] = {
 		{ "refs/heads/" , FILTER_REFS_BRANCHES },
 		{ "refs/remotes/" , FILTER_REFS_REMOTES },
-		{ "refs/tags/", FILTER_REFS_TAGS}
+		{ "refs/tags/", FILTER_REFS_TAGS},
+		{ "refs/remote-tags/", FILTER_REFS_REMOTE_TAGS}
 	};
 
 	if (!strcmp(refname, "HEAD"))
@@ -1884,7 +1886,8 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	if (filter->kind == FILTER_REFS_BRANCHES ||
 	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
+	    filter->kind == FILTER_REFS_TAGS ||
+	    filter->kind == FILTER_REFS_REMOTE_TAGS)
 		return filter->kind;
 	return ref_kind_from_refname(refname);
 }
@@ -2053,6 +2056,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_REMOTE_TAGS)
+			ret = for_each_fullref_in("refs/remote-tags/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind & FILTER_REFS_ALL)
 			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, broken);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
diff --git a/ref-filter.h b/ref-filter.h
index 76cf87cb6c..8b8d725b37 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,12 +15,13 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x0001
 #define FILTER_REFS_TAGS           0x0002
-#define FILTER_REFS_BRANCHES       0x0004
-#define FILTER_REFS_REMOTES        0x0008
-#define FILTER_REFS_OTHERS         0x0010
+#define FILTER_REFS_REMOTE_TAGS    0x0004
+#define FILTER_REFS_BRANCHES       0x0008
+#define FILTER_REFS_REMOTES        0x0010
+#define FILTER_REFS_OTHERS         0x0020
 #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
-				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
-#define FILTER_REFS_DETACHED_HEAD  0x0020
+				    FILTER_REFS_REMOTES | FILTER_REFS_REMOTE_TAGS | FILTER_REFS_OTHERS)
+#define FILTER_REFS_DETACHED_HEAD  0x0040
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
-- 
2.17.0.393.g4573f5e134

