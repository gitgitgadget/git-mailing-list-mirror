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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA1C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F34221F9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbhADQX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbhADQX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E1C0617A3
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jx16so37500417ejb.10
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=id8pNBZOQ06x21o05zcjaUXjroar3o9jXUQ1of2mgyA=;
        b=UtoeAvaqyh3gBS2FAMepLENdo4a7eJi+mX2WJBfBxgZ4DYk7FjUoffpFMnCgVb+1uj
         8EZ2nXfhlbkPEMENJWiJ5/nAVH+CXYbbnpiyDDOs4qtwR5wjLj4faQaG/yZ0sBO9obg6
         Goz/ndNf9kZC1VWdPgymcirxcwyxXTNvhwANZSWqBoqi37sodMwYhp5Z8/3Mkxz+RuGF
         s2S0Eddc/DslhsFRwBDPYAxe7iHhDfhvanBLcs9DHsKFsRxdc+2VNM4JjQZAAGPEGxkZ
         r9TKdtnvLHbgyVZctjUJBv8ZfH6ZHq+XhLLVH6x6iFgvDe/+MH0PA2YYFk7/erUbhfm9
         iOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=id8pNBZOQ06x21o05zcjaUXjroar3o9jXUQ1of2mgyA=;
        b=V8LVKxQ7HFO1WpFP3+1uE8+3GHusw5DaKNdAsP7vliUSwpRSlIRFA28XkKslwyD5FL
         LqW+ls3RYJxko+tmlS6XTXRk0nYqu0OEioKADAeiqhl8yV8S7aLus7nTOjcs6VW94qyx
         XcsXMrVhhEJnZK7xvrXbMnX2T6A163IpPVtvzs02Tc/sBSuUipjA+ErD90z0oqkfeRQV
         H9ELpJOx+VRTp8ZzGnk0qZOBfaCRPt70DVkacakHXXybo3EaWcOg91/Qsy6PSTBU7ED9
         BdnjSoS+3wh6BkdSk7cVWUgQJjiT7gEJ1NsoiXBkjr9EI1BOV85/CHaiGKDS6wZOFt8r
         TF4A==
X-Gm-Message-State: AOAM532eSiNPSW5c29il6LSNTA8ncJL8qIUpxI9326ROOo8o0KwuNqKm
        JTrfPR/jh1Ltm9cMkNRc1+dsDa/biEs=
X-Google-Smtp-Source: ABdhPJxL0dDqJWx7u0BfZwUmWHVCQ3/Btvd11+nSCtWygz1GXITngCO8YKHIpe0zvpUinqKcjM2Zbw==
X-Received: by 2002:a17:906:6d14:: with SMTP id m20mr66320667ejr.3.1609777343947;
        Mon, 04 Jan 2021 08:22:23 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:23 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 7/7] worktree: document `list` verbose and prunable annotations
Date:   Mon,  4 Jan 2021 17:21:28 +0100
Message-Id: <20210104162128.95281-8-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the documentation with "git worktree list" verbose mode, prunable
and locked annotations for the default and porcelain format as part of
teaching the command to show prunable working trees and verbose mode.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 59 ++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index af06128cc9..8ce579e2e8 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -97,8 +97,9 @@ list::
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
 whether the working tree is bare, the revision currently checked out, the
-branch currently checked out (or "detached HEAD" if none), and "locked" if
-the worktree is locked.
+branch currently checked out (or "detached HEAD" if none), "locked" if
+the worktree is locked, "prunable" if the worktree can be pruned by `prune`
+command.
 
 lock::
 
@@ -226,9 +227,12 @@ This can also be set up as the default behaviour by using the
 -v::
 --verbose::
 	With `prune`, report all removals.
+	With `list`, output additional information for working trees.
 
 --expire <time>::
 	With `prune`, only expire unused working trees older than `<time>`.
+	With `list`, annotate unused working trees older than `<time>` as prunable
+	candidates that will be remove by `prune` command if the same option is used.
 
 --reason <string>::
 	With `lock`, an explanation why the working tree is locked.
@@ -367,13 +371,48 @@ $ git worktree list
 /path/to/other-linked-worktree  1234abc  (detached HEAD)
 ------------
 
+The command also shows annotations for each working tree, according to its state.
+These annotations are:
+
+ * "locked", if any working tree is locked
+ * "prunable", if any working tree can be pruned via "git worktree prune".
+
+------------
+$ git worktree list
+/path/to/linked-worktree        abcd1234 [master]
+/path/to/locked-worktreee       acbd5678 (brancha) locked
+/path/to/prunable-worktree      5678abc  (detached HEAD) prunable
+------------
+
+For these annotations, a reason might also be available and this can be
+seen using the verbose mode. The annotation is then moved to the next line
+indented followed by the additional information.
+
+------------
+$ git worktree list --verbose
+/path/to/linked-worktree        abcd1234 [master]
+/path/to/locked-worktreee       acbd5678 (brancha)
+	locked: working tree path is mounted on a removable device
+/path/to/locked-no-reason       abcd578  (detached HEAD) locked
+/path/to/prunable-worktree      5678abc  (detached HEAD)
+	prunable: gitdir file points to non-existent location
+------------
+
+Note that, the annotation is only moved to the next line only if the
+additional text is available, otherwise the text is kept on the same.
+
 Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  The first attribute of a working tree is always
-`worktree`, an empty line indicates the end of the record.  For example:
+`worktree`, an empty line indicates the end of the record.
++
+In case any of the working trees are locked or is a candidate for pruning
+(See DESCRIPTION above) the labels "locked" and "prunable" is also shown
+followed by a reason, if available, otherwise only the labels are listed.
+For example:
 
 ------------
 $ git worktree list --porcelain
@@ -388,6 +427,20 @@ worktree /path/to/other-linked-worktree
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
 
+worktree /path/to/linked-worktree-locked
+HEAD 5678abc5678abc5678abc5678abc5678abc5678c
+branch refs/heads/locked
+locked
+
+worktree /path/to/linked-worktree-locked-with-reason
+HEAD 3456def3456def3456def3456def3456def3456b
+branch refs/heads/locked-with-reason
+locked reason why is locked
+
+worktree /path/to/linked-worktree-prunable
+HEAD 1233def1234def1234def1234def1234def1234b
+detached
+prunable gitdir file points to non-existent location
 ------------
 
 EXAMPLES
-- 
2.30.0.391.g469bf2a980

