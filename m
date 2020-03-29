Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BCC2D0E9
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A92074A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0EjdsI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgC2NSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39837 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgC2NSb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so14957972ljn.6
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYv+hhqum9YTLy6229wlRRUKtGvKKE8wNA9ZLupjzPE=;
        b=T0EjdsI5NdUAKEHLHoq6Hq7bl3GyMlduadVR4aGMiJxsc8nv927kQ1La0n7nWCV1X2
         aLKnjC/R8PA4G3Ngepm+KE4V17Q+e4+RI3d9DwAyaqJS+i3ufgxrWCQTEtUtA/3Q04iF
         dbm8xhRcpz294DyBv3kDglFfaMCdOh21+aFZ7HduD3xzXeWPMAtWGIqo6eT4ahidPoz9
         JE0ouc+60HLLq/GGx6P/qhTvzyQaDlZWTBzZj7bhxAVXgE3Mb8d3SrL3dzbW7K8vXqz/
         2nVzBOCyE6GFUkBfXD+9IQYVI81++eKpEFZP9qF6UYc8Th//H3ERYkG9j3pfJ/C4k7MR
         2p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYv+hhqum9YTLy6229wlRRUKtGvKKE8wNA9ZLupjzPE=;
        b=nz+Qw/fMqyMm06daazoPFoEptsr/+nKAKJpN4StDFM4N2+tZKG0ZxJRE+ag2wQDakK
         NDWxxAN2/m8kVzc53NFsIuOn1z1zZzDMuSWoA8ori+z3Vdho7lgfmCYEOzBdkrLaBlNP
         /Z9HwV0boYB9DSYG24zgOdhl5xmKWGpllkQyxYGILjSTLRe2uoslBG28R53nGDpFW2Wa
         gGbObe4ZuPqx00k80sBy1Gn9yYF5GdD1VVDDTiT6pwhJnVUp/aPmHOUPgWXHS2xs+2/X
         ttw2b8oiG9cr84FyFAaKVWyxOcjpNkPIuQ3hB5o3wPJSdnvB6cX2eCyPDcyH+DIDVXfm
         zZ7A==
X-Gm-Message-State: AGi0PuZ0TY9pwO76VHqtmuGHewiQfNJ/qdobNFGTACYoBXaQfdEQRGoP
        Mo9ecA+DvOifahTixfB8c3qsmfsa
X-Google-Smtp-Source: APiQypL+FK846K/SWQW3dvGpYwke0IDBo3p/TkEt0PAlXKY9C086iU69L30I1uyjUUOriwLgqnP4qA==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr4689244ljn.151.1585487908482;
        Sun, 29 Mar 2020 06:18:28 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/6] Doc: drop support for docbook-xsl before 1.72.0
Date:   Sun, 29 Mar 2020 15:18:06 +0200
Message-Id: <49ff2871beef36bfd44796f3832629dd09c5560b.1585486103.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

docbook-xsl 1.72.0 is thirteen years old. Drop the ASCIIDOC_ROFF knob
which was needed to support 1.68.1 - 1.71.1. The next commit will
increase the required/assumed version further.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile      | 10 +---------
 Documentation/asciidoc.conf | 19 -------------------
 Makefile                    |  3 ---
 INSTALL                     |  2 +-
 4 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c7b805d1ee..c7a8fc99cf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -151,21 +151,13 @@ endif
 
 #
 # For docbook-xsl ...
-#	-1.71.0,	not supported
-#	1.71.1,		set ASCIIDOC_ROFF?
+#	-1.71.1,	not supported
 #	1.72.0,		set DOCBOOK_XSL_172.
 #	1.73.0-,	no extra settings are needed
 #
 
 ifdef DOCBOOK_XSL_172
-ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
 MANPAGE_XSL = manpage-1.72.xsl
-else
-	ifndef ASCIIDOC_ROFF
-	# docbook-xsl after 1.72 needs the regular XSL, but will not
-	# pass-thru raw roff codes from asciidoc.conf, so turn them off.
-	ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
-	endif
 endif
 ifndef NO_MAN_BOLD_LITERAL
 XMLTO_EXTRA += -m manpage-bold-literal.xsl
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 8fc4b67081..3e4c13971b 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -31,24 +31,6 @@ ifdef::backend-docbook[]
 endif::backend-docbook[]
 
 ifdef::backend-docbook[]
-ifndef::git-asciidoc-no-roff[]
-# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
-# v1.72 breaks with this because it replaces dots not in roff requests.
-[listingblock]
-<example><title>{title}</title>
-<literallayout class="monospaced">
-ifdef::doctype-manpage[]
-&#10;.ft C&#10;
-endif::doctype-manpage[]
-|
-ifdef::doctype-manpage[]
-&#10;.ft&#10;
-endif::doctype-manpage[]
-</literallayout>
-{title#}</example>
-endif::git-asciidoc-no-roff[]
-
-ifdef::git-asciidoc-no-roff[]
 ifdef::doctype-manpage[]
 # The following two small workarounds insert a simple paragraph after screen
 [listingblock]
@@ -67,7 +49,6 @@ ifdef::doctype-manpage[]
 {title#}</para></formalpara>
 {title%}<simpara></simpara>
 endif::doctype-manpage[]
-endif::git-asciidoc-no-roff[]
 endif::backend-docbook[]
 
 ifdef::doctype-manpage[]
diff --git a/Makefile b/Makefile
index ef1ff2228f..0e0a6badc1 100644
--- a/Makefile
+++ b/Makefile
@@ -285,9 +285,6 @@ all::
 # Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72
 # (not v1.73 or v1.71).
 #
-# Define ASCIIDOC_ROFF if your DocBook XSL does not escape raw roff directives
-# (versions 1.68.1 through v1.72).
-#
 # Define GNU_ROFF if your target system uses GNU groff.  This forces
 # apostrophes to be ASCII so that cut&pasting examples to the shell
 # will work.
diff --git a/INSTALL b/INSTALL
index 7647ce1320..07a283fcf2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -206,7 +206,7 @@ Issues of note:
    clone two separate git-htmldocs and git-manpages repositories next
    to the clone of git itself.
 
-   The minimum supported version of docbook-xsl is 1.71.1.
+   The minimum supported version of docbook-xsl is 1.72.
    It has been reported that docbook-xsl version 1.72 and 1.73 are
    buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
    the patch in contrib/patches/docbook-xsl-manpages-charmap.patch
-- 
2.26.0

