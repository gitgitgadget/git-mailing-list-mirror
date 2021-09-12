Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB1C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477D5610A3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhILAR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhILARX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01429C06175F
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so4178388wmq.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fD3o4xaWjuu+E2OO3NdUvZv3Ev1nVB0lJhpRcOVJS8=;
        b=NGpFjUj7JresrKcHAhJxxXXYoavjsN6s0deqJhYQAP8/4RmlWjgqGTAGuKbAvtp2RY
         FsNtScOBv3URgc3BTnohUdtV8XxsxhKT9Ze7xjryNIdd23e/RCJCV2Af9QyLJFV9SgBH
         UyKhxs1+q7sPeJYQZNYQGzs2B7xsilrGaEP4c8B6/b1orUk2gTUFQuZv9X2sF9jn5jJj
         /mFk1IN+oo38dVY/Z4tsClNHk0Jj5LyoQvq20KUrZCD0qlkKvRCCJ3P2Nq2XkO60h4Mp
         6tu+CP/2PrBv7ykpSVKcdgaS9tveTSezlPoKiQ6Qfeccu3woXw0GjMYQhTg4wiYNhaS6
         OolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fD3o4xaWjuu+E2OO3NdUvZv3Ev1nVB0lJhpRcOVJS8=;
        b=v8X1PZvWhk2ZBgDwELK86yQQ89kVfoWsElG6sqmDCyxSFZbUxnqUbP+3PIj3hKJZ7s
         Dn1jm9qirozRdvw5mS6NjMpVOZzNUwToP/xEST8k7w+ZwbdaigJwLEok63wMlUiIqj0R
         0zSv5ri9Oi97aEcZ2ucxls0QvzZ8rTV7XtjlKFK6m9KBfz0izw4jun7Rr8iX/d1cUCVE
         47RqnwZ0eLBtUkhoqYgUKq5CqouEG799HyK1k1Akgu1PoZ9Q85j0pNysnYQQ4bnGyiak
         4wrmcXnIhjkBCnagAZG2V6uyKrThXA/lxSjkGMrAAiSsvDcpo9ubSOQCNLBBgLo6answ
         0MRQ==
X-Gm-Message-State: AOAM530/ciWwHOw2NhKvuVYq95UzcFZ+MOf92xPKl3JPzDpPn4LuxQVm
        gFXeYATbauRe3K1OpY+CY0G41/v9q30w6g==
X-Google-Smtp-Source: ABdhPJyQ2K8eZ949T3c16MQChOWUQNxylai2VQwPAOYx3OTCb8xnK5QnuDSl/vkRORIR9v0czsMOwQ==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr4403353wmp.93.1631405768317;
        Sat, 11 Sep 2021 17:16:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] upload-pack.c: pass "struct strvec *" instead of int/char ** pair
Date:   Sun, 12 Sep 2021 02:15:52 +0200
Message-Id: <patch-v2-4.7-2e0b82d4316-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit, prepare for the "nr" member of "struct
strvec" changing from an "int" to a "size_t". These are the same sorts
of changes to pass a "struct strvec *" further down instead of passing
args->nr and args->v.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shallow.c     | 5 +++--
 shallow.h     | 6 ++++--
 upload-pack.c | 7 +++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/shallow.c b/shallow.c
index 9ed18eb8849..6928db36669 100644
--- a/shallow.c
+++ b/shallow.c
@@ -15,6 +15,7 @@
 #include "list-objects.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "strvec.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
@@ -196,7 +197,7 @@ static void show_commit(struct commit *commit, void *data)
  * are marked with shallow_flag. The list of border/shallow commits
  * are also returned.
  */
-struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
+struct commit_list *get_shallow_commits_by_rev_list(struct strvec *args,
 						    int shallow_flag,
 						    int not_shallow_flag)
 {
@@ -215,7 +216,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, NULL);
+	setup_revisions(args->nr, args->v, &revs, NULL);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/shallow.h b/shallow.h
index 5b4a96dcd69..206405ec8ca 100644
--- a/shallow.h
+++ b/shallow.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "strvec.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 int register_shallow(struct repository *r, const struct object_id *oid);
@@ -32,8 +33,9 @@ void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
-struct commit_list *get_shallow_commits_by_rev_list(
-		int ac, const char **av, int shallow_flag, int not_shallow_flag);
+struct commit_list *get_shallow_commits_by_rev_list(struct strvec *args,
+						    int shallow_flag,
+						    int not_shallow_flag);
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 			  const struct oid_array *extra);
 
diff --git a/upload-pack.c b/upload-pack.c
index 6ce07231d3d..5928973bcc3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -859,13 +859,12 @@ static void deepen(struct upload_pack_data *data, int depth)
 }
 
 static void deepen_by_rev_list(struct upload_pack_data *data,
-			       int ac,
-			       const char **av)
+			       struct strvec *args)
 {
 	struct commit_list *result;
 
 	disable_commit_graph(the_repository);
-	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
+	result = get_shallow_commits_by_rev_list(args, SHALLOW, NOT_SHALLOW);
 	send_shallow(data, result);
 	free_commit_list(result);
 	send_unshallow(data);
@@ -900,7 +899,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 			struct object *o = data->want_obj.objects[i].item;
 			strvec_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(data, av.nr, av.v);
+		deepen_by_rev_list(data, &av);
 		strvec_clear(&av);
 		ret = 1;
 	} else {
-- 
2.33.0.998.ga4d44345d43

