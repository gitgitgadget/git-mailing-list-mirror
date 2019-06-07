Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271381F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfFGBJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53343 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id b24so312724plz.20
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DO6cP6nO+DkGhzWNGsy8vE5XwUrW039IjR1o5onjLDI=;
        b=Z4MIuzbk0s1KiZVZ5s2bSvZ1+F99vKczI6pcUPCrWbJIpC18rgSp0wyhiEkwKkbyFE
         aNDnn16VGuLWPZU1xQzPaW3B/C3wuhhMkrB2tiW9KGqkebHbJq+nAz77C50nLx3Q/zmj
         iGBXRO8sReTeQW8CjG6YkmaBkfM335NxWb3pOTyJJ9vA9hszsjO+jdNAOSIAdeayfLdH
         9mLlAX5yViw6gdtx6mRlb3zu0eAfCH00cMoMhIrvWzUdOP0xb+xwmFPgZwt8pK+B80OL
         8oOd2T1B1UvZ3+nThcowYBprAp/XcJ6HRhpgh61Xq5LcDNbblH6qhOwucMM7lgVl0HIU
         3OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DO6cP6nO+DkGhzWNGsy8vE5XwUrW039IjR1o5onjLDI=;
        b=NVkkBmcn3OUHeWc1ZBfhYXzWur9VvmVl1vnKxU19IhFATjHhEmc2o+NzjbogBzWfE5
         zCbnwGUPgdqzsRIRFrOKKPgOa67nl8se7N9f4tINEyrxeDhtCK2eCqptRL12IKrN2wDh
         T4SCrjl9khc2W60WMXb2Oo9JkizXIcdRLenN2ibx6e8oifHlnmJrTOMyH+D/PCCNf7Zh
         MWjySVfRGZuKSTpZAdPeYb8nP8cUN8liApDSMT1aLN/QrOmM2JRyJM7gRmlXMzh01lO3
         ZOsjsfjmhrZAyDJ4F0+4jUZLvIrLSqwDEDakrdmfeOLpSa+DN/A6PJuIxvZYR+9ffsWj
         lshA==
X-Gm-Message-State: APjAAAXnPPtLl0RrL5b8MkLTll4u9+UqQ/e/7j/0B2qsPnk72vCkPFff
        NIC3vmudDkDhAKLLyIWDd2KyTo/aC5dev1M8P7+6f8JHhUzUC4tm3FY8cFbiDGV2KvUSQSk9PM4
        eyjtL6Q+tFi/OKUO2gO+FwCKSr2mRSfgGqONPItpTjWrZHdNBwky/eePhluepRIgNp9v1A9smCQ
        ==
X-Google-Smtp-Source: APXvYqxrkjD8oqJqNRygw6hKtXoHj6ZcUNBpeC/BFGm091Q2q+z8Z0Fs8lOqCJlOX8KAxXGzwaPAEzBeyf9ndQDnVko=
X-Received: by 2002:a65:5ccb:: with SMTP id b11mr572539pgt.172.1559869761848;
 Thu, 06 Jun 2019 18:09:21 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:09 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 11/13] walken: add filtered object walk
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate how filter specs can be used when performing a revision walk
of all object types. In this case, tree depth is used. Contributors who
are following the revision walking tutorial will be encouraged to run
the revision walk with and without the filter in order to compare the
number of objects seen in each case.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 408af6c841..f2c98bcd6b 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -13,6 +13,7 @@
 #include "pretty.h"
 #include "line-log.h"
 #include "list-objects.h"
+#include "list-objects-filter-options.h"
 #include "grep.h"
 
 static const char * const walken_usage[] = {
@@ -154,7 +155,22 @@ static int walken_object_walk(struct rev_info *rev)
 	blob_count = 0;
 	tree_count = 0;
 
-	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
+	if (1) {
+		/* Unfiltered: */
+		printf(_("Unfiltered object walk.\n"));
+		traverse_commit_list(rev, walken_show_commit,
+				walken_show_object, NULL);
+	} else {
+		printf(_("Filtered object walk with filterspec 'tree:1'.\n"));
+		/*
+		 * We can parse a tree depth of 1 to demonstrate the kind of
+		 * filtering that could occur eg during shallow cloning.
+		 */
+		parse_list_objects_filter(&filter_options, "tree:1");
+
+		traverse_commit_list_filtered(&filter_options, rev,
+			walken_show_commit, walken_show_object, NULL, &omitted);
+	}
 
 	printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
 	       "and %d trees.\n"), commit_count, blob_count, tag_count,
-- 
2.22.0.rc1.311.g5d7573a151-goog

