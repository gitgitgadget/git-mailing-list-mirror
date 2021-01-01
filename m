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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A252C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36886221ED
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbhAACfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAACfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:35:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2635C061757
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i9so21280171wrc.4
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wbFxwuR0mJ88lBfOYEZRwFLji0FcvED1IaVK6/E3Gjs=;
        b=JVGq9jYR6+1kibi/QZ8phROWSd50ZeesqXBGFH3gA5VmpcBWOA8FMOzbZNP1WnVKQy
         bEmtEDwCcBF1f9GvxKweHEPUPsxKmOdkIasmhpSsSm/P5e3IUbNPBCtjSF9z4RBjlmm2
         LJZHzfGfwi1cztSwBuOFLi7N33W0G5dvfzWYV43/tnLHNaA8JztTQwiC06Qa7sumHIo+
         fl+rqc005JfdNwMAodXQTVuR3i8ZPlU94ghC8glaOdaD54A3hyPVvqtXDmaTda7vLkHS
         z3XU+1sP5VO85SSoDulkrgrSVf6lqqlBaolgcq2b6SB2snLc4jHc2t7ZSOu3EqNnV4nU
         qY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wbFxwuR0mJ88lBfOYEZRwFLji0FcvED1IaVK6/E3Gjs=;
        b=cDOxwE2HCdnqmGr/5KooxdGT7adnXvnB6GOI19TA8Jc4lre7oGvg8lk2SPGeNdCIwy
         HvdpARyWjMj5+/RJikzLEmrY3ISFeenB9rrSm34ivy8Ya/Cny+PQTXERTCAv8tMfYa3b
         yIjqP2B0cMEiueAW7mq0GTE3EsLX0Iweiuz/x0RTOelz9RLLov7s5Vy9en83fWG1+efd
         3+9lFFiMkVBJJIHE6/4yETG2zXjM+Ss3XYvNkHGDIlS/omEcgyfjVWx27cV1TxJdDX4S
         TghU6MiI1LHymNvNrh4WAyCu4L9+FDVhmUjxtz6+Vp7XZOuNpckS0S3bD6b3oVyueGHt
         lXSQ==
X-Gm-Message-State: AOAM530ZshGrxgJIVCDiVYG2Ju7jinnnL3Fi17ZKiLkqQQ/ZV8JXagXu
        bk0yRzrN+TtAI4R6gkmcyt6VD8Ob1mo=
X-Google-Smtp-Source: ABdhPJxVQ9cep7ooS/YTfag5lrKzyzy54tmnJnd2Nqopvd2gu9SkWObRjO77eJsOQcW/Jp+Ta6IsKw==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr66812398wrv.132.1609468492430;
        Thu, 31 Dec 2020 18:34:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm70650995wrq.1.2020.12.31.18.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:52 -0800 (PST)
Message-Id: <63fed5e49a734b11246f91d480ff4a27cc98db14.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:41 +0000
Subject: [PATCH v2 03/10] merge-ort: implement unique_path() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement unique_path(), based on the one from merge-recursive.c.  It is
simplified, however, due to: (1) using strmaps, and (2) the fact that
merge-ort lets the checkout codepath handle possible collisions with the
working tree means that other code locations don't have to.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index d300a02810e..1adc27a11bc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -343,11 +343,34 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+/* add a string to a strbuf, but converting "/" to "_" */
+static void add_flattened_path(struct strbuf *out, const char *s)
+{
+	size_t i = out->len;
+	strbuf_addstr(out, s);
+	for (; i < out->len; i++)
+		if (out->buf[i] == '/')
+			out->buf[i] = '_';
+}
+
 static char *unique_path(struct strmap *existing_paths,
 			 const char *path,
 			 const char *branch)
 {
-	die("Not yet implemented.");
+	struct strbuf newpath = STRBUF_INIT;
+	int suffix = 0;
+	size_t base_len;
+
+	strbuf_addf(&newpath, "%s~", path);
+	add_flattened_path(&newpath, branch);
+
+	base_len = newpath.len;
+	while (strmap_contains(existing_paths, newpath.buf)) {
+		strbuf_setlen(&newpath, base_len);
+		strbuf_addf(&newpath, "_%d", suffix++);
+	}
+
+	return strbuf_detach(&newpath, NULL);
 }
 
 /*** Function Grouping: functions related to collect_merge_info() ***/
-- 
gitgitgadget

