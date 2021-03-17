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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06675C43381
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB54564F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhCQSV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhCQSVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5CCC06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so2853272wrn.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vo6qKEfgTN4WCdQ/POanr/8yE9eXgo9vYyLOSdibKJE=;
        b=dRSwWtEqYMoxeoYQHk8ZTWakrJrdC3WPNJyuws3Fn+K+IIZnLzeal5iPo9C9Jxb0FE
         t/OwH7HPZTjcsZWcLS3vSKqjNoHJ8Gec9f38RUfOjP8HxFSy59Pgei0uQ7EfMTDP9dFE
         7rfm5zmTnPGD5p1FRZcY9JF9Q5BgJvQ6tbMYA+sfEnK8sUCGoW4IPFF9T4E9fW3z+L+F
         fxfUjBZOk9r8Aj759X5FLILg0J0OeoGe4lYFsMyUO/QYWXL+gjIFRtUN4wE8WGT7+O2i
         lVf28NvXRMd2ia6JW2RdYl9nTLvL8mrzRThhIWIHvjhbCAqb3Kup1EO/zphtAu2i/p1U
         9Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vo6qKEfgTN4WCdQ/POanr/8yE9eXgo9vYyLOSdibKJE=;
        b=II8LduC/AqXllKWwa35cKs97nm2DKD919Z6L/N8ntiHY0UdfNZMtuHvph6edO5RUhL
         MGLsKaEapC46ISVn93gObqBubwu4wDvhcSCQFLj8PDY+/zDAYoZC6PjBsCQwmLoBs6mH
         y98rDN0FMPoNhimhcBiaOJZ017Pu3R2b+ZhSpmpMGYMP4AMPDBcxmn3jmhvdMmgszzbc
         dd14bw5ajZexwMF9CxQVSjIWzauqvIs8IYk6VlR3xv6q/YQO8mEefl+XXYBOI+hO5aqj
         Bp5tQoXST3pMyZNxmrOXEyLGUFXcJJGYP081VsBvO0YJ5IY2/gm40XLfy/8ltLWxdsKS
         hrGg==
X-Gm-Message-State: AOAM532LYxYGJu2Xr9xLlMkJXn47WY3Z1yf4htazNul22ewtI5GHHbJx
        fH0wJTTA8/JptDU9im94f0PGkoMN/2JaRw==
X-Google-Smtp-Source: ABdhPJzrMJpYCv56aypgp+yeXRsnDYVam/akH3aepyN8QZA4pQINgQQ3pIOGckeUtBgxsv9DVSPmwg==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr5827909wrp.112.1616005282436;
        Wed, 17 Mar 2021 11:21:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/19] fsck.c: add an fsck_set_msg_type() API that takes enums
Date:   Wed, 17 Mar 2021 19:20:50 +0100
Message-Id: <20210317182054.5986-16-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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
index 96e63bc772..dddcccdd36 100644
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
index 01b2724ac0..307d454d92 100644
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
index 80b1984f34..344c3ddc74 100644
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

