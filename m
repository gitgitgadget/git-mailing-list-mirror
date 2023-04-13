Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF8C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjDML6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjDML6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C57686B6
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7606df2b5e3so9913039f.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387075; x=1683979075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gprV56wg+2Xc/8OjOoEuNXsAn3pN8IUnKYbOuuG2fNQ=;
        b=U0gHc58D0huJnSAY4vfFfJ50duU5BarcFqrBNe3Gsy8y53d3OBI9dmncgVpUkwPAm0
         5UcC2OycX7+iU0xGE/sIhWnPlbdrNShv/K9d6OGkzZKGcl4B3U6P/snG6SCynqVorQNH
         iTH+4g7W6jjRhUW61099XvIzGvZrN3xRIL8EIsrOhSV4pPSnkgl5G0gBvxNeT2RYHPfs
         ua14igCND0w0RvuGRe7JnOubfl6XnPZpwniRGi6XSO+a6fJtX5NGVMCC/9QLf+cfu9re
         ebPP6rnapF9EuYN5NbcLWAO9Ip4xX1oIRVRgKbUTnI+E8CzymKOGDsuuFdEby1Itqltr
         6rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387075; x=1683979075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gprV56wg+2Xc/8OjOoEuNXsAn3pN8IUnKYbOuuG2fNQ=;
        b=CsMT6p/d3/G/9+M6J9VdSUvEfIZwofeu+VN2Hdfv9/St1ptymLfHiBknJ/TP8nfzEJ
         6v4CVhUkH0AcyyQfKhU8ADLJlZsJNZojrzbRV8lj+BsIsfX+sKUF6N8CjDSZZOSYK3yQ
         QoqVl/e35ouRU3lcMoSk5TU5STm0dscskXKXQtwJfMs1h0reQkmifWPMOjhV3xpKMK08
         4cS49HgeqFoMFViX0CpHENH62lZ8SVlvUrYmFOVqCuDgi9VWozt6KJDJB+Bv89bVwmeJ
         bG2Uzsw/SbGZozvj2sqrTMIUXJk5ss8VVfHqVzco7abhnDTGryw/tTauJklL3Z1Hf3Qm
         FWTA==
X-Gm-Message-State: AAQBX9e0RlFW5xyS/c4MOdDq74X5A0cAFV8NuwiGKA60nqhhPFm1NX2l
        it5lWQO0UhKKNRvjjXvtZKzUv2KSveA=
X-Google-Smtp-Source: AKy350ZhPYwBPNXMk3JKyUSYY4s19kwH8nnYHdV7/SqqVNxNdPD0tbfV/MxEGDuhdBGNISMjyqiFWw==
X-Received: by 2002:a05:6e02:5c3:b0:32a:82e9:23c1 with SMTP id l3-20020a056e0205c300b0032a82e923c1mr471693ils.21.1681387075181;
        Thu, 13 Apr 2023 04:57:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f5-20020a056638328500b00405f36ed05asm421710jav.55.2023.04.13.04.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 06/12] doc: add gen-stylesheet helper
Date:   Thu, 13 Apr 2023 05:57:39 -0600
Message-Id: <20230413115745.116063-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move most of the logic of xmlto into a simple script that generates a
single stylesheet.

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/.gitignore     |  1 +
 Documentation/Makefile       | 12 +++++-------
 Documentation/gen-stylesheet | 17 +++++++++++++++++
 t/t0600-doc-tools.sh         |  4 +++-
 4 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100755 Documentation/gen-stylesheet

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index a48448de32..afec7e7f19 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -15,3 +15,4 @@ tmp-doc-diff/
 GIT-ASCIIDOCFLAGS
 /.build/
 /GIT-EXCLUDED-PROGRAMS
+/manpage.xsl
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3fab7ce9cd..96d3f52c60 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -155,7 +155,6 @@ ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
-MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
 INSTALL ?= install
@@ -176,10 +175,6 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
-ifndef NO_MAN_BOLD_LITERAL
-XMLTO_EXTRA += -m manpage-bold-literal.xsl
-endif
-
 # Newer DocBook stylesheet emits warning cruft in the output when
 # this is not set, and if set it shows an absolute link.  Older
 # stylesheets simply ignore this parameter.
@@ -338,8 +333,11 @@ $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
-manpage-prereqs := $(wildcard manpage*.xsl)
-manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+manpage-prereqs := manpage.xsl $(wildcard manpage*.xsl)
+manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -x manpage.xsl $(XMLTO_EXTRA) man $<
+
+manpage.xsl: gen-stylesheet
+	./gen-stylesheet >"$@"
 
 %.1 : %.xml $(manpage-prereqs)
 	$(manpage-cmd)
diff --git a/Documentation/gen-stylesheet b/Documentation/gen-stylesheet
new file mode 100755
index 0000000000..c006a85c39
--- /dev/null
+++ b/Documentation/gen-stylesheet
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+includes='manpage-normal.xsl'
+test -z "$NO_MAN_BOLD_LITERAL" && includes="$includes manpage-bold-literal.xsl"
+
+cat <<EOF
+<?xml version="1.0"?>
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"/>
+EOF
+
+for x in $includes
+do
+	printf '<xsl:include href="%s"/>\n' "$x"
+done
+
+echo "</xsl:stylesheet>"
diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index 2552b0d376..a003686c2f 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -54,10 +54,12 @@ description
 Part of the \fBgit\fR(1) suite
 EOF
 
+"$doc_dir"/gen-stylesheet >"$doc_dir"/manpage.xsl
+
 xmltoman() {
 	base="$1"
 	shift
-	xmlto --skip-validation -m "$doc_dir/manpage-normal.xsl" -m "$doc_dir/manpage-bold-literal.xsl" "$@" man "$base.xml"
+	xmlto --skip-validation -x "$doc_dir"/manpage.xsl man "$base.xml"
 }
 
 build_asciidoc_py() {
-- 
2.40.0+fc1

