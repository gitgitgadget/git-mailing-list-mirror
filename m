Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5055DC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFDB23C91
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgLITmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbgLITmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:14 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078DC06179C
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:34 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so2579289wml.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9o26fS35UK0LREBqC+PayUR5LfFCNU4XZ7QxCHWU0xo=;
        b=Zc2clqDjlyo1lDDsoAl2Nt0IBtgfJMdSFJQyeV88D/mlrjtis13OP8GwLMj2Pz9m2T
         St/YRnMYvwf3FnW32UxZSwpt/L/pL9s39GQoZ0K1cSexSJmil41lXTww1vYGUK4SGQQz
         94QfUUHx31qMLroear9yr+OnZcjYn219VxU5qMFb4ZGxOxEqdSlQWYDVO8Vcm74XvpQJ
         YibJhPJpx74IDxQaCti1qNbtvUbbwaYTHWlLliaPhWM7T6ILZ2qJpPK4D/c1CFP+AUyl
         LxX/l8hbl7HM172Yvx7Gi0XmcODkJzF7gKx4Gt7uFql0OntEN/DWsK0cdKcuerCTZcMB
         LkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9o26fS35UK0LREBqC+PayUR5LfFCNU4XZ7QxCHWU0xo=;
        b=tY0UmoOwWdbdyV9SXngGlDvDWt1t1ero1Es2+FiMDvNGuFwkQe5ORUkyLiLX0TiGz/
         z9jWcLwdsW9N8+DPQLBGI1YN7E9t/xKvgrrN/29PIkUA1wZbqfVeNl+WHhnAqgvLk4Zl
         PaL7ikVKzorakKctKBvAQaxn1XTV5RJP0K+SdVGjaDkK7jXnkvMKPTssYmYY2gr/kjeX
         1Z3Z2cUr7rzbnKs/rGAkxmca7qTl44lVzYOlC2lbGJ8SJZEBjCL6muSe8Yz9I4Ofo8w4
         oECRyC5BGumw6uVAMu8P3nNLyMP5taui7vP/kENQf0lXoQBWqPzrYZqbS3HqKr3OlfXu
         YfRw==
X-Gm-Message-State: AOAM532DwE8AFv/rIrm8sCULPaDl/d3k4buyLNy0Ejs/H0FFT/Jc1/s9
        TYEWm/5N9fltE/glIcXrefCOyP/7t7E=
X-Google-Smtp-Source: ABdhPJwzyAnY87kqhZPMloQWP6/pwTormJKmZ5rMP6LJ7gsuAewpZh8R6Cj4M7Y7yEaGvjw2O/RhGQ==
X-Received: by 2002:a1c:b4c4:: with SMTP id d187mr4408800wmf.38.1607542893051;
        Wed, 09 Dec 2020 11:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm5245769wrw.16.2020.12.09.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:32 -0800 (PST)
Message-Id: <207bb9a837cb855721daa88caaad80e37cb40ffe.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:20 +0000
Subject: [PATCH 04/11] merge-ort: implement compare_pairs() and
 collect_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1ff637e57af..3cdf8124b85 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -625,7 +625,13 @@ static int process_renames(struct merge_options *opt,
 
 static int compare_pairs(const void *a_, const void *b_)
 {
-	die("Not yet implemented.");
+	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
+	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
+
+	int cmp = strcmp(a->one->path, b->one->path);
+	if (cmp)
+		return cmp;
+	return a->score - b->score;
 }
 
 /* Call diffcore_rename() to compute which files have changed on given side */
@@ -671,7 +677,24 @@ static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
 			   unsigned side_index)
 {
-	die("Not yet implemented.");
+	int i, clean = 1;
+	struct diff_queue_struct *side_pairs;
+	struct rename_info *renames = opt->priv->renames;
+
+	side_pairs = &renames->pairs[side_index];
+
+	for (i = 0; i < side_pairs->nr; ++i) {
+		struct diff_filepair *p = side_pairs->queue[i];
+
+		if (p->status != 'R') {
+			diff_free_filepair(p);
+			continue;
+		}
+		p->score = side_index;
+		result->queue[result->nr++] = p;
+	}
+
+	return clean;
 }
 
 static int detect_and_process_renames(struct merge_options *opt,
-- 
gitgitgadget

