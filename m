Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBC2C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A0861152
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbhIWKcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbhIWKco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D3C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w17so15659516wrv.10
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNHxA9w4355X0jut1wR1e2qwaNjWWhZi3GApKEGEsA0=;
        b=C4PzsMCTOlxpR3eroK543mK39lQb20jHmJqF/GcGARtLQTUma3cHiqlyfvUs+ikLx7
         F5ET5a/FZCe+/DW2KlvuEpre/k4nWcYLk9lZQ/qmG/JiPdknSPVCUI4Hc7vocL7FYMDk
         HpLkreElRLfE6gFVnPw25axTaQzs4wcHfgB/PbbrOa1RXgaxXytn7hMxavKFH9cZcbIq
         pjfmzkBM1NItKu+qspk/SFvp03ays9j60hkEadJMr+jZHYdQMJcUDWHpSGZScbbnnyjM
         McdHVhlCxBB9Ub+lc/RkA4XH8UAl9+LMdTInFIRQ1xJ2BYybxjj1xRCMu4c1ppp70bzv
         0WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNHxA9w4355X0jut1wR1e2qwaNjWWhZi3GApKEGEsA0=;
        b=Q2dLWs07LbwGqxKjGMnsyeR2nyn+qWMMl9JrYe8Z7whe1Msxt7jY9ZYxm6kdySKD5Y
         u90dcn+++1YsI3rex/2cP9zhgTZT6bwzRFUEtPiW7o2PPjY9/Cl0navGCOadPwdW9Jju
         +46NLwg41GhcNHDV38Vi/3NUT/7viJwBL22J9LaYglocOBxH04tJwnmTmqyuM10xvGqD
         Id0Z65SCJrT3/TpE4+PFt+oZ7wSaeLEg3CiziOItP12evBAwx61o3zJK9UgbeNiaUaUW
         44JyAVrw16RIITUXPxJZ3K9eb1BLXZqNTTxQVyZnTi45nbyGo5omoiumufM4KrBz9sy1
         w60A==
X-Gm-Message-State: AOAM532T6y79bexw3HB+P3tbgZagEcctq10q4/6tVW4XxvqoGRMGenM2
        rUp6gzf6oiFZ9F3hlGhTx4D+FmiMGxBTqw==
X-Google-Smtp-Source: ABdhPJz4G8rJXArRqZy7wRKzkAKZ9drcZ8wfinsklmlmugKnC81HOWpX9za8uaoJXwfBaWpb/DdeYw==
X-Received: by 2002:adf:f2c4:: with SMTP id d4mr4287280wrp.434.1632393071749;
        Thu, 23 Sep 2021 03:31:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] Makefile: stop hardcoding {command,config}-list.h
Date:   Thu, 23 Sep 2021 12:29:57 +0200
Message-Id: <patch-2.8-804795771c6-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
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
index e85a8e07d3e..eb5780264a4 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+.PHONY: generated-hdrs
+generated-hdrs: $(GENERATED_H)
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2910,7 +2912,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2933,7 +2935,7 @@ style:
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
2.33.0.1229.g0a86d28df49

