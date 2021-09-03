Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE847C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 12:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B969B610A1
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbhICMA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhICMA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 08:00:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2750C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 04:59:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 7so4115457pfl.10
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xQl9dgIl071n6Nx2b/ycYyFvgOns02uv0WSh0Uv0yQ=;
        b=pNrODCWhQ7vSNJ7zOGUyMpJrBA4HMictuXqb5HoeNX0+YxfzhmqhweIQiMA4rpX/5D
         9t4sAfkceXkNb4GOInbxpuyvSZvgvU+t1L9PDwUKLvhfz9C9z3CeuY4zOsYBZ5ah/uJG
         Z6dJGbLh9u1WW5jPAWP64xlNF3X3GqLaqr1GANve7ACEHeqD+GC9il0FdQkIYETe2sFs
         WnVEM2dXJYFi5tUL2Ve687OglsjKd+cR2sfkJaf6urVZc/nENlmN8OHRDKyord9kbF6k
         TACWPQOH9SYHTrSDa8hnLu2vm3PTm6aWY8qM8dHPLQBMMqWA1QBJIFS5x+Qix9Nt7JrE
         d6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xQl9dgIl071n6Nx2b/ycYyFvgOns02uv0WSh0Uv0yQ=;
        b=n8sxRDn0vvCwrM09SJfRMnrCv2eMUYjPBxhYsSCF9AQxKWIF39hJrrih53ZLmIhkO9
         lJWeob462bg6Yq5T6T0/IRrbtMEeYGNaYIfNIOmwxgp3qqcj8CE06Ei79Muc8ofEaLT1
         ZhhAdIM7ofjRqRRn53IXD8Wf9K7CqIuAfw5qMuO0eeqYHgZZJS4HXYejdN/B61irnZuo
         odX5vaCggxNcS7AFN8YKfBiiTsu+/xWpbBj6Cu+itehlIcysgZxz89P3lSTlkYgFQEiY
         VR7F6DD+qUVVY7hh/Ub+oIHAVy8ATOo5uBfAOtknWuCJztUqgWWyrfFmw7R1LjpsmMO1
         iiHw==
X-Gm-Message-State: AOAM531IVF2VEnVOQOL1a9qTdzp8SWnaIDpN9sZq4LmuyIi+aye0vJq1
        jHH5tce12uP5pfr324o7gDi7R4yqwM+AYE4N
X-Google-Smtp-Source: ABdhPJzAAN03wpbGU4NP2E6yllmx3QQYKvf7pWFr1wOZIY9q4bqOfMNaezUy3nuWlvrNjUPvqm4PxA==
X-Received: by 2002:a63:4e65:: with SMTP id o37mr3313591pgl.202.1630670398195;
        Fri, 03 Sep 2021 04:59:58 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id d5sm5159872pfo.186.2021.09.03.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 04:59:57 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: fix default directory of git bugreport -o
Date:   Fri,  3 Sep 2021 18:59:34 +0700
Message-Id: <20210903115933.622847-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git bugreport writes bug report to the current directory by default,
instead of repository root.

Fix the documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-bugreport.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 66e88c2e31..d8817bf3ce 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -40,8 +40,8 @@ OPTIONS
 -------
 -o <path>::
 --output-directory <path>::
-	Place the resulting bug report file in `<path>` instead of the root of
-	the Git repository.
+	Place the resulting bug report file in `<path>` instead of the current
+	directory.
 
 -s <format>::
 --suffix <format>::

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.25.1

