Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02462C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AD6206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZeXd3w7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLTSnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:43:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46130 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:43:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id y14so5660703pfm.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dVfCjgWkGeZggmACsIUzF8y+H2uMcillGzFsSS+YaI=;
        b=DZeXd3w76dxiegCn9LRqEvw/z3fXFZ7qVBYFYKZz19ey9qFw8fbGLakCTO2+zWp5AR
         hENrTHd2OtJOoHc8eObL20/tqL4KKWwBzpCf715JPgq/agmpZ6smGCZpil5EAHlAmQCd
         Y9PIlyxgfDd5jee9CUp6O89zvhKEDL2Xlc+S68tSib6Q2zz5M0lGkTfWLGdiO0wyPgiW
         1lgylNAz3xpF7lYxF/+plyEsJGVO2ZhnkLYFsTyJ3Tji9zGeXL9vol3XWCTA8qYfI3Qg
         NwB9qU2r7DjaA3jqgKWdZPbfcUxn8CaqU+oV/qQVwSrAzfHafvZ94ALDeA1Esxc0q4m2
         BqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dVfCjgWkGeZggmACsIUzF8y+H2uMcillGzFsSS+YaI=;
        b=fpPipoCxxcLIlhRxZuHjt9kvanW332DBIOvzz5UVktg4cAMoGnFXXzQsxhF7xmO9w5
         o37uKeiIh6+5hEAEc6wA6oSoX072Tx2GFYP7Vc7CIlht+oZG2PZUBHUVxnv9bSU4B5Jw
         rk4OTecMnz8BBGNihRLSW5q092DvcpN5CLTq2yCwgXGlnfEiywJIt/mnu5gje0HVrbaW
         2Hubj/Up8SfpCqvpt3Ri4CqKC89EMRDHIJ/uYoAhQdYBjfzmJ6uCUcbCfUW7q8+reFDD
         YMW02tZBHzipR5v5jFNaqFB+M+hHcJJYcCNMuNk8+o0+Fd8O7BXVGJDLzIJ3PjM74BEt
         8FIA==
X-Gm-Message-State: APjAAAWV4/rRaNSKYfYEdErXGXbOWIVL4qQ/8L4aqNUtGqZ1DlaxvQeh
        rgo+4vZWuna2bcd2AGB3/MMAXNVp
X-Google-Smtp-Source: APXvYqyz9yHK24cLavX4WndOBbFTj2zdJZHvZlHheaDvKviaxf9szux5a6lYxBLzk9oZ2CJmc7MN5Q==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr17547109pfp.65.1576867403886;
        Fri, 20 Dec 2019 10:43:23 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id ce15sm11403553pjb.4.2019.12.20.10.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:43:23 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>
Subject: [RESEND PATCH 1/2] contrib/credential/netrc: make PERL_PATH configurable
Date:   Fri, 20 Dec 2019 10:45:00 -0800
Message-Id: <fb01e34ec1c19dfac353f85e0f1b8162f1ca2434.1576867467.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576867467.git.liu.denton@gmail.com>
References: <cover.1576531851.git.liu.denton@gmail.com> <cover.1576867467.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shebang path for the Perl interpreter in git-credential-netrc was
hardcoded. However, some users may have it located at a different
location and thus, would have had to manually edit the script.

Add a .perl prefix to the script to denote it as a template and ignore
the generated version. Augment the Makefile so that it generates
git-credential-netrc from git-credential-netrc.perl, just like other
Perl scripts.

The Makefile recipes were shamelessly stolen from
contrib/mw-to-git/Makefile.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/credential/netrc/.gitignore           |  1 +
 contrib/credential/netrc/Makefile             | 26 +++++++++++++++++--
 ...ential-netrc => git-credential-netrc.perl} |  0
 3 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 contrib/credential/netrc/.gitignore
 rename contrib/credential/netrc/{git-credential-netrc => git-credential-netrc.perl} (100%)

diff --git a/contrib/credential/netrc/.gitignore b/contrib/credential/netrc/.gitignore
new file mode 100644
index 0000000000..d41cdde84b
--- /dev/null
+++ b/contrib/credential/netrc/.gitignore
@@ -0,0 +1 @@
+git-credential-netrc
diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
index 6174e3bb83..c284fb8ac4 100644
--- a/contrib/credential/netrc/Makefile
+++ b/contrib/credential/netrc/Makefile
@@ -1,8 +1,30 @@
 # The default target of this Makefile is...
 all::
 
-test:
+SCRIPT_PERL = git-credential-netrc.perl
+GIT_ROOT_DIR = ../../..
+HERE = contrib/credential/netrc
+
+SCRIPT_PERL_FULL = $(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
+
+all:: build
+
+build:
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
+                build-perl-script
+
+install: build
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
+                install-perl-script
+
+clean:
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
+                clean-perl-script
+
+test: build
 	./t-git-credential-netrc.sh
 
-testverbose:
+testverbose: build
 	./t-git-credential-netrc.sh -d -v
+
+.PHONY: all build install clean test testverbose
diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc.perl
similarity index 100%
rename from contrib/credential/netrc/git-credential-netrc
rename to contrib/credential/netrc/git-credential-netrc.perl
-- 
2.24.1.703.g2f499f1283

