Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4488AECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiHaImH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiHaIl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:41:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B4B654D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b16so9649502wru.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f+6RnR+UOCGk8nGiev9avJTFFxjPfkLJ2BYP/DNJDbw=;
        b=LDEaLizvnFsr0Sr7fpj0CfopJNJB/iAenIMDOhxOf8I1UEzrXwaU9Gn8prGSoG3gWp
         mgxjQA5ceb9iepuEESnOHFoRfSzVtP9eJbrwqPE8Zyn1AWc194xbESflWTwgCJZSNEyQ
         rjpxq9AJZuvIVl7C2ZeVPMBJ3s2mNHq2Y15lITxRQfJCjttj9R+omKXQyND8KyfFrJ0L
         VGDFVy5ke0TjvBXYFXMSvm6mCBR292R8PJT3cb1RGidnhdPRVg2GiEVmLEIvfcOI6JDh
         M+oQ27ZJ54j7PGO6tsoDPESSDnUZ2sFnvDfQdpM35Oh9yboN23gT7ceW2veo0fk43iUG
         cfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f+6RnR+UOCGk8nGiev9avJTFFxjPfkLJ2BYP/DNJDbw=;
        b=EyMtJnCgN1boiGQIhmdsMg4Eycyt3izTWfIs0Rv0D3qEtgwzMNgSSJHpVsTyjBkDRT
         D3D+B/zt9q78UsoO1EHVkB/Stci7mWf8/XW4FSRFub5vqYyrQ+boIxbWimb/FlVtohRV
         020/ECZ6gJ/Hh65osJyb9v7zB+5fGUq4AtO+7BtIYcP44NkyHCW1hvWrcgEZ7HutXy9V
         i/z9X+osYLMx6Zqta58CYwh+jXDMrVtC6xZhPTitQf31wS1PWVZlhfSFHoC3atYdB+3j
         V0rZnk0F0/mPt0s5Dy8OQfE17+3MrY6TiS38Bi3FNqs3g9uPZPeqHGdFzoJ8rvKOV91F
         UF3Q==
X-Gm-Message-State: ACgBeo0ibV/xoyQW4ookHERpcIruE/ImUfhfaPBqcPEsYzK4rTHKbmTy
        7UPXe1q+2350zDj6GK++q06jheH0RLtMYw==
X-Google-Smtp-Source: AA6agR4cMGL3euxSMKpIFr1LzG3lnp4iINZ32/iEp/LFOknM6aVppEfZq250SzDRtQp0vnKSgx3kgw==
X-Received: by 2002:adf:9cca:0:b0:226:dfa0:3fb7 with SMTP id h10-20020adf9cca000000b00226dfa03fb7mr5804017wre.412.1661935314228;
        Wed, 31 Aug 2022 01:41:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] send-email docs: de-duplicate configuration sections
Date:   Wed, 31 Aug 2022 10:41:34 +0200
Message-Id: <patch-v3-3.9-c36feb6f35a-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
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
2.37.3.1406.g184357183a6

