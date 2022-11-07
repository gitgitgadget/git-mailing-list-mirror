Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC0DC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiKGVX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiKGVX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA802102F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s12so10026351edd.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HZHvERxq7vHEN22SojWO1d/+wIpRLipDbShKHvhOvM=;
        b=jJhTGweOgiVeyTwHGjJ3EF64FIN2TOyCiFcNS+yb5jNUjxdX3sD7dzAJMBdfc9+hW6
         mBTJBIRsIm7NgakGaIQJG/Awt52EU5Y9ETlN8d0nxRduqN44zlSV3xSwsLVDW6QlvUuV
         0U5Avefct5ubcJPGhPBBSG+aOU5hjl8GB0I12uYlXq3XNWHj5CK5WhCUhFsuWJrAPD0Q
         U5GQEbfuzhq/FlhdzDrvMe7YYGSRd9xBIYG+uezmsxxPNCx43YMlsK0fiNBISNS8fx59
         J3vGLZj19TD+4LOAHZehbxY8Y7OMJ78hrZ1QVjpnB+na4l7Q/Xef3a8gN4zZtqBewI8/
         uUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HZHvERxq7vHEN22SojWO1d/+wIpRLipDbShKHvhOvM=;
        b=3WjVILybDxdAn5IV3bWak7NzHA/LNjmwqgWBRO6iqwUFbyYl8UQUqEPoCvOa0UJlZM
         qMeyDK6wApGlCfpUPh2/QW5GlY47z5ePfBq2APX7Z32rx/tiGYY/xyTyZMd7J2DvDpBl
         75CP5HZ1kipaL7eHcwtJNzi5OUmxBeyYN+82UyHxH9IranXU50ICVEAJ5XDm7JC8gIwR
         ZLbvbJU0WHam+JAVE510KjDXcgjo+mNVWtcqny+bxe/lWpUgUMGy1rf2RgwkXdiAJ4Jk
         sBSEaT0nbvTljnYjuoFso1lQr3mcCpmsyDV5Gsl3zhd3JoESAZ0zBbo/kQ0+uJIt38Um
         hCkg==
X-Gm-Message-State: ACrzQf1GZ0as5p2PkrvppuUVwyjbzjNubDTebllQePucLguSJahCl0LB
        qSQxXEC66EH9cVQu94h0uYeBAFamghS+kg==
X-Google-Smtp-Source: AMsMyM57Q/vNAXY7ohTakSLSYO33cd6hXFSL3RpOcUPHft6ynXVwro+JRS7dq8WuqnxXsMmPyVzmtA==
X-Received: by 2002:aa7:d506:0:b0:461:565e:8673 with SMTP id y6-20020aa7d506000000b00461565e8673mr52578571edq.416.1667856204866;
        Mon, 07 Nov 2022 13:23:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/10] Makefile & test-tool: replace "DC_SHA1" variable with a "define"
Date:   Mon,  7 Nov 2022 22:23:10 +0100
Message-Id: <patch-v5-08.10-6daac578fd0-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address the root cause of technical debt we've been carrying since
sha1collisiondetection was made the default in [1]. In a preceding
commit we narrowly fixed a bug where the "DC_SHA1" variable would be
unset (in combination with "NO_APPLE_COMMON_CRYPTO=" on OSX), even
though we had the sha1collisiondetection library enabled.

But the only reason we needed to have such a user-exposed knob went
away with [1], and it's been doing nothing useful since then. We don't
care if you define DC_SHA1=*, we only care that you don't ask for any
other SHA-1 implementation. If it turns out that you didn't, we'll use
sha1collisiondetection, whether you had "DC_SHA1" set or not.

As a result of this being confusing we had e.g. [2] for cmake and the
recent [3] for ci/lib.sh setting "DC_SHA1" explicitly, even though
this was always a NOOP.

A much simpler way to do this is to stop having the Makefile and
CMakeLists.txt set "DC_SHA1" to be picked up by the test-lib.sh, let's
instead add a trivial "test-tool sha1-is-sha1dc". It returns zero if
we're using sha1collisiondetection, non-zero otherwise.

1. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
2. c4b2f41b5f5 (cmake: support for testing git with ctest, 2020-06-26)
3. 1ad5c3df35a (ci: use DC_SHA1=YesPlease on osx-clang job for CI,
   2022-10-20)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                            | 8 ++++----
 ci/lib.sh                           | 2 +-
 contrib/buildsystems/CMakeLists.txt | 2 --
 sha1dc_git.h                        | 1 +
 t/helper/test-sha1.c                | 8 ++++++++
 t/helper/test-tool.c                | 1 +
 t/helper/test-tool.h                | 1 +
 t/t0013-sha1dc.sh                   | 6 ++++--
 8 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 9b5f872d107..0c79546712f 100644
--- a/Makefile
+++ b/Makefile
@@ -500,8 +500,10 @@ include shared.mak
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
-# Define DC_SHA1 to enable the collision-detecting sha1
-# algorithm. This is slower, but may detect attempted collision attacks.
+# If don't enable any of the *_SHA1 settings in this section, Git will
+# default to its built-in sha1collisiondetection library, which is a
+# collision-detecting sha1 This is slower, but may detect attempted
+# collision attacks.
 #
 # ==== Options for the sha1collisiondetection library ====
 #
@@ -1867,7 +1869,6 @@ ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
-	override DC_SHA1 = YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
@@ -3030,7 +3031,6 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
-	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
 	@echo SANITIZE_ADDRESS=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_ADDRESS)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
diff --git a/ci/lib.sh b/ci/lib.sh
index 1808e3b1ce1..24d20a5d648 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -260,7 +260,7 @@ macos-latest)
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 		MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
-		MAKEFLAGS="$MAKEFLAGS DC_SHA1=YesPlease NO_OPENSSL=NoThanks"
+		MAKEFLAGS="$MAKEFLAGS NO_OPENSSL=NoThanks"
 	fi
 	;;
 esac
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3957e4cf8cd..2f6e0197ffa 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1025,7 +1025,6 @@ set(NO_PERL )
 set(NO_PTHREADS )
 set(NO_PYTHON )
 set(PAGER_ENV "LESS=FRX LV=-c")
-set(DC_SHA1 YesPlease)
 set(RUNTIME_PREFIX true)
 set(NO_GETTEXT )
 
@@ -1061,7 +1060,6 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 41e1c3fd3f7..60e3ce84395 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -17,6 +17,7 @@ void git_SHA1DCInit(SHA1_CTX *);
 void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
+#define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index d860c387c38..71fe5c61455 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -5,3 +5,11 @@ int cmd__sha1(int ac, const char **av)
 {
 	return cmd_hash_impl(ac, av, GIT_HASH_SHA1);
 }
+
+int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
+{
+#ifdef platform_SHA_IS_SHA1DC
+	return 0;
+#endif
+	return 1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 01cda9358df..775854c9f96 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -73,6 +73,7 @@ static struct test_cmd cmds[] = {
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
+	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "simple-ipc", cmd__simple_ipc },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ca2948066fd..7cf84eca12e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -66,6 +66,7 @@ int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
+int cmd__sha1_is_sha1dc(int argc, const char **argv);
 int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 9ad76080aa4..53240476896 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -6,9 +6,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
-if test -z "$DC_SHA1"
+test_lazy_prereq SHA1_IS_SHA1DC 'test-tool sha1-is-sha1dc'
+
+if ! test_have_prereq SHA1_IS_SHA1DC
 then
-	skip_all='skipping sha1 collision tests, DC_SHA1 not set'
+	skip_all='skipping sha1 collision tests, not using sha1collisiondetection'
 	test_done
 fi
 
-- 
2.38.0.1464.gea6794aacbc

