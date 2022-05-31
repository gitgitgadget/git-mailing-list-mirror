Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B8DC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiEaRq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiEaRqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480432AC7C
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so11593300wrb.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubvBArhpBz/hB6FMQ2BErJBjpPUJoQcVlkNer5KUDug=;
        b=kXRlBpte8ypTvh6+gOw4Q2MwgzqTlAoXDxpQNoH473j7xF/DKX3fMPU35KbKhMNorZ
         M8kk568B6AT7/d4EqtJIAJlRQBFe6RNCWdzpSt2IhtZX9LjBG9CvoIIo/7UXWBmoXaZu
         JbX+6NBmXoEFyHoDI5XxitH9WaJ9VEVDGOekO8Mi3ATbH8YNwYsyqI9/MbJ38ca0URpA
         aqLMJ80wvSD/IJw2UCMaNnS11ntojt63QXEH7I0Byh77RFVdxvkTOM6RJSjXR5ap0xOa
         mxMkrsxMIa+UPuonVfp9YmvLPqC41WCxT5U0n+hZw46pD84zqdjjd3YxU3qVz4tCR7L5
         X21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubvBArhpBz/hB6FMQ2BErJBjpPUJoQcVlkNer5KUDug=;
        b=jYh+BDm6c+5/WbNi6QFP7rOkXVtygnLfalh4sm6pmRtPukV4JLR/FTU6PG35IhtrXp
         7XjwYPzzVCQjnpp3wkd/hQpxaw8HpofIBIFQ83sbzoL9eqca0zmLicd93s4ckETBCWXk
         MdZeYOl+r/Pl/KG5hU1ByVNNvZ23pLzll5b7Pi8RV2AfjbiYg1KbkALDXmsyN2TXDrKF
         /K79zRebKPkzF1HnrbfdiVmkvUPj7Wl5GH0374x0DIvX7Q2A7fhAfR50P7RiMGK6hlF+
         3FLNO0DdJEUaX/BgXhoj4+NroKLdGRb2VXBDJq1Eny4JPd4xQR5tjobbYXyWecMN5f3y
         Nu4g==
X-Gm-Message-State: AOAM531sr1x0SQ1Puf9anRLbk162p8mdR2JIP97tUCKSVnZcoz/AGqKM
        7ke/mMi13IP6eELYV9ev/sltnEvgmXxYmw==
X-Google-Smtp-Source: ABdhPJwS6hZ+wBme60x/WNAZGeq8KaAbU4xWx9Yg79LS3gY9OjZJwJfbroQPAzvhxrL1AsWgJd77jQ==
X-Received: by 2002:a05:6000:186f:b0:20f:c2a1:772 with SMTP id d15-20020a056000186f00b0020fc2a10772mr44674435wri.226.1654019179253;
        Tue, 31 May 2022 10:46:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
Date:   Tue, 31 May 2022 19:45:56 +0200
Message-Id: <patch-v2-3.7-e14a5b73061-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
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
2.36.1.1103.g036c05811b0

