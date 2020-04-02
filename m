Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65351C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348C82078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccT0GNOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgDBNRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:17:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44072 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbgDBNRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:17:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so1722613pfb.11
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=ccT0GNOLRLh+4VKCFuUFX4Eb2Xp3PudludlhwWXjWxqEt6Vg08IWjPJT3E0Qzv2YdA
         c7rsEM3DfLHJUQj9+FrYQqN94DYOC7a+RsRVU1G69Ssv4JDS+LOlkDmvfJMkauPoRVdq
         vW5t+AbzNyZ3k4gnPfd5XZ1c+QP8EjsKyJF+/76Gw5ewNZcRGK7igQcB+uAsMcB8r6xx
         iLCQoKAwEH5qvJd4gyPpPfC67FSdapzegDAadwB7jvP+o8qUOypENXttJOCSwNUtVNBu
         9vXUKILqlRwTKyUieqPFYM7xOf15BUc6clB/663YiXg5ySoDd5476+KY4iq48k8fC2Bk
         rw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=TWzCtbLnGhnl85Th5nUqwCoHCY1PwvwkM2K0dRzwL3TWLsNs6fp9ryCalc3BbmR8+H
         4ss2Snc4sAyfEFWhZaoYPAK4pNQ7NV1a0hoGggsoC9UimrGUeDPHX2UeHxx3Apbwq5cT
         A/h2SwhhMsiKle5VGr5y79Oshjcz8zHZGTKLGNSx2gHzPrzAj/k11KpOSEKvnO1pkwKX
         ZMM2ah7LGUoRJa7LIhyWEwpDOpS1C3B5tCp5h2uT05wOwJEVFoHXcoulXq8zv217A+Fo
         JKfhJM0zU9oil+0K+UTgb2qw1pyujhUxJZ5La4DNW8MyRCFmRgtTO+w1JkgvX7FiewJP
         nD3g==
X-Gm-Message-State: AGi0PuY9uGVWRx1cZTYvU/eQCOb9d8Ej+4ZtIT8ULIsDa0/d/6YGjMIb
        DpkS9oqF3rMYcy7ZpE2YKGxI+dOy
X-Google-Smtp-Source: APiQypKMPxABP4r1FjY0iCuohA0TW7/42GQFUrs34NM9gFOpBXnxmmsni4KQl9PZlZg+8YSwHC6GjQ==
X-Received: by 2002:aa7:9e4d:: with SMTP id z13mr3195397pfq.6.1585833454246;
        Thu, 02 Apr 2020 06:17:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g18sm3350711pgh.42.2020.04.02.06.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:17:33 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 5/6] README: add a build badge for the GitHub Actions runs
Date:   Thu,  2 Apr 2020 20:16:59 +0700
Message-Id: <365ba5e831cff36177a0a486e74e3fbc438562de.1585832999.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832999.git.congdanhqx@gmail.com>
References: <cover.1585756350.git.congdanhqx@gmail.com> <cover.1585832999.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 9d4564c8aa..e2e00ae249 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,4 @@
+[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
 [![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
-- 
2.26.0.334.g6536db25bb

