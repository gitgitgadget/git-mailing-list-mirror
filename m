Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC9FC4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871A022D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393632AbgLMIGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393157AbgLMIFw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:52 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF2C0617A7
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:36 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a12so13244439wrv.8
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t1IsNGWzotdnHOnSfGKrCq25w3EteMzMjz74ihCbnK8=;
        b=Ze8eoVCprMUifvmxW3uwQ8xJhntKEfCDQS978hdZK3CFkFuP8/H21baWm3KK6tqNri
         TSKwkgIsHTQ05c8xgG9Cczt6NF5j5Y222oJP0eEllablRSvApiqFKSVDjEPRHI/Mbafz
         3mTD0yZAunlCvKrpLzQFJXR+3Qaw5rSUvJOgp8UQs2o1BjjNTFcbLYLoEieX8Fm808tg
         Rg+u856/5ogKYPPn+Ty3cmpLV5FS1heePbPaF1fzx45KfZAtiVbXMN3SCGeBM5cJgW2E
         4jbz4FVc4hnWFdaWhENEzI44TMnipQSP/k0zD/iMo+CZHZFU3PCRIKVwnfoo365UBdem
         Srxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t1IsNGWzotdnHOnSfGKrCq25w3EteMzMjz74ihCbnK8=;
        b=EQAbpIsevUtzVjj79dFw4ifSgx4ZJT5ai7BCR/0/Y4OJ+RD4cbXcH0ZBPowT2CvQAi
         ElgqfqmP9VspRvvlE1j8wLB7YCqJ3c6UoVsqS8Evose8l0WGKstN9ojcIfwRiVwTB4JW
         ZC/fxKFXQUK9a/vYg/CMJ8KXxSoCEf9SBvKqxVgxXB8u9Xirq0DKFLqAmyp7gv/bdgg/
         r9LBkvH07ZxYF2FRhZ1afrs/LcnSPyTpTNUtdSvfgPMoU7013ONEtGZ9ZNpliarCECQo
         jBij6uNdz2bsMXiN/YJNGKriI8/zklw9tY4GpJY6OzQ94RruraBLAYsbKeQ7DUafvNI1
         RAEg==
X-Gm-Message-State: AOAM5322RI6VEa1ZN0R/vhUYhm524J7TOYRCXli+0QHFCICxwxWkbdhG
        B0S/BdwvMEENlr1u1m763I4uk2iy808=
X-Google-Smtp-Source: ABdhPJx9D4KbzD85u3GE0/3/dPrG4+LDDYP8UYZfscm/vebkgA7rmpTFtyUolWX99Pimpe9NU7t9wQ==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr23202765wrj.148.1607846675194;
        Sun, 13 Dec 2020 00:04:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm19828297wrm.14.2020.12.13.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:34 -0800 (PST)
Message-Id: <c18bdc1b05223416e12e0748f6f722a97bcd105e.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:14 +0000
Subject: [PATCH v3 07/20] merge-ort: avoid repeating fill_tree_descriptor() on
 the same tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Three-way merges, by their nature, are going to often have two or more
trees match at a given subdirectory.  We can avoid calling
fill_tree_descriptor() on the same tree by checking when these trees
match.  Noting when various oids match will also be useful in other
calculations and optimizations as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4a2c7de6e8e..690c64fe264 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -223,6 +223,15 @@ static int collect_merge_info_callback(int n,
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
+	unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
+					names[0].mode == names[1].mode &&
+					oideq(&names[0].oid, &names[1].oid));
+	unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
+					names[0].mode == names[2].mode &&
+					oideq(&names[0].oid, &names[2].oid));
+	unsigned sides_match = (!side1_null && !side2_null &&
+				names[1].mode == names[2].mode &&
+				oideq(&names[1].oid, &names[2].oid));
 
 	/* n = 3 is a fundamental assumption. */
 	if (n != 3)
@@ -275,10 +284,19 @@ static int collect_merge_info_callback(int n,
 		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
 
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
-			const struct object_id *oid = NULL;
-			if (dirmask & 1)
-				oid = &names[i].oid;
-			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+			if (i == 1 && side1_matches_mbase)
+				t[1] = t[0];
+			else if (i == 2 && side2_matches_mbase)
+				t[2] = t[0];
+			else if (i == 2 && sides_match)
+				t[2] = t[1];
+			else {
+				const struct object_id *oid = NULL;
+				if (dirmask & 1)
+					oid = &names[i].oid;
+				buf[i] = fill_tree_descriptor(opt->repo,
+							      t + i, oid);
+			}
 			dirmask >>= 1;
 		}
 
-- 
gitgitgadget

