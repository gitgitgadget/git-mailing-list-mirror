Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E8BC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbiF1KQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbiF1KQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D256E2FE60
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so4553715wrc.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqZN1Aig+jEWO/wyscXFvynMxrwoqjXOzDZ2WFxwZuI=;
        b=Nv/hKUDG8jcpFfYc/IVqXFrKaqu9fF2v5BLUU4R7VF4CZR31Wk9eVd01g+IsAmhWfG
         MlBfKXadLubi34D8L8jOPt7ILf4KC2xfFdJtIeCGagpB7C+skS710yFaOLXObtIjvFZo
         vBUZmbhAFdrXOgqY27Jve2Af09N1ZEQirQoR4+tvo5Ik92RFfWKwixuppZfpnNlAXGp8
         jerz70+vYPm7iMnHnEEvQIdG1EryK9vbaVxorOFsytZWKAEp5l3vM0pZsvib6ayWhLog
         9Nv1e3k+0JB4kdlvCR4BGsVc+GulTsTp8PV+Bb4E+CKNMyiF/Z/uNOqm7NijDohx74os
         zpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqZN1Aig+jEWO/wyscXFvynMxrwoqjXOzDZ2WFxwZuI=;
        b=3sXPueKfYrJmNhhf9RgxAkIwCDfMNKUWFpUeVSxnAdZDjouRi4e9i+017unjoWgb83
         zwdC/Fix3N9FkEOKrOEkSZ547DMsxcfHA8lzZVooBLQ8zImgcmonQxBk6V3MvTJOyvrn
         rd5Y5mX3/EWabuV/y2Q0aW2ZhMGHXaO1EFRWbutSHnkgfDp6KJROs/JXilryADNsEPHF
         ILb5Ou/jxJxj2BWnD8F1YI1PX7IMLnXluOVMksill6XNMGjD/u+c2wUMmuAiADeDRQJf
         B8svf3SzUyFW6TfH/NV1fm+TYeqKdcq99SQ+hnyxehx5bLB0tCqMv15iHzhriLPBv2Ya
         wowg==
X-Gm-Message-State: AJIora9pW+kSigvgMIU76ZssMWBc5BGpVP8qfE8nlfs6aJSXugtLw8mm
        Lik7GkrzbRRusWdPYYIRFv0+lJf2Etf6Iw==
X-Google-Smtp-Source: AGRyM1sJIbw/Jle0ixuDGsQogiIMGF/MPvSLwgReDOGsaGMRq2U+/DWMi/Ws6WgeVo1gfpHgi8Ma1A==
X-Received: by 2002:a05:6000:1844:b0:21b:b06c:3ab2 with SMTP id c4-20020a056000184400b0021bb06c3ab2mr17445090wri.618.1656411369070;
        Tue, 28 Jun 2022 03:16:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/8] gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
Date:   Tue, 28 Jun 2022 12:15:57 +0200
Message-Id: <patch-v3-3.8-2f4db54923d-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the variable definitions for the $(GITWEB_CSS) and $(GITWEB_JS)
so that we have a clear separation between what we use as "in" files,
v.s. our "min" files. We can now make the appending to $(GITWEB_FILES)
unconditional, since $(GITWEB_{JS,CSS}) is either the "min" or
non-"min" version. This reduces the duplication within the file.

While we're at it let's initialize "GITWEB_JSLIB_FILES" as we normally
do with such variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/Makefile | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 733b60f925e..a8752c1f11c 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -31,10 +31,12 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
-GITWEB_CSS = static/gitweb.css
+GITWEB_CSS_IN = static/gitweb.css
+GITWEB_CSS = $(GITWEB_CSS_IN)
 GITWEB_LOGO = static/git-logo.png
 GITWEB_FAVICON = static/git-favicon.png
-GITWEB_JS = static/gitweb.js
+GITWEB_JS_IN = static/gitweb.js
+GITWEB_JS = $(GITWEB_JS_IN)
 GITWEB_SITE_HTML_HEAD_STRING =
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
@@ -57,7 +59,7 @@ endif
 # What targets we'll add to 'all' for "make gitweb"
 GITWEB_ALL =
 GITWEB_ALL += gitweb.cgi
-GITWEB_ALL += static/gitweb.js
+GITWEB_ALL += $(GITWEB_JS)
 
 ### Build rules
 
@@ -101,25 +103,23 @@ all:: $(GITWEB_ALL)
 
 GITWEB_PROGRAMS = gitweb.cgi
 
+GITWEB_JS_MIN = static/gitweb.min.js
 ifdef JSMIN
-GITWEB_FILES += static/gitweb.min.js
-GITWEB_JS = static/gitweb.min.js
-all:: static/gitweb.min.js
-static/gitweb.min.js: static/gitweb.js GITWEB-BUILD-OPTIONS
+GITWEB_JS = $(GITWEB_JS_MIN)
+all:: $(GITWEB_JS_MIN)
+$(GITWEB_JS_MIN): $(GITWEB_JS_IN) GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(JSMIN) <$< >$@
-else
-GITWEB_FILES += static/gitweb.js
 endif
+GITWEB_FILES += $(GITWEB_JS)
 
+GITWEB_CSS_MIN = static/gitweb.min.css
 ifdef CSSMIN
-GITWEB_FILES += static/gitweb.min.css
-GITWEB_CSS = static/gitweb.min.css
-all:: static/gitweb.min.css
-static/gitweb.min.css: static/gitweb.css GITWEB-BUILD-OPTIONS
+GITWEB_CSS = $(GITWEB_CSS_MIN)
+all:: $(GITWEB_CSS_MIN)
+$(GITWEB_CSS_MIN): $(GITWEB_CSS_IN) GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(CSSMIN) <$< >$@
-else
-GITWEB_FILES += static/gitweb.css
 endif
+GITWEB_FILES += $(GITWEB_CSS)
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
@@ -127,6 +127,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 #
 # js/lib/common-lib.js should be always first, then js/lib/*.js,
 # then the rest of files; js/gitweb.js should be last (if it exists)
+GITWEB_JSLIB_FILES =
 GITWEB_JSLIB_FILES += static/js/lib/common-lib.js
 GITWEB_JSLIB_FILES += static/js/lib/datetime.js
 GITWEB_JSLIB_FILES += static/js/lib/cookies.js
@@ -201,6 +202,6 @@ install: all
 
 .PHONY: clean
 clean:
-	$(RM) gitweb.cgi static/gitweb.js \
-		static/gitweb.min.js static/gitweb.min.css \
+	$(RM) gitweb.cgi $(GITWEB_JS_IN) \
+		$(GITWEB_JS_MIN) $(GITWEB_CSS_MIN) \
 		GITWEB-BUILD-OPTIONS
-- 
2.37.0.880.gf07d56b18ba

