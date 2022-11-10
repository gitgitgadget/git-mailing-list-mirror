Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79EC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKJQO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKJQO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:14:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA12EE0A
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:14:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i21so3802866edj.10
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXVZTIGuJTQ5MNkmw+oX8vFgqXomAG90b1Pe/0xFEIA=;
        b=DZUkiBlgXPjHznpgujWBYD1R6FUsNjl4xLBSPNzKf5MemTARZ3awxtktaritKChZcT
         lj37Qpp2k8ZjZNY5eboN6X32BpYXC/XlO1c/Acw7FVmuSnlI3sK70plim2OJkWCsxfz9
         w1rfSR874QUp2Ndzin9IqdUPgPheLo+bhYrM6KhIZc/HCzyVx1rn30lK0Q8N7MfKAgpi
         6U7N8dlzBpkUJaQV9dawnZcO2rBm9iZ+vu8KniJkYuAbYIycL6cFyuuMSNaZB+cjlNXn
         T7pRfnICIr5i2YbBDvturjL0obf3vTybzd4TjkQAncP1mWni83GCXCn+Q/B+iXRFKmii
         /J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXVZTIGuJTQ5MNkmw+oX8vFgqXomAG90b1Pe/0xFEIA=;
        b=cBV1hnk/TxF5qmjOCZD4IAm14maiiSqbUi2kyafdK0ugvYOxnQyCOaak/scVjiCiNZ
         q+U0FrXVaHu/ZUw8Nk3LuqoQRL5FAiq6zajklN06kKOJ7GG1mNGIbXjW0LqUkIJ7kU2e
         +LyZRqPAt/DayBjzvUWmmWhcE+2n1gjo7CSITGTrx1VafIvdXkjWB2aiwmUqEkedpKak
         ymdLw+kRgTrXa3ZnnBlYTGkkRNBYc2SAQ51FNHKbaP2zCiYkljIEe4Pg0x5ZCONuAfZY
         2mrAH2pBUZhoTJDXxZVjdoAp+fUZrumaYWKAFIO3scjlaM7hZh4vm1ClT/Jwc+Y4fc6L
         BDGA==
X-Gm-Message-State: ACrzQf0B+dNspgljOpfypUkBltZFeMYSpc8UYpM8wsUmN51A9PwVsYOK
        Ub16AFnSVUbhqw+zvF0Na+pOwM6utAR9UA==
X-Google-Smtp-Source: AMsMyM69jhRScO6PrXPZjBwqB7eRMjMazelijrf54jh14AsoyQ3WaJSerYgneW3qi/DIERToclcfWg==
X-Received: by 2002:aa7:c981:0:b0:461:522c:ce0d with SMTP id c1-20020aa7c981000000b00461522cce0dmr61411249edt.169.1668096863157;
        Thu, 10 Nov 2022 08:14:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ed13-20020a056402294d00b00459e3a3f3ddsm8763462edb.79.2022.11.10.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:14:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: don't create a ".build/.build/" for cocci, fix output
Date:   Thu, 10 Nov 2022 17:14:18 +0100
Message-Id: <patch-1.1-5bdb8deb0c7-20221110T161232Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1465.g0d50a1dab40
In-Reply-To: <221109.86tu38p1x8.gmgdl@evledraar.gmail.com>
References: <221109.86tu38p1x8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a couple of issues in the recently merged 0f3c55d4c2b (Merge
branch 'ab/coccicheck-incremental' into next, 2022-11-08):

In copying over the "contrib/coccinelle/" rules to
".build/contrib/coccinelle/" we inadvertently ended up with a
".build/.build/contrib/coccinelle/" as well. We'd generate the
per-file patches in the former, and keep the rule and overall result
in the latter. E.g. running:

	make contrib/coccinelle/free.cocci.patch COCCI_SOURCES="attr.c grep.c"

Would, per "tree -a .build" yield the following result:

	.build
	├── .build
	│   └── contrib
	│       └── coccinelle
	│           └── free.cocci.patch
	│               ├── attr.c
	│               ├── attr.c.log
	│               ├── grep.c
	│               └── grep.c.log
	└── contrib
	    └── coccinelle
	        ├── FOUND_H_SOURCES
	        ├── free.cocci
	        └── free.cocci.patch

Now we'll instead generate all of our files in
".build/contrib/coccinelle/". Fixing this required renaming the
directory where we keep our per-file patches, as we'd otherwise
conflict with the result.

Now the per-file patch directory is named e.g. "free.cocci.d". And the
end result will now be:

	.build
	└── contrib
	    └── coccinelle
	        ├── FOUND_H_SOURCES
	        ├── free.cocci
	        ├── free.cocci.d
	        │   ├── attr.c.patch
	        │   ├── attr.c.patch.log
	        │   ├── grep.c.patch
	        │   └── grep.c.patch.log
	        └── free.cocci.patch

The per-file patches now have a ".patch" file suffix, which fixes
another issue reported against 0f3c55d4c2b: The summary output was
confusing. Before for the "make" command above we'd emit:

	[...]
	MKDIR -p .build/contrib/coccinelle
	CP contrib/coccinelle/free.cocci .build/contrib/coccinelle/free.cocci
	GEN .build/contrib/coccinelle/FOUND_H_SOURCES
	MKDIR -p .build/.build/contrib/coccinelle/free.cocci.patch
	SPATCH .build/.build/contrib/coccinelle/free.cocci.patch/grep.c
	SPATCH .build/.build/contrib/coccinelle/free.cocci.patch/attr.c
	SPATCH CAT $^ >.build/contrib/coccinelle/free.cocci.patch
	CP .build/contrib/coccinelle/free.cocci.patch contrib/coccinelle/free.cocci.patch

But now we'll instead emit (identical output at the start omitted):

	[...]
	MKDIR -p .build/contrib/coccinelle/free.cocci.d
	SPATCH grep.c >.build/contrib/coccinelle/free.cocci.d/grep.c.patch
	SPATCH attr.c >.build/contrib/coccinelle/free.cocci.d/attr.c.patch
	SPATCH CAT .build/contrib/coccinelle/free.cocci.d/**.patch >.build/contrib/coccinelle/free.cocci.patch
	CP .build/contrib/coccinelle/free.cocci.patch contrib/coccinelle/free.cocci.patch

I.e. we have an "SPATCH" line that makes it clear that we're running
against the "{attr,grep}.c" file. The "SPATCH CAT" is then altered to
correspond to it, showing that we're concatenating the
"free.cocci.d/**.patch" files into one generated "free.cocci.patch" at
the end.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This fixes the issues SZEDER reported against the
ab/coccicheck-incremental topic (now in "next") in
https://lore.kernel.org/git/20221109150556.GE1731@szeder.dev/ and
https://lore.kernel.org/git/20221109145701.GD1731@szeder.dev/

 Makefile   | 12 ++++++------
 shared.mak |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 36cefe3b1d6..15b29652221 100644
--- a/Makefile
+++ b/Makefile
@@ -3236,14 +3236,14 @@ endif
 define cocci-rule
 
 ## Rule for .build/$(1).patch/$(2); Params:
-# $(1) = e.g. "free.cocci"
+# $(1) = e.g. ".build/contrib/coccinelle/free.cocci"
 # $(2) = e.g. "grep.c"
 # $(3) = e.g. "grep.o"
-COCCI_$(1:.build/contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
-.build/$(1).patch/$(2): GIT-SPATCH-DEFINES
-.build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
-.build/$(1).patch/$(2): $(1)
-.build/$(1).patch/$(2): .build/$(1).patch/% : %
+COCCI_$(1:.build/contrib/coccinelle/%.cocci=%) += $(1).d/$(2).patch
+$(1).d/$(2).patch: GIT-SPATCH-DEFINES
+$(1).d/$(2).patch: $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
+$(1).d/$(2).patch: $(1)
+$(1).d/$(2).patch: $(1).d/%.patch : %
 	$$(call mkdir_p_parent_template)
 	$$(QUIET_SPATCH)if ! $$(SPATCH) $$(SPATCH_FLAGS) \
 		$$(SPATCH_INCLUDE_FLAGS) \
diff --git a/shared.mak b/shared.mak
index a34b66c926d..be1f30ff206 100644
--- a/shared.mak
+++ b/shared.mak
@@ -72,9 +72,9 @@ ifndef V
 	QUIET_RC       = @echo '   ' RC $@;
 
 ## Used in "Makefile": SPATCH
-	QUIET_SPATCH			= @echo '   ' SPATCH $@;
+	QUIET_SPATCH			= @echo '   ' SPATCH $< \>$@;
 	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
-	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $$^ \>$@;
+	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $(@:%.patch=%.d/)\*\*.patch \>$@;
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.38.0.1465.g0d50a1dab40

