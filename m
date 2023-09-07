Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02EEC8743
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjIGRZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbjIGRZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1DCB2
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:24:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so12980595e9.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694107435; x=1694712235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjOFbkb8q2Pa07AlZR+/OvQvqJ19nYTd8Je4qQv9qCw=;
        b=WQWuiBf1aWYmtP/0jB6wjuCPE3hhZMg4GKDMHA+X+uwggcyoKf/DJH4NGpq6BSONY9
         MGz1Jna7YE3aCKA+12JqScok0/Z687kOyEw+EByEIc8bT7jw2EgqqP6q/p1arQYSFFD2
         SOR5dPAh2dZ1tnLfzUfwexPu4tI4DYmczM6thxiE1OH/Y8cSg5NZucPYZE2SJuvT1VHI
         0DsRqbvFBCW4PLraaJ0ofwKIU3Qd005nN0yzPVL7UG5NyQnoLmU2D0UOZ5M+xu2wYJ8C
         KFbplM9RdiMdCJaRxo8X+nEwDcObwJBg8dDc0hT9hpWF43YeOSMPUVJfZ58rnysI0kaG
         WgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107435; x=1694712235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjOFbkb8q2Pa07AlZR+/OvQvqJ19nYTd8Je4qQv9qCw=;
        b=NW6KnzTuSpybY0r2iVCkAhAnCSctBx0gL8FG8IbRTw9J2RvWelF8cFaEoapRQTt4J6
         qEfzIE1vj2fqnzs3VqiiM7GraobRYfL62HjcIVfFnzmtQoJBvY+sWQBQpOLTzD38DZNj
         EEcuupYYe1CHT/957f7JVJGt9eKaZDWeoVRZg1jkeNfLVKRrnl+FAqU1g1//LluSleoz
         t+BWHe0rH8V/2JKqRlYW9nnqlxE/UUqCGkkF/spaxRed2TmVtxxW7FcH3n5vPP9A4Bw1
         uWYbAC3Wmg+lYEeA3SnSKN6igIx1g1c2TGOKAaaovUDTpsBJRPZeRNUvT1kSKl2rJ/ro
         fqrA==
X-Gm-Message-State: AOJu0Ywjp+mslm07/m/4HkTVcyqC3LHtqLPpE/Y5WtL49XZMoYeMB3G9
        ACEP4x1+IXzFDqTnbeLaHZf3i7XSR2I=
X-Google-Smtp-Source: AGHT+IG8qtmtLWzncUEP6VB60JOkNOm53TZHbuT/QO6ux7SLyyCgfY1QVvK9SKN54iHqdppEK0cQ5Q==
X-Received: by 2002:a5d:4a4d:0:b0:317:5eb8:b1c4 with SMTP id v13-20020a5d4a4d000000b003175eb8b1c4mr4311103wrs.2.1694078889596;
        Thu, 07 Sep 2023 02:28:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:28:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 09/15] replay: remove HEAD related sanity check
Date:   Thu,  7 Sep 2023 11:25:15 +0200
Message-ID: <20230907092521.733746-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want replay to be a command that can be used on the server side on
any branch, not just the current one, so we are going to stop updating
HEAD in a future commit.

A "sanity check" that makes sure we are replaying the current branch
doesn't make sense anymore. Let's remove it.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index b5c854c686..a2636fbdcc 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -123,7 +123,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -162,11 +161,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	/* Sanity check */
-	if (repo_get_oid(the_repository, "HEAD", &head))
-		die(_("Cannot read HEAD"));
-	assert(oideq(&onto->object.oid, &head));
-
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
@@ -238,7 +232,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
-- 
2.42.0.126.gcf8c984877

