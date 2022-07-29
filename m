Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B1C19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiG2I0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiG2I0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78A28706
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so384703wrq.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zbFs3FJw0bJFugD2PGTwrl3XgxCLDktr96Q38Ui9pbg=;
        b=Q9aAdu3klsXH/UaTU908Sescl6aKy4G4x/1xt/w8jW8y3lQMxKnJMVTzTjDYWzbNui
         Zm6G2SFNEOODOHCMSyv5cEgH399jJzZYycNngg+zx0NSiXbXbs0PFd3Y9DWzPC8XFo7U
         kDGnJ/8sfy0OAwK6gwLbacGQQhN8Ua92zpR4D3CS8qJd4vHvf3NDgP2MxaNdBd63usKn
         oA/u3BBSPft4JUr00E4tBwUcfYZPYsp8qEb2IMS3wcza6Zli1mbjPSUIQJfTRovgExLo
         N5P9eAwY9T37A+U3eGF1UFByMMThvjDIujVPCqueAVl/PjRptDhMcVvnDFIc10PuRkQT
         wEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zbFs3FJw0bJFugD2PGTwrl3XgxCLDktr96Q38Ui9pbg=;
        b=KQHhVTsdmNQEmNewUN1ICV5dqLZJmUl0SOM+e9QWTibdkJAULCe7H9RkXdu4EodDmg
         rQV5MQA9NX0EGErs1P49NiDuun36X3l+bBG2DClek8SRQtNe65D54gTfE4ZLGEfuY4Ij
         7u5eZuHMK6TPu0N5UdDYXQgs55LqnkNXRDGohmYxiugPHlMaofmix8AOShZMbfgdKs1A
         nQNQVx2jp27Ayr6/LislB+lfjH1j0C6D6I/WAvAfipi+w9D6j7XhSoHko9qUC0S/AeDE
         VVUZydPrE8qq22OJxZqYAp8rYyxK0MxX9t8X4Dw3nwarrRjvzC1l0nzvlTNbyboTfpIP
         QC2w==
X-Gm-Message-State: ACgBeo0jIMOwgTja5pVJ2lr9X0hI/0sOKJOxBh1jr1Ur+Kv9Qi4PGxlZ
        8WQ9NO/UjZqb4bz3GLmxoxJBR6b4I8e83A==
X-Google-Smtp-Source: AA6agR5/8lS6DC/gqFRbO4KR3tAFkXhxIHK59v7txs/5dfBKi6EmeNJp/o70A2xVWu4XLYxuFUegxQ==
X-Received: by 2002:adf:fbc3:0:b0:21e:3c88:2aa1 with SMTP id d3-20020adffbc3000000b0021e3c882aa1mr1685159wrs.84.1659083160159;
        Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:25:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] send-email docs: de-duplicate configuration sections
Date:   Fri, 29 Jul 2022 10:25:49 +0200
Message-Id: <patch-v2-3.9-8138dc54e3e-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

De-duplicate the discussion of "send-email" configuration, such that
the "git-config(1)" manual page becomes the source of truth, and
"git-send-email(1)" includes the relevant part.

Most commands that suffered from such duplication had diverging text
discussing the same variables, but in this case some config was also
only discussed in one or the other.

This is mostly a move-only change, the exception is a minor rewording
of changing wording like "see above" to "see linkgit:git-config[1]",
as well as a clarification about the big section of command-line
option tweaking config being discussed in git-send-email(1)'s main
docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/sendemail.txt | 40 +++++++++++++++++++++++++++---
 Documentation/git-send-email.txt   | 36 ++-------------------------
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 50baa5d6bfb..51da7088a84 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -18,17 +18,49 @@ sendemail.<identity>.*::
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
+sendemail.multiEdit::
+	If true (default), a single editor instance will be spawned to edit
+	files you have to edit (patches when `--annotate` is used, and the
+	summary when `--compose` is used). If false, files will be edited one
+	after the other, spawning a new editor each time.
+
+sendemail.confirm::
+	Sets the default for whether to confirm before sending. Must be
+	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
+	in the linkgit:git-send-email[1] documentation for the meaning of these
+	values.
+
 sendemail.aliasesFile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply `sendemail.aliasFileType`.
+
 sendemail.aliasFileType::
+	Format of the file(s) specified in sendemail.aliasesFile. Must be
+	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
++
+What an alias file in each format looks like can be found in
+the documentation of the email program of the same name. The
+differences and limitations from the standard formats are
+described below:
++
+--
+sendmail;;
+*	Quoted aliases and quoted addresses are not supported: lines that
+	contain a `"` symbol are ignored.
+*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
+	supported.
+*	File inclusion (`:include: /path/name`) is not supported.
+*	Warnings are printed on the standard error output for any
+	explicitly unsupported constructs, and any other lines that are not
+	recognized by the parser.
+--
 sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
 sendemail.ccCmd::
 sendemail.chainReplyTo::
-sendemail.confirm::
 sendemail.envelopeSender::
 sendemail.from::
-sendemail.multiEdit::
 sendemail.signedoffbycc::
 sendemail.smtpPass::
 sendemail.suppresscc::
@@ -44,7 +76,9 @@ sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
 sendemail.xmailer::
-	See linkgit:git-send-email[1] for description.
+	These configuration variables all provide a default for
+	linkgit:git-send-email[1] command-line options. See its
+	documentation for details.
 
 sendemail.signedoffcc (deprecated)::
 	Deprecated alias for `sendemail.signedoffbycc`.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 41cd8cb4247..3290043053a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -456,41 +456,9 @@ Information
 CONFIGURATION
 -------------
 
-sendemail.aliasesFile::
-	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply `sendemail.aliasFileType`.
+include::includes/cmd-config-section-all.txt[]
 
-sendemail.aliasFileType::
-	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
-+
-What an alias file in each format looks like can be found in
-the documentation of the email program of the same name. The
-differences and limitations from the standard formats are
-described below:
-+
---
-sendmail;;
-*	Quoted aliases and quoted addresses are not supported: lines that
-	contain a `"` symbol are ignored.
-*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
-	supported.
-*	File inclusion (`:include: /path/name`) is not supported.
-*	Warnings are printed on the standard error output for any
-	explicitly unsupported constructs, and any other lines that are not
-	recognized by the parser.
---
-
-sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
-	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
-	after the other, spawning a new editor each time.
-
-sendemail.confirm::
-	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
-	in the previous section for the meaning of these values.
+include::config/sendemail.txt[]
 
 EXAMPLES
 --------
-- 
2.37.1.1196.g8af3636bc64

