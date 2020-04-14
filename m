Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9474C352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C594C206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz7mgUcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436524AbgDNQnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407453AbgDNQm7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 12:42:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393DBC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 09:42:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i7so413303edq.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5AhrdgHQZgca4kfKW4r1Bq3Qzd2jAaW3HuTxa2z53WQ=;
        b=Gz7mgUcJZLscaZYISF49hz483sb66eEaCtNqJ7sehyZgyPNw4QIgXAh2H7H2VqtIIw
         ugBgBsuysBU2RTJ1dx2QqzBAzfRRA/Fq1zm5YYSV80OkhtdzrwuXp3w/9oCkrVwS3fw3
         CxIO7ChZBZCO9UcBM+LA0FVEWvzFTM4IhMyP7t9499CtOQYhBUQ2xRHNF6rH9mBNDrmo
         tr7v0JdudXtZKIKu5Zcoh90Jj0Z8rOqaVmlthNIxdjwj4oUSVjpuFpM72s8Y5iLpcEpY
         3Uz0pAJEDxzPnfXBQtOhpFPcw7s+wrVGMAIw0Nbl0m5Ml3kXzH7LRjs8e0XhK6Ve+4yh
         glpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5AhrdgHQZgca4kfKW4r1Bq3Qzd2jAaW3HuTxa2z53WQ=;
        b=aUcSbFcaHf6tbZR97uVTbatpJASesuUXUx8qszO4uWs8QCd3L7tmp7rG9HXIkeF0Iq
         quZHOBaYgEU5KW7TVoAhxIlkrtdwfaVdMwnh6ttLwU7aqqPIb5euB/KryImY16A5aGFC
         qqLCY9zjQTHTjHYlisPNJv69x2IBTbuhYRtRmbbLcJe2L4uWrfjgQpckeqRrYrt35DIb
         s4vp9FE5VmEYZOCILtblk4umc9F7aVYkCZljcEDyATpf4eTZfqnsO3lfYIQTgvkVXijn
         oFg+tjCIjV/8X8kgh3POjXNbpBitohaqgvVd547UjrC5ZC7+bFFsEHwOHiVmKC6uGRS3
         x1Xw==
X-Gm-Message-State: AGi0PuYQ0hb1YI3eoWBGUbgtH8Mwoi75tB5G7Ei3nV7hzva3phE++25V
        vT6x9z5ElLFY+rk6eFKm7iKg6Azj
X-Google-Smtp-Source: APiQypLC8M63yqg//sXGnfrgtRTO1dZFeB3Pb6xnTDbt9RZuy5pRVf0m+dH2zbufakji6JD9kQiIfw==
X-Received: by 2002:a17:906:164f:: with SMTP id n15mr971525ejd.322.1586882577696;
        Tue, 14 Apr 2020 09:42:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm436061ejn.54.2020.04.14.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:42:57 -0700 (PDT)
Message-Id: <pull.647.git.git.1586882575822.gitgitgadget@gmail.com>
From:   "Kazuo Yagi via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Apr 2020 16:42:55 +0000
Subject: [PATCH] doc: fix the stale link to api-builtin.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kazuo Yagi <kazuo.yagi@gmail.com>,
        Kazuo Yagi <kazuo.yagi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kazuo Yagi <kazuo.yagi@gmail.com>

ec14d4e had moved documentation from api-builtin.txt to builtin.h.
This patch updates new-command.txt to reflect that change.

Signed-off-by: Kazuo Yagi <kazuo.yagi@gmail.com>
---
    Fixed unavailable link in Documentation/howto/new-command.txt along…
    
    … with the changeset history.
    
    Signed-off-by: Kazuo Yagi kazuo.yagi@gmail.com [kazuo.yagi@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-647%2Fkyagi%2Ffix-unavailable-link-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-647/kyagi/fix-unavailable-link-v1
Pull-Request: https://github.com/git/git/pull/647

 Documentation/howto/new-command.txt |  6 +++---
 builtin.h                           | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
index 15a4c8031f1..ac73c98be72 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -1,13 +1,13 @@
 From: Eric S. Raymond <esr@thyrsus.com>
 Abstract: This is how-to documentation for people who want to add extension
- commands to Git.  It should be read alongside api-builtin.txt.
+ commands to Git.  It should be read alongside builtin.h.
 Content-type: text/asciidoc
 
 How to integrate new subcommands
 ================================
 
 This is how-to documentation for people who want to add extension
-commands to Git.  It should be read alongside api-builtin.txt.
+commands to Git.  It should be read alongside builtin.h.
 
 Runtime environment
 -------------------
@@ -48,7 +48,7 @@ binary); this organization makes it easy for people reading the code
 to find things.
 
 See the CodingGuidelines document for other guidance on what we consider
-good practice in C and shell, and api-builtin.txt for the support
+good practice in C and shell, and builtin.h for the support
 functions available to built-in commands written in C.
 
 What every extension command needs
diff --git a/builtin.h b/builtin.h
index 5cf5df69f72..101ef8edc4d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -92,6 +92,31 @@
  *
  * The return value from `cmd_foo()` becomes the exit status of the
  * command.
+ *
+ * Changeset History
+ * -----------------
+ *
+ * The following describes how the documentation has finally been placed
+ * in this file, over the related changesets.
+ *
+ * +-----------------+ *OLD LINK*  +-----------------+
+ * | api-builtin.txt | <~~~~~~~~~~ | api-command.txt |
+ * +-----------------+             +-----------------+
+ *    |                               ~  *  |
+ *    | deleted,                     ~  N   | moved and renamed from
+ *    | contents is taken over      ~  E    | Documentation/technical/
+ *    | by builtin.h               ~  W     | to
+ *    | (this file)               ~         | Documentation/howto/
+ *    |                          ~ L        |
+ *    |                         ~ I         |
+ *    v                        ~ N          v
+ * +-----------+              ~ K  +-----------------+
+ * | builtin.h | <~~~~~~~~~~~~ *   | new-command.txt |
+ * +-----------+                   +-----------------+
+ *
+ * ---> moved to(or renamed to)
+ * ~~~> refers to
+ *
  */
 
 #define DEFAULT_MERGE_LOG_LEN 20

base-commit: 3cb8921f74354a3a4aeaa932869acb7e6aabe630
-- 
gitgitgadget
