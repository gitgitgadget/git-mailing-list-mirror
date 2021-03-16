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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B3C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1716511D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhCPQS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbhCPQSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E158C061765
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1803894wmj.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLLS+orsKOB3Y7zGkEJaBeqB437/baKQ+ohkELuntd8=;
        b=Zk60pncaxzq2IxJF0yYUMyE0MsfMo4cj5dunB1d+VWLiG9WzevCs7Dbp+xby0CryFy
         qXY27jv860JE6imoFmrvFIE2/+UiTOs6XlVmOCJJ9CkJwaoPn1xR5D07xW1Uhhv9QKtT
         VMITr1kDQsvqKikTDAhwJfyj9HnCFJU6W3BjArY8mdtU9ybStGl0GtAs2Gyguua+96Md
         M1IUNPgrBPGEdqhqTupdbgjBFq8cr+tfX7YpmxsEvFrnxXi+L45vhTW0RETzKn9Y90Lc
         kdzkhLiCYkrbk6ZgAnVH8Y594Ix08zCqDMeldMJlTm3OPV9STJBDlg4sOy5SNiZUuCyt
         cL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLLS+orsKOB3Y7zGkEJaBeqB437/baKQ+ohkELuntd8=;
        b=EvVWfU7EtU3vFRgpKKcoB8Cx3THyNu2CAljxrOp7D1pKDQnN+zLFUHpx/rESBL0Vu+
         bBCGbNK4PbOaw8+JBXVl424SXa+2P1AjbJ7RqG/A2Eai9d/sGa8qnG7tQ4xV4qP2P9sn
         au+mgx3RHB0r0BySrUuJ1rdDCQllyI7mla/w/9QB76a4yn+DP9rH9L8qU5ccBcbL17Gq
         vnsLgf2lRUYXLExegRDxZPfud4GdfnegD4puKyDjFocpULa5aGFnwHgM2Wg/MdDnGfM1
         KbmeYh7Yv8mF6tUHvvIXKq3F/i2lKPOje7GutDVBSm3bMOvyMi3W/nwA/x0Mooo1pVsZ
         R52A==
X-Gm-Message-State: AOAM530UY6G/spT01ZwvNUiy2ZiDVVbJevYfttvTxg10qSYK3qiJobRE
        zvFN6HsVYc3X33yZ0z/HSVWOBqL3lhn5nQ==
X-Google-Smtp-Source: ABdhPJxHSf9yq300XaptPz9FanHT9MeCdEagAqcjHFllUVgrzKhsI2JVuMFho8dbzUX/ET5V9b+0Uw==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr34191wmj.34.1615911489513;
        Tue, 16 Mar 2021 09:18:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 18/22] fsck.c: add an fsck_set_msg_type() API that takes enums
Date:   Tue, 16 Mar 2021 17:17:34 +0100
Message-Id: <20210316161738.30254-19-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code I added in acf9de4c94e (mktag: use fsck instead of custom
verify_tag(), 2021-01-05) to make use of a new API function that takes
the fsck_msg_{id,type} types, instead of arbitrary strings that
we'll (hopefully) parse into those types.

At the time that the fsck_set_msg_type() API was introduced in
0282f4dced0 (fsck: offer a function to demote fsck errors to warnings,
2015-06-22) it was only intended to be used to parse user-supplied
data.

For things that are purely internal to the C code it makes sense to
have the compiler check these arguments, and to skip the sanity
checking of the data in fsck_set_msg_type() which is redundant to
checks we get from the compiler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c |  3 ++-
 fsck.c          | 27 +++++++++++++++++----------
 fsck.h          |  3 +++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index dc989c356f..de67a94f24 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -93,7 +93,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 		die_errno(_("could not read from stdin"));
 
 	fsck_options.error_func = mktag_fsck_error_func;
-	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
+	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
+				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
 	git_config(mktag_config, NULL);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
diff --git a/fsck.c b/fsck.c
index 5a040eb4fd..f26f47b2a1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -132,6 +132,22 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 	return 1;
 }
 
+void fsck_set_msg_type_from_ids(struct fsck_options *options,
+				enum fsck_msg_id msg_id,
+				enum fsck_msg_type msg_type)
+{
+	if (!options->msg_type) {
+		int i;
+		enum fsck_msg_type *severity;
+		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
+		for (i = 0; i < FSCK_MSG_MAX; i++)
+			severity[i] = fsck_msg_type(i, options);
+		options->msg_type = severity;
+	}
+
+	options->msg_type[msg_id] = msg_type;
+}
+
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
@@ -144,16 +160,7 @@ void fsck_set_msg_type(struct fsck_options *options,
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
-	if (!options->msg_type) {
-		int i;
-		enum fsck_msg_type *severity;
-		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
-		for (i = 0; i < FSCK_MSG_MAX; i++)
-			severity[i] = fsck_msg_type(i, options);
-		options->msg_type = severity;
-	}
-
-	options->msg_type[msg_id] = msg_type;
+	fsck_set_msg_type_from_ids(options, msg_id, msg_type);
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
diff --git a/fsck.h b/fsck.h
index 33ecf3f3f1..6c2fd9c5cc 100644
--- a/fsck.h
+++ b/fsck.h
@@ -82,6 +82,9 @@ enum fsck_msg_id {
 struct fsck_options;
 struct object;
 
+void fsck_set_msg_type_from_ids(struct fsck_options *options,
+				enum fsck_msg_id msg_id,
+				enum fsck_msg_type msg_type);
 void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
-- 
2.31.0.260.g719c683c1d

