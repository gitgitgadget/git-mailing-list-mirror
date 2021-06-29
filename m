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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E4C11F68
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8350E61DE3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhF2TGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhF2TGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:06:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FBC061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u8so403791wrq.8
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbJWHCe0oQtCcSeroEJB3JRlslTVNbolE8pUYwnC8zc=;
        b=t2T2vpkMtiu1e2GqG1eto72yefUgfG5jg1ySUsy1tLUTRaxA/rGvq0N+pB28HXfRq5
         48FekjRJv1azIX2rrBmhSS7xURgENJIhqphAYVIkjc+u84umX2vYgVWMz1ZWiQdTebM6
         mN1C64HEVGpa1KJ9wJB1BR8NWgxWz9zFvn5qbdOKuOYzXMuV4vKfQETzgemDgasHAgAS
         e0URMNrIhWY3VU/6ufFG9koUwvgbAuofFPR3JIJv4i3dGAD+JmM1CJbKaStbfPKNizpx
         p2R8Oci6/MYisR6WHVeQTl7RUt7DfEIlK+mBLh+CbtBS+FAFl/JDYabvPGovYDyfmBgg
         YylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbJWHCe0oQtCcSeroEJB3JRlslTVNbolE8pUYwnC8zc=;
        b=fkqmiWO4vyxCwJXiW83222WeUTMaKs259JocVYc4Avw6j4dnkox632HDQxxZclYbHW
         zWYiY78UXJWn6n/QJpiUptUSGQaJmkF+DRu4saM3ywh5xitkpPNYeBLYucSSS7Ni/mWZ
         eOlh90RuukxTJBqb/JppXSlX1npfO6du6kh2duEwwZtsHuUVp1mnmfVpbbAK44RndXv0
         JEI3DWj9iUAtp9cMyTPsQE5vroo9QZJqbTRo+VPq1d45/coLRA3U7nqJ+AqdhqjY5XLI
         p+rhsmblr2jxeAFvyOegNUvv2YzlszGPxdEH4jn2ocCpB9UYFJbV3TYmoqRIny/UMT1q
         h2Fw==
X-Gm-Message-State: AOAM533IGWgdOdteYbD/R9ECh3HeisY1GYlraVznMzyeVvaMBakU+Kyb
        C2z+E1Pn92lbs9FxTyIS/puAetCQOxtN9Q==
X-Google-Smtp-Source: ABdhPJwRb0ljULFRrq7XGnOETlevRF+dXDEsSoRD7e7l5gO8VpNQF7CfPpDP2pBEEuIaz0BvPB/nbA==
X-Received: by 2002:adf:e706:: with SMTP id c6mr25327106wrm.13.1624993417279;
        Tue, 29 Jun 2021 12:03:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm17641188wmb.35.2021.06.29.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:03:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] Makefile: stop hardcoding {command,config}-list.h
Date:   Tue, 29 Jun 2021 21:03:32 +0200
Message-Id: <patch-2.3-983d072d52-20210629T190137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com> <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
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

A follow-up commit (not part of this series) will add a new generated
hook-list.h. By doing this refactoring we'll only need to add the new
file to the GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README
etc.

I have not tested the Windows-specific change in config.mak.uname
being made here, but we use other variables from the Makefile in the
same block, and the GENERATED_H is fully defined before we include
config.mak.uname.

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
2.32.0.615.g90fb4d7369

