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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A3C433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B09B6196E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhC1NQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhC1NP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:15:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4387C0613B4
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so5297610wmf.5
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vsw7inabgC0J2mp4mkdrnLJrzLAHMYdQHyg/Y/y764M=;
        b=JJ3TTB9EVgDYbaiJ+LUKXAUIEd7Z5RNJW3m7NGmQofqQgU8ioIFKmn/p2VVGtBpbgH
         duJLI4v5Am4CgAI/Oo6uloQpVIZtrBLCuEtI0B41zDVI1SwwknUTqxCb1/zTfQ+i4lYZ
         ya+9nJfr+ZaCffeAyGwk5KwHizl5zd/k1Ax/jhccOoZ0opW0ragaOi0aJIH55vtxRRFn
         eb5p+IFHaWToTGjD4trYNIkq/P0mLY4SFiozgebP3jZA6yM3VGBoFnE1MSEMfvlwXo/9
         qxYy8rTFHGzSTWDPjG6npwhkENYKXPGAU+hjfI0ic98dLeq4vvvZW6wa5xPvHLXdjVw6
         yOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vsw7inabgC0J2mp4mkdrnLJrzLAHMYdQHyg/Y/y764M=;
        b=DILynph+gtnq/CL+1OL7WO7/IgbrtRP0SbKaNaoYHy+nm0QNkh2W97laspN84cSuft
         QSKRKspog5yiy5nbnFYD6x4nGtkd0yaNkFMC36RpL11R+HOWCFJrIoQBcgOmsE7FhaSa
         vWkUlkK0f/1lVAxSwRvJ8L5rV5fsLhxV6ROy5ApAQaXUE1Yz8P9zm34MdVEQ5dw2pmLs
         OUZMaxpe04QUvyu5dMJs/ikGx0qm2ZfuCTKePoNlQwk9hlfN0/2krPYe7vcfnokd1yrP
         uOOPJBWxV/2yUjI9vXCUaJnMWpIo0B92+koelVlccVa6iGF+kAGqfacaje0pahG68ZBb
         jczA==
X-Gm-Message-State: AOAM533Yxj5deeV64HBuLKwsfJWmV9iDbIMncUK+7LXMdMK3JH6/TG5s
        2ZYqna5ajZOpR9cP+shzKd2f/jt1t9x9hg==
X-Google-Smtp-Source: ABdhPJxMT4DzOUHZ6UwePjDHL07wBA8E/JdUePuw1d7gvUoIrlqJ2SWKzVG6+Dh/mUqnGIXUfLsXJw==
X-Received: by 2002:a1c:1f4c:: with SMTP id f73mr20795845wmf.25.1616937357273;
        Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/19] fsck.c: rename variables in fsck_set_msg_type() for less confusion
Date:   Sun, 28 Mar 2021 15:15:36 +0200
Message-Id: <patch-04.20-fcdba2f8fe8-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index 5dfb99665ae..7cc722a25cd 100644
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
index f20f1259e84..30a3acabc50 100644
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
2.31.1.445.g087790d4945

