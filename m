Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1041F453
	for <e@80x24.org>; Fri,  2 Nov 2018 20:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKCFKD (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 01:10:03 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43184 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKCFKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 01:10:03 -0400
Received: by mail-yw1-f65.google.com with SMTP id j75-v6so1229426ywj.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POc1KCqF+BV6zVxoDFfayulOUh2nTBGdTX76WiO7OKk=;
        b=RqD/0NSOC3AHt1WhYCTaHwccfDoxCJ7BHksCDiggMEfsR8unv1pTRRRKAu4V8YB+ff
         URCBYx1SCefTLxIMrkc9n7bne8JIjtB8Rft5tuy+e4kt22XQkaSoR/BchKsHI9aktJ6D
         OR06BkmFVvWR3JIRyap+jZmoCybaKPEgX0TLqfbnZ4V4dE/g3A+em42s+H3xQUfSbqqF
         rHl+/GuT0mGSMKjTvU1S7ZY9tDo8WkP8QDgZJJ56Mss0wsNPfoUB8F3Lt5VIJg3gsvEC
         JhOsT1uyvEmf+wqsjSr4OAWR3DjVzBgB6whoX0Ri9h54BkVMAxSZHV4gqWiJ2q2dy95H
         XSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POc1KCqF+BV6zVxoDFfayulOUh2nTBGdTX76WiO7OKk=;
        b=UjFAFgRw1Nzr+5br86bjwQPzEBVogU3nYyeq8t6sxwmKiwVXjEBud42GfgFuOOpeMY
         uemipSgrZxw5EtcEvQXDeRmlNUPIuhRKWew9hLIuwj6mbxpgDQ8CC5fG9KVXBfk9SJAZ
         1DZ8A0zTuTQN3Tkp0Sam1O6HDL9Zr5LKDWbgXyRIjtiN6TQoPafr3lcxiNgSHgHG78zG
         1LVCtgUEyI5kTYO/LDuUDPhQ2NWdKYLo7mVpia0lQljkUgmQ8191pPS9CHOk9IsZd+WV
         8YWFqx5DVTA2r4DEVmOarwdNSxcHoGCrGEBQxEek5G9bYzT/cip13WecvmT5/r2M5MQ1
         DgCQ==
X-Gm-Message-State: AGRZ1gKuuE1Zk36QBucGO0MV/Nh6sflmy+rDjV7h9Vt8Z7XscqJXX4aa
        suV68q6XAz3saqmb4dtuGk146Bb/
X-Google-Smtp-Source: AJdET5f/OfL6PpZCgXhv1MP92C6ThIeB/ZxNF7hD082rVqsOGRZfE7WSxNPPxFijpDjJSx2Mddnwwg==
X-Received: by 2002:a81:8044:: with SMTP id q65-v6mr12489397ywf.196.1541188891115;
        Fri, 02 Nov 2018 13:01:31 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b63-v6sm6667869ywd.64.2018.11.02.13.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:01:30 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] merge-recursive: combine error handling
Date:   Fri,  2 Nov 2018 20:01:27 +0000
Message-Id: <20181102200127.127356-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.1235.gbda564b1a2
In-Reply-To: <20181102185317.31015-9-newren@gmail.com>
References: <20181102185317.31015-9-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In handle_rename_rename_1to2(), we have duplicated error handling
around colliding paths. Specifically, when we want to write out
the file and there is a directory or untracked file in the way,
we need to create a temporary file to hold the contents. This has
some special output to alert the user, and this output is
duplicated for each side of the conflict.

Simplify the call by generating this new path in a helper
function.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Elijah,

Here is a patch that combines the logic to avoid code clones, and also
more easily covers code blocks. Of course, your additional test helps
the branch coverage.

Thanks,
-Stolee

 merge-recursive.c | 53 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 59811116b6..5e36bef162 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1709,6 +1709,27 @@ static int handle_rename_add(struct merge_options *o,
 				     ci->dst_entry1->stages[other_stage].mode);
 }
 
+static char *find_path_for_conflict(struct merge_options *o,
+				    const char *path,
+				    const char *branch1,
+				    const char *branch2)
+{
+	char *new_path = NULL;
+	if (dir_in_way(path, !o->call_depth, 0)) {
+		new_path = unique_path(o, path, branch1);
+		output(o, 1, _("%s is a directory in %s adding "
+			       "as %s instead"),
+		       path, branch2, new_path);
+	} else if (would_lose_untracked(path)) {
+		new_path = unique_path(o, path, branch1);
+		output(o, 1, _("Refusing to lose untracked file"
+			       " at %s; adding as %s instead"),
+		       path, new_path);
+	}
+
+	return new_path;
+}
+
 static int handle_rename_rename_1to2(struct merge_options *o,
 				     struct rename_conflict_info *ci)
 {
@@ -1783,19 +1804,9 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 						  &add->oid, add->mode) < 0)
 				return -1;
 		} else {
-			char *new_path = NULL;
-			if (dir_in_way(a->path, !o->call_depth, 0)) {
-				new_path = unique_path(o, a->path, ci->branch1);
-				output(o, 1, _("%s is a directory in %s adding "
-					       "as %s instead"),
-				       a->path, ci->branch2, new_path);
-			} else if (would_lose_untracked(a->path)) {
-				new_path = unique_path(o, a->path, ci->branch1);
-				output(o, 1, _("Refusing to lose untracked file"
-					       " at %s; adding as %s instead"),
-				       a->path, new_path);
-			}
-
+			char *new_path = find_path_for_conflict(o, a->path,
+								ci->branch1,
+								ci->branch2);
 			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
 				return -1;
 			free(new_path);
@@ -1812,19 +1823,9 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 						  &mfi.oid, mfi.mode) < 0)
 				return -1;
 		} else {
-			char *new_path = NULL;
-			if (dir_in_way(b->path, !o->call_depth, 0)) {
-				new_path = unique_path(o, b->path, ci->branch2);
-				output(o, 1, _("%s is a directory in %s adding "
-					       "as %s instead"),
-				       b->path, ci->branch1, new_path);
-			} else if (would_lose_untracked(b->path)) {
-				new_path = unique_path(o, b->path, ci->branch2);
-				output(o, 1, _("Refusing to lose untracked file"
-					       " at %s; adding as %s instead"),
-				       b->path, new_path);
-			}
-
+			char *new_path = find_path_for_conflict(o, b->path,
+								ci->branch2,
+								ci->branch1);
 			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
 				return -1;
 			free(new_path);
-- 
2.19.1.1235.gbda564b1a2

