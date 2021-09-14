Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D31AC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848A6610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhINN2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhINN2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 09:28:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFBBC061762
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d21so12525759wra.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Kc1IHHnCfBQX29JaNyynpZGGLYYFTmFsm2etSy+Dnpk=;
        b=WUcCk4xIqazEbc0IylSR5vGt7ALixzxKLJSnba8pKxrnSVXA805VBmC6olaxSp+GRF
         L2GJiZkBQY4pS6WtkgobObdaspAst8SmiUIVJzjBqJZ3o6y2aks0ayINR5lRA7T6z+hq
         udOjbwBOHFPyMo4B3+wXiEztHeNCHqc3FnkLnDRaLWryIecgcU5BZLlyI4h+8fMAVZ2l
         g71debE96JiOya9B8FOFLac3U8pSp7sDXdu1gTHkV9XRCY7OmXLIdTCZJY0AGfc+0tSG
         12QdI1YsHDniTs4Olk7eUDhfUDlnm88wtTbhTL+rhYdhtSEHV3UMOcKSr4J1ZqRPyPYr
         tCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Kc1IHHnCfBQX29JaNyynpZGGLYYFTmFsm2etSy+Dnpk=;
        b=2VfckM4ZDDwz9P6YsSnb3tnwKpfYZbPIeEJICnNO2pmMUrwC1BLwn0OcDuY4MSPrhG
         orkSs8SS+lFAHoH92NzlfMT7wCJMLanMl2QUzlTKVj4r9I2sp+EMbRcGLMzp1bNX8p8C
         COQZ6Q4lCNUaRge0D6kRbTL0W/I7YYRZidaskHixVTx9v8Zoca/yLkqIOA/kHqcP1281
         s4TBLuB3QBfAzvwTh7maNo3j9s6/YbGJ+V3Pa2QCZCy4GwrBFCUnXVOXj7kPiQZsi+Iu
         C1NWCNYPPfmsgXRwSY3D8PVq3KYzCz+YA7zgV7jlLoB0iClTdUlPSP4M0b7wXTZMIAsl
         2BMg==
X-Gm-Message-State: AOAM532RBFERRyGiVr64QK9sUtNh9Yp6JbBLIl0ROOIkO0gd5FQe18HS
        eXHoCk4lziEsSF6M8UtV0SisjROd3I0=
X-Google-Smtp-Source: ABdhPJyaAYpjKgta9hfAxu6nFVVqAPhgNYgkoLfNkiZsthVRFDD32h9lUKXqYzY7HJNUI1/ALOdi5g==
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr7219387wrp.44.1631626040697;
        Tue, 14 Sep 2021 06:27:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm1272134wmq.43.2021.09.14.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 06:27:20 -0700 (PDT)
Message-Id: <bc9a4534f5bc6756ab2df869b55e390183c4ff30.1631626038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
        <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 13:27:18 +0000
Subject: [PATCH v2 2/2] documentation: add documentation for 'git version'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

While 'git version' is probably the least complex git command,
it is a non-experimental user-facing builtin command. As such
it should have a help page.

Both `git help` and `git version` can be called as options
(`--help`/`--version`) that internally get converted to the
corresponding command. Add a small paragraph to
Documentation/git.txt describing how these two options
interact with each other and link to this help page for the
sub-options that `--version` can take. Well, currently there
is only one sub-option, but that could potentially increase
in future versions of Git.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 Documentation/git-version.txt | 28 ++++++++++++++++++++++++++++
 Documentation/git.txt         |  4 ++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/git-version.txt

diff --git a/Documentation/git-version.txt b/Documentation/git-version.txt
new file mode 100644
index 00000000000..80fa7754a6d
--- /dev/null
+++ b/Documentation/git-version.txt
@@ -0,0 +1,28 @@
+git-version(1)
+==============
+
+NAME
+----
+git-version - Display version information about Git
+
+SYNOPSIS
+--------
+[verse]
+'git version' [--build-options]
+
+DESCRIPTION
+-----------
+With no options given, the version of 'git' is printed on the standard output.
+
+Note that `git --version` is identical to `git version` because the
+former is internally converted into the latter.
+
+OPTIONS
+-------
+--build-options::
+	Include additional information about how git was built for diagnostic
+	purposes.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6dd241ef838..95fe6f31b4f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -41,6 +41,10 @@ OPTIONS
 -------
 --version::
 	Prints the Git suite version that the 'git' program came from.
++
+This option is internaly converted to `git version ...` and accepts
+the same options as the linkgit:git-version[1] command. If `--help` is
+also given, it takes precedence over `--version`.
 
 --help::
 	Prints the synopsis and a list of the most commonly used
-- 
gitgitgadget
