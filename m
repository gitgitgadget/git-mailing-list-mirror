Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E9A1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFZXv0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:26 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52001 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:26 -0400
Received: by mail-qt1-f201.google.com with SMTP id x1so485178qtj.18
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PLh8swemc+bh8jpE+XjDaF1VxeJH+RzuBnEXRJuK0rw=;
        b=ujf6ursYTko9XLdynGoFYESk/cW0vRPukRZQLR0vYPcRhMYN7b6Ga0gTB20kuKOpU/
         ZILKiI5u1Q/GnxBHRqAMXe5JiLo4RmrVfAl3SD3YNx4hrjtogt8ZYUiK/WB+7uJzbcAH
         A7r7FF32pnhcw43EH/+QqS0agPjaNdAjxwZIOsuwsmUnAfcdKdlja36PM3HBtaJM4VOL
         FSX8CjXfogfA5MwJWs6uqhWG/g3rdMF0qWn27UQtlz2jK52XZLj9wqLB6QsMe3JzsIBh
         ONUec40cIQt06DjFappl7ouUU39naIu4ZdnffslOp1udAcmRg0NuvqA6JnovZxCCrS0/
         EQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PLh8swemc+bh8jpE+XjDaF1VxeJH+RzuBnEXRJuK0rw=;
        b=m+55l7suugvMfUiLtlaxVZtm9tOWu6Tw2EXdfiHt0fvbTKULD/Yfc2gzR0ijD8R2tr
         oUtYw5H7+2E35FNhvi+q7xiGXczXMdHjZwlaMW8RlPZB0EGxLFaQXODnae72yd7sCWcp
         riW0YV/26h03dquhzy2dY2NA65E5JF3fiMvSowR1AcqMoaj1Q5EpZXI+fFYliK/noKHB
         haBBzae+zGzeRJlNUhKlQ5DXsmeRFuuTiigjuePWkJlsSMn+7n1oYV+JTfUADyN667Ph
         TLTCZo1E+EDxsH0CTtSVcU/vj9OwYsyvQDP5UR952g4zw1ZwymACeHxkwG6Fv+Z8EG/2
         FsUg==
X-Gm-Message-State: APjAAAWumMQWHcN2/dlmlZS4NZJJi2f4vdb4Qhw0YRrFApX8r8/Uwcw+
        pNzgjxNY5GAuJtA1dLSH87zV+SM7ffIbPOF2ymU3lVbxT2eVPqbwVUi2DFm701MQIAw2LYnNSkN
        CjA7V9skeG3vr+sCA91aMilZK4JnAewxnMZOtCSi5zML8Y2opbJboq686VM6kK1i+CPcH4y6amQ
        ==
X-Google-Smtp-Source: APXvYqxhQDgVF3wlTHTDaJUz6w+GW7p0GTVIjhSvro+cJtSHLa7CGxjCofBfs+gV4mnzmlkNPC+mPTq9gWUx/rubElw=
X-Received: by 2002:a05:620a:5a:: with SMTP id t26mr615204qkt.201.1561593085438;
 Wed, 26 Jun 2019 16:51:25 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:31 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 12/13] walken: count omitted objects
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be illuminating to see which objects were not included within a
given filter. This also demonstrates, since filter-spec "tree:1" is
used, that the 'omitted' list contains all objects which are omitted,
not just the first objects which were omitted - that is, it continues to
dereference omitted trees and commits.

This is part of a tutorial on performing revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index a744d042d8..dc59ff5009 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -45,7 +45,7 @@ static void init_walken_defaults(void)
  * mirror those settings in post_repo_init_init.
  */
 static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
-		struct rev_info *rev)
+				 struct rev_info *rev)
 {
 	/*
 	 * Optional:
@@ -145,6 +145,11 @@ static void walken_show_object(struct object *obj, const char *str, void *buf)
 static void walken_object_walk(struct rev_info *rev)
 {
 	struct list_objects_filter_options filter_options = {};
+	struct oidset omitted;
+	struct oidset_iter oit;
+	struct object_id *oid = NULL;
+	int omitted_count = 0;
+	oidset_init(&omitted, 0);
 
 	printf("walken_object_walk beginning...\n");
 
@@ -181,13 +186,19 @@ static void walken_object_walk(struct rev_info *rev)
 			walken_show_commit, walken_show_object, NULL, NULL);
 	}
 
+	/* Count the omitted objects. */
+	oidset_iter_init(&omitted, &oit);
+
+	while ((oid = oidset_iter_next(&oit)))
+		omitted_count++;
+
 	/*
 	 * This print statement is designed to be script-parseable. Script
 	 * authors will rely on the output not to change, so we will not
 	 * localize this string. It will go to stdout directly.
 	 */
-	printf("commits %d\n blobs %d\n tags %d\n trees %d\n", commit_count,
-	       blob_count, tag_count, tree_count);
+	printf("commits %d\n blobs %d\n tags %d\n trees %d omitted %d\n",
+	       commit_count, blob_count, tag_count, tree_count, omitted_count);
 }
 
 /*
-- 
2.22.0.410.gd8fdbe21b5-goog

