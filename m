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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ABDC4742C
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDD9214DB
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0emmo8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgJ3Dm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758FDC0613D6
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:48 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n11so4473692ota.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/AWh+RiIpndKYGuUwBn+oiGcyXdhD2Jq8CniHYSjMc=;
        b=H0emmo8VMK5ZUTRCQwVWemfEBn60loR4dvYghImjHC0zzoiAzUyIvaQIhDfR3kOEWQ
         6Z+iPMpviRvCFWqvTqgXrMyM0SJ6LtRQCu2ST0QDsijfnpitJJULv1u45iqrrOF/J9eA
         BM3NnmHS08688iprl+arVw55HZmTeHruYBM/Sp+BP65/id4zmODNHz925yK+b9RM0iSr
         0vdxcGzj+9HqpdKcVkz1W1jdxpshOai2ztHAZYYDZ+mfkBFsbEVN2fVIYqFyowMnY9EK
         KAXbk+cwJNARMGTFK98x6/JqwpH5ryVn/KshKa24KLc4y5ijKUQ8utZd6GaunH2vXJIF
         g1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/AWh+RiIpndKYGuUwBn+oiGcyXdhD2Jq8CniHYSjMc=;
        b=R2d9ehb84penfcTWAtUZobAAPm7hxLyboLVr4u/JEfaXOR5d/00T2Bcg2XlTJQkM6s
         cLsb74iQEPJ5PZ2CYmhRNScP819CRs4oaulx3XYOlKKJlJLipzj5AB9GtBs0mZ5VLk9F
         NP7nh+27BHYFCUz8V871theOdBxb2I5Nsde6G3ONbDQ52kVAnkpWuEauSV0umb8GEe9c
         vr54/GWfq2iWgMp/2pDR/73iFLIXbpOxCx7lMVb4SzKigb16axAfZDnKqStlewgN+t2S
         3yXlW+QvBSRMtwt48gP3bnL8zjv+qXu6Mkld8WrG8bcA83VLojllStqGpP9vIPhBpLjE
         ssAA==
X-Gm-Message-State: AOAM533nt4CLKYRiTLr/WdzH+K6HEJyf6OKsfFkWX59fTZCi4v4wcG3n
        vy+ztbn4elBo4ninG1/g0ERn3AYE4WsOAQ==
X-Google-Smtp-Source: ABdhPJzjfR2auZEn4UQ4CCUL9npN9hv0jJCfiBTs3D05XdGyVFkYD/Wui9R2UylL4Yq6lkjCiYG4yg==
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr225325otn.30.1604029307671;
        Thu, 29 Oct 2020 20:41:47 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/20] merge-ort: add an err() function similar to one from merge-recursive
Date:   Thu, 29 Oct 2020 20:41:16 -0700
Message-Id: <20201030034131.1479968-6-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various places in merge-recursive used an err() function when it hit
some kind of unrecoverable error.  That code was from the reusable bits
of merge-recursive.c that we liked, such as merge_3way, writing object
files to the object store, reading blobs from the object store, etc.  So
create a similar function to allow us to port that code over, and use it
for when we detect problems returned from collect_merge_info()'s
traverse_trees() call, which we will be adding next.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index e629d7b62c..ffea7ac8ea 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -61,11 +61,28 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+static int err(struct merge_options *opt, const char *err, ...)
+{
+	va_list params;
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, "error: ");
+	va_start(params, err);
+	strbuf_vaddf(&sb, err, params);
+	va_end(params);
+
+	error("%s", sb.buf);
+	strbuf_release(&sb);
+
+	return -1;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
 			      struct tree *side2)
 {
+	/* TODO: Implement this using traverse_trees() */
 	die("Not yet implemented.");
 }
 
@@ -167,7 +184,15 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
-	collect_merge_info(opt, merge_base, side1, side2);
+	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
+		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
+		    oid_to_hex(&merge_base->object.oid),
+		    oid_to_hex(&side1->object.oid),
+		    oid_to_hex(&side2->object.oid));
+		result->clean = -1;
+		return;
+	}
+
 	result->clean = detect_and_process_renames(opt, merge_base,
 						   side1, side2);
 	process_entries(opt, &working_tree_oid);
-- 
2.29.1.56.ga287c268e6.dirty

