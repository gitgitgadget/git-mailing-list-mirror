Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894FBC4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiKYJzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKYJye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CE748424
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so5818584wmi.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWKuBVMFrCFcdf9R4hcItVFlxyZEr+3GB+LU1CF5vwA=;
        b=iUVSUim4Z8Pi8/su0fxkOnJmCk2XT6eIPIM0n3a9Vc4lumnyS7M9sI04pImjfI5Q8d
         8JqKf+dCLeXbdQgMXw/NR5NccD9ln3l0kU6xmuNG+oRvuLE5z8Y1F/qjDjA8NMbR+uXK
         qeJqQPNw9TYikIJB/9UIkhC67okC8fTFXuvoz+CtS30dX2mLvnwgzqg1caDDCp8ZBrLz
         W4NRTdmqRi11mWc0BcTOUve/CL+35R8JHkfn7R9NNAwBAVTmUXmSsHFyK4ROYraTWvBh
         tImjn/swE8rBwKALn9Myt2AMFo1GBopOP9d6aIsMhdBq9Od2IDunHozgaumqRryQeu9U
         Uh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWKuBVMFrCFcdf9R4hcItVFlxyZEr+3GB+LU1CF5vwA=;
        b=DfWD9GIR5m4wShkP92edifVNgPCgKT4ZW7wMWv8ss26pQ9Um5Pa+1bCJSpFyzPdimi
         xvJE4ZG46DQcMyK+pt/EYnwVE0IZJ3mN8s3NXPsVJj5/TtsRfk7MoEabLbJ9u/j/wZVM
         gvPTQ3MYuNux0dCwn2M9ZtPie2KYbLODIeEcroLR/e7OwIK0ZPSXPWwifcWYR5L6bzdW
         muMOtUZTqvkVB05GrGqNsY6IeOOx/betcLmzc10SG5BFtrf9u/P8vqdXirm6BLoZ53gu
         OtNy23gsllUut7Nqh7JsKOLq3tzCl6zPCQAxIrnWSS+zfY2iTI1DQN74QjJBh/rFzAw3
         IKJg==
X-Gm-Message-State: ANoB5pn+0Or+IuCDfvXcOkzMnW1izdzeELkMkbuz7llbf8Vx3ZFJuYSZ
        WEw4WfbP2u1H/bKdJPFhj+aTvjuaHJDbcHHT
X-Google-Smtp-Source: AA0mqf5/zv+Slg0KVDqxnhU0TGVvL5D2LB92+I73hS5WLd3w7A+duHK6s7ic1KRubvvaoU5RAFNO4g==
X-Received: by 2002:a05:600c:3d18:b0:3cf:b7bf:352d with SMTP id bh24-20020a05600c3d1800b003cfb7bf352dmr18943515wmb.106.1669369888389;
        Fri, 25 Nov 2022 01:51:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] config API users: test for *_get_value_multi() segfaults
Date:   Fri, 25 Nov 2022 10:50:08 +0100
Message-Id: <patch-v3-7.9-f35aacef4ca-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we'll discus in the subsequent commit these tests all
show *_get_value_multi() API users unable to handle there being a
value-less key in the config, which is represented with a "NULL" for
that entry in the "string" member of the returned "struct
string_list", causing a segfault.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh                 | 11 +++++++++++
 t/t5310-pack-bitmaps.sh        | 16 ++++++++++++++++
 t/t7004-tag.sh                 | 12 ++++++++++++
 t/t7413-submodule-is-active.sh | 12 ++++++++++++
 t/t7900-maintenance.sh         | 26 ++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2ce2b41174d..e4f02d8208b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -835,6 +835,17 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_failure 'parse log.excludeDecoration with no value' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[log]
+		excludeDecoration
+	EOF
+	git log --decorate=short
+'
+
 test_expect_success 'decorate-refs with glob' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82f..2e65c8139c4 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -404,6 +404,22 @@ test_bitmap_cases () {
 		)
 	'
 
+	test_expect_failure 'pack.preferBitmapTips' '
+		git init repo &&
+		test_when_finished "rm -rf repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			test_commit_bulk --message="%s" 103 &&
+
+			cat >>.git/config <<-\EOF &&
+			[pack]
+				preferBitmapTips
+			EOF
+			git repack -adb
+		)
+	'
+
 	test_expect_success 'complains about multiple pack bitmaps' '
 		rm -fr repo &&
 		git init repo &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 9aa1660651b..f343551a7d4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1843,6 +1843,18 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 	test_must_fail git tag -l "foo*"
 '
 
+test_expect_failure 'version sort handles empty value for versionsort.{prereleaseSuffix,suffix}' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[versionsort]
+		prereleaseSuffix
+		suffix
+	EOF
+	git tag -l --sort=version:refname
+'
+
 test_expect_success 'version sort with prerelease reordering' '
 	test_config versionsort.prereleaseSuffix -rc &&
 	git tag foo1.6-rc1 &&
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 7cdc2637649..bfe27e50732 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -51,6 +51,18 @@ test_expect_success 'is-active works with submodule.<name>.active config' '
 	test-tool -C super submodule is-active sub1
 '
 
+test_expect_failure 'is-active handles submodule.active config missing a value' '
+	cp super/.git/config super/.git/config.orig &&
+	test_when_finished mv super/.git/config.orig super/.git/config &&
+
+	cat >>super/.git/config <<-\EOF &&
+	[submodule]
+		active
+	EOF
+
+	test-tool -C super submodule is-active sub1
+'
+
 test_expect_success 'is-active works with basic submodule.active config' '
 	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
 	test_when_finished "git -C super config --unset-all submodule.active" &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 823331e44a0..2dbac07be83 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -524,6 +524,32 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --config-file ./other --force
 '
 
+test_expect_failure 'register with no value for maintenance.repo' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[maintenance]
+		repo
+	EOF
+	git maintenance register
+'
+
+test_expect_failure 'unregister with no value for maintenance.repo' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[maintenance]
+		repo
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''maintenance.repo'\''
+	EOF
+	git maintenance unregister &&
+	git maintenance unregister --force
+'
+
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 	META="a+b*c" &&
 	git init "$META" &&
-- 
2.39.0.rc0.955.ge9b241be664

