Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65CC10F13
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354EA20674
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbhAZWKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbhAZWGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 17:06:23 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE8C061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 14:05:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bl23so4633534ejb.5
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8WjSzFFeOzitjlZCPxXdJeR5+pvW99FunhcVtFL0yQ=;
        b=rSmDVGev2kN8vzu80RdzOOvOk46MggqmKe5K2uXTuPUhuZrbaGGPgb/QQCgmvBM0xq
         JFBwT/Jqff42FBy2cq20Zhkq7hsj7l9H9eIbaOb7ezS4wbU7tSGdritsWzw+ihbTp9zK
         IMYPuDakUE4SBGS7e1dAXsXB5zuTbRsdLorg8iOaKGfeCMxqITuKTBbUn9ggvVKqsYG0
         Or+GEljESWtH/mIfeVsMfrV/j1YydJt9JJLESMlelgM1V7Tf7joP5ntNoevSJohpV/TA
         xGlaEosEHT+NB5RQIFCoKZupTPfBbTsb1xAEjofqFl/cngOPV2TYdH79CCNaHESybGJS
         UlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8WjSzFFeOzitjlZCPxXdJeR5+pvW99FunhcVtFL0yQ=;
        b=opazcdo2ociySpV7hvRYhyZeEjyF0h9iizNd0dqI2eQBe+GN8mk/wQ4RP6+fP62DuP
         G998Byj5d7vmwm3E3zW28g5SX6HYjoAd+l2qrV4rAlCF/HBJHIaRknkyUjGvH1PvsGDU
         fhZB2fU3DKkw9kqbGipKk2s8m5PRONciTWGLOwnLciXG+AlFaUWlNhB/VlpNLL45m5AC
         CZzaZBg+Uy2+/pR160YGxhEY3V5W9pgs9uqr5QnJsmjvnlC/EQoHxOgoRG/KinaOgkoS
         2y4OvxGBuvCRJ/TngkOsGCBDoQnySqqDrE8VP1YlOGnYIdmFwAerU6srRWpjrh7ugODN
         j+Qw==
X-Gm-Message-State: AOAM533tXF+H3RuBpqTkUPFKhk4r4tLsulGpwjpoFw6CVmgEHC291orr
        l+E5GCQIgPAXoeRrEjPzY6PWSIY9Mqk=
X-Google-Smtp-Source: ABdhPJzNz7h2lHrLet5/XuPRzY3KJA4j/3CBJMiUJkZvMK4Id05OjAAq2mBPOfoG7mU24QvHuasYYg==
X-Received: by 2002:a17:906:90c3:: with SMTP id v3mr4879100ejw.461.1611698740805;
        Tue, 26 Jan 2021 14:05:40 -0800 (PST)
Received: from localhost.localdomain (94-21-58-108.pool.digikabel.hu. [94.21.58.108])
        by smtp.gmail.com with ESMTPSA id m8sm38768eds.70.2021.01.26.14.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:05:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: prevent '--stress-jobs=X' from being ignored
Date:   Tue, 26 Jan 2021 23:05:33 +0100
Message-Id: <20210126220533.1452453-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.30.0.615.g3128ec9b6c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'./t1234-foo.sh --stress-jobs=X ...' is supposed to run that test
script in X parallel jobs, but the number of jobs specified on the
command line is entirely ignored if other '--stress'-related options
follow.  I.e. both './t1234-foo.sh --stress-jobs=X --stress-limit=Y'
and './t1234-foo.sh --stress-jobs=X --stress' fall back to using twice
the number of CPUs parallel jobs instead.

The former has been broken since commit de69e6f6c9 (tests: let
--stress-limit=<N> imply --stress, 2019-03-03) [1], which started to
unconditionally overwrite the $stress variable holding the specified
number of jobs in its effort to imply '--stress'.  The latter has been
broken since f545737144 (tests: introduce --stress-jobs=<N>,
2019-03-03), because it didn't consider that handling '--stress' will
overwrite that variable as well.

We could fix this by being more careful about (over)writing that
$stress variable and checking first whether it has already been set.
But I think it's cleaner to use a dedicated variable to hold the
number of specified parallel jobs, so let's do that instead.

[1] In de69e6f6c9 there was no '--stress-jobs=X' option yet, the
    number of parallel jobs had to be specified via '--stress=X', so,
    strictly speaking, de69e6f6c9 broke './t1234-foo.sh --stress=X
    --stress-limit=Y'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9fa7c1d0f6..a1634ba69d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -163,8 +163,8 @@ parse_option () {
 		;;
 	--stress-jobs=*)
 		stress=t;
-		stress=${opt#--*=}
-		case "$stress" in
+		stress_jobs=${opt#--*=}
+		case "$stress_jobs" in
 		*[!0-9]*|0*|"")
 			echo "error: --stress-jobs=<N> requires the number of jobs to run" >&2
 			exit 1
@@ -262,9 +262,9 @@ then
 	: # Don't stress test again.
 elif test -n "$stress"
 then
-	if test "$stress" != t
+	if test -n "$stress_jobs"
 	then
-		job_count=$stress
+		job_count=$stress_jobs
 	elif test -n "$GIT_TEST_STRESS_LOAD"
 	then
 		job_count="$GIT_TEST_STRESS_LOAD"
-- 
2.30.0.615.g3128ec9b6c

