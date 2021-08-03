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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01CFC4320E
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D941260EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhHCTj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbhHCTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19228C061764
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d8so26473919wrm.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6Egb8vZeS6l9iQjRvmtuI6xE6Lpzpw0QjroqTZSFJc=;
        b=sGHDojD6Jj/w+ETJksTmInALaJDdW8u6IHm2QJEDKCqpntX5uu4R8w5LUHfgIkSWFv
         +WKrinJaveAxok05UY+7yhn9Tol26C6t/tHePdlCsViZh+jZ52UH8sWqKD+UMlnhk6+L
         JsJ9dJaAHFzAPm2rAwYxkox4J3pqVaaF3lS3Le/zVLxnMkm9R+GZ7ECCjU1Mi3UTfYbA
         q4VOFgW6S4lpG2FN3HILfsiYYnKa628ArK1nAyolzF9Euvc+VAYio6qHX517Vyj+vqzQ
         jLBxeQIS1zTxIYaF1jNRtoSwq/IveQg7Cj354KE7LI1PF94vo9B0eh2/lYu9uFRaj2MW
         8b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6Egb8vZeS6l9iQjRvmtuI6xE6Lpzpw0QjroqTZSFJc=;
        b=HQxY4cgJIU3wBORWUU54hAhnLxyc0qY11iCavSOqi7yuBNJ8xBUTJ6zlC2qihqieIt
         tJjSNVi3DNH+u49scCKmvL53kmFHyLjBGQlS1BGUCXd+X/+LCQJ9f/UkktuHP8qJEBcs
         ck38ugzdiaf4xOT0/JdYrqZxs24RMIaoMBIA481mANJs+yUI4vb3KswW6xHSYfoqR4sq
         0LPLYpEP4jh+5pAeKJi1XQOi/vOIXkG0FHEgJL+Llf62V3VauywFdH5NfqiJTp6XOcZN
         YvsHSXmnVJz3WnRRMGlQdc2l1fcZZKJzd3Ra1HPfa0jQWIveFOEPgua1LI3UHu2ghIHD
         rx4w==
X-Gm-Message-State: AOAM531A/rT6OEz7vmjPy+lTF7cx4nI7Z3V2ZZPmQXheHULnbNcbg+3c
        uXX0xXcB/lI/rKJ3UbhBLkp5diL+HfjLkg==
X-Google-Smtp-Source: ABdhPJx+YWf8gC+8z61QHoD2byumHNoW6mgb5fD7a/FwZ+xmMiYUA8IsFw2xOhctNHgY7bCSdcjzXg==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr22260648wrs.141.1628019552443;
        Tue, 03 Aug 2021 12:39:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/36] Makefile: stop hardcoding {command,config}-list.h
Date:   Tue,  3 Aug 2021 21:38:28 +0200
Message-Id: <patch-v4-02.36-0f749530777-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index 2ff038069e8..89bf0dd7332 100644
--- a/Makefile
+++ b/Makefile
@@ -823,6 +823,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+.PHONY: generated-hdrs
+generated-hdrs: $(GENERATED_H)
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2909,7 +2911,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2932,7 +2934,7 @@ style:
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
index 69413fb3dc0..9988378160b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -732,9 +732,9 @@ vcxproj:
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
2.33.0.rc0.595.ge31e012651d

