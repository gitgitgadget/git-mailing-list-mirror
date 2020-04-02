Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE20C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBCA20675
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTZOKLky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbgDBNEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:40 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40062 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBNEj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:39 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so1475444pjb.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUzV235WMnzvbTMVOAZmCWuc5LuKwPpcztnjQibor+Y=;
        b=mTZOKLkyIvRFie70lKuWn8GK/dJoCcFhQ+A+yPJ6s0VxM5P5LSipuQlSev3BOX1trD
         uTszSnCfGYwtAqMlR4U9NWMfQ3KJuoM1Sw2MNmMrJQz3qnYUMvOfmisXXH7Wum5vSieu
         LavMJvam/weifuhhk+5p9sftiGMNmWJ6JkLi1NZ1zR1+fecicz3QjGXJYMU5u/jr/p0I
         lKjh5jSCtwHrnZHxQrK/9I9x//H003nnx2fZtuTpVrXrHzbllaeqbtIYq8FcnFuaQCyd
         F80N46g068iOAl6G44/aujp1vtmRML8eUFGgqzrSDNvRRYcexWkWGVVW7nkgBw3V3Xd3
         BqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUzV235WMnzvbTMVOAZmCWuc5LuKwPpcztnjQibor+Y=;
        b=Sl/4d3Z6xuRtGg6Lqi3RLDgCp0vcvc3YgQvTZ3VEqaMvHM/UYKQG3pboJTf+5U57T6
         4kDNxQnenpKC4K3njpckYi8GjfRXdKG5CGZ1LOPf1iHW87bwAWDqp3gRZAP4q+zkwuJD
         qzaaaG/Hl4prVoDZsFiIWnpmXAqSDjaYLlgodWP6VK2jXZHzTYAVWDQ3aw4MXYpaeids
         xQXqwQfjQvEmBALwMTWAh6oziSuRPkmhjssBbMWsR6S9XHUeiE9S4palIrytcz3u3sP+
         nhYNRlH3PpYnhVzXxDnuPM53uaxmthpNo+ePdhrRAO6PWv/pt1BWF9g2nKUQO9lGuDbM
         l9Cw==
X-Gm-Message-State: AGi0Puau5vVfc/A/qLNc/N77ka5Prp5fGZJDNbhx/0mVKrMf/a7XCsqM
        LQRSWT3J3M2+mPqWC5ytfZlPeBu5
X-Google-Smtp-Source: APiQypJGTR6kOEB0llEeypcLWzLRQk6zdYa/b/3hA9XiJmmywMsQQ7Ci2KBaur2jAfCRxOU5VI5K0Q==
X-Received: by 2002:a17:90a:fa08:: with SMTP id cm8mr3715045pjb.144.1585832678154;
        Thu, 02 Apr 2020 06:04:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:37 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 2/6] ci/lib-docker: preserve required environment variables
Date:   Thu,  2 Apr 2020 20:04:01 +0700
Message-Id: <b7b079f559a17b6d6cef037afd6ce023df8f90b0.1585832270.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832270.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585832270.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're using "su -m" to preserve environment variables in the shell run
by "su". But, that options will be ignored while "-l" (aka "--login") is
specified.

Since we don't have interest in all environment variables,
pass only those necessary variables to the inner script.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/run-linux32-build.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e3a193adbc..7f985615c2 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -51,10 +51,17 @@ else
 fi
 
 # Build and test
-linux32 --32bit i386 su -m -l $CI_USER -c '
+linux32 --32bit i386 su -m -l $CI_USER -c "
 	set -ex
+	export DEVELOPER='$DEVELOPER'
+	export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET'
+	export GIT_PROVE_OPTS='$GIT_PROVE_OPTS'
+	export GIT_TEST_OPTS='$GIT_TEST_OPTS'
+	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
+	export MAKEFLAGS='$MAKEFLAGS'
+	export cache_dir='$cache_dir'
 	cd /usr/src/git
-	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
+	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
 	make
 	make test
-'
+"
-- 
2.26.0.334.g6536db25bb

