Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD7C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9376123119
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN99vrOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgHFQsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgHFQmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A42C0A893C
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:41:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so27904820ply.11
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7u8wQpZMhwP7ijYPwyMtvsLyxsB0vZqqLb+xJfG2DA=;
        b=KN99vrODF+YwX5xlAL8iyJjW7bYgjJTnWN0Hh/fGAOPuDqrYSvc3JNYnSo+B0RcPPh
         AO9AQtMeD8xX9rAQsxwiD13oCZWxSdvSQFGqZ3tTmrAYOwMTrwvI1XajjTsCSfACLH28
         ZRim6MpY8QEhLP9JCI5HFPPb/fugf+rPRTx6xi4Z4BlUydXYlqBBx47tzi/dhS42JvbC
         iWC+UfV28KBLVXw+/7HIONmVB0M03Nng6hY0rv6DtEpOGgn2kkDN4bNmrJR3G1m8/N+H
         ZOOlzBEbRjAPwISWURzJ+axEVWSmzhktkI5DL35dubQcRD0x4rPKBRijADRC68ppu+3U
         u+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7u8wQpZMhwP7ijYPwyMtvsLyxsB0vZqqLb+xJfG2DA=;
        b=DME3D86OtHP52aaEObclvSNBOA1JehgdG1KwKVvuLYX3kI7cxJf94nlfLU6+vpL0/2
         U6qlLZsGmRarb/ma6+CNz4nA0ovzxJnZJ3LtY6/d5AzoonMWk9UCQkjndd+BapLJcaH9
         DZPZprlsLtyOZTgiOqE3X62V5BOhKgbk8A/+FOZezLQCGCY8hm6jw+svk3jjB9VF+Rb2
         PDyUkpRWW6sMQoP4HH2Kab9t09/YIE8sBREGN2to4pr2U6vnKO9Lx0xKDWrvzgkJ3+nM
         kRRs7M551iqtyfm02F3dqyPtZHYDxsPkrKx6Wpe0ZB1CImt4wJRydeshdRpNXRzO0IiM
         qDjA==
X-Gm-Message-State: AOAM530LQgAhtQ5aqcRT06GsjFuhMucct6EO23uUpbrJn5hrwUh2npeU
        jjV91FtAPOTOyyLMOqUbrgI7xWLHZ8I=
X-Google-Smtp-Source: ABdhPJyt+eCsTGazwom3frf5jIOvAxZuzcXpOx+SfipoVJrvAhLzQ9QouLsQe26Fq3xoS/RQkz568A==
X-Received: by 2002:a17:902:7b82:: with SMTP id w2mr8883173pll.39.1596732085500;
        Thu, 06 Aug 2020 09:41:25 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id w16sm8008381pjd.50.2020.08.06.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:41:24 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] submodule: rename helper functions to avoid ambiguity
Date:   Thu,  6 Aug 2020 22:11:00 +0530
Message-Id: <20200806164102.6707-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
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
2.28.0

