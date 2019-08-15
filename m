Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81371F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfHOVlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32799 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbfHOVlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so1256538plb.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9N0leVUQsbK90SpghEb8bVJeSw74Qso3JoepuQFdlQ=;
        b=hpUnpwS7dP1q2eCrsDDi4TrVeNQk5eAVX2Mas6vp+88GJW46rJVPt/x1t9wIW9/FVq
         W0igm59ioIBXDPw9QHi7cCJ0UBu+oGxdggtIUHOzoVmTrX9AKH4RBmK4kGPbKj22mso0
         AUxFeV/Cqcz3iwJEKR0QLkpEWtv5278JPoFGbFnt6iX2rvi6rCQIutw5sOrFDSOP50D9
         DbEHJbYpn3laioRmpTR/yZaSWJywwEfn3xuo3A0TE10gGK7j0rKRpeRF+iiJt5Fn7rnk
         I0n8ijib4zLuk+LbKcVwB6iL6RPMjZ0J3Vvhgu428TNrgGFes9K0eK3NeAuodoJdf9BY
         b2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9N0leVUQsbK90SpghEb8bVJeSw74Qso3JoepuQFdlQ=;
        b=tnegFHre+J2bVxTNd6zFiDnt0d+EbSQ7Au3e8W4GEHC8B9mDUj6jj0uH4ZmfboonyI
         4Nl8lEIFqc3WMQ5ZxGsWnhXdyij5uqqKuGjpWMWKxSqgTpY5M/U+1LhgfqWx43sA6TZZ
         56Avw4YI9YrEL9lN+Uv0tM9q1V4WEgY2QMc9qUBafv9zubWRk+aV+WHDzfCsmfWFn10Y
         pGwDKpCtfw2/Y+ODSEPWzyoKIe4xFwrf7YbjrW2qbR8VABP8+hny0/wWIk+qDHIIiOoI
         70O7P3gECklKprwV07Cg1BSfQeWSf3pTKSDhRVEQQxZmEvvT23F8YNBQEqxBxdD4oPCo
         NLqg==
X-Gm-Message-State: APjAAAW2NPsVnjGDkhFgJ5Sq6Mkl4MCmJxSaoFQMdtKNPZ2iJSISX28J
        ald1sdxFF/tbhyHEyAXMO8nW+vKl
X-Google-Smtp-Source: APXvYqz3uyFaL70+aUN3vq03IqHV1W1kgSHYE3OFf9WcVPveGsjr37sm9YDs7nFpvTLWghMf4Zg60Q==
X-Received: by 2002:a17:902:ab96:: with SMTP id f22mr6287450plr.147.1565905276303;
        Thu, 15 Aug 2019 14:41:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 03/24] merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
Date:   Thu, 15 Aug 2019 14:40:32 -0700
Message-Id: <20190815214053.16594-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We always want our conflict hunks to be labelled so that users can know
where each came from.  The previous commit fixed the one caller in the
codebase which was not setting opt->ancestor (and thus not providing a
label for the "merge base" conflict hunk in diff3-style conflict
markers); add an assertion to prevent future codepaths from also
overlooking this requirement.

Enforcing this requirement also allows us to simplify the code for
labelling the conflict hunks by no longer checking if the ancestor label
is NULL.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d960fa64b..a67ea4957a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1019,7 +1019,7 @@ static int merge_3way(struct merge_options *opt,
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
-	char *base_name, *name1, *name2;
+	char *base, *name1, *name2;
 	int merge_status;
 
 	ll_opts.renormalize = opt->renormalize;
@@ -1043,16 +1043,13 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path && o->path);
-	if (strcmp(a->path, b->path) ||
-	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s:%s", opt->ancestor, o->path);
+	assert(a->path && b->path && o->path && opt->ancestor);
+	if (strcmp(a->path, b->path) || strcmp(a->path, o->path) != 0) {
+		base  = mkpathdup("%s:%s", opt->ancestor, o->path);
 		name1 = mkpathdup("%s:%s", branch1, a->path);
 		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s", opt->ancestor);
+		base  = mkpathdup("%s", opt->ancestor);
 		name1 = mkpathdup("%s", branch1);
 		name2 = mkpathdup("%s", branch2);
 	}
@@ -1061,11 +1058,11 @@ static int merge_3way(struct merge_options *opt,
 	read_mmblob(&src1, &a->oid);
 	read_mmblob(&src2, &b->oid);
 
-	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
+	merge_status = ll_merge(result_buf, a->path, &orig, base,
 				&src1, name1, &src2, name2,
 				opt->repo->index, &ll_opts);
 
-	free(base_name);
+	free(base);
 	free(name1);
 	free(name2);
 	free(orig.ptr);
@@ -3390,6 +3387,8 @@ int merge_trees(struct merge_options *opt,
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
+	assert(opt->ancestor != NULL);
+
 	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
-- 
2.23.0.rc2.32.g2123e9e4e4

