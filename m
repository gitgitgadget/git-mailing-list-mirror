Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3AAC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBBJc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBBJcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D84F79CA9
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso854184wms.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32jNOFJECkUz0FpaN53jVi+vA32XqMMuDypnVR6fleE=;
        b=TsskHnxlnhxh6cGLB3x4UznF7P/OPKg6JeKW/52btvDfcsfOxtMMw3ySDPSha+CZSJ
         wI42vANL6m5UDVLx1fnIfswm5lsk9IRWhQG3AMPIjSbi8/6Qt+pH7yycl13BWBb9Bxtv
         y7Ry/TszA90gc3MrevKdSEqGnvyY7+CDBhjACoj1zg5cNAkITtnIzCmlQxtZfc8PTEH/
         bzRPonX0zMb9DrvpWsnnBMOGCK6TZCJ/sv3LpFFKpwDJJ8YDsWODMZMnB+UWW6QqBUDe
         F28LJZe42/1lH0fWpxNTo82s3CQ3xFKKpCf2O07p8cJPUbbHqQ5+1O0bJRfkxv/6IL1V
         qQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32jNOFJECkUz0FpaN53jVi+vA32XqMMuDypnVR6fleE=;
        b=mOWRTRRLhhdacEk/yVtP6IYLqhZ6crEGdAsuxhp+W2EKPbnp3x0UCCyXDd3EC8W/sA
         EXSLUKIBpaL3EX02BDwiLt0uoNF/R7GYoMn8Cq/q6eyQhniBVrgAizQ4I5nD6plhMLeq
         /oLsvvcMMIf26xMxnM9xT9w9HLQD8yLu43JNBG5uUI3yF4KtRj9CNuu7BZKf9Na6izSU
         JPSi8XsesZISWV7tNr4pQa4RLI6WkX3qWdVH+cqXR54FDiXc33ZNHEbcT639V5rXMeK0
         zx4kJEZaVXKzMWUOzI+XPiACLXem9yLVLA8k4dG3sZkMqJ2Qo6Ip6TOXwD0iD4KKdtGN
         Q0DQ==
X-Gm-Message-State: AO0yUKXeGter5xxnqovmG2EHnNxKpT+I0NGRF/szwU0qmZrX+/mcK4Xs
        xUOPFktNLTiAgQ0oJhv3/I9FH6FgqB5rQg8O
X-Google-Smtp-Source: AK7set901V/Z4s6b41dfC7xHGEiafxs8IftNjGDejpIsPa5fr0vCoHYswLeDTBFmT1Tl5t+f5wmZHw==
X-Received: by 2002:a05:600c:44c8:b0:3dc:5009:bc74 with SMTP id f8-20020a05600c44c800b003dc5009bc74mr5002710wmo.7.1675330366616;
        Thu, 02 Feb 2023 01:32:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/9] test-lib.sh: add a lazy GZIP prerequisite
Date:   Thu,  2 Feb 2023 10:32:27 +0100
Message-Id: <patch-7.9-0c7a8aa59e8-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "gzip --version" lazy prerequisite added in [1] and
copy/pasted to another test in [2] to test-lib.sh. A subsequent commit
will add a third user, let's first stop duplicating it.

1. 96174145fc3 (t5000: simplify gzip prerequisite checks, 2013-12-03)
2. 6c213e863ae (http-backend: respect CONTENT_LENGTH for receive-pack,
   2018-07-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5000-tar-tree.sh                    | 2 --
 t/t5562-http-backend-content-length.sh | 2 --
 t/test-lib.sh                          | 4 ++++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index d4730481384..e1fa34bb828 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -38,8 +38,6 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
 	)
 '
 
-test_lazy_prereq GZIP 'gzip --version'
-
 get_pax_header() {
 	file=$1
 	header=$2=
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index b68ec22d3fd..e83aa336fa8 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -3,8 +3,6 @@
 test_description='test git-http-backend respects CONTENT_LENGTH'
 . ./test-lib.sh
 
-test_lazy_prereq GZIP 'gzip --version'
-
 verify_http_result() {
 	# some fatal errors still produce status 200
 	# so check if there is the error message
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 01e88781dd2..33bb9fe991f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1922,6 +1922,10 @@ test_lazy_prereq LONG_IS_64BIT '
 test_lazy_prereq TIME_IS_64BIT 'test-tool date is64bit'
 test_lazy_prereq TIME_T_IS_64BIT 'test-tool date time_t-is64bit'
 
+test_lazy_prereq GZIP '
+	gzip --version
+'
+
 test_lazy_prereq CURL '
 	curl --version
 '
-- 
2.39.1.1392.g63e6d408230

