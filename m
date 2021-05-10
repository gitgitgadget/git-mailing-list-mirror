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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E2C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD1061108
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhEJPgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbhEJPgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894ADC061761
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:35:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v6so21341686ljj.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCpV8oz7FCNaOUZBMyoTu3fLUwAHtr+vf+qs5Rm63RY=;
        b=u1Tae1QSIXKi/tcFGWgKxyveOUJdmXeAfuvTkAHJQ78/5OLxMs5MB1tQztstuBjfWl
         PgglvGybs4gUbEt7AxiiGduRrTreuW5Ha+/AzAhKu7CmxRr4m1RhAXWZ+c5LXFYAc/BY
         uyMcy9hJVdBpYZXyStpEdTVeURTBQEWK9q4mfnUzdAvbvB8/4vF74brnjh2AtIZD8joT
         rtjJ2oS7FH/MAQpzxKT68tf+IETnN8hFNOTIKtbtixF40PVfhUV/y4X2bxuyFLAwhDtZ
         LFqhGOsasJkv/I/4kDwci302egXP/sxoG4T4nbTQkvtaGicYrs/GNuMbGypESE2kPAcP
         ubBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCpV8oz7FCNaOUZBMyoTu3fLUwAHtr+vf+qs5Rm63RY=;
        b=F0rU3h9hemOKGu5ltyuDq0vZxKZjkE3jdJfd/GAt9MWMRKEVz3lV4ZSJhpAvMdM9xQ
         jC6XxdVrmSDEdcdjN8wZ9DOiuelRVRJ/7puQVU1GECRuX9mVTVpmshM0kQErjK9kLnvY
         ke5Nsq389x0I9olQmxtHU8f9ufyomLOC2o7XAZz4UPlandAy1Qkk/tRWkMRC558bDiEm
         EKAKVudd1C3GYPf63mkqs85tmv3TG80DTSca4zGjZFFRuuidLsJ6EfNSObgCCbN5cJqw
         jiUl1QsQcD1ZBhUojmLtWU2eyW4BztjFc4U6d739yNPq/nCV/NK1IxfeRtD9xmfisH5u
         xn6w==
X-Gm-Message-State: AOAM5336cdbzQoRcUexLjzljZXVkXa5ao7TFt9OHcRGVYLBJwvOF2FuS
        j8BkJFQysGq5iKOTpfvuMHM=
X-Google-Smtp-Source: ABdhPJwi9g487CwdKc8RkxOGPk5Ev9ScnUJSQAcp44gYEpMITOzG1JGFCEFqVQsH2qLKWWjVywwhYA==
X-Received: by 2002:a2e:1f12:: with SMTP id f18mr3057612ljf.75.1620660898777;
        Mon, 10 May 2021 08:34:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 5/6] diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
Date:   Mon, 10 May 2021 18:34:50 +0300
Message-Id: <20210510153451.15090-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510153451.15090-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring change in preparation for the next commit that
will let -m imply -p.

The old name doesn't match the intention to let not only -c/-cc imply
-p, but also -m, that is not a "combined" format, so we rename the
flag accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 10 +++++-----
 revision.h    |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 4016800c422c..211c99482cac 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -14,7 +14,7 @@ static void suppress(struct rev_info *revs)
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
-	revs->combined_imply_patch = 0;
+	revs->merges_imply_patch = 0;
 	revs->merges_need_diff = 0;
 }
 
@@ -100,10 +100,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		set_to_default(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
-		revs->combined_imply_patch = 1;
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
-		revs->combined_imply_patch = 1;
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -150,9 +150,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combined_imply_patch)
+	if (revs->merges_imply_patch)
 		revs->diff = 1;
-	if (revs->combined_imply_patch || revs->merges_need_diff) {
+	if (revs->merges_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
diff --git a/revision.h b/revision.h
index 93aa012f518e..17698cb51aca 100644
--- a/revision.h
+++ b/revision.h
@@ -193,10 +193,10 @@ struct rev_info {
 			/* Diff-merge flags */
 			explicit_diff_merges: 1,
 			merges_need_diff: 1,
+			merges_imply_patch:1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
-			combined_imply_patch:1,
 			dense_combined_merges:1,
 			first_parent_merges:1;
 
-- 
2.25.1

