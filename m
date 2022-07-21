Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38384C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGUGwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiGUGv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10925D0EE
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id id17so486831wmb.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tF6rQyvJEX57WPMb1eq90AmSq24y/rXeoSPnyKy8LBs=;
        b=BMsdEg9E/XkBXPuapvrC1SZ0dOZyb08fLzNiMe1lh5R7FEHVeYo8N42ZaGk/Rqxm58
         Pl0KgIJgh7c6WL54pv+IPDeOVJNML383vC6Nt74f2vLGte2MRwgcO/XpjR5D9z7yn/oL
         RGCdT87MPjoQ8EkZslbpszR1V6/zT7+erAXEto8kEo20Lw8xZIdc/h7+QoCKeEodxozQ
         7Pu8p7UVvaXTYB3T/4PcoJPWDT+h23g1ilcBKi0ELn6AxjiCjV35Yhou0bFe5yrt93/8
         uFJgvrV9dtsWRX/JrtJ6XJhgo5k6trO6PYZNseVUJcJD//Q81Fmb2yL2TQ7FW3IgCGd6
         +TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tF6rQyvJEX57WPMb1eq90AmSq24y/rXeoSPnyKy8LBs=;
        b=3R4sh/6ch3TRtgjjoiTQFiNwxyC86uJ95oyv/RO91kBcYI3jEQOt4shGcoL96iWo6T
         9YQUW7cDMcsK3rSLbNcPg+CpWHEinJ6fuX0ibnGngvTBJ6qa2lta94sPPVBPdOiAzXSt
         w/lDhTRecSQttTbYeV83kdDbREXRZeqyjH/LBJ300HcW5Tl22kUIIK9fgahynFu5/3k+
         zm5gvrIxoK20esbvh1y92XoFQ16UayB6gE2S0K8KsZ/Yv6wnlnTPcUzaXhmIAh8L8tR9
         fFcPxm5Y8DDZE54l4NdB04+qQHiB6NN/5dxt7TbmeIIlGcAnL3DVJj60yDCx7/PQVsTP
         XjVQ==
X-Gm-Message-State: AJIora9xYRXIC44Wgl4TQ/aRSLrUvczizLot1h+ebIeYs5b0AEP5M9D/
        twS7CPcRa0owrbmXgm2AcgE/blCC4XcWlA==
X-Google-Smtp-Source: AGRyM1vaR3eIqAa1bJploWv3xRs0ty2Af2bnHNu5fU/FEc94a7AVHimxaS4Dwzj+EMNluUdBgwDISg==
X-Received: by 2002:a05:600c:1d21:b0:3a3:3227:e482 with SMTP id l33-20020a05600c1d2100b003a33227e482mr634521wms.121.1658386312903;
        Wed, 20 Jul 2022 23:51:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] test-lib-functions: add and use test_cmp_cmd
Date:   Thu, 21 Jul 2022 08:51:41 +0200
Message-Id: <patch-4.6-df1b674b8a7-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "test_cmp_cmd" helper for the common pattern discussed in the
documentation being added here to "t/test-lib-functions.sh".

This implementation leaves the door open for extending this helper
past its obvious limitations, such as:

	test_cmp_cmd "some" "lines" -- <some-cmd>
	test_cmp_cmd --stdin <some-cmd> <expect
	test_cmp_cmd --ignore-stderr "output" <some-cmd>

By using this in t0060-path.sh we'll catch cases where "git" or
"test-tool" errors (such as segfaults or abort()) were previously
hidden, and we'd either pass the test, or fail in some subsequent
assertion.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0060-path-utils.sh   | 45 +++++++++++++++++++++++------------------
 t/test-lib-functions.sh | 18 +++++++++++++++++
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 1f2007e62b7..6f278417e83 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -10,8 +10,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 norm_path() {
 	expected=$(test-tool path-utils print_path "$2")
-	test_expect_success $3 "normalize path: $1 => $2" \
-	"test \"\$(test-tool path-utils normalize_path_copy '$1')\" = '$expected'"
+	test_expect_success $3 "normalize path: $1 => $2" "
+		echo '$expected' >expect &&
+		test-tool path-utils normalize_path_copy '$1' >actual &&
+		test_cmp expect actual
+	"
 }
 
 relative_path() {
@@ -166,8 +169,10 @@ ancestor D:/Users/me C:/ -1 MINGW
 ancestor //server/share/my-directory //server/share/ 14 MINGW
 
 test_expect_success 'strip_path_suffix' '
-	test c:/msysgit = $(test-tool path-utils strip_path_suffix \
-		c:/msysgit/libexec//git-core libexec/git-core)
+	echo c:/msysgit >expect &&
+	test-tool path-utils strip_path_suffix \
+		c:/msysgit/libexec//git-core libexec/git-core >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'absolute path rejects the empty string' '
@@ -189,34 +194,34 @@ test_expect_success 'real path rejects the empty string' '
 
 test_expect_success POSIX 'real path works on absolute paths 1' '
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-tool path-utils real_path "/")" &&
-	test "/$nopath" = "$(test-tool path-utils real_path "/$nopath")"
+	test_cmp_cmd / test-tool path-utils real_path "/" &&
+	test_cmp_cmd "/$nopath" test-tool path-utils real_path "/$nopath"
 '
 
 test_expect_success 'real path works on absolute paths 2' '
 	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "$d")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "$d/$nopath")"
+	test_cmp_cmd "$d" test-tool path-utils real_path "$d" &&
+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "$d/$nopath"
 '
 
 test_expect_success POSIX 'real path removes extra leading slashes' '
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-tool path-utils real_path "///")" &&
-	test "/$nopath" = "$(test-tool path-utils real_path "///$nopath")" &&
+	test_cmp_cmd "/" test-tool path-utils real_path "///" &&
+	test_cmp_cmd "/$nopath" test-tool path-utils real_path "///$nopath" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "//$d")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "//$d/$nopath")"
+	test_cmp_cmd "$d" test-tool path-utils real_path "//$d" &&
+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "//$d/$nopath"
 '
 
 test_expect_success 'real path removes other extra slashes' '
 	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "$d///")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "$d///$nopath")"
+	test_cmp_cmd "$d" test-tool path-utils real_path "$d///" &&
+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "$d///$nopath"
 '
 
 test_expect_success SYMLINKS 'real path works on symlinks' '
@@ -227,19 +232,19 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir third &&
 	dir="$(cd .git && pwd -P)" &&
 	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
+	test_cmp_cmd "$dir" test-tool path-utils real_path $dir2 &&
 	file="$dir"/index &&
-	test "$file" = "$(test-tool path-utils real_path $dir2/index)" &&
+	test_cmp_cmd "$file" test-tool path-utils real_path $dir2/index &&
 	basename=blub &&
-	test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
+	test_cmp_cmd "$dir/$basename" test-tool -C .git path-utils real_path "$basename" &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first && pwd -P)"/file &&
-	test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
+	test_cmp_cmd "$sym" test-tool path-utils real_path "$dir2/syml"
 '
 
 test_expect_success SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
 	ln -s target symlink &&
-	test "$(test-tool path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+	test_cmp_cmd "symlink" test-tool path-utils prefix_path prefix "$(pwd)/symlink"
 '
 
 test_expect_success 'prefix_path works with only absolute path to work tree' '
@@ -255,7 +260,7 @@ test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
 test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
 	git init repo &&
 	ln -s repo repolink &&
-	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
+	test_cmp_cmd "a" test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a"
 '
 
 relative_path /foo/a/b/c/	/foo/a/b/	c/
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..63e46442eb6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1366,6 +1366,24 @@ test_cmp_rev () {
 	fi
 }
 
+# test_cmp_cmd is a convenience helper for doing the more verbose:
+#
+#	echo something >expect &&
+#	<some-command-and-args> >actual &&
+#	test_cmp expect actual
+#
+# As:
+#
+#	test_cmp_cmd something <some-command-and-args>
+test_cmp_cmd () {
+	local expect="$1" &&
+	shift &&
+	printf "%s\n" "$expect" >expect &&
+	"$@" >actual 2>err &&
+	test_must_be_empty err
+	test_cmp expect actual
+}
+
 # Compare paths respecting core.ignoreCase
 test_cmp_fspath () {
 	if test "x$1" = "x$2"
-- 
2.37.1.1095.g64a1e8362fd

