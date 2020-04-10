Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4666C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952382087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8C5tRED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJRS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35320 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgDJRS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id a13so1295447pfa.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GT0TpvTmy2q5lZKq0oThu8BDwzlulVSHnkrfqEkAQfU=;
        b=h8C5tREDl6F+K2YJrDWr4hDbBcY2IYHcJrCKPgpz2QPWZkeox8ToS4BFeUl1/kFBMt
         JU5lYxJmhra8dZgThnuLL0mwbn/G7fZdefU1hKl59HxCRNnYiL7qSTe2qHUN92B1JoEw
         IcTfHxlMUwRyj6iXE4fx0s8hWB3YCFHu0Dem0txp3Ia4N7HZ6M+F47WMLWLV2zYyhGGM
         8z+kLf4WmKXofeHutL+0FPwIuoQeSpebfRvycrqtU885XVrFo1guym3B698D2Bzubm6c
         kGhq2VYhvuzQYCZzMLfGSh8pxZ+JPAW6V6X1XUvKURc/XApoubJ8hL08CzCmAZSSzrwu
         76jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GT0TpvTmy2q5lZKq0oThu8BDwzlulVSHnkrfqEkAQfU=;
        b=hKYKIltmPjm1T3fZhYWI6T6X9Q7rEz3Jd/UjXvMdGkyHe2+GV2toWlEhQPSQLfRJYM
         rLJLD9HAFhialx6nXam1H2/4c+sWpu8M1Za61kmkmGqkdNZ8lrUF6UYIcj1emhH51bO0
         6Fm3mWpgC9OfXg06XH7TnXXSq/6rCmE1pWI5tlzir7dniGEY1fKeE1dGyhMF4RlJEg3n
         LdNf2kKY5wxAmcZpr6OLGhMb174emA8743iqRhtwrkXZStcF2ikQZ8cUDkLGSFJv4GDj
         KLkw8y1/0ZFTQ5V5q2O43W0qXCkC+hWegLneRkyIL+oXTtIQOLplfhdXB9V8kl6PrdTA
         0PnA==
X-Gm-Message-State: AGi0PuYmXiTh9yZGQLHdm+5oPCy/yHdQ9IJ7ihJor1W+R2IGNKD4io7K
        P8cBUB5skZVFbuwujj53I3OaCzGk
X-Google-Smtp-Source: APiQypIshdNbAeQTQlP2yxCHtRH93i1kLJmS2XGw83LGhDaTLUEKWHYJe2TrY4GNB4UZagyr8FOoEA==
X-Received: by 2002:a63:a07:: with SMTP id 7mr5236614pgk.261.1586539106338;
        Fri, 10 Apr 2020 10:18:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:25 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 03/12] ci/lib: set TERM environment variable if not exist
Date:   Sat, 11 Apr 2020 00:18:05 +0700
Message-Id: <b88586c2c5e4781c6a7fdfa0e2669bf37773afd2.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub Action doesn't set TERM environment variable, which is required
by "tput".

Fallback to dumb if it's not set.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index a21c6241b0..5c20975c83 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,6 +79,9 @@ check_unignored_build_artifacts ()
 	}
 }
 
+# GitHub Action doesn't set TERM, which is required by tput
+export TERM=${TERM:-dumb}
+
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-- 
2.26.0.334.g6536db25bb

