Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A3C433FE
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A50460EE4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhIZTFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhIZTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86463C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t8so45547618wri.1
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uz/++S0IIB/2z6nJJoD+oLBniQ/Q5hoIp6dizk0aWMU=;
        b=GkYHgnlcpaCaT937cq7kgIkejTjmIbPgY54tohVU3yG9ms3CTJtambpCf/VEK7OmdB
         sDaP802V1bpZXP7O/AiQ9SHV0nzjfc/Qor+UtxpHzPgdp8035sHDileppGsDptpXuLYS
         0OFxHhkGHyRvpnWPlzb8WITjN4HroqAGpck6C+h1ypD0pcYidcTXRy/2QVHDlOMoCA3l
         qd1M1NzqcpQQfNyYGEnYICbGMQz6Xg/1ToIujFcjQ9vnEJXxm4OEOgHsDU+bWAOAcMsR
         8nLY0EKUZl8JbDIYUSPpK7Xat8d2dSgEsgvRXMSRq4EcOIv3mKEW3XjAuI97QGIGaTaq
         mP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uz/++S0IIB/2z6nJJoD+oLBniQ/Q5hoIp6dizk0aWMU=;
        b=6NIBM/4YdBgNxavYXrLZ/9ge0ikOgsghCLBH8sAN9Fe6Ty0WP2+szKwAU+ZPm2g2jY
         3Wu0ZAW0aS1XSyoVL5IakZgwy8rRuTXVA4SXiDzd2sB35DjDN1OD8i5W+ZuMOXTfrmTn
         lKUvdDzox/lU7QjLSBodl5TIVcgScZ3e0FMZww9kzP8lAlC4aRn7gL3VGAqV/4DXJGdR
         SwBG3/EzZRFTqvZYs0xbgoJS7jRK77KKIxHYhGIibcmchcAOrEQxW8UPe12HXSsR4pbF
         J3SOFa8hZxzENwJK07S79IIWj0thh2d1jQIjQB1LRgrh9QmNZBEwXW+VUrR8T36cZOv4
         0UPA==
X-Gm-Message-State: AOAM531pAnDcp7hI4yThP52Q6FuIse5MQ6LMLkNNqIG7Z8WlUv4u/pHs
        9cezUozUTERxIuesobiHTko+1CeBhSMQhw==
X-Google-Smtp-Source: ABdhPJxMmZzTVsHjheQIssBd0diPC++/5YDEG3UTYM4Nl22DbnQI+J+jVxBgzASsVu81/kSVgnvQBQ==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr23914454wri.141.1632683013859;
        Sun, 26 Sep 2021 12:03:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] Makefile: stop hardcoding {command,config}-list.h
Date:   Sun, 26 Sep 2021 21:03:23 +0200
Message-Id: <patch-v2-2.8-520e4baede6-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various places that hardcode the names of these two files to
refer to either $(GENERATED_H), or to a new generated-hdrs
target. That target is consistent with the *-objs targets I recently
added in 029bac01a8 (Makefile: add {program,xdiff,test,git,fuzz}-objs
& objects targets, 2021-02-23).

A subsequent commit will add a new generated hook-list.h. By doing
this refactoring we'll only need to add the new file to the
GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README etc.

Hardcoding command-list.h there seems to have been a case of
copy/paste programming in 976aaedca0 (msvc: add a Makefile target to
pre-generate the Visual Studio solution, 2019-07-29). The
config-list.h was added later in 709df95b78 (help: move
list_config_help to builtin/help, 2020-04-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile              | 6 ++++--
 compat/vcbuild/README | 2 +-
 config.mak.uname      | 6 +++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 2777284b0f1..47e79a6252a 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+.PHONY: generated-hdrs
+generated-hdrs: $(GENERATED_H)
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2903,7 +2905,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2926,7 +2928,7 @@ style:
 	git clang-format --style file --diff --extensions c,h
 
 .PHONY: check
-check: config-list.h command-list.h
+check: $(GENERATED_H)
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 51fb083dbbe..29ec1d0f104 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -92,7 +92,7 @@ The Steps of Build Git with VS2008
    the git operations.
 
 3. Inside Git's directory run the command:
-       make command-list.h config-list.h
+       make generated-hdrs
    to generate the header file needed to compile git.
 
 4. Then either build Git with the GNU Make Makefile in the Git projects
diff --git a/config.mak.uname b/config.mak.uname
index 76516aaa9a5..8aac06eb094 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -735,9 +735,9 @@ vcxproj:
 	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
 	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
 
-	# Add command-list.h and config-list.h
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h
-	git add -f config-list.h command-list.h
+	# Add generated headers
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(GENERATED_H)
+	git add -f $(GENERATED_H)
 
 	# Add scripts
 	rm -f perl/perl.mak
-- 
2.33.0.1291.g8857a6a91ac

