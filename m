Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD8C433E1
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB46206E2
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFKNEC3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgHCFhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgHCFhS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 01:37:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E7EC06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 22:37:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i138so24185700ild.9
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N317HqoQSuX/YaPtBRju/3iMq/cy1TQOmlaRE7k4r5g=;
        b=qFKNEC3yhvzMlsWxVsR+DRsAqgT6XdAQ6M27ke8kwrqHa9VrgM6R0ueUjtmWDYBOxR
         cTQNAUpz7vghX5dvlHnduur7laod8UdbVl5Qu8OEQ2mp9+ISmzIzhUDGqlJXBHlTi0zr
         m1zsjxOLW/jlizcHM/IxuqBECYU1PaRKTpDzk7mWgvIs3Q8K0/6WsJu0wrIrbG3rL3fK
         OU83tbwgJx/ROy71tHe+TSBRTao1/+GoQ7K754ak7EDKPCgOEFUAGupanEk4pIpPMAJW
         yLLu1J/L9E10bHvY7VQ775AdJGVS6IdcziDqtnnB1MNA85G0u8UG7HTB6X1/booCZ8TA
         YrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=N317HqoQSuX/YaPtBRju/3iMq/cy1TQOmlaRE7k4r5g=;
        b=M+O949KKJ33PHMXxT3j32fZIhvDLtvxX6vDgVfwK4bRq+93ryY9naUeGXfFgPL+5G3
         k7bxYsQ93MRqk20yfjcIU07Z1GE4YvOElEBimJYYpP7upv/vfiRb0vQGb4GEtdG/QEKm
         YzkByGrlgTE9It7EwC+GltWLgi/0HmxAioP2a00thQZlZSTX0kzPaLp8KIwS7ndUwFML
         1gHsg1xQuvJxxe/kglFm7ZGmijOuvwXp2RTno/Gf18V7MFsaRO1JPORTigl3XUBnMTDX
         6nPHIjHpoWFrHARl0vP0vkTaD2RObQPbzFIYKuExQLcPmfpgvnvWZDkpktFHcHpAREx4
         /MqA==
X-Gm-Message-State: AOAM533IZnnUGqgRI9kIHOjAuVi1MnEVjuBv7sy/3Rb748KjSbqaD2dt
        0tdTYvdAcBUTHlURl0ktwxukNz9g0ZI=
X-Google-Smtp-Source: ABdhPJyxgDPJd/KE4GnwfD2K9xtvA5WDfge4GzWKSpFnq3Gic+Qz/QHvY2jeFfl9BbfAx0AZIJFiuA==
X-Received: by 2002:a05:6e02:8a4:: with SMTP id a4mr14783103ilt.92.1596433036984;
        Sun, 02 Aug 2020 22:37:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r6sm8183114iod.7.2020.08.02.22.37.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:37:16 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/4] git-worktree.txt: fix minor grammatical issues
Date:   Mon,  3 Aug 2020 01:36:11 -0400
Message-Id: <20200803053612.50095-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200803053612.50095-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few grammatical problems to improve the reading experience.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index cd762876f0..49422454d1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -82,7 +82,7 @@ list::
 
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
-if the working tree is bare, the revision currently checked out, and the
+whether the working tree is bare, the revision currently checked out, and the
 branch currently checked out (or "detached HEAD" if none).
 
 lock::
@@ -171,7 +171,7 @@ This can also be set up as the default behaviour by using the
 --lock::
 	Keep the working tree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
-	but without race condition.
+	but without a race condition.
 
 -n::
 --dry-run::
@@ -202,21 +202,21 @@ This can also be set up as the default behaviour by using the
 	absolute.
 +
 If the last path components in the working tree's path is unique among
-working trees, it can be used to identify working trees. For example if
+working trees, it can be used to identify a working tree. For example if
 you only have two working trees, at `/abc/def/ghi` and `/abc/def/ggg`,
 then `ghi` or `def/ghi` is enough to point to the former working tree.
 
 REFS
 ----
 In multiple working trees, some refs may be shared between all working
-trees, some refs are local. One example is HEAD is different for all
-working trees. This section is about the sharing rules and how to access
+trees and some refs are local. One example is HEAD which is different for each
+working tree. This section is about the sharing rules and how to access
 refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
 with `refs/` are shared. Pseudo refs are ones like HEAD which are
-directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There is one
-exception to this: refs inside `refs/bisect` and `refs/worktree` is not
+directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are
+exceptions, however: refs inside `refs/bisect` and `refs/worktree` are not
 shared.
 
 Refs that are per working tree can still be accessed from another
@@ -255,7 +255,7 @@ configuration in this file with `git config --worktree`. Older Git
 versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
-is gone. If you have them in `$GIT_DIR/config` before, you must move
+is gone. If they exist in `$GIT_DIR/config`, you must move
 them to the `config.worktree` of the main working tree. You may also
 take this opportunity to review and move other configuration that you
 do not want to share to all working trees:
@@ -334,7 +334,7 @@ Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
-and `detached`) are listed as a label only, and are only present if and only
+and `detached`) are listed as a label only, and are present only
 if the value is true.  The first attribute of a working tree is always
 `worktree`, an empty line indicates the end of the record.  For example:
 
-- 
2.28.0.236.gb10cc79966

