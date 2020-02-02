Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA8FC35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 19:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC720679
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEKvkzgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBTdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:33:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40173 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBBTdi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 14:33:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so12340395ljo.7
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WY9QOD78qfliQMQjjKqS+nO17m41xBMlrf7pWRBbc8Q=;
        b=jEKvkzgCeiShjg/T3WjpZbVioiXFMAbs/CQnRDnrxvJ/6YiosTsZZX4i4Y53O54+Gg
         HRWg7/vj0hqHzFO0v/Uz3kavUnp0be30Ij/5mSYpL5COR6F246fCg+YohLEHzrPVlSrZ
         kIszOf+fZsTKPNBkVZy0JdoVJGP8fYkFylGLx0GY6T5/bckzTnkxw11uYx2VAlOXKT6W
         YMBnvD9chJSmPmI/5LTcYFNrs2l3ooBpa0+Of4ez9Dh5597Re6An084syIKaPMjLx1Ph
         fXjVoYN2xMsEWnovJCaRx/2+OtPnhr+t+0OPf0QCES/pVUdb75RnO81s4dpcEG+JNAPY
         fLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WY9QOD78qfliQMQjjKqS+nO17m41xBMlrf7pWRBbc8Q=;
        b=pemwJpmXCfCdthLTK4aWqcn7FOo/Su20m2GOoKnueLivrZPooPJF48CoAYqS/hubg7
         LnHozi9nSkbyzDuQlmPezuoZb/Iy8TazLhguIcJVneILPcslNv+ObeOUTxKYQITVFK7M
         /e2vKFM8UHRaqShUbBSDdydCIoG+1h4Q/xgOeXuvw4B5ENPV/W/6KuMAU7ePv0+VQdxN
         WAHblygEqPM775DXRLmRnQsr8GmLso9+bPCtomb1q/Oy71KA/83pebMA/ZElbCyMk9VG
         J5IqjZn3kk1xDS1UaGcrugr5KpIh/e59kybCYVJ/SR5OvTjzhjDExL9c58APl7B16yCG
         A+xQ==
X-Gm-Message-State: APjAAAVRo6uahWKqsB36kn5+267THaMgQEnDt4ZdhM7utHou73/bf1wy
        aMdXSl6j/YpETmMUZ6uumUVXkRIE
X-Google-Smtp-Source: APXvYqy4pNzh4p16Dkiymqu3Ghpa5KB575QNJJlQkHU1UUmhYy8WLbYcHDL//28MuH7ZVaacPqhboA==
X-Received: by 2002:a2e:a402:: with SMTP id p2mr12184524ljn.143.1580672015475;
        Sun, 02 Feb 2020 11:33:35 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h19sm8397821lji.86.2020.02.02.11.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 11:33:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] git-filter-branch.txt: use {caret} for ^
Date:   Sun,  2 Feb 2020 20:33:19 +0100
Message-Id: <20200202193319.1966-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this paragraph, we have a few instances of the '^' character, which
we give as "\^". This renders well with AsciiDoc ("^"), but Asciidoctor
renders it literally as "\^". Dropping the backslashes renders fine
with Asciidoctor, but not AsciiDoc... Let's use "{caret}" instead, to
avoid these escaping problems.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-filter-branch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index a530fef7e5..9e58d34c6a 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -467,9 +467,9 @@ impossible for a backward-compatible implementation to ever be fast:
 
 * In editing files, git-filter-branch by design checks out each and
   every commit as it existed in the original repo.  If your repo has
-  10\^5 files and 10\^5 commits, but each commit only modifies 5
-  files, then git-filter-branch will make you do 10\^10 modifications,
-  despite only having (at most) 5*10^5 unique blobs.
+  10{caret}5 files and 10{caret}5 commits, but each commit only modifies 5
+  files, then git-filter-branch will make you do 10{caret}10 modifications,
+  despite only having (at most) 5*10{caret}5 unique blobs.
 
 * If you try and cheat and try to make git-filter-branch only work on
   files modified in a commit, then two things happen
-- 
2.25.0

