Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166AAC77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjEIRyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjEIRyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D726140E4
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f423521b10so21037875e9.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654860; x=1686246860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1Ug5pY7c9XatsVwSnDcz/FuzbmeiRLBPIXjp8yq4xw=;
        b=lzFD910PQ6JJA735dpl8x2DI1eJ51EvMqalzeOUV2qIJFkoIErQ1gpDJiy9M8n1sEN
         oOdlOlrb1b0li4hJs/fc876G9/47DWnckmtpqO2h6rUmNiboWN9jRnIiE9pmPmY+ghfI
         R9BecSQ2wAo45GCAVOtEP8WVUlmoWoSEIkFOkfVEvGu7PmGlhlLysKKM7azHY3VdHAcR
         47ycBl2kMc7wb3lcXmAYQJGorqCHYcANhULB9DcDk18gzWxpTeDzGCMPUzyLVoUMpEkk
         0LSwVK5N+jbfNawVW1rEcQfd36Sd5BpL/GXouFgYdW0qPbZ6pG4slraoEzOnBrUSz6bj
         sw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654860; x=1686246860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1Ug5pY7c9XatsVwSnDcz/FuzbmeiRLBPIXjp8yq4xw=;
        b=cwL4iaaCfkB9Zzf0C10CC+f4SkFdsEAKkNyNqyDJ//hB9+My90u7/oZdJkOgcC3OEX
         ekzJQDmTgeW8eTMFLDy9VwnPGW56dUTmg3A4gfdwdsR4zL00zRwqSW5fKpxJoaETLWvh
         XdGaCr+D30QtDGxFzJfh9k8Lx3cK0O/qT0Kokchx9OybzkzBvXDyUNTUUUzYVrzS607X
         0XGyQinPqdtgLdhfoGj8MrLpYwbG3oeYBRq8k8OCIWFZ5bTrK+gCU7+Nfvt4cxRp8diG
         9aSPxnrM8U349/7/uATErRPzGXEEPWy80G9mcMk9rz5fcRSmOh+eUxroDvXOiGT3PO+W
         Ux/A==
X-Gm-Message-State: AC+VfDxmqRZI3UpsIONfHd3BsypzMk9RKap+z6uxwbdlADpWGbzC3Mj1
        cruiongNKNGGgU8wDwLfSQD5qAcywpQ=
X-Google-Smtp-Source: ACHHUZ75sBS2j8OsykV7RCwVeVEdbszQI/v8KA0IZW4eCmbh9XcVlJmiPnHPYzl9r4HRTXquwqbnRA==
X-Received: by 2002:a05:600c:2119:b0:3f4:2c71:b9b1 with SMTP id u25-20020a05600c211900b003f42c71b9b1mr1912451wml.24.1683654859663;
        Tue, 09 May 2023 10:54:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:19 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/15] replay: remove progress and info output
Date:   Tue,  9 May 2023 19:53:40 +0200
Message-ID: <20230509175347.1714141-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index a9d88ac6df..ccbef6552a 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -193,7 +193,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -201,9 +201,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -222,7 +219,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -236,7 +232,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.40.1.491.gdff9a222ea

