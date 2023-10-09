Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF9E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbjJIKzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJIKzq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:55:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0516B8E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:55:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7125741a12.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 03:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696848940; x=1697453740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FiY2+5KerkCg3TRlt8yED0XiGRko5TMen1uOL/Q64Y=;
        b=bhVrZ31fS3m/LjjpPGTL9zoUzFmx+aOZ8n0+jNeCCR8KExEuGGZD58HrQWkojSpY/O
         Gb0d8z3GvIJS0sb+WxRF9CKqimRoG5oynzlB2l9hnu9d3dEvXre1T7WFLGNDy0S7t5iY
         v4NERx3dRFHojf5CSPHQmLYUZNqWXW2XjG3KDbtbq+BZyStBVIMKYH0+C67KCqmMTT3J
         oflLnFeQBdsQHnm7k9lMxThan6DOBPl2v+Z73xSHPp5y4CPpNhImllwyauukWZGS7xfv
         dvBybz595Wf+0lHe/mpNiyVRDlCB05EoMzoS/MWHGFiGo61fLkjOqu8kgoN+vtZ5bCf4
         KmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848940; x=1697453740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FiY2+5KerkCg3TRlt8yED0XiGRko5TMen1uOL/Q64Y=;
        b=tEzJKS+WOXpVJsqqjVMR9BPstfSDdpC/FdNGcSnmEaQeNMXIC9FnZoOUkB8li0FW82
         x4Yo9DtvCwz76A9Wpavwe+p69MKZSr/yEzpvKC2yGqwWlI5Uxo7uYdlIpIhje9HeGpye
         Kpq9bjU9D0/RBcnEv2qsJLL4iRYXys4l58LPuDT3oBwj8Np7OgYIqej2N/RyZ5RA7mt/
         yAnxz9irPrZ4Ek007KT87XOp3W4GvTMWGY5e7Umd83THY2+7tgKgAc4tHSSsRsPhRgX6
         ibN9uzeEk7SRZYKuS18eZCWLS75gXnt/NCv9K5cGCj9APGaD83GfXhTZvT2GfDC6OsjO
         aTew==
X-Gm-Message-State: AOJu0YynQzAyb8eUov3qtEGbEyzOURgGg54ePLcnOEvecPJEulj+Fn4p
        fGyquqZdCC3ye33z2HVAiqNhcV7bDKgbng==
X-Google-Smtp-Source: AGHT+IGHk1jy2P2Tj7kCcthj+CBGT9yt4DqBLbXokK0d66kKfNJKccizHveo24MMzCevf1d1SKH6Jg==
X-Received: by 2002:a50:ee8f:0:b0:531:3e89:1bef with SMTP id f15-20020a50ee8f000000b005313e891befmr12811690edr.32.1696848939726;
        Mon, 09 Oct 2023 03:55:39 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:47bc:9393:72b0:bdf2])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005331f6d4a30sm5906800edb.56.2023.10.09.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:55:39 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/3] revision: rename bit to `do_not_die_on_missing_objects`
Date:   Mon,  9 Oct 2023 12:55:26 +0200
Message-ID: <20231009105528.17777-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009105528.17777-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bit `do_not_die_on_missing_tree` is used in revision.h to ensure the
revision walker does not die when encountering a missing tree. This is
currently exclusively set within `builtin/rev-list.c` to ensure the
`--missing` option works with missing trees.

In the upcoming commits, we will extend `--missing` to also support
missing commits. So let's rename the bit to
`do_not_die_on_missing_objects`, which is object type agnostic and can
be used for both trees/commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/reflog.c   |  2 +-
 builtin/rev-list.c |  2 +-
 list-objects.c     |  2 +-
 revision.h         | 17 +++++++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index df63a5892e..9e369a5977 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -298,7 +298,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		struct rev_info revs;
 
 		repo_init_revisions(the_repository, &revs, prefix);
-		revs.do_not_die_on_missing_tree = 1;
+		revs.do_not_die_on_missing_objects = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
 		if (verbose)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff715d6918..ea77489c38 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -561,7 +561,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (arg_missing_action)
-		revs.do_not_die_on_missing_tree = 1;
+		revs.do_not_die_on_missing_objects = 1;
 
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
diff --git a/list-objects.c b/list-objects.c
index c25c72b32c..47296dff2f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -177,7 +177,7 @@ static void process_tree(struct traversal_context *ctx,
 		    is_promisor_object(&obj->oid))
 			return;
 
-		if (!revs->do_not_die_on_missing_tree)
+		if (!revs->do_not_die_on_missing_objects)
 			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
diff --git a/revision.h b/revision.h
index 50091bbd13..c73c92ef40 100644
--- a/revision.h
+++ b/revision.h
@@ -212,18 +212,19 @@ struct rev_info {
 
 			/*
 			 * Blobs are shown without regard for their existence.
-			 * But not so for trees: unless exclude_promisor_objects
+			 * But not so for trees/commits: unless exclude_promisor_objects
 			 * is set and the tree in question is a promisor object;
 			 * OR ignore_missing_links is set, the revision walker
-			 * dies with a "bad tree object HASH" message when
-			 * encountering a missing tree. For callers that can
-			 * handle missing trees and want them to be filterable
+			 * dies with a "bad <type> object HASH" message when
+			 * encountering a missing object. For callers that can
+			 * handle missing trees/commits and want them to be filterable
 			 * and showable, set this to true. The revision walker
-			 * will filter and show such a missing tree as usual,
-			 * but will not attempt to recurse into this tree
-			 * object.
+			 * will filter and show such a missing object as usual,
+			 * but will not attempt to recurse into this tree/commit
+			 * object. The revision walker will also set the MISSING
+			 * flag for such objects.
 			 */
-			do_not_die_on_missing_tree:1,
+			do_not_die_on_missing_objects:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
-- 
2.41.0

