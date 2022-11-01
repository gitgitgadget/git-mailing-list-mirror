Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4FC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKAXGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiKAXFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2E167E1
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q9so41011815ejd.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y0MF1K5Z6PAoaFgWE+NEJGp+hqnDMufwXj90Dv/A6I=;
        b=pXfPpYddShOcmub2iuh7Ic0rNwB9ZKMWeZ1xFYqQShQk65NYUjl4y1tgDHiG5TCNwF
         Dwct4edddz1mKsKTeMgJmwnMyuAzw9/T7OZMqA9xFCaTRD1EYICiUK+y7+kUl3k7m3//
         Ed9rG3xINrD8AyF9JC5FiMHbnOzfm1k2dx+Ptsleu6jfB5fr8TGT0VZuh3NFuOnSAL/g
         Vnxf30JZ7/kBqxxXVF9QXSJZ4cCy/2PWt/4Yf0529vyVbKHew01kg+dh2RL3sZ170jhM
         BPg5Y9q096QeHNcICe3v2aAZfG1PM0gfYwgJk/YYlZ9ToXVwJ/elE0Zwp53gvgKL48gE
         ZFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Y0MF1K5Z6PAoaFgWE+NEJGp+hqnDMufwXj90Dv/A6I=;
        b=j/XKdGRkpHzUMQmC5Oyp7HUyBIC8jLksiKhm6HoMJkS4Leq1QrCwGF7nthWjlVn7Sx
         a0PGSzU8122T3Dz5kO0GKz/XSEh1YU9AAKFu33XLz1Qg65aVtFcGCz2TCFIZGYWlmvIV
         TLaSO1gfjRQpFxw/5Ed0KyHW10QZ3Uhwsrnr63w0IUv+zJJS0eMRdzgjd36RdmuRX7CB
         7tSaPPabqz4BWTKa5YnH+hlLTTnfifTkPk47TdqWczFldeSZXdvRJTyLs8Vcw5KPNuzg
         u1shdo//RwCsquDUBtZTiJY5Z0XzCyX9dN1NMU5zly4IFEcd3bgBSnSxwzVO82YwJ7fm
         NOvQ==
X-Gm-Message-State: ACrzQf10GD4pGbX46UlhzV/dxXQj0glJpimz3CfAonzfL5W5RjxKfhHj
        VyhBON0STYzLuXll2TOjeIHf56VuiNuu9w==
X-Google-Smtp-Source: AMsMyM4I3cE2ekoJ9us4P0BL4sT8Jz61cHkizu770r7hFPtr0kQ0ke9h/kwFZOYYHp8cGoB9V46fHg==
X-Received: by 2002:a17:906:5dce:b0:78d:e71a:6e0 with SMTP id p14-20020a1709065dce00b0078de71a06e0mr20337179ejv.360.1667343938758;
        Tue, 01 Nov 2022 16:05:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] config API users: test for *_get_value_multi() segfaults
Date:   Wed,  2 Nov 2022 00:05:18 +0100
Message-Id: <patch-v2-7.9-c12805f3d55-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
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
index 96bdd420456..958d906f245 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -505,6 +505,32 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --force
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
2.38.0.1280.g8136eb6fab2

