Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C968C43619
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189406503A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFLFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCFLFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5CFC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so826753wmj.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRWoV/+h5pPWadif3wMm5bfmuMMKe1qbLrvHaSNO0gc=;
        b=apIynBFsWO8JkF2RrqyXuzfVLj383DLfASpKafk/QHu+gkyRS0oY5kSfHkfzPeZkzM
         /9xoFJoECPp0w74+eCqq35VZPnpVn/usvLpsDcJy+HPPB8kytYvBHQ1weUoqyEfxi+8/
         6nD10TVLUd9dessJTjT6EwN9honzCytZNvq8r+UmuHldIGEHm/csn92qQunmdJg4TgKn
         zBlu45mj6asQLFNdRAj1FMHpx/FZXrsOHzo9JERwIgQgNIqaZlbxE4Ym5/Aj4jS4pb/H
         vSn3d896MB4OSGEKDCb9nDPUAwvtGMEFSxv/Np3sGKJPORj7IrZ5nuYNthceIF1j0MPG
         o+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRWoV/+h5pPWadif3wMm5bfmuMMKe1qbLrvHaSNO0gc=;
        b=at1BAWB2lC9a1BSE62MNe5L05ViGNJ2rDeMApUtZoiuPWoVzqOGIQC+0ZgJF93SPIa
         O51Dke2eSvpv9fBWS61wkt3O+MITkce8Skn9q4LhXbxAB0yRtZU+GQ6TpKkNzOKcmcqP
         COIbLWulR6cJMF/VW6kH6BP3mgjaszM0qsogvE9bQtug5jHgR/rAqLkVMk/zYKKV3lYM
         HHIrsyiKCjvcEj6Lpm1qc+o2IAM7ZJ4I8syChrrDHb8E3bZMFBzqVovopbU63CiBLKGf
         tANyEFqw6CjH0NJjHCGi6FkS1vpPWHjSB6wYkq7Nxu9+Y4yol2qS/2OZ2Okj71itm7QB
         MJzQ==
X-Gm-Message-State: AOAM533G01ubDcKI5C5exF38A71UZuimFVvUYC7cf8GNwa//oibl24Ea
        Rjl6rudtH+QK2RiEEvA2dAHUJUFvUXNErg==
X-Google-Smtp-Source: ABdhPJz2AEMxAVJzEYYP1TlCKJuxkYiBEDsbFIBpBIHU7QDOIk8kqOV2z8rfsMWPac58Kv3+EfTlcg==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr12877484wmb.20.1615028706592;
        Sat, 06 Mar 2021 03:05:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/22] fsck.c: add an fsck_set_msg_type() API that takes enums
Date:   Sat,  6 Mar 2021 12:04:35 +0100
Message-Id: <20210306110439.27694-19-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
index dc989c356f5..de67a94f24e 100644
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
index 5a040eb4fd5..f26f47b2a10 100644
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
index 33ecf3f3f16..6c2fd9c5cc0 100644
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
2.31.0.rc0.126.g04f22c5b82

