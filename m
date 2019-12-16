Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B2C2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1324673
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA4LiBTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfLPVb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46110 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLPVb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id z21so3565673pjq.13
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyrqU080wLyAttD8V6qJSDhw6F6mFHPu94fY43EnDAY=;
        b=hA4LiBTNL9ic4iYPruYF7ufXp13QNuq7UMbIjJ6DGIi9DAKRuHlliRwdEsc3mi+jhM
         ErOSzTqA5TF210Zoc3lBqe7grVwiInLJMbM7ii9RWdPDeJOviZZcMxb+r7S9RvE7osno
         v5MLxWYKFXrg33D4odb0GnKL3Q1PpweKEiRd6ESumPPhNUY/NbE9tpj6FPGG771oOwxz
         +8fpTE+9Lym0DmiziXSUkodSkg6iprENGiIZ8nI7s14T2PDOBGQiiJxb7wQp72oRbXhg
         k1MQiUNCBTmYinxmrfrlxkF6Ytw6IMqs5XmIWgNiXY3xxu9Umgbgxl/8hHpRkqRHkgIt
         IbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyrqU080wLyAttD8V6qJSDhw6F6mFHPu94fY43EnDAY=;
        b=WQPVaQa5dI3hqy47J7DfmRGAeQ7PWTPYhuH2mI4t47o/mF3VytZ8rnhWv+yo7adBCq
         l3Sb5QyGRYVisdQhibynmJ8mMyFTvgW2WQmMsS/tOyDQ2TXYNrMe/atN2MXGSq0eM1VA
         ii9V1qBXsyfHG30nkCXaC4gzmii7dT70oXOUTwjV5xAzKPTxQZOtdbqbdTm9DZce3vHa
         NA8ZcCPoHXr9qO5b7Sca5Xt1xleL1TGkxmELnnpJ3ntPdYh2ehCrniOIw3MRNXkKqN/x
         2vDWK2CEaV+/MpfOZY0ppnnREy4CM1LFOl6kmDZ5qXVW6bEU5JAnL73OY/Sd9KpadwTI
         g/9Q==
X-Gm-Message-State: APjAAAUDPMynAX9dfVV99ci0oyscQJCxYehlCw+aXxWYt0NmjQZwbr7C
        ZX/IRk1Ws8qEDfWjVw20e3uGo+y8
X-Google-Smtp-Source: APXvYqwtZWCzrGLL6PVxIJXECuUpl3b/+josga0bI1UHj5zeS/smXMlC2edBdiPt74OkI32/qbYX2g==
X-Received: by 2002:a17:90a:b38f:: with SMTP id e15mr1680877pjr.101.1576531917700;
        Mon, 16 Dec 2019 13:31:57 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id q6sm23951063pfl.140.2019.12.16.13.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 13:31:56 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 1/2] contrib/credential/netrc: make PERL_PATH configurable
Date:   Mon, 16 Dec 2019 13:32:33 -0800
Message-Id: <fb01e34ec1c19dfac353f85e0f1b8162f1ca2434.1576531851.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.664.g198078bb5a
In-Reply-To: <cover.1576531851.git.liu.denton@gmail.com>
References: <cover.1576531851.git.liu.denton@gmail.com>
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
2.24.1.664.g198078bb5a

