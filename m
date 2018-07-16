Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D96C1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeGPRzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 13:55:44 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:42006 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPRzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 13:55:44 -0400
Received: by mail-qt0-f201.google.com with SMTP id f8-v6so41213270qth.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=QcEwbx9/c+omAqf00m7gqhCF0BW74QzABDxz4BNGHDU=;
        b=W/xGF4+kIKrbbmXoT28bqAU/c7thlBCfkC2Q7EsP5a4flzPRf1WVkbloVQA0X1KzT1
         3UWUE8/iKR9iFZZOUUQOkqst71NJfRNXIKCbjTZaJ6hxtlnyxjCfdrWAlQAxXFBJtjTE
         eBCX+hi3FHQZdXiZn1qWaMWnMNk2egyAcIslF+Mzt6fjbGrMatRnSTHT+zKgpbB/sQt3
         bwyXY0dw3Nt3XlXD2yLAmQgSs86QILfeqsokWtNLny5ENteKdD9LYHOGi75+TX4ddbzX
         tMea48vahL8Yqmd6DAKKSkZ8cA0tmaO6Wd4w/s+F5/5/xKuKdAvtfUtZRT09ONq+dlgn
         aFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=QcEwbx9/c+omAqf00m7gqhCF0BW74QzABDxz4BNGHDU=;
        b=VdZvUOA4yN9PIDiCWZNXn/Bc1KFocobKW5XVF01J7xwkRtBt/bOlnR45+jERFEPFNO
         5u9yg8iVKHw5ESkR3XiL7wg2OAw/WYe0ns44mgDsKzzH182l9rhZCb6yHIi2UzHWpg42
         oG6B9pSXTwbFp3tS+vSL7oYwic4HrtkHMthRzkOrICDU1BGcawdH2aIJq9t00RhPGEEd
         lHEnTNa+LnvkGBqUWT+k9I4ZhmeqSadS30g7Pc0/bSgIPY7X2Qb3TqZJ/7bzbJOf7K/o
         HYU5QBWi9kt0A6KWtHX11na9dY9pxvCD13srBSWDZCe7pZX/ahptwfyZGZfMFJ3fUPCY
         zUbA==
X-Gm-Message-State: AOUpUlF4cOgrYUIENCfhRtqeNWFbKpF/NUukjhFoZkPcSBc7sRJwRgZi
        vPWdzQNonD9lHAv4Y2Ub0hvh9Cv75FKYzm3HZCFWi0PMP3jogE+8/vUE8AA14kZxYgFqEcVTCsM
        jlywCq3rS5mZC8O6zVfPlCvvZuJluuL0xte9KwjsGosaWcc6QndPSKfEb/2kAL8S74Ec1jhH5MF
        iY
X-Google-Smtp-Source: AAOMgpd8GMdvgGVc5QD7vPvXUQimISTY/yIkQehjKoqrUfoWRR5DyWM/QOuPfNDbholFUqFDMGyTYxP+VH08IPikX3zt
MIME-Version: 1.0
X-Received: by 2002:ae9:ef44:: with SMTP id d65-v6mr10087931qkg.19.1531762040708;
 Mon, 16 Jul 2018 10:27:20 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:27:17 -0700
Message-Id: <20180716172717.237373-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] gc: do not warn about too many loose objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a087cc9819 ("git-gc --auto: protect ourselves from accumulated
cruft", 2007-09-17), the user was warned if there were too many
unreachable loose objects. This made sense at the time, because gc
couldn't prune them safely. But subsequently, git prune learned the
ability to not prune recently created loose objects, making pruning able
to be done more safely, and gc was made to automatically prune old
unreachable loose objects in 25ee9731c1 ("gc: call "prune --expire
2.weeks.ago" by default", 2008-03-12).

This makes the warning unactionable by the user, as any loose objects
left are not deleted yet because of safety, and "git prune" is not a
command that the user is recommended to run directly anyway.

Therefore, remove this warning.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was noticed when a daemonized gc run wrote this warning to the log
file, and returned 0; but a subsequent run merely read the log file, saw
that it is non-empty and returned -1 (which is inconsistent in that such
a run should return 0, as it did the first time).
---
 builtin/gc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..fc3b553651 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -641,10 +641,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
-	if (auto_gc && too_many_loose_objects())
-		warning(_("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them."));
-
 	if (!daemonized)
 		unlink(git_path("gc.log"));
 
-- 
2.18.0.203.gfac676dfb9-goog

