Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E8C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLOJ7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLOJ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:59:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48911193EB
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m19so13327186wms.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNXD1TmzXUDz5bUNux6HcT6l24jtDGfKq7GTpKAGU2Y=;
        b=LeCeq1IE4lyc6xsemcqmXRdq4kTLjSjnaI02FOHsbKaDKWb0ve0GIuqridU0eAUjPZ
         V8o7qAgKnrQ12NMmIMks1ZWcRofpMJ3OzB16M992I2jGyB9vU7PDdmXRmG0JFIp1etkM
         YekDeagXNxP/8ajV3V4kJqlZBZy/6qRHDTll5LeFIWVRFOKLnQQFf/iJs/c2VJ1yxOw1
         OI665okFAY+YYFZvHMrv/44aREWZgrc9b+2zjJw/gZjtrIbec1CZYmir/0pGjrnczjLE
         kq+Q6mIqUUUbt+Wt+hCCmyNwk+xeEEZ9Cctdy0HBVvyMqc9aE2T3SJWVhJg6qbYEDHVV
         tW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNXD1TmzXUDz5bUNux6HcT6l24jtDGfKq7GTpKAGU2Y=;
        b=jnOfzyDYsdoEvKxv/HhKrmzuvRbvgdAoT0QGN2QC7mQWQTzpSyoXQtz0dZu936HGpP
         HPQb8Y9nAX3ZCJxgSxbqygvgwwR/a5PAWRiT0yBVkhRsgIjGygcZ7+c6kmPdsNNfzFyu
         g8wneRidBJNKDisGuBCqmDsXSI4jp6bXrki0a+V3D19FfsTcSqTDkPJjdpajlzmtyh5L
         gnmBh/F8S07SwBkKIjG1lmBFCI8w7KcVXVVPdu8aFbeGa7/X7ukXkVzAMrkcl9H6cF7n
         qlt7jZf6DCgRsQdt55/C3kDVq4tG1qy+2MYjUfBa8of4QMUuqkWh0epHzXOpWw51Cvfa
         7l/g==
X-Gm-Message-State: ANoB5plZkaw7fcle3yR76rYWzB6t+md9fIr8u1uRjQstx/UaiOMuBiTz
        rBSvSuEwki/MS7a3DcNtQ6Ka3Jxv8nLQag==
X-Google-Smtp-Source: AA0mqf5mbnUPMQliJMZNn6SRF8hPKnS9tL3TcgIMYVz1S90I8K1Jir21EeS8QXJZv6Y1pmAjyvx9pA==
X-Received: by 2002:a05:600c:6899:b0:3d1:cfcb:7d19 with SMTP id fn25-20020a05600c689900b003d1cfcb7d19mr28814810wmb.32.1671098350493;
        Thu, 15 Dec 2022 01:59:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b00228cbac7a25sm5495948wrn.64.2022.12.15.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:59:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] cocci & cache.h: fully apply "active_nr" part of index-compatibility
Date:   Thu, 15 Dec 2022 10:59:01 +0100
Message-Id: <patch-2.6-03c6e404367-20221215T095335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the "active_nr" part of "index-compatibility.pending.cocci",
which was left out in [1] due to an in-flight conflict. As of [2] the
topic we conflicted with has been merged to "master", so we can fully
apply this rule.

1. dc594180d9e (cocci & cache.h: apply variable section of "pending"
   index-compatibility, 2022-11-19)
2. 9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                             |  2 +-
 cache.h                                      |  2 --
 contrib/coccinelle/index-compatibility.cocci | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 44b763d7cd0..57a95123dff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -991,7 +991,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!active_nr) {
+		if (!the_index.cache_nr) {
 			discard_cache();
 			if (read_cache() < 0)
 				die(_("Cannot read index"));
diff --git a/cache.h b/cache.h
index 07d40b0964b..9de988574e0 100644
--- a/cache.h
+++ b/cache.h
@@ -438,8 +438,6 @@ extern struct index_state the_index;
 
 #ifndef USE_THE_INDEX_VARIABLE
 #ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
-#define active_nr (the_index.cache_nr)
-
 #define read_cache() repo_read_index(the_repository)
 #define discard_cache() discard_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 8520f03128a..028ff53354a 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -1,6 +1,7 @@
 // the_index.* variables
 @@
 identifier AC = active_cache;
+identifier AN = active_nr;
 identifier ACC = active_cache_changed;
 identifier ACT = active_cache_tree;
 @@
@@ -8,6 +9,9 @@ identifier ACT = active_cache_tree;
 - AC
 + the_index.cache
 |
+- AN
++ the_index.cache_nr
+|
 - ACC
 + the_index.cache_changed
 |
@@ -15,15 +19,6 @@ identifier ACT = active_cache_tree;
 + the_index.cache_tree
 )
 
-@@
-identifier AN = active_nr;
-identifier f != prepare_to_commit;
-@@
-  f(...) {<...
-- AN
-+ the_index.cache_nr
-  ...>}
-
 // "the_repository" simple cases
 @@
 @@
-- 
2.39.0.rc2.1048.g0e5493b8d5b

