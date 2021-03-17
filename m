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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13352C4332E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB4E64F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhCQSV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhCQSVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B99C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so2832979wrt.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dj4R1z5WjejkTK819mL17+k5twm4kg36VHwxL48S7i4=;
        b=KSfVYCiciRYxlPSx8k7OlZf9wjAlxz3adlBduV308N08OjVhoSmCrhBoKhLoK5jrTR
         Kk3OuT69qDx/qZz4rgishg43ec8q7nhp5f3TYQOKu6QWNsUTbVFOe/Rfcj/1dgppu2UB
         1HPxJVsIGUSygdEjbxrRdT52spAmh5NCwpu9W8nkJ46cW1wuO6X1vFyZ2Yu2CZD/+s8y
         28Qyo81Eb5Ou4JWtNO1WvCF6xCV0wES5oUdIgbtbsfS1qIshsfPb17Ira8DX6H0NDQQM
         GYfJmoegfUR81WvFLpt3nuqAHA3L6EpWLBC0cy5qhkeeDbDKiVRCMwLRrAlaBhiyCZe3
         Jvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dj4R1z5WjejkTK819mL17+k5twm4kg36VHwxL48S7i4=;
        b=ugG4r4v0oX4NpyZPW1LtESk0F89wwV3zi1AeJgUz4M+1Npu7j1QXBAMDo/8dmuhy0q
         VGa1tSsy7o87Dx9rDwzh0mHlBcbTzz5ZSSY1ss9rgSuir8ze2r6SHpYGWtCWQfSOmnSt
         BJ/5S6cIGGelyqrCW5Z9bPY4qSiw69n+tPkcCSvMedc1Qv0VwoXndFF++F/Nq1rjPU2M
         UDf4mM2BTwWeM1I5i3pN4nmBB1Yc35u8pbhv2Z5HFsQPcjukalPyWLBMWuYRZKSYBo7+
         LxfYunDJ4e/Q5MCXFVxsnq8Agzmmc9HUebRnExf5n0O0t629BmcZQqz3E1GoBlKMbbHR
         GRnw==
X-Gm-Message-State: AOAM533EnzJXwxmFBursTNwEIBk8QWsM91zt9+FCrwCJYMYUYo/dJJgP
        1PLkWTme5S3NRbqvygQVJEwXPZ1Qbdd9EA==
X-Google-Smtp-Source: ABdhPJxOs+KrOMBzm1PtqibNqPAyHuX/KtdN8YnEctUWbNqVoxYDrmjG4g9io4ZaTghBd8s2tUGjVA==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5745236wru.214.1616005273801;
        Wed, 17 Mar 2021 11:21:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/19] fsck.c: rename variables in fsck_set_msg_type() for less confusion
Date:   Wed, 17 Mar 2021 19:20:39 +0100
Message-Id: <20210317182054.5986-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename variables in a function added in 0282f4dced0 (fsck: offer a
function to demote fsck errors to warnings, 2015-06-22).

It was needlessly confusing that it took a "msg_type" argument, but
then later declared another "msg_type" of a different type.

Let's rename that to "severity", and rename "id" to "msg_id" and
"msg_id" to "msg_id_str" etc. This will make a follow-up change
smaller.

While I'm at it properly indent the fsck_set_msg_type() argument list.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 24 ++++++++++++------------
 fsck.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index 5dfb99665a..7cc722a25c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,27 +203,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 }
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type)
+		       const char *msg_id_str, const char *msg_type_str)
 {
-	int id = parse_msg_id(msg_id), type;
+	int msg_id = parse_msg_id(msg_id_str), msg_type;
 
-	if (id < 0)
-		die("Unhandled message id: %s", msg_id);
-	type = parse_msg_type(msg_type);
+	if (msg_id < 0)
+		die("Unhandled message id: %s", msg_id_str);
+	msg_type = parse_msg_type(msg_type_str);
 
-	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
-		die("Cannot demote %s to %s", msg_id, msg_type);
+	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
+		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
 	if (!options->msg_type) {
 		int i;
-		int *msg_type;
-		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
+		int *severity;
+		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			msg_type[i] = fsck_msg_type(i, options);
-		options->msg_type = msg_type;
+			severity[i] = fsck_msg_type(i, options);
+		options->msg_type = severity;
 	}
 
-	options->msg_type[id] = type;
+	options->msg_type[msg_id] = msg_type;
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
diff --git a/fsck.h b/fsck.h
index e3edaff8e7..12ff99b56e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -11,7 +11,7 @@ struct fsck_options;
 struct object;
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type);
+		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
-- 
2.31.0.260.g719c683c1d

