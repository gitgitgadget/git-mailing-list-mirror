Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DFC77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDML54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDML5w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:57:52 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AA09755
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32879a8cbe5so2360345ab.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387071; x=1683979071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fodCi4KXNxQsZEylyi/LqaMcL76xV59ZSoYwH4S1b0=;
        b=MLxxtFJ+nTqxKrCjTT0rfkzVpSYTWiXROv/Rt/2xq3gyBvlpaoz7qp3GY1i8zzkDjF
         CmxMbzIqEjv1fd+uhhvPS40EXjNj91V6UmNNGoJLKERC26DiPUQVwCqgiisTC719NdZs
         sOQzmnLpNeHYxRBzCmxSelzB80Wo9mecnI361TT45NQqYkqDrJ0mzye+SiueIK2IeeDh
         qYZtT4aeD5h1E6ynFqT0rla1l7lNgoSE/jVCh4/uayjJgWBVFhizvK+v1qYXzBozdPeI
         HXQpNi4GYNrTsC8NCgNhF/m75lHVBIBeQ1ZZWNOjsjSPmuPPMal1jV8TLzSeRSZo6SdE
         4lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387071; x=1683979071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fodCi4KXNxQsZEylyi/LqaMcL76xV59ZSoYwH4S1b0=;
        b=iOLx/l8YQ1cJUGrNrx8vIJLDFIlAI/lC+Byev66usKJaKvOX1S/88UU4d/nve+vbz0
         aah7CdtfvCQs8YI4fSVSOfhB8/rtuTAVo9QZoWvpNgIo6JcFB02fr0NahCe2mLcyRG52
         Gf9drJjark+GMysavJ5vAyRnBJWmt/kARaAbUREP2nMgoLN7U+OJrTBMx8XO8hbQpf1w
         w6HT3FllDs8dpIz1ivjzvA53UWFnJ1unP28jGlpbmyWu27ONvkUQhKf260wxYCZzHuOz
         3k6H22PwSThNYQlTfam6nRL9cqM6GMHFuKx8cpQimuqtwxQhaPBCnK32Q8ecwFjDiaVP
         2KQQ==
X-Gm-Message-State: AAQBX9cKQ/CUtu2tCDlP3oRLSDMvdBAt5H7Uw9e8nmoBBxRdcTjJPKnY
        SDLuUILdCf/fOCbR6lqremHK8IBgR+Q=
X-Google-Smtp-Source: AKy350YUrr139BUykGDzQvqtj128Zn0RN3ZMRDHRp921MAUZS0D5arpy0jbNmSrU8Sb7ep+7KFPKTQ==
X-Received: by 2002:a05:6e02:809:b0:329:5813:8de6 with SMTP id u9-20020a056e02080900b0032958138de6mr1491476ilm.18.1681387070816;
        Thu, 13 Apr 2023 04:57:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q18-20020a056638239200b0040b27189e8dsm416684jat.116.2023.04.13.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 03/12] doc: remove unnecessary hack for asciidoctor
Date:   Thu, 13 Apr 2023 05:57:36 -0600
Message-Id: <20230413115745.116063-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was added in f6461b82b9 (Documentation: fix build with Asciidoctor 2,
2019-09-15) to avoid newlines, but they don't matter.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile    | 1 -
 Documentation/manpage.xsl | 3 ---
 t/t0600-doc-tools.sh      | 4 ++--
 3 files changed, 2 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/manpage.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5cd35df61c..3fab7ce9cd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -202,7 +202,6 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
-XMLTO_EXTRA += -x manpage.xsl
 endif
 
 SHELL_PATH ?= $(SHELL)
diff --git a/Documentation/manpage.xsl b/Documentation/manpage.xsl
deleted file mode 100644
index ef64bab17a..0000000000
--- a/Documentation/manpage.xsl
+++ /dev/null
@@ -1,3 +0,0 @@
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
-	<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl" />
-</xsl:stylesheet>
diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index db77db72e5..a80cd32cd6 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -70,7 +70,7 @@ build_asciidoctor() {
 	asciidoctor -acompat-mode -atabsize=8 -I "$doc_dir" -rasciidoctor-extensions -alitdd='&#x2d;&#x2d;' \
 		-amanmanual='Git Manual' -amansource='Git 1.0.0' -arevdate='2005-01-01' -b docbook5 -d manpage \
 		-o "$1.xml" "$1.txt" &&
-	xmltoman "$1" -x "$doc_dir"/manpage.xsl
+	xmltoman "$1"
 }
 
 check_manpage() {
@@ -83,7 +83,7 @@ test_expect_success ASCIIDOC 'legacy asciidoc.py' '
 	check_manpage "git-foo"
 '
 
-test_expect_failure ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
+test_expect_success ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
 	build_asciidoctor "git-foo" &&
 	check_manpage "git-foo"
 '
-- 
2.40.0+fc1

