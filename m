Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78820C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiBARAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiBARAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:00:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05062C06173D
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:00:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k18so33304927wrg.11
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NuKWdmCegZj7sPgFXXLtPw7o5rcay1//43Tf8j66vuY=;
        b=TCL3kWsnYOuvwap3GOSkDNrVRYO31hyfMol8IWS+qR359pM0xEFU3BW3umr0L1AXdu
         BRA572Q+fW2IsCOZ1vgWRYuw0uqAnUJBi1UcCPOUUb+CkKWLecM58y0A/IRs2S3+Nwot
         0h/+OQc1Rcxe1qhk5+B//lk4JD50WMynE2t6LVS7Lm/12olJE+afyd5oOvhSOwbXzC7/
         MYk1R2+Qhdp266PYqFaIRE9U0j9PhiWQEe/beys9fsOTTsEThPZFsUhQ2eUGCPiTx+0w
         pInxuuDAdhqcwP2j96o6ZZ768fwPHD2Kdh+Tj5Ae6h8057ekqN4Gi+a7nUFJV6VHdduB
         drqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NuKWdmCegZj7sPgFXXLtPw7o5rcay1//43Tf8j66vuY=;
        b=6L7GpTbbWRf0MqSN0MQZb+saDx91KfHXu/BRtt8P4J4JQaPfTVE4t1fqAPgIYDrDJ+
         OdwL6YqYKkWr+IJRIKX7ZGlP37u1fSYXFoVdu3wy/kHQNkhpOHBK0PSpniuNuSrB7jZA
         dKUtLqMc51LlltXZSs/Z6SAU7z/bhxS5HMoBCHrJ8552cXp3z3/+NTZFr4mZbexZuKnA
         N0panFNCQVmasi9A0zFUzlhr1ZwjZG2fAI3GIPBuDWdSZz60U7LYqHLME4U2Kl2nbc5u
         1eMso/Y7vpgoznmrnaiRXizVDSj13tXsnS/95nLCx+in4I9/d34k4YIOVWWndoCpTw46
         bxxw==
X-Gm-Message-State: AOAM532C8lGthZHJMxqsu1UbfT55BOGxlcKn+9NbLHmiF5qL14Fez75/
        OjYULunTyLN2PgFeZq6/qyRbHGUbL9c=
X-Google-Smtp-Source: ABdhPJxT3msjjfZ1ldLgpTa0N6SMtXM7jkiSJQGLVfiikQgjX1aPDo2m28yW5OI6PIWWFHykFsDRzg==
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr22769816wry.523.1643734830294;
        Tue, 01 Feb 2022 09:00:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25sm2624480wms.23.2022.02.01.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:00:29 -0800 (PST)
Message-Id: <df0ec5ffe98a17e1ec7b572085e733d8748c0379.1643734828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
        <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 17:00:26 +0000
Subject: [PATCH v3 1/3] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

