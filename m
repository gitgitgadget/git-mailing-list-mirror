Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A5C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF72D221E9
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaBl/lwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGBTYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 15:24:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F062C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 12:24:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so11683346pls.5
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQD+HDai7Q5CR/dG8a4vM+E9F2libihPB1l+ixu4cV0=;
        b=CaBl/lwA1Zi6lVDGI+SliEsUS30rLbbJ+db2fyQ8jG6Aaybac4L87zxTOBO+T98oks
         J8bsgG8bDtleiXpD+xRB5C5swxhyImuW5hF3WDfkDoq8Nigc8XjWR3418OYRKZrCDnjV
         7U3Ur/LdBC85EG3y6A3C1Vu1nAh7COYeqq5SG5vO93bmNJ06zvlXbv3aSqGTHVeNIDdW
         u+qDa+wZGp4yN8YpkG9TQPf0uQcEXfceBOmNu/k5Kch54qSpTbV0/b5NBE7k7QUVKX6g
         NgEG9B9bHmqPA69F5tzUQ6k9DmjUB4fV1TCng0wqZLRHiRwVJMqyVfeBs3APwjvV42GI
         YNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQD+HDai7Q5CR/dG8a4vM+E9F2libihPB1l+ixu4cV0=;
        b=r1fOfUI9KC1//XgekV/Ray0S2gspcB+EXd3/NYC4b4ZbKLSem/AqvCfAgVEKAonQHU
         Q5SusPkhEtVymwAAjaw225SfQyfdJUcjI0RtdrsZJlIlnAOTtI/7gOvdAGE9wQ9n637s
         inV4LiRCx0+rIr9IKWd1mpiGhWs1kKH/HrC7Zq2q4TGkiTJhGeN2WPq/NU0OPswb27HT
         6zn4dC5SIvugzcGHUMFJ+6DvBcep2uV9c6zY7Yp5NtfOVQ4dWuHPMmbNBTjY000HhC6u
         ty9TQHx+4whTznSCoofyvAO4f03vd3xyoTHiKXn0rOAWDk1/zXzbJlgd9TQTeVJbLb+L
         GPEg==
X-Gm-Message-State: AOAM533mwX2oFG4EwK70OqIK3SGQFQuZktlxAos+iWVGwmWHJ3xtCFTJ
        Tj8Pvbz/7LpLijEukRLLSXrNigRQSnX/4Q==
X-Google-Smtp-Source: ABdhPJw5tmy2863Xy8I/MqFdHNIIKt6RQTuaXSuAWXWMnq8J1ySefg+fqyID2sPRxlNpoL1jWa3Oug==
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr31509199pju.80.1593717891493;
        Thu, 02 Jul 2020 12:24:51 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.244])
        by smtp.gmail.com with ESMTPSA id c2sm9266739pgk.77.2020.07.02.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:24:50 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] submodule: rename helper functions to avoid ambiguity
Date:   Fri,  3 Jul 2020 00:54:07 +0530
Message-Id: <20200702192409.21865-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper functions: show_submodule_summary(),
prepare_submodule_summary() and print_submodule_summary() are used by
the builtin_diff() function in diff.c to generate a summary of
submodules in the context of a diff. Functions with similar names are to
be introduced in the upcoming port of submodule's summary subcommand.

So, rename the helper functions to '*_diff_submodule_summary()' to avoid
ambiguity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 diff.c      |  2 +-
 submodule.c | 10 +++++-----
 submodule.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index d24aaa3047..4a2c631c37 100644
--- a/diff.c
+++ b/diff.c
@@ -3429,7 +3429,7 @@ static void builtin_diff(const char *name_a,
 	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
 	    (!one->mode || S_ISGITLINK(one->mode)) &&
 	    (!two->mode || S_ISGITLINK(two->mode))) {
-		show_submodule_summary(o, one->path ? one->path : two->path,
+		show_submodule_diff_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
 		return;
diff --git a/submodule.c b/submodule.c
index e2ef5698c8..097902ee67 100644
--- a/submodule.c
+++ b/submodule.c
@@ -438,7 +438,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	 */
 }
 
-static int prepare_submodule_summary(struct rev_info *rev, const char *path,
+static int prepare_submodule_diff_summary(struct rev_info *rev, const char *path,
 		struct commit *left, struct commit *right,
 		struct commit_list *merge_bases)
 {
@@ -459,7 +459,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
+static void print_submodule_diff_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
@@ -610,7 +610,7 @@ static void show_submodule_header(struct diff_options *o,
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(struct diff_options *o, const char *path,
+void show_submodule_diff_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
@@ -632,12 +632,12 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 
 	/* Treat revision walker failure the same as missing commits */
-	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
+	if (prepare_submodule_diff_summary(&rev, path, left, right, merge_bases)) {
 		diff_emit_submodule_error(o, "(revision walker failed)\n");
 		goto out;
 	}
 
-	print_submodule_summary(sub, &rev, o);
+	print_submodule_diff_summary(sub, &rev, o);
 
 out:
 	if (merge_bases)
diff --git a/submodule.h b/submodule.h
index 4dad649f94..22db9e1832 100644
--- a/submodule.h
+++ b/submodule.h
@@ -69,7 +69,7 @@ int parse_submodule_update_strategy(const char *value,
 				    struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *, const char *);
-void show_submodule_summary(struct diff_options *o, const char *path,
+void show_submodule_diff_summary(struct diff_options *o, const char *path,
 			    struct object_id *one, struct object_id *two,
 			    unsigned dirty_submodule);
 void show_submodule_inline_diff(struct diff_options *o, const char *path,
-- 
2.27.0

