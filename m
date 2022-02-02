Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2ABC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 03:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiBBDmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 22:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiBBDmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 22:42:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82DFC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 19:42:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s18so35728787wrv.7
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NuKWdmCegZj7sPgFXXLtPw7o5rcay1//43Tf8j66vuY=;
        b=hvDMrRUpdI+9WogbCK2sekmTo3QF1gUFEYW2Yv3BoAIfRlG0JahvcO4vSW8pYIJGN2
         mkLn1NTxfwxG9wLoa5BwVtHiMthEO4pqSMXHugVeicXwNzmTrVXIrtMA2GXr9DRFx8Ki
         a3PNiMBJRM15RK41EH6eIGYQjFv7tT9yMU6Gmc/Z56QlQrlFTTkqsz1zf2yvMCZcY+xW
         40T4G4GvT1vZLWF6bo3JEpqS0gFnWVLbbidsIC9ZKAF81JyJB8aIFB8Lb4c6ForkvWqY
         KBQ2DMD7dGgyUKWhCovDtAesqPK8MMl+vRoOQV5Y/1VbAz5pHObZ2KtZlYCmuuM3jWis
         bFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NuKWdmCegZj7sPgFXXLtPw7o5rcay1//43Tf8j66vuY=;
        b=ny8NVc2QUwyGFn3B/ARFCVSf87z0/iL/LgeLNSa1Yy2nSkF0KwBwp1k25LlrZg7sNe
         QdtXGRinhcz+oa1BHC9cJX1yQN8NgDAewAW19P/xsJ3CK75amUucYGuiTiEydYexA4my
         I6/BSP3DAKIT6RS6XuwA0HKDbOzkZqKK1VkFX+ZCOXmzrktOwGwdSNUX3fT41mIdl61U
         hjjrPp+SnFLngoS2bDwMqLWX4yi7T7JGb/8YESb4eiTwpqwSRmtxAh8loPvxrj7YbYgc
         eL5YGUKUo3vAkpHWbQ4H0hqXm0wrtrpoibFb/52tu1g9POIoHgeE1XKKTZd8PrpXYss6
         js5Q==
X-Gm-Message-State: AOAM530qLWIsjk16X/z73LSm6zNwyR82P/UjVQXEYzVxg8INGzfqt3ym
        XoKW2YKqZHY4nnt9N0KQxSkwaSCZPRQ=
X-Google-Smtp-Source: ABdhPJw4B8Tz2bEouUwSiRE6PHU+4UF91tk4IYHaHbQpg997Y5gMVGJPtYWyRCkdmzT37vnxV1dj/w==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr23881940wrx.133.1643773363372;
        Tue, 01 Feb 2022 19:42:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm18348456wry.109.2022.02.01.19.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 19:42:42 -0800 (PST)
Message-Id: <df0ec5ffe98a17e1ec7b572085e733d8748c0379.1643773361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
References: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 03:42:38 +0000
Subject: [PATCH v4 1/3] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 3050b6dfc75d (repo-settings.c: simplify the setup,
2021-09-21), the branch for handling fetch.negotiationAlgorithm=default
was deleted.  Since this value is documented in
Documentation/config/fetch.txt, restore the check for this value.

Note that this change caused an observable bug: if someone sets
feature.experimental=true in config, and then passes "-c
fetch.negotiationAlgorithm=default" on the command line in an attempt to
override the config, then the override is ignored.  Fix the bug by not
ignoring the value of "default".

Technically, before commit 3050b6dfc75d, repo-settings would treat any
fetch.negotiationAlgorithm value other than "skipping" or "noop" as a
request for "default", but I think it probably makes more sense to
ignore such broken requests and leave fetch.negotiationAlgorithm with
the default value rather than the value of "default".  (If that sounds
confusing, note that "default" is usually the default value, but when
feature.experimental=true, "skipping" is the default value.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 repo-settings.c       |  2 ++
 t/t5500-fetch-pack.sh | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 00ca5571a1a..38c10f9977b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,6 +85,8 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
+		else if (!strcasecmp(strval, "default"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
 
 	/*
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f0dc4e69686..666502ed832 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -927,7 +927,8 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
-test_expect_success 'use ref advertisement to prune "have" lines sent' '
+test_negotiation_algorithm_default () {
+	test_when_finished rm -rf clientv0 clientv2 &&
 	rm -rf server client &&
 	git init server &&
 	test_commit -C server both_have_1 &&
@@ -946,7 +947,7 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 	rm -f trace &&
 	cp -r client clientv0 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
-		fetch origin server_has both_have_2 &&
+		"$@" fetch origin server_has both_have_2 &&
 	grep "have $(git -C client rev-parse client_has)" trace &&
 	grep "have $(git -C client rev-parse both_have_2)" trace &&
 	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
@@ -954,10 +955,20 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 	rm -f trace &&
 	cp -r client clientv2 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
-		fetch origin server_has both_have_2 &&
+		"$@" fetch origin server_has both_have_2 &&
 	grep "have $(git -C client rev-parse client_has)" trace &&
 	grep "have $(git -C client rev-parse both_have_2)" trace &&
 	! grep "have $(git -C client rev-parse both_have_2^)" trace
+}
+
+test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	test_negotiation_algorithm_default
+'
+
+test_expect_success 'same as last but with config overrides' '
+	test_negotiation_algorithm_default \
+		-c feature.experimental=true \
+		-c fetch.negotiationAlgorithm=default
 '
 
 test_expect_success 'filtering by size' '
-- 
gitgitgadget

