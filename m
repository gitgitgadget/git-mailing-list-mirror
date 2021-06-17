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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F3EC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A14B6102A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhFQKD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFQKDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:03:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD63C061768
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id my49so8839492ejc.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7V/gIrU4GPs/zD9QZnU/eRqwYhGVmzoVIAZOlvPLYs=;
        b=JnmEIAHW+9j2iNEQAtxekyyMK+8YG3jzZ4RIoB+ufLO007HJlJXEkYGKV9Vi/G9Dur
         1khBg8y2mZznV4cGtYF0pIjqYm7X5GQvNrVX2u3Suce+n1EVhV+VQVLLiOJnRYVOSAG5
         wNAmGK7B9xWwsfHYuaoQoQ+gYyv1y+yeCBkMFxFIBGqeJWwVd7NMKgHOYq2t5PO1Lm+D
         GfptCXOkPD0QWPOPM9KowDxEu04KDFG3l1ZTEFBq709vtfu8p6rnbqa5tp5nsRvMYeSo
         IaFfUckyQqoQzmrgp7RtF9KERAFYURhiWiiHeiiSeIPlDzzgLH1R8vUcVCaG2IjK/Rb+
         mhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7V/gIrU4GPs/zD9QZnU/eRqwYhGVmzoVIAZOlvPLYs=;
        b=hFdyPKLCA7qLdlxWg7iEW4MQeomUfa2Ca0JKa78zOrZRRjKomToN6oKOZK+UHFNfDs
         lJFmDdmaTL2T7nZ34uD/u961X9tmsZ1rZvLGEy9hs4yWalneyFxfXieO5r2E9sUV2nBg
         zxRIhT0ImSb35qEtyFcu5rXxv2ujg3UkpExCJIy2DgU7eMbfWus1P6MxDbwULS9/nb7N
         7phV8OYuqSHP3zYrZDtYnYqibti+gZmaDe5jCwb2LpllfWBSpNslo/y9GDYQIhUD2Pw/
         PGJNU9TTTc1RhgLsOgQjOAXPdwJ530W1Wro2PwnB4X+0WvjlL4DNEtksoDvhkQMYPkr4
         Gnlw==
X-Gm-Message-State: AOAM531OoYBNtSI+sRMoT2N61nKA4SO0ucFioM1S3CUXZ23fN4t8a7eZ
        2+BctdPA9vHSyUCcM6MoaNMwN+5PMvjolQ==
X-Google-Smtp-Source: ABdhPJykQwSKQ9ccMYWHcSZ+lfyG3E0QSU6wq7c/j4UXU0JsnX6IywyvNZEsK/z67H8nTCbsU+th1w==
X-Received: by 2002:a17:906:9bce:: with SMTP id de14mr4406605ejc.353.1623924102539;
        Thu, 17 Jun 2021 03:01:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7sm3827031edc.46.2021.06.17.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:01:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] Makefile: stop hardcoding {command,config}-list.h
Date:   Thu, 17 Jun 2021 12:01:37 +0200
Message-Id: <patch-2.3-6e164edb0b-20210617T095827Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
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

I have not tested the Windows-specific change in config.mak.uname
being made here, but we use other variables from the Makefile in the
same block, and the GENERATED_H is fully defined before we include
config.mak.uname.

Hardcoding command-list.h there seems to have been a case of
copy/paste programming in dce7d29551 (msvc: support building Git using
MS Visual C++, 2019-06-25). The config-list.h was added later in
709df95b78 (help: move list_config_help to builtin/help, 2020-04-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile              | 6 ++++--
 compat/vcbuild/README | 2 +-
 config.mak.uname      | 6 +++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7f984bce50..66f5ded3a4 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+.PHONY: generated-hdrs
+generated-hdrs: $(GENERATED_H)
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2888,7 +2890,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2911,7 +2913,7 @@ style:
 	git clang-format --style file --diff --extensions c,h
 
 .PHONY: check
-check: config-list.h command-list.h
+check: $(GENERATED_H)
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 51fb083dbb..29ec1d0f10 100644
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
index cb443b4e02..af4c5c540e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -722,9 +722,9 @@ vcxproj:
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
2.32.0.576.g59759b6ca7d

