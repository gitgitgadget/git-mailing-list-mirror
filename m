Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93840C636D6
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBGQLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjBGQLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:11:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29BC3BDB4
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:11:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r3so6531471edq.13
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6ZXguUL0zvth7OMKc/pWf+se5PT0Xbq4S3yjQlRB2Q=;
        b=g05voD7zphnKLLpc0gKjqlP94fnU7XBA8Z1Hp4znJvH+Do3xuqkzOFrmWtZvLV9dm2
         YtsU4u/Z7EoDt5iOsYR7EZOhRYWO3GeSRzSBxlpszcWrGxtOlT7TiSoR4gBEx4yNgJ6Y
         h6ebVnW4ORjM9y87zv4s61cm2zc+DldaOdJx92PUzeNHFX4Tgrn4iSGpTdr9Ok+lcfgs
         24d2Qez2qwg7DmVYOHmbRJimZvRGRzvk0zQYfIQWaNVUgObTxiAmcQgPohyf4KUZEZMq
         hwejcudvH3DxIA/KfKAgYlhmwstDutw6Xq2G0yqaZid4gNaEA3zFhyzJZhVTWqwfOhUr
         f9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6ZXguUL0zvth7OMKc/pWf+se5PT0Xbq4S3yjQlRB2Q=;
        b=AtULXjcLdU6CNQHIpVT76fXXdK5QMiBedlNO1V33BoF7Ixd80unpH+pDo9flA9ZIbx
         ByYA/cb2bIC6GyNvGKTgH6i5aNkkUl7ryoM/yr/Rf63yPf6Y/zvi+yQ7vw3pbS0yXcEF
         61fWBgRJSfscNB8fBwHT8db13+xZ88y+7O45QIbulmFhnni4Gs4GUReHGdsobh5+D24H
         ZGJ0XmwC4B5xXi9xxyJzNADk/cwAOMXXroJtUL7USf+jHjTYq6pH63l4bpjT1+ndtVM8
         tJgn/GrAi6+dd2D0xdh8xfYHE06jpqpB8Ih7ZYG5sZkwDNR9l3OZXGyc4zqJKojlrv8s
         0A2A==
X-Gm-Message-State: AO0yUKUMO+B/S0GIcrvYwMAtR5oaC12EFnXEvD+WPlh5NRC0uqSsdnty
        BAfH164TBOcmZwYIesN2s5GC2edCiOi1jj0u
X-Google-Smtp-Source: AK7set+dWjOdBJf75240B4PFQZKDVjkpMjuB/bVeKWyzg7ykNxhrFtwBK+YRUX4PM5TvOcKLT+BkQw==
X-Received: by 2002:a17:906:7097:b0:885:fee4:69ee with SMTP id b23-20020a170906709700b00885fee469eemr4008784ejk.59.1675786263862;
        Tue, 07 Feb 2023 08:11:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:11:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/10] config API users: test for *_get_value_multi() segfaults
Date:   Tue,  7 Feb 2023 17:10:48 +0100
Message-Id: <patch-v5-08.10-d9abc78c2be-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we'll discuss in the subsequent commit these tests all
show *_get_value_multi() API users unable to handle there being a
value-less key in the config, which is represented with a "NULL" for
that entry in the "string" member of the returned "struct
string_list", causing a segfault.

These added tests exhaustively test for that issue, as we'll see in a
subsequent commit we'll need to change all of the API users
of *_get_value_multi(). These cases were discovered by triggering each
one individually, and then adding these tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh                 | 11 +++++++++++
 t/t5310-pack-bitmaps.sh        | 16 ++++++++++++++++
 t/t7004-tag.sh                 | 12 ++++++++++++
 t/t7413-submodule-is-active.sh | 12 ++++++++++++
 t/t7900-maintenance.sh         | 23 +++++++++++++++++++++++
 5 files changed, 74 insertions(+)

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
index 7d8dee41b0d..0306b399188 100755
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
index 823331e44a0..d82eac6a471 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -524,6 +524,29 @@ test_expect_success 'register and unregister' '
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
+	git maintenance unregister &&
+	git maintenance unregister --force
+'
+
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 	META="a+b*c" &&
 	git init "$META" &&
-- 
2.39.1.1430.gb2471c0aaf4

