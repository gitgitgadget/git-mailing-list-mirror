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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD2C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EB761A27
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 10:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCYKza (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhCYKzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 06:55:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB655C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 03:55:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s21so882017pjq.1
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jic6PqGnWmiycsInb3CXyEQ090je9Xoy1b/7O1SET68=;
        b=VD1SgOgGPrvN2rRsyvI9at154EkQyGT0g7TJqQg7eRyaAZBAfnT8kETJm3TGby2Gy2
         zMRiG5YfxvSc5OTKK270mSV6ca7BvEEWiYvnEP4mvNVSf3Kd0huad86rupNRLMUUiHvt
         3YBjy8PC1lBOcwezPLmzPNWqof8W3wTBu5Vj8EoJxAhxG/3f+I40sRQvTy9m5r6XjNGN
         vQIh1OGvV/4TvN2LPvmxf9CAWQU1coNDOFjENrbzPGrHas+/94WOmgfAKCPzthgXReTD
         jql0i/OemOvoJ9VV5BBkj4aAroWml+1vK1fx/e3ISnkxeN/F+lpzeTN317M/X/UlUzZR
         65IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jic6PqGnWmiycsInb3CXyEQ090je9Xoy1b/7O1SET68=;
        b=hy5jnrFwq5HwPVWeNe2wcsS1sGpaIbsMLWrQttx5TvyFBXKnVpzlXp0gg0wY/6Uybq
         Rb+Q7Qlp5z06dKlW0zCMxGe319+yLE2BE9ZqPhxKS6kCkZXaZjnB9Fj9ETdCy2LLvoL6
         /Eiov67VcA8PMzDARnkDxQHa3W3qo5IEQDx2tV1BD4/pJwtBU5eomSfozLbUoEvdfwPK
         hZEyjXrZG0jnGTq9hDXb9I+n1dgUOA+28vPmYeYv2vDWo8pnAtqM3kpLBQqyfHzhYSAj
         oORGLiuhhY8dbcKvdiesI8EajXMTRT+4hxAZFhrsK3eE/O58uYjsrWuORBxmlKfPdKi9
         XrUQ==
X-Gm-Message-State: AOAM532Q1DJBoXDj/6Q8rEGOpa4EhLmUgkVQdPowej3Q8oGyAjrvdGub
        6lyUI4GYhnD5bxc5wUsFBTqpxvhVBr1Hvg==
X-Google-Smtp-Source: ABdhPJysF7PiBE+Vfq3YovkQI30g8340gtSy4TBuZOb/AVB/HBubERKKWsFS214y2QrK18AlIPfyKg==
X-Received: by 2002:a17:90a:4d07:: with SMTP id c7mr8277936pjg.104.1616669701190;
        Thu, 25 Mar 2021 03:55:01 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id p1sm5420067pfn.22.2021.03.25.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:55:00 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] format-patch: give an overview of what a "patch" message is
Date:   Thu, 25 Mar 2021 17:54:34 +0700
Message-Id: <20210325105433.43310-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The text says something called a "patch" is prepared one for each
commit, it is suitable for e-mail submission, and "am" is the
command to use it, but does not say what the "patch" really is.  The
description in the page also refers to "three-dash" line, but that
is totally unclear unless the reader is given a more detailed
overview of what the "patch" the first paragraph refers to.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

This patch is from discussion on [1]. Junio said that rather than
add a new section describing the format of format-patch generated
patches, extend the first paragraph of Description to better
reflect that format.

[1]: https://lore.kernel.org/git/xmqqeeg4zbyz.fsf@gitster.g/

 Documentation/git-format-patch.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf2210..5cd8578b6f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -36,11 +36,28 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Prepare each commit with its patch in
-one file per commit, formatted to resemble UNIX mailbox format.
+Prepare each commit with its "patch" in
+one "message" per commit, formatted to resemble a UNIX mailbox.
 The output of this command is convenient for e-mail submission or
 for use with 'git am'.
 
+A "message" generated by the command consists of three parts:
+
+* A brief metadata header that begins with `From <commit>`
+  with a fixed `Mon Sep 17 00:00:00 2001` datestamp to help programs
+  like "file(1)" to recognize that the file is an output from this
+  command, fields that record the author identity, the author date,
+  and the title of the change (taken from the first paragraph of the
+  commit log message).
+
+* The second and subsequent paragraphs of the commit log message.
+
+* The "patch", which is the "diff -p --stat" output (see
+  linkgit:git-diff[1]) between the commit and its parent.
+
+The log message and the patch is separated by a line with a
+three-dash line.
+
 There are two ways to specify which commits to operate on.
 
 1. A single commit, <since>, specifies that the commits leading
-- 
2.25.1

