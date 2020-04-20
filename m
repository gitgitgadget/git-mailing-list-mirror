Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F4C3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA8821473
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKERZpjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTIzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTIy7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:54:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E33C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:59 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v18so4274266qvx.9
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BpRyGoJMzp7FknDxIkEzvsZj/dcMnzcFniZYoHX/CK0=;
        b=bKERZpjRSHGIgJoYQC8H8s+YNRsvjZNJYje7epcc5T/CIvbpM2lccewnCe9/Bq9fTH
         wm/OKgNkl53McMDjq7XQK2pH/wzguqvgt/89bSOfs4vxzDoRr/1BfqPtXvCD6DhP+WE4
         yWWTESGk/c8VB9GuYRhTRAJnfGde+PDBNXKC6wLkt4ieBXQYltke2iK+Znda3uyaGfBU
         1jV/WWbIqRVyfTUBweqTRshibUUsGVx6MbHD8qpBLLeve794ap7Gg8dK6pYGZNy1GqS9
         lVvs/BfJ9y/Jv7RJkToJtn20zo+4x7PZQqcNi8Zue0+ILDsnNKfVv2GxuYP19lxfloqG
         Tx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpRyGoJMzp7FknDxIkEzvsZj/dcMnzcFniZYoHX/CK0=;
        b=VYk+QV1gT+Wy6WKWsI07QueQ2tEsIm1TEJHVJ0Jfkszx0Za9Q+bBdiSskQN6vSDE6V
         flcUBoEfysSNB/jKOudFUHPHT5GnKbvYRRMzFMF7yuMqwYX4nA8oeX4+NFWEeLUKRZVQ
         4z9NbuswegTSwrf627oGGhBMrtBZX3fT6gekeZTHQscPTOTTLedPHDBGXzVqTCeDYhAJ
         2Fb8WQJ2iyJlxQQmlMPE7jkmg4y9X6/JFJBuEdVQSzurJbLkJ5IlIJyswhLI3bdYC6/D
         HJOpEXfQBDyb2uWKePVmT5+p1q0Joj511s1Y8YV9KWpP15QwmxWWTD3QrQjnq5ebYF1i
         UD+g==
X-Gm-Message-State: AGi0PubmJmOKvv/kZLumsOjqqLwEkeRV3ewF1LT+CMw6Av66aKBR7je6
        Z1dYvz7a7QemJ5E1l6jAK9CJEP6c
X-Google-Smtp-Source: APiQypL7hmPyxU8x4j+FFOYlyKBZFl8qfYvKNkluVl6wy/0XeyV15T6XsBuuhXemybnY1Geq0mnGdg==
X-Received: by 2002:a0c:b5a2:: with SMTP id g34mr12489827qve.219.1587372898593;
        Mon, 20 Apr 2020 01:54:58 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:58 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/8] t9160: use test_path_is_missing()
Date:   Mon, 20 Apr 2020 04:54:43 -0400
Message-Id: <572d12a5fb4777b10417bb4fc7e38954796a8404.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we assume that external commands work sanely. Since, not only should
this file not exist, but there shouldn't exit _any_ filesystem entity in
these paths, replace `test_must_fail test -f` with
`test_path_is_missing`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9160-git-svn-preserve-empty-dirs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 0ede3cfedb..36c6b1a12f 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -86,8 +86,8 @@ test_expect_success 'remove non-last entry from directory' '
 		cd "$GIT_REPO" &&
 		git checkout HEAD~2
 	) &&
-	test_must_fail test -f "$GIT_REPO"/2/.gitignore &&
-	test_must_fail test -f "$GIT_REPO"/3/.gitignore
+	test_path_is_missing "$GIT_REPO"/2/.gitignore &&
+	test_path_is_missing "$GIT_REPO"/3/.gitignore
 '
 
 # After re-cloning the repository with --placeholder-file specified, there
-- 
2.26.0.159.g23e2136ad0

