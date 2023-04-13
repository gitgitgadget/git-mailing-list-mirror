Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38750C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDML6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDML6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC59773
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:01 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id cg19-20020a056830631300b0069f922cd5ceso6957326otb.12
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387080; x=1683979080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzQKhI3rPEaaHLtlp6EiEJpW9xfOn0SqJKvOAN7iXkI=;
        b=SEWKiWrr4ZCRFfvdQnk5fp2MFhCbUNpjy/YNKbizdt8rG9APL+qrK4ejcIpeMNpIjc
         9eIa008FQeCjcmrXv1ibJ0goDqTMo1fE5DQEXBE+IiHkGdU7Cvzkf1UhHpWEE9MOToRh
         2Oo6tYyz+DiOI9xzR0kxvI5BRiFJXdSKiiVxFhZ94jraTBzDLB8KxrI5+xn3kpAJyzHX
         mmRjejCli2nlGdfPAKninK6MOVFMA4fKd8O0quUlZJ9+3Ore8CYHdy3482frfujNx7sM
         y51C29WE8+zfteZqmD9p/ZUEbJyEdEXIuXDUWyIIzU/5M4Qm1LDk0M44wH3WlhuPVyc8
         Eh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387080; x=1683979080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzQKhI3rPEaaHLtlp6EiEJpW9xfOn0SqJKvOAN7iXkI=;
        b=cBnR1SHX67dfsVUlH3A9cHNxQzbiVUKy5tcKw8FamFsFuaB25Bq+Rnjv/0kQXOMWGA
         Y+vOeWhYu/XrQhWUp4KrjKMo/LI+aK6Ri/GnXOJFoXRj0SAZyim9Kq7belccGNlSmOCM
         CF8GlGuIZLiihQM1roDyU1jnKh9IqwBiT47Klzft7kOBP2IZ+wsGK9rfRdhpk5ikgD9/
         Cl8PEaWSfbc1tyiMJeNiE/BiDXqtA+m4CS0g0avtCEbCXeKaRvLSpWhbpLItR6Yoh9l8
         O2OJ3cjwoFyUefh2rDCVCC2UQQN988pW8c29ibhgUElrweNLFovoHQmcAvmsLxEBYrZJ
         WufQ==
X-Gm-Message-State: AAQBX9eUOI8hjiCeT2FHX/vWkVoUyzNgmE914OU/lu6XhGRbOZ5jaJ+r
        eepgkvRwqXBbZnmdbZzYckbGij9Xg4U=
X-Google-Smtp-Source: AKy350absN1HhFvY2sbGet6EZH9Xh/hQF9E53Pwt+XaX4al98WEUWpQgAU0Ykw2MRuZq9k2oUO87FA==
X-Received: by 2002:a9d:6f05:0:b0:6a4:28e5:8a8d with SMTP id n5-20020a9d6f05000000b006a428e58a8dmr926194otq.10.1681387080383;
        Thu, 13 Apr 2023 04:58:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c7-20020a9d6847000000b0069f0794861asm582525oto.63.2023.04.13.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 10/12] doc: stylesheet: move all the xslt templates
Date:   Thu, 13 Apr 2023 05:57:43 -0600
Message-Id: <20230413115745.116063-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to have them scattered everywhere.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gen-stylesheet           | 42 +++++++++++++++++++++-----
 Documentation/manpage-bold-literal.xsl | 16 ----------
 Documentation/manpage-normal.xsl       | 26 ----------------
 3 files changed, 35 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/manpage-bold-literal.xsl
 delete mode 100644 Documentation/manpage-normal.xsl

diff --git a/Documentation/gen-stylesheet b/Documentation/gen-stylesheet
index c006a85c39..7d1839fcab 100755
--- a/Documentation/gen-stylesheet
+++ b/Documentation/gen-stylesheet
@@ -1,17 +1,45 @@
 #!/bin/sh
 
-includes='manpage-normal.xsl'
-test -z "$NO_MAN_BOLD_LITERAL" && includes="$includes manpage-bold-literal.xsl"
-
 cat <<EOF
 <?xml version="1.0"?>
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"/>
 EOF
 
-for x in $includes
-do
-	printf '<xsl:include href="%s"/>\n' "$x"
-done
+# these params silence some output from xsltproc
+cat <<EOF
+<xsl:param name="man.output.quietly" select="1"/>
+<xsl:param name="refentry.meta.get.quietly" select="1"/>
+EOF
+
+# convert asciidoc callouts to man page format
+cat <<EOF
+<xsl:template match="co">
+	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>.br&#10;</xsl:text>
+</xsl:template>
+EOF
+
+if [[ -z "$NO_MAN_BOLD_LITERAL" ]]
+then
+	# render literal text as bold (instead of plain or monospace); this makes
+	# literal text easier to distinguish in manpages viewed on a tty
+	cat <<-EOF
+	<xsl:template match="literal">
+		<xsl:text>\fB</xsl:text>
+		<xsl:apply-templates/>
+		<xsl:text>\fR</xsl:text>
+	</xsl:template>
+	EOF
+fi
 
 echo "</xsl:stylesheet>"
diff --git a/Documentation/manpage-bold-literal.xsl b/Documentation/manpage-bold-literal.xsl
deleted file mode 100644
index e13db85693..0000000000
--- a/Documentation/manpage-bold-literal.xsl
+++ /dev/null
@@ -1,16 +0,0 @@
-<!-- manpage-bold-literal.xsl:
-     special formatting for manpages rendered from asciidoc+docbook -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		xmlns:d="http://docbook.org/ns/docbook"
-		version="1.0">
-
-<!-- render literal text as bold (instead of plain or monospace);
-     this makes literal text easier to distinguish in manpages
-     viewed on a tty -->
-<xsl:template match="literal|d:literal">
-	<xsl:text>\fB</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>\fR</xsl:text>
-</xsl:template>
-
-</xsl:stylesheet>
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
deleted file mode 100644
index 3fb044a8a7..0000000000
--- a/Documentation/manpage-normal.xsl
+++ /dev/null
@@ -1,26 +0,0 @@
-<!-- manpage-normal.xsl:
-     special settings for manpages rendered from asciidoc+docbook -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-
-<!-- these params silence some output from xsltproc -->
-<xsl:param name="man.output.quietly" select="1"/>
-<xsl:param name="refentry.meta.get.quietly" select="1"/>
-
-<!-- convert asciidoc callouts to man page format -->
-<xsl:template match="co">
-	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
-</xsl:template>
-<xsl:template match="calloutlist">
-	<xsl:text>.sp&#10;</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>&#10;</xsl:text>
-</xsl:template>
-<xsl:template match="callout">
-	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
-	<xsl:apply-templates/>
-	<xsl:text>.br&#10;</xsl:text>
-</xsl:template>
-
-</xsl:stylesheet>
-- 
2.40.0+fc1

