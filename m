Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D1C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbjDGHZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbjDGHZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBBCA5E8
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso399467wmb.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1itwQJtJLYK1b9fii+eiwv2KZu14RsH9gKBV6iIaEB4=;
        b=IP6uyRgCZw4RwOsLVsCIbpyoRV6W/akW4V5kSawk32J9ZUV0baVCNsVnktIVZZibPh
         3cniAw6r3YExT7aCKvoWgRcev+7egXB+QwnMLZJex9OEj7xCECkdhU0snD7pCwPojVTL
         KaesmqGMxsJjCn6DITw9pqedzGb8lVCKi8mgsm1ZAHdR9N43iRVxOYLSkTVJlNA9/77y
         bwc1n6JPQmvRhlmO9vvgrYUAvB5mrflEYPqNqUkkCgn6NngZrymUitCFpK4sCxHkp/Oq
         smdP+zWAZmeJgtNt82LwM5lCXg8ukRjgi+WjFlBkdvvgssPAt8yVgxkO8AZgN4s/Qlr5
         CdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1itwQJtJLYK1b9fii+eiwv2KZu14RsH9gKBV6iIaEB4=;
        b=2KAhws3aapDOcslYPCfHRAIFN+m9hyFv2/TrZJcqchYVERo2gQblrbAETaZ6L1rV/0
         NQAEZRvQxB4SfU45xo2U11AFDEmq7vDePwdpsEbxR/Ztps6I6AaeYi2SSDe4ZmBLutYE
         1KRZYuIrrF6to2pDdrM8/3/dQfL7XV/fpX9/chMIBFTzS9OalQNkqWp9zwoonRe4LRqA
         MiwMWWn37bCifPQVluXsyEPNs0yrjrexIOMYzH+U3yba472taRQW+7D9gCxXenptdwPs
         ZUfeXQ+me6yBIdPGVCkGlmAOotm/+P/W3smBy3XTgthtP7adhoY/OcqRlp5sTx0PjmDw
         mrTA==
X-Gm-Message-State: AAQBX9d24eyzT14hGi4MLZYyQazJHH6lqo8VPy4MBSxqEltCCN/ii6sC
        YzWRh30LTpWMc5dizKykVEqe0BfOMzh2pw==
X-Google-Smtp-Source: AKy350b7m9gJzfLmbuIbOgNZX1vW8rtrdau+FRyvQxb+aBcVkwOJIH32/NzoMH/s7X3zpEtKfSkQig==
X-Received: by 2002:a7b:c018:0:b0:3ee:775:c573 with SMTP id c24-20020a7bc018000000b003ee0775c573mr579015wmb.20.1680852287217;
        Fri, 07 Apr 2023 00:24:47 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:46 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/14] replay: remove progress and info output
Date:   Fri,  7 Apr 2023 09:24:08 +0200
Message-Id: <20230407072415.1360068-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
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
index ffd7ce1fde..0a23ea70dc 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -186,7 +186,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = get_commit_tree(onto);
 	result.tree = head_tree;
@@ -194,9 +194,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -215,7 +212,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -232,7 +228,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		prime_cache_tree(the_repository, the_repository->index,
 				 result.tree);
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.40.0.228.gb2eb5bb98e

