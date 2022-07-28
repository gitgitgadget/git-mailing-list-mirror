Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF7C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiG1QrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiG1Qq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:46:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DF96112A
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:46:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q18so2952994wrx.8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d89TG589hkq7gK5neH4mimZOYXKSg8814Uit/7V2klc=;
        b=pxjZXNQ1hj7yljWrUVZIre/HiFh2iNqLaCgeov1d555+dYqteDUNKJYS1QuaH0PUj4
         L4gawGJWBiBcvkgkv+9YOoUZemwlhYCyJtIEcHCo0r7Il2KB7pSS0/RQapgMa4Lmbxye
         xYzKHu8wtpPFK0zGyoAFf+m9CAnPoT4UWHw00eOuAvd78YgsdT6MoGA2qEsdy8QXxWWP
         LL5MTVC8ZHNAleygic6iNVWWvsoAdVQJNBHjpfJmY9EZ/tDjlsaGlucf9OE9OrXX5dLo
         mH4eCeydG+5DvIznTkwR1o027YAwTHW1SIFNO910ORvWvZkzdjQ+fy/osWfEYQZx8M+Y
         c23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d89TG589hkq7gK5neH4mimZOYXKSg8814Uit/7V2klc=;
        b=E2yoMUsFMTpDz77BpHN9N8mBG4glI+IB2m35OS6r6AY3eMW9uZpKc6O5OphHVgp4LS
         4YBplJOBiQDcDrjgSoaaTSRUtFvMA4bkfbE75OatAJ/8oZkLBvDtTmcKfe8qcZYKguOO
         fOiMLKef6Cv6iKRSkr0AArdQmUKUOZH5ECLfrCAtwa11QYwMt3XHRMxgViGg3gYjm97a
         6ZDmC/qRJT5KNRoSAAHzwoEmW9y7RSajp2OMrZTu2hCXW21BZfriqDPXt798gGyqxoxn
         37xkupZh6rDANYUYA046iN+9r1SkxErAu+ri7Z8CUEXCFOn1kXsMC2qmRhrSv9HMPo85
         jZeg==
X-Gm-Message-State: AJIora9ncRm4mFb4srTBhpulqx0IGV+fqgEeC1cyZFqvzBvPER+BUBaf
        lHVopokIng0Hn4FWnNG61HK5G7NV98gCrQ==
X-Google-Smtp-Source: AGRyM1sOPOtOB+SEjuZOk41u52zAdU3oh6wwP+3dtyDYUo+/SDLU6FR0TVnOk6K8WNI5gPtt36jrLw==
X-Received: by 2002:adf:e10a:0:b0:21e:47f4:6a51 with SMTP id t10-20020adfe10a000000b0021e47f46a51mr18825656wrz.276.1659026814232;
        Thu, 28 Jul 2022 09:46:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021efc75914esm1495403wrt.79.2022.07.28.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:46:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/9] git help doc: use "<doc>" instead of "<guide>"
Date:   Thu, 28 Jul 2022 18:46:41 +0200
Message-Id: <patch-v6-2.9-80322d44ea5-20220728T164243Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of "<guide>" originally introduced (as "GUIDE") in
a133737b809 (doc: include --guide option description for "git help",
2013-04-02) with the more generic "<doc>". The "<doc>" placeholder is
more generic, and one we'll be able to use as we introduce new
documentation categories.

Let's also add "<doc>" to the "git help -h" output, when it was made
to use parse_option() in in 41eb33bd0cb (help: use parseopt,
2008-02-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 8 ++++----
 builtin/help.c             | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 239c68db457..bead763fd29 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,14 +9,14 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
-'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
+'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
 
 DESCRIPTION
 -----------
 
-With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
+With no options and no '<command>' or '<doc>' given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -26,8 +26,8 @@ printed on the standard output.
 If the option `--guides` or `-g` is given, a list of the
 Git concept guides is also printed on the standard output.
 
-If a command, or a guide, is given, a manual page for that command or
-guide is brought up. The 'man' program is used by default for this
+If a command or other documentation is given, the relevant manual page
+will be brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
diff --git a/builtin/help.c b/builtin/help.c
index 222f994f863..dec82d1be27 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -81,7 +81,7 @@ static struct option builtin_help_options[] = {
 
 static const char * const builtin_help_usage[] = {
 	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
-	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
+	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
 	NULL
-- 
2.37.1.1197.g7ed548b7807

