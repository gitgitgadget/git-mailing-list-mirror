Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513DEECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiHaImM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHaImE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:42:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB9BC831
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1519653wmk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+1tGP+k4t6rzILk1ui/VHno61vRQA3V3ZQF9s2DMtwg=;
        b=K9VmlmI69cXstxserLKb/WOMniG1OBR/WAQvfwOov21yQOvvrtbXZiojP89s6LH9fg
         6NFFjyanYQS0rtTbrVc1s+MkoBnUvhq8i6WnGTuRGqQSaWJslUm6hWaAhBVGnQs9VbVn
         /FaQz5+OMtuyQIp12+nB94NzoG1yzgTurfRaZ/Jdzrlv9NdMp2lds2Ojx1+7EeEqNuA3
         27poYHWvMuVuwW0RLYS31BdhRbPkAmn12SjwIN6hiQjgfxWF/w1xXFjyzcBA02c9FKdY
         yISjDpHj+FhUjTDRq6ftqBMMzbhU6SiNLOd3dlHybFdLo62jNvClhnHQ4pt4sIt0KRd6
         A6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+1tGP+k4t6rzILk1ui/VHno61vRQA3V3ZQF9s2DMtwg=;
        b=n3/5gfhXY9mICq4NkXYcB7cp4AP+myfLj1HNOFGdhlyGoIhUGrnr1hc/PIQOdHpCor
         19Z4giw1FViS6G7dmg7LEWB7b5PCthbyTPxCp+iY58g3Ce2vVKCjMaIZSTREbkMNdaMU
         JBwfMW46mDDEYIPEnQrnVEcKoI5Co3Kq/Qj65qmpNsV8bjeiVqEfK3tV2idhxsHXyL46
         bu3hFLMkcxf7zoXx2pK1ybR1fbIjcCWyCpZbzF+cKsAhL0S/dcC5RSc7DHd+8WPTsWXB
         rv065YFmZMmYAm592bsyGyCEAXeMZ0w9uFpsm/MraSx24DX/fI5aCJNY9zSUY/dmk5z/
         fEtQ==
X-Gm-Message-State: ACgBeo0S0d2UiHuUqoq5ab7DKPBNir+89+Aa2kFpYY9UaQZfYVtRtPTN
        QCTM6eaL7w5kH+oOwZkgkfJl4hEYz796hw==
X-Google-Smtp-Source: AA6agR5SMQp5OkNhUo4NfFFZykF6f9Vf3tMtlipQ4qgc9eC0JcEaemH0MrBv6VIuSLc/KpKm/cGzMQ==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr1262415wmq.188.1661935317357;
        Wed, 31 Aug 2022 01:41:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] difftool docs: de-duplicate configuration sections
Date:   Wed, 31 Aug 2022 10:41:37 +0200
Message-Id: <patch-v3-6.9-c4c3fa14190-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the "config/difftool.txt" file in "git-difftool.txt", and move
the relevant part of git-difftool(1) configuration from
"config/diff.txt" to config/difftool.txt".

Doing this is slightly odd, as we usually discuss configuration in
alphabetical order, but by doing it we're able to include the full set
of configuration used by git-difftool(1) (and only that configuration)
in its own documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/diff.txt     | 15 ---------------
 Documentation/config/difftool.txt | 28 +++++++++++++++++++++++++---
 Documentation/git-difftool.txt    | 27 ++++-----------------------
 3 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 32f84838ac1..35a7bf86d77 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -178,21 +178,6 @@ diff.<driver>.cachetextconv::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
-diff.tool::
-	Controls which diff tool is used by linkgit:git-difftool[1].
-	This variable overrides the value configured in `merge.tool`.
-	The list below shows the valid built-in values.
-	Any other value is treated as a custom diff tool and requires
-	that a corresponding difftool.<tool>.cmd variable is defined.
-
-diff.guitool::
-	Controls which diff tool is used by linkgit:git-difftool[1] when
-	the -g/--gui flag is specified. This variable overrides the value
-	configured in `merge.guitool`. The list below shows the valid
-	built-in values. Any other value is treated as a custom diff tool
-	and requires that a corresponding difftool.<guitool>.cmd variable
-	is defined.
-
 include::../mergetools-diff.txt[]
 
 diff.indentHeuristic::
diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index 67625944804..a3f82112102 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -1,6 +1,17 @@
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
+diff.tool::
+	Controls which diff tool is used by linkgit:git-difftool[1].
+	This variable overrides the value configured in `merge.tool`.
+	The list below shows the valid built-in values.
+	Any other value is treated as a custom diff tool and requires
+	that a corresponding difftool.<tool>.cmd variable is defined.
+
+diff.guitool::
+	Controls which diff tool is used by linkgit:git-difftool[1] when
+	the -g/--gui flag is specified. This variable overrides the value
+	configured in `merge.guitool`. The list below shows the valid
+	built-in values. Any other value is treated as a custom diff tool
+	and requires that a corresponding difftool.<guitool>.cmd variable
+	is defined.
 
 difftool.<tool>.cmd::
 	Specify the command to invoke the specified diff tool.
@@ -9,6 +20,17 @@ difftool.<tool>.cmd::
 	file containing the contents of the diff pre-image and 'REMOTE'
 	is set to the name of the temporary file containing the contents
 	of the diff post-image.
++
+See the `--tool=<tool>` option in linkgit:git-difftool[1] for more details.
+
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+difftool.trustExitCode::
+	Exit difftool if the invoked diff tool returns a non-zero exit status.
++
+See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 143b0c49d73..9d14c3c9f09 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -113,33 +113,14 @@ instead.  `--no-symlinks` is the default on Windows.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
-CONFIG VARIABLES
-----------------
+CONFIGURATION
+-------------
 'git difftool' falls back to 'git mergetool' config variables when the
 difftool equivalents have not been defined.
 
-diff.tool::
-	The default diff tool to use.
+include::includes/cmd-config-section-rest.txt[]
 
-diff.guitool::
-	The default diff tool to use when `--gui` is specified.
-
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-difftool.<tool>.cmd::
-	Specify the command to invoke the specified diff tool.
-+
-See the `--tool=<tool>` option above for more details.
-
-difftool.prompt::
-	Prompt before each invocation of the diff tool.
-
-difftool.trustExitCode::
-	Exit difftool if the invoked diff tool returns a non-zero exit status.
-+
-See the `--trust-exit-code` option above for more details.
+include::config/difftool.txt[]
 
 SEE ALSO
 --------
-- 
2.37.3.1406.g184357183a6

