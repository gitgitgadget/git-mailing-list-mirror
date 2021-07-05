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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337BC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA65613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGEMfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhGEMfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:14 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E932FC061762
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:37 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so6086714otp.8
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1UrZI1rrT1ek2lTooJMYLa96X2vgVPv+T6snNJbHyU=;
        b=G8vLUGIIcBv6aLPueZug1psrw04ZKgBLu5s2zpsTB2zotcKmI5Jv63f1Lfb4us84bR
         5rBFg80pWUxwYknv7pnwnBuKLjWSxkdcGvlcsRA8ms3czD0ZOK/qbm0A1jgvK79fg94d
         ij/44qs8Zdyr0Lz62PJbSNUD/w+5sQQzM75Y5GPE8Iqnv+MpaPuZ/vOCGQIERee+6nxD
         2yfeq+ifMJ6TdeQLHDxDJLJavTHZZ0hMsFudtGn7aGygxJhQgb3Zcz3TkRyJYTdQE7KS
         sCgGfMQ7zGzviFb3DS9NpZ3ahrQACQgI83qmNRrGalD+n1q1A3c/eESY7Q3/3Dxm7qbn
         7K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1UrZI1rrT1ek2lTooJMYLa96X2vgVPv+T6snNJbHyU=;
        b=UqMmAK0IpgSJrpZ4PvPo6TMQYykLZDN3SmiUq275kFV992ttmUr9oMOjLCXcGZ8eqj
         tA8tbyTYIo37hTenRtz5ed67/wPP4hAd9470iLcnU9nkWRDXSDmB6uyrdYb8L6yb1CmW
         +Q3R+Zvyp4EU8vhIopU5Kqtn/5J20JcTqRfjyDCIR5sH2snSa2Qh3bhAjLf7do3cRASh
         HLKBOG59X6HefyEkk+nbs3hfdfs1W2zChqCf1Re2ja17l5C9IEer0N/d4N/jW8d5BpD2
         LpmwwUEItT+K8fzzGT4z9hGTpSob5uUjsH512mVDb0pdYO9mPn8iOMwCqYWZqYRam2Ad
         2pwg==
X-Gm-Message-State: AOAM530gjZq1heDwSZBw/twgQIIRqDCWtkhy7KEcgLJpeOUqvlzFK36p
        0vET+mr6acnOMwCjRaamtY1gOor6lh9o0A==
X-Google-Smtp-Source: ABdhPJxfWFb4aW5PERFGCYcSyYmIq+YgtxMjreNyqqa5qNVUx5DrUXC694eHHqgltd5ROa86ryySjA==
X-Received: by 2002:a9d:609e:: with SMTP id m30mr10693562otj.168.1625488357134;
        Mon, 05 Jul 2021 05:32:37 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w15sm736662oie.21.2021.07.05.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 15/35] update: fake a reverse order of parents in message
Date:   Mon,  5 Jul 2021 07:31:49 -0500
Message-Id: <20210705123209.1808663-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c   |  1 +
 fmt-merge-msg.c   | 21 +++++++++++++++++++--
 fmt-merge-msg.h   |  3 ++-
 t/t5563-update.sh | 10 +++++++++-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b9c6c43d8f..cb476958ad 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1136,6 +1136,7 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 	opts.add_title = !have_message;
 	opts.shortlog_len = shortlog_len;
 	opts.credit_people = (0 < option_edit);
+	opts.reverse_parents = reverse_parents;
 
 	fmt_merge_msg(merge_names, merge_msg, &opts);
 	if (merge_msg->len)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 0f66818e0f..1f840711cc 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -432,6 +432,19 @@ static int dest_suppressed(const char *dest_branch)
 	return 0;
 }
 
+static void fmt_update_msg_title(struct strbuf *out, const char *current_branch)
+{
+	struct src_data *src_data;
+	strbuf_addf(out, "Merge branch '%s'", current_branch);
+	src_data = srcs.items[0].util;
+	if (src_data->branch.nr) {
+		const char *branch_name = src_data->branch.items[0].string;
+		if (!dest_suppressed(branch_name))
+			strbuf_addf(out, " into %s", branch_name);
+	}
+	strbuf_addch(out, '\n');
+}
+
 static void fmt_merge_msg_title(struct strbuf *out,
 				const char *current_branch)
 {
@@ -665,8 +678,12 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			die("error in line %d: %.*s", i, len, p);
 	}
 
-	if (opts->add_title && srcs.nr)
-		fmt_merge_msg_title(out, current_branch);
+	if (opts->add_title && srcs.nr) {
+		if (opts->reverse_parents)
+			fmt_update_msg_title(out, current_branch);
+		else
+			fmt_merge_msg_title(out, current_branch);
+	}
 
 	if (origins.nr)
 		fmt_merge_msg_sigs(out);
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index f2ab0e0085..fbdb1c905e 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -7,7 +7,8 @@
 
 struct fmt_merge_msg_opts {
 	unsigned add_title:1,
-		credit_people:1;
+		credit_people:1,
+		reverse_parents:1;
 	int shortlog_len;
 };
 
diff --git a/t/t5563-update.sh b/t/t5563-update.sh
index 72d6a357a1..aabbf5a965 100755
--- a/t/t5563-update.sh
+++ b/t/t5563-update.sh
@@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+check_msg () {
+	test "$2" != "master" && into=" into '$2'"
+	echo "Merge branch '$1'${into}" > expected
+	git log -1 --format=%s > actual &&
+	test_cmp expected actual
+}
+
 test_expect_success 'setup' '
 	echo one > file &&
 	git add file &&
@@ -55,7 +62,8 @@ test_expect_success 'git update non-fast-forward with merge' '
 	git reset --hard master &&
 	git update --merge &&
 	test_cmp_rev @^2 master &&
-	test_cmp_rev @^1 other
+	test_cmp_rev @^1 other &&
+	check_msg test other
 	)
 '
 
-- 
2.32.0.36.g70aac2b1aa

