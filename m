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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79885C433F2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586046196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhC1NQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhC1NQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B83C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so5305304wmi.3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6TE3wc7OY6ofCSMD5RZKu2noK0DkRNhEq0/4vXIRws=;
        b=P5cOHglmZl0zDfZphWfpJYrGShoJG9QRImLHuodnAspFOvDzej0zzFYLvQzBvd03fO
         nOeCNv3egjAUOWIrvSuu2jL1u6AgJN6U5nQyQZwEpQ1Hz3hPxkisXNBn5oAYdhT+hs4H
         hOPxkmsxDEtqBvkG6c3Otpvx0GsZcKFH+wuq7ZOc8kNxj21LD6+GKLFuzK+QkL9lNnP6
         r9yUAre6FuZHDKUzWOhLFvVA8THe8eyxYvwzHDvqAC0EO0jhLHiQlWho4QYtZXJ1x6b5
         RYJtkc7GTivhYVXKxUSXxbqbM6y5MpJsYW6zGTICg7HhLNMkshtuh7y+19n0KMjkJSDJ
         urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6TE3wc7OY6ofCSMD5RZKu2noK0DkRNhEq0/4vXIRws=;
        b=Ak5B6m5QzK8okleD6nSt357hgzTdeAbV6sk7hneYL/n9IVpQ6PWV/e0KxODptvpgol
         Riett+qRfvO1XkgE8FlKrbhrqoTgJS3IQXbGAPEKqk4TJ1FX2GSocDDhCVZNMEczljB5
         xAfJ/mNq7SmBFS7wOPN9Y51lsmoXBX9TNXO9LkdkZhWH8S4O0BHp2BpmGin/ibvRvW9b
         z6yaFX00IflfNfXTl5okYGWXVN3nK/TvaHrxlgC1bmCs0m0VdDggpTdaZK2ciFX0Y/tr
         XNvpFrZNYWwLfAjcvuwBq5hcA1xvHxZwqQrl16tifO2nWYBuaIcskVZAetoYPhswq5CT
         gSpA==
X-Gm-Message-State: AOAM532G+tKy6x/SJcas5m5DX1QVfZ1QY8iNDlHUgY3potSPUw/sFwvG
        0VgfJmyhlL0ESrcXZEisEgFKykDiRktukg==
X-Google-Smtp-Source: ABdhPJy4CoomwjaAleIh6Ta4IGikLlsXrj/tmCtwIpnuZbMT55Avz2OZ5JTWzj8nSqUDlALuR5+LvA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr21358072wme.114.1616937366806;
        Sun, 28 Mar 2021 06:16:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 15/19] fsck.c: add an fsck_set_msg_type() API that takes enums
Date:   Sun, 28 Mar 2021 15:15:47 +0200
Message-Id: <patch-15.20-5e504f25c51-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index 96e63bc772a..dddcccdd368 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -88,7 +88,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 		die_errno(_("could not read from stdin"));
 
 	fsck_options.error_func = mktag_fsck_error_func;
-	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
+	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
+				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
 	git_config(git_fsck_config, &fsck_options);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
diff --git a/fsck.c b/fsck.c
index 23a77fe2e0f..a59832a1650 100644
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
index fa2d4955ab3..d284bac3614 100644
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
2.31.1.445.g087790d4945

