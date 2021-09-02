Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027CFC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4DF610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbhIBNMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbhIBNMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D8C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1123678wme.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4yujwZRHvfKWDpk0vPk5I355epwFHoUGNFWbZCu5oE=;
        b=lMY6MN6l3sKc3ohzFtFkDlWD/d82IYmrq1HJse+a5UgA6uddsfc9JgSWtGRwStykY4
         Rr3J5Eaw27kkkErGouSbjVywQxv8WO//098997KoRoK1MUlDlt3K4qfnw3pdv72JzLvJ
         t/NgkW5y4asq4RAxfrDL0BzTfBbdLCkgtiKMbKr19bDbN42nzY2BGwh0hd5aV3hhnrYk
         5GnFuQlR+v5ZNjLbhBQfRMfIQtL1Ge5+5zK+j0toRILE4HJYmzJKZytiuGc0Kk6q9P0G
         h5ElKkz+zVXhDh1k5vdPAXE8xlPYmMZJVjSk4l30ISM1i8x33sjBaLQNTG9VVawrUKQz
         RkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4yujwZRHvfKWDpk0vPk5I355epwFHoUGNFWbZCu5oE=;
        b=CfyHjk5ud5mMgV3aIyNZDUHLYxoe679D441phtATBbVVk/LfS15ndqVq/arZwwQ6kQ
         9Jf29ojmCk6F4oOo7WIYmuBcyLwWRcnUg14ruPGqSNnmSssqAZj5u5hy4wAbqJVqUfMu
         WVgtB7X/BA8U0A/JhY2h6gp9xjeUiV5QB80M/PrakHygp08NU1FJPsgdmIZrHCB0lLxD
         lekz5g1eqZZrMhewhOLOR/flsTWQZ1dNq+B8P4lnqQog6L/W6DVt2e7QfsWoslKptEag
         l0eNKipvZVmEKvhGeDtvAhfB5Y4+RbbEszSS4H7aTy6IdCeBciA5H/bTa0uQ6MovKUyn
         U/JQ==
X-Gm-Message-State: AOAM531KgcfB5FNjpnC0yFtqACEr+/BR1Is5obloYDrFGfAm2stFkY/2
        /MeXClrXwrYiE4vOwZJDCoYZWeY4188QZg==
X-Google-Smtp-Source: ABdhPJzUSjHIrJg/JQVG+Pto3AOrSdzQ89inkwux24kfQvC9X4q6rIx97dFwgZEINWeaiWyg0PVOuA==
X-Received: by 2002:a1c:7417:: with SMTP id p23mr3131724wmc.144.1630588303077;
        Thu, 02 Sep 2021 06:11:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:42 -0700 (PDT)
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
Subject: [PATCH v5 02/36] Makefile: stop hardcoding {command,config}-list.h
Date:   Thu,  2 Sep 2021 15:11:02 +0200
Message-Id: <patch-v5-02.36-a161b7f0a5c-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
index 5ec23e6b59a..4f1f13b5f0a 100644
--- a/Makefile
+++ b/Makefile
@@ -824,6 +824,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+.PHONY: generated-hdrs
+generated-hdrs: $(GENERATED_H)
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2919,7 +2921,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2942,7 +2944,7 @@ style:
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
2.33.0.816.g1ba32acadee

