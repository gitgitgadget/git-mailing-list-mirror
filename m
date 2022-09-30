Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88CDC4332F
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiI3LgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiI3Lfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A613A95F
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso2097859wmq.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B9KP+RgI0IjE9hlGGaHgkjJvxR+rakOvdniboxz8hUs=;
        b=USPeyIhZp73uEbeqoUu2bCDet3lXYg+PLjLlbYLH/WrEllFTo6Sx63Hv2BbYksIqCL
         VSmUCPopbTUrLFmT1Lvj8a3JCTUmzYRI7hDVCDE2A/9z5/YUN53s9ezAKFKFp0cgT4MI
         0aukxU7CwPNQsFTPxqc/TAa2CsgtnxZIgb3vEMwy31XNTiUTwbewZm88zDkbSAO//zd4
         XpBd6CsUDBzRGp5KehzM6CuDpZWavHNcoI+8lhq/Jp63vLSFRLIQqVm5bK/qRj3KaC0G
         X39FkisDROmJ5szBjyKo0Hd6QWtJ1Yuv8St6PxgEhfvvwpwTN5zTFirVTSNDnvM6aUE/
         2SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B9KP+RgI0IjE9hlGGaHgkjJvxR+rakOvdniboxz8hUs=;
        b=uBO6+HncCSKhG8oLAQF12G9wHOsbRRUiSud/jAo53LdGGRTH69WSWTRrgm1sm48vLa
         E0UXr1UhDn85ySut9G9gTN8fC863/y4EzxsabAZMyrck8ip8mQhFyiAB3urhVCXaurBf
         FnSpQ8I0I0czXoEJ7J8LhyyCm6AiOJGETLRklNOdwUqoEYhadHUd7o7tMU6xsTYrAibK
         oM9HueD3eqTil2xwuJJu3AsT5ylffMuh6DJSzY8adNlmHMdL62zVfWXeGsblc7VF29s1
         fFG3friWmRGgi7/QvCzWIKdlROF4ufNrLJr2d0phN5oDcgCY2SVEWVS1rMuIKqXsFqyd
         itRQ==
X-Gm-Message-State: ACrzQf1crjUwuQ/kPX9Abt+c9gTtfDSjt3ZTteBP4ErifUM3ZtaZ/b5S
        N5CtGMs0iy97ntg9jZpwjDM70vL6+j9ceg==
X-Google-Smtp-Source: AMsMyM6NwkA8yQodsF1+NpkZlQkib37tAgpLXZAA8R4EWJeWnkgD8d+8kqxFwKiUQtKarsIY7T+WIA==
X-Received: by 2002:a05:600c:4e91:b0:3b4:bcbd:b641 with SMTP id f17-20020a05600c4e9100b003b4bcbdb641mr14274935wmq.59.1664537298086;
        Fri, 30 Sep 2022 04:28:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/15] submodule tests: reset "trace.out" between "grep" invocations
Date:   Fri, 30 Sep 2022 13:27:59 +0200
Message-Id: <patch-02.15-605b15fceab-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix test patterns added in 62104ba14af (submodules: allow parallel
fetching, add tests and documentation, 2015-12-15) and
a028a1930c6 (fetching submodules: respect `submodule.fetchJobs` config
option, 2016-02-29).

In the former case we were leaving a trace.out file at the top-level
for any subsequent tests (there are none, currently). Let's clean the
file up instead.

In the latter case we were testing that a given configuration would
result in "N tasks" in the log, but we were grepping through the log
for all previous such tests, when we really meant to clear the logs
between the "grep" invocations.

In practice this resulted in no logic error, as e.g. "--fetch 7" would
not print out a "9 tasks" line, but let's be paranoid and stop
implicitly assuming that that's the case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5526-fetch-submodules.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a301b56db89..e36f9fdf242 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -177,6 +177,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	test_when_finished "rm -f trace.out" &&
 	add_submodule_commits &&
 	(
 		cd downstream &&
@@ -704,17 +705,25 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 
 test_expect_success 'fetching submodules respects parallel settings' '
 	git config fetch.recurseSubmodules true &&
+	test_when_finished "rm -f downstream/trace.out" &&
 	(
 		cd downstream &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "1 tasks" trace.out &&
+		>trace.out &&
+
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
 		grep "7 tasks" trace.out &&
+		>trace.out &&
+
 		git config submodule.fetchJobs 8 &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "8 tasks" trace.out &&
+		>trace.out &&
+
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
-		grep "9 tasks" trace.out
+		grep "9 tasks" trace.out &&
+		>trace.out &&
 	)
 '
 
-- 
2.38.0.rc2.935.g6b421ae1592

