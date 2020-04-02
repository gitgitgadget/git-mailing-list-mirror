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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED717C2BA15
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE07520757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ9ome+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbgDBNEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34725 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBNEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so1737399pfj.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/05iEFWX5JXC5UQTYfzsFMJZ0Wb9bXyAbm9U1echHc=;
        b=bJ9ome+F32mgtHffonhc7VuFDb5MZ22n/lMbKqc/ykc5uxNNTM2vDz3/sLdi6YI7FQ
         15a02xVaF0yxuQO0zLdusaWcECapDiM5hrvzT+D8ZpVwnR68NNWJF5PfpmwQbwP/Q+Ie
         /X3XgDaaSj4vKbA/9J7+CcbXs35ByKyqm+l2motVBuPZ/v4IciqPhi7jUQktoM66kPOH
         6h0lu9KF9OxTuSMKomdo3381QxD9OZK1x2eoK0VAtnIK9YuYK/Uo6FAPA9WkcJGfjTJO
         4bdIIuU0ZLkcn3DdSxJTBXNZRRXEJ5MAfC/HBfAThJE6N1lMFhV651yY1sG/OcmhI0WL
         jTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/05iEFWX5JXC5UQTYfzsFMJZ0Wb9bXyAbm9U1echHc=;
        b=AxzzkrJRTFN7cc8wONToxhQ0jvL1LhP0uDFbCTKxyPdip8Bg7vynV+wHPosBa0oGQC
         UT6KAXcPyJWJ3YfICHQa0rKgq8rDOoXcy6mKczDhyIdLm2YGbMzwoSXRmoei7CXc6Kif
         F1QdLI/V0J51eiUA0Gokw5Z44Vw56Nki7Idihfe45SzqDY/0QD9ZRCN8pgbbJXM/i0R3
         ysVWdgyp5jmLb5UoLoGeYWDcPdIfnKjX8CyYWZukpI6YQwZQ6SFnra/y0+laBcvI2Zz+
         /AlyuiN+a0Hkx8UIMJtyZId+fW+np7LNpgVwn7hExhegYgeWOt+oJcpDcmrQV3eIzBT7
         Xqiw==
X-Gm-Message-State: AGi0Pual/cFCv5xb9PmTz3+Q0gEHCytwPzHwLn5JP/h0LAsLXOMO/XES
        za/CC+Lu0DkfocM8JLYR/A+9oATZ
X-Google-Smtp-Source: APiQypKOf0KI7tjO0A2c/yPIzhYjrwGBACyiPy+XhqxZLk0KGer0z/dsnjBCauvSI/15+c4YqOhbJg==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr3115804pfh.299.1585832674074;
        Thu, 02 Apr 2020 06:04:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:33 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 1/6] ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
Date:   Thu,  2 Apr 2020 20:04:00 +0700
Message-Id: <2fdce60075935f8ff94bc117747f1768f41ed435.1585832270.git.congdanhqx@gmail.com>
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

From: SZEDER Gábor <szeder.dev@gmail.com>

Once upon a time we ran 'make --jobs=2 ...' to build Git, its
documentation, or to apply Coccinelle semantic patches.  Then commit
eaa62291ff (ci: inherit --jobs via MAKEFLAGS in run-build-and-tests,
2019-01-27) came along, and started using the MAKEFLAGS environment
variable to centralize setting the number of parallel jobs in
'ci/libs.sh'.  Alas, it forgot to update 'ci/run-linux32-docker.sh' to
make MAKEFLAGS available inside the Docker container running the 32
bit Linux job, and, consequently, since then that job builds Git
sequentially, and it ignores any Makefile knobs that we might set in
MAKEFLAGS (though we don't set any for the 32 bit Linux job at the
moment).

So update the 'docker run' invocation in 'ci/run-linux32-docker.sh' to
make MAKEFLAGS available inside the Docker container as well.  Set
CC=gcc for the 32 bit Linux job, because that's the compiler installed
in the 32 bit Linux Docker image that we use (Travis CI nowadays sets
CC=clang by default, but clang is not installed in this image).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh                | 3 +++
 ci/run-linux32-docker.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c3a8cd2104..d637825222 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -198,6 +198,9 @@ osx-clang|osx-gcc)
 GIT_TEST_GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=true
 	;;
+Linux32)
+	CC=gcc
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 751acfcf8a..ebb18fa747 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -20,6 +20,7 @@ docker run \
 	--env GIT_PROVE_OPTS \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
+	--env MAKEFLAGS \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-- 
2.26.0.334.g6536db25bb

