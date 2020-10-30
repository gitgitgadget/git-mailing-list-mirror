Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D159C4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3B20796
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3N9XHTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgJ3Dmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJ3Dmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07777C0613DC
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 32so4474772otm.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAmOxGVitKXhlYrJ/4fHaJEH2uvTcyZqXkfEp5oYRWA=;
        b=I3N9XHTuQn1lQ9yRiX7t5O0751iKiCUDZvHRV/dWNnu1/bdnyka5WVMfkSlLNcXmxo
         SNynM+Xk73gofoUsUl/Z3CxYVLsgiolNKTp6i0Zw0pKhcYTpBLb4EHgeDhHZdKXXCRBx
         ZVHRiQI8uqiiVWk6j1W19M8NfcXQ9yK7SNwO+pVCs1XFXTHr0FadXtoCSmheWwz7ZNwE
         PWy9n/yku3d8B42TeEBw3S4C2dA2gRb9YDQ3bfV1GQ/viMlXDzbn31xoX2iWv5rDuA/y
         4sMMMbqrOjpZNmm2bi2hhkCrxUfidhXr472zAZ2cJruTMjYSjVQRmhwgv7wTrpQIL9lX
         JIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAmOxGVitKXhlYrJ/4fHaJEH2uvTcyZqXkfEp5oYRWA=;
        b=Ok8bwsjfc9Su8VC9iKYVshR+KfWzLKRDz6avSmBHKVbRccIorz7xtX2anUd1Oev684
         fXLJAChj8DmMFXFphGtfvp+BE+ICZI7ecf1R6qhPVgNzNyhXc0MyFaN+VQT4DgRbDeHx
         mER4K6hcimumJt/d5uH/yAWC0vlfimgi0OTK02KQhJVSQO4Lkyox1Gs/TG2u+qSb1Gl5
         BmSfzUpYqXaNYpxHxo6r7rNJXvzJKiQXqH9eXZFB7L4WpdH0ISaLjFMQB5XzJozzsVFI
         2UCevF+JKmG2W9kB+YwMVdoGaTWP72unNsw4AjDA3v8QZKr20lvkcTv0YQOEwriw5PVl
         v6jw==
X-Gm-Message-State: AOAM530+8Me+cWA3jAbOXcSrnHlsnHlt+Wpfft4Rn+4PWX/Znkn7wssb
        sViExIZOsWa35mUbVYtfRGISsdlh8MbNCw==
X-Google-Smtp-Source: ABdhPJy1zt60hdFrlMzrUZXUmIMWrP6BXod4Nv0xCkWsRF3XGHXqBXB8oQWRI2HfybHTfObm2oymsw==
X-Received: by 2002:a9d:7f09:: with SMTP id j9mr192328otq.184.1604029314104;
        Thu, 29 Oct 2020 20:41:54 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:53 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 11/20] merge-ort: add a preliminary simple process_entries() implementation
Date:   Thu, 29 Oct 2020 20:41:22 -0700
Message-Id: <20201030034131.1479968-12-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a process_entries() implementation that just loops over the paths
and processes each one individually with an auxiliary process_entry()
call.  Add a basic process_entry() as well, which handles several cases
but leaves a few of the more involved ones with die-not-implemented
messages.  Also, although process_entries() is supposed to create a
tree, it does not yet have code to do so -- except in the special case
of merging completely empty trees.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2a402e18ed..f4bf1baf78 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -324,10 +324,114 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+/* Per entry merge function */
+static void process_entry(struct merge_options *opt,
+			  const char *path,
+			  struct conflict_info *ci)
+{
+	assert(!ci->merged.clean);
+	assert(ci->filemask >= 0 && ci->filemask <= 7);
+
+	if (ci->filemask == 0) {
+		/*
+		 * This is a placeholder for directories that were recursed
+		 * into; nothing to do in this case.
+		 */
+		return;
+	}
+
+	if (ci->df_conflict) {
+		die("Not yet implemented.");
+	}
+
+	/*
+	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
+	 *       which the code goes through even for the df_conflict cases
+	 *       above.  Well, it will once we don't die-not-implemented above.
+	 */
+	if (ci->match_mask) {
+		ci->merged.clean = 1;
+		if (ci->match_mask == 6) {
+			/* stages[1] == stages[2] */
+			ci->merged.result.mode = ci->stages[1].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+		} else {
+			/* determine the mask of the side that didn't match */
+			unsigned int othermask = 7 & ~ci->match_mask;
+			int side = (othermask == 4) ? 2 : 1;
+
+			ci->merged.is_null = (ci->filemask == ci->match_mask);
+			ci->merged.result.mode = ci->stages[side].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+
+			assert(othermask == 2 || othermask == 4);
+			assert(ci->merged.is_null == !ci->merged.result.mode);
+		}
+	} else if (ci->filemask >= 6 &&
+		   (S_IFMT & ci->stages[1].mode) !=
+		   (S_IFMT & ci->stages[2].mode)) {
+		/*
+		 * Two different items from (file/submodule/symlink)
+		 */
+		die("Not yet implemented.");
+	} else if (ci->filemask >= 6) {
+		/*
+		 * TODO: Needs a two-way or three-way content merge, but we're
+		 * just being lazy and copying the version from HEAD and
+		 * leaving it as conflicted.
+		 */
+		ci->merged.clean = 0;
+		ci->merged.result.mode = ci->stages[1].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+	} else if (ci->filemask == 3 || ci->filemask == 5) {
+		/* Modify/delete */
+		die("Not yet implemented.");
+	} else if (ci->filemask == 2 || ci->filemask == 4) {
+		/* Added on one side */
+		int side = (ci->filemask == 4) ? 2 : 1;
+		ci->merged.result.mode = ci->stages[side].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
+	} else if (ci->filemask == 1) {
+		/* Deleted on both sides */
+		ci->merged.is_null = 1;
+		ci->merged.result.mode = 0;
+		oidcpy(&ci->merged.result.oid, &null_oid);
+		ci->merged.clean = !ci->path_conflict;
+	}
+
+	/*
+	 * If still unmerged, record it separately.  This allows us to later
+	 * iterate over just unmerged entries when updating the index instead
+	 * of iterating over all entries.
+	 */
+	if (!ci->merged.clean)
+		strmap_put(&opt->priv->unmerged, path, ci);
+}
+
 static void process_entries(struct merge_options *opt,
 			    struct object_id *result_oid)
 {
-	die("Not yet implemented.");
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	if (strmap_empty(&opt->priv->paths)) {
+		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
+		return;
+	}
+
+	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		/*
+		 * WARNING: If ci->merged.clean is true, then ci does not
+		 * actually point to a conflict_info but a struct merge_info.
+		 */
+		struct conflict_info *ci = e->value;
+
+		if (!ci->merged.clean)
+			process_entry(opt, e->key, e->value);
+	}
+
+	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
2.29.1.56.ga287c268e6.dirty

