Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B4C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F820714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPqgZxu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfKVNOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:14:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55225 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 08:14:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id x26so7125414wmk.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 05:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PhK0T/jqm632ZWfWOTiWbAfeVbGRL7YcAdsVssGTwg=;
        b=PPqgZxu73xsLnXbwKFWC2GL2NzbEN05yUlK8lUUd/me8d4UMq/Sl+7rHyzWs+E6DJ3
         eL1nUj6tnqalh5xKTjyqa56yAz9yntaNh7OPJJbaXPQVZ1oPzoTDE04GW2QHwfVLrVwG
         3tke1WboNMrxwRb80XB2QmivZeXQSQY8tf565Hq242QXYbeQwwi6Yq/5iw3xp36QXeOc
         tUNgMtJwtTi8QQtssn32T5mcnoILZyq8TGuS/UJxDVDUPYgLAOvX8BNyNyKOcEpZN5lk
         MeAQ+To/BxQ4zFHBr9pFms6VG+AGrgKVqb+Stj6NzfFGQTU5CwSOJYEQzWETaWMf/5fh
         tOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PhK0T/jqm632ZWfWOTiWbAfeVbGRL7YcAdsVssGTwg=;
        b=b16/bEvoI2n3TjqT+yjbj8E6M4jldAJ/jd/p86esLq9qaVVv9mIOjQiA8nryQAS3yi
         Sg5V5+4QJS47H4L+34F+lBD+DfOp9/bEpciAzVp7tUOClg4feS7XcFKyDMwcqlGiJMTg
         u5ZgGcnr4vIpV28sm/cxMDuUIBratDo6S9tt54YEjyu8R4mf5r5L1bUGDIPUY9pYU1g0
         yt1+nHRp75N/716BNrsSZ08HodESe03qpMDrtbST4Z+s2NTFlAWwEnmr+ymVzQZ/JLBZ
         nYoFEaaymF5zbaMnhv7gpl/g10gXHSatDUSY6yb3O8XigvWUAQvgi+EsHJVcNmdWzU5e
         ojnA==
X-Gm-Message-State: APjAAAWOD46bWlhMnj6iekYW2hOB7kJuZJNJgg2E3RuhRsRkoAjgyZdk
        656+qZnndlZfDe0mEq4HjiM=
X-Google-Smtp-Source: APXvYqyr7U8fojvrlGourr259TTEcpyEpLaKNmhuwXNMZKiGIxGm0d09IbRwry6kKktxwtEj1j4KBw==
X-Received: by 2002:a1c:9601:: with SMTP id y1mr15985362wmd.157.1574428483177;
        Fri, 22 Nov 2019 05:14:43 -0800 (PST)
Received: from localhost.localdomain (x4db9604a.dyn.telefonica.de. [77.185.96.74])
        by smtp.gmail.com with ESMTPSA id u4sm7407934wrq.22.2019.11.22.05.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 05:14:42 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Wong <e@80x24.org>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] t5608-clone-2gb.sh: turn GIT_TEST_CLONE_2GB into a bool
Date:   Fri, 22 Nov 2019 14:14:37 +0100
Message-Id: <20191122131437.25849-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.532.ge18579ded8
In-Reply-To: <20191122131437.25849-1-szeder.dev@gmail.com>
References: <20190907101637.GE32087@szeder.dev>
 <20191122131437.25849-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GIT_TEST_CLONE_2GB environment variable is only ever checked with
'test -z' in 't5608-clone-2gb.sh', so any non-empty value is
interpreted as "yes, run these expensive tests", even
'GIT_TEST_CLONE_2GB=NoThanks'.

Similar GIT_TEST_* environment variables have already been turned into
bools in 3b072c577b (tests: replace test_tristate with "git
env--helper", 2019-06-21), so let's turn GIT_TEST_CLONE_2GB into a
bool as well, to follow suit.

Our CI builds set GIT_TEST_CLONE_2GB=YesPlease, so adjust them
accordingly, thus removing the last 'YesPlease' from our CI scripts.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib.sh            | 2 +-
 t/t5608-clone-2gb.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 29dc740d40..2540bb6110 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -151,7 +151,7 @@ fi
 
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
-export GIT_TEST_CLONE_2GB=YesPlease
+export GIT_TEST_CLONE_2GB=true
 
 case "$jobname" in
 linux-clang|linux-gcc)
diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 2c6bc07344..eee0842888 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -3,7 +3,7 @@
 test_description='Test cloning a repository larger than 2 gigabyte'
 . ./test-lib.sh
 
-if test -z "$GIT_TEST_CLONE_2GB"
+if ! test_bool_env GIT_TEST_CLONE_2GB false
 then
 	say 'Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_2GB=t'
 else
-- 
2.24.0.532.ge18579ded8

