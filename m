Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51609C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357976AbiFVO3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352490AbiFVO2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5F1BE8C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so23664887wra.9
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTXgzG3Ro3Dohb7hi59+t+VttfpTksv5Ml/LAZczkPw=;
        b=iZhyWdD7kk/rGYb38xSFDG3fLecITdFvdccIfMOSyP902+Nw1HWyy6nKbWCRKc8YOz
         DN719/7QZdg/BfJ/xeGTnZ3pnAa5aw/ICvEWGKhPyDt7aU4ij8RXaC8CS8HlBTqp75Cs
         JLuxbqoVpuoaaoIfI1R4taT9OTbMvcmaoUZJQ7Cp8OBtOdfEDQF4bF4nivfsp1nhs+xJ
         gMCwkc/gLtum7Kai+WcPKtqeE5eb1kthx2TIuk9r6uN5jk7ro3D2FkaXbDCxwiwG4I24
         wtxb3ZZm8hYsT1aBFbMlNrYDTRBhHacfFCl+itvyQTqY8iGYFdGAx1r8EYvJpZRyT31Q
         nQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTXgzG3Ro3Dohb7hi59+t+VttfpTksv5Ml/LAZczkPw=;
        b=ca6ToaSdH+LmnqbAMAKKK1dLxp2c2c22uaXWWprieuYWHs5FQJ6qIwnfdrxl95IsZo
         R/GNPh88DpYzBuZrpC1jIlrb1aOWX4nikmQH71+TERp4d7NW3zABfPrZT14XPjhHQpy7
         rqH/FNTqUEiZL0IXCkSwaFCsrEN+GeRIL8h8V69UiMx+1DZa3M4GLAE8YzXZPBr+LD5w
         Re7ki+xUYy4s03BzCzRC0YrX2sQ/ajKYscpD7DN24858Wex+y9jau7SqfLKnCwdwV7gh
         LzUlfikOUB6PiJqAev2DKMkrExFzGZkAa2DdgQmDVMu4yUB77My5SUivDMhbBSuFFncl
         Lolw==
X-Gm-Message-State: AJIora/jNYivTk9EsCYy9pbIla40zfyC7HhaJ7e6lvXpqvjalKYWrdzJ
        sSwgYtdVUMrzzQflMJOw/g4ZKtBbBiSb7w==
X-Google-Smtp-Source: AGRyM1v6hkgHkf8wXSgFtH2qUlaff9C88RrYuooZsqpKfr96GFceURBZ5WmZPa2S3NNUg8aEWaRgZw==
X-Received: by 2002:a05:6000:156d:b0:210:3135:ce1c with SMTP id 13-20020a056000156d00b002103135ce1cmr3635221wrz.409.1655908094305;
        Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/12] git-submodule.sh: remove unused top-level "--branch" argument
Date:   Wed, 22 Jun 2022 16:27:59 +0200
Message-Id: <patch-v3-04.12-b5967afd59f-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 5c08dbbdf1a (git-submodule: fix subcommand parser, 2008-01-15) the
"--branch" option was supported as an option to "git submodule"
itself, i.e. "git submodule --branch" as a side-effect of its
implementation.

Then in b57e8119e6e (submodule: teach set-branch subcommand,
2019-02-08) when the "set-branch" subcommand was added the assertion
that we shouldn't have "--branch" anywhere except as an argument to
"add" and "set-branch" was copy/pasted from the adjacent check for
"--cache" added (or rather modified) in 496eeeb19b9 (git-submodule.sh:
avoid "test <cond> -a/-o <cond>", 2014-06-10).

But there's been a logic error in that check, which at a glance looked
like it should be supporting:

    git submodule --branch <branch> (add | set-branch) [<options>]

But due to "||" in the condition (as opposed to "&&" for "--cache") if
we have "--branch" here already we'll emit usage, even for "add" and
"set-branch".

So in addition to never having documented this form, it hasn't worked
since b57e8119e6e was released with v2.22.0.

So it's safe to remove this code. I.e. we don't want to support the
form noted above, but only:

    git submodule (add | set-branch) --branch <branch> [<options>]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b99a00d9f84..20fc1b620fa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -574,14 +574,6 @@ do
 	-q|--quiet)
 		GIT_QUIET=1
 		;;
-	-b|--branch)
-		case "$2" in
-		'')
-			usage
-			;;
-		esac
-		branch="$2"; shift
-		;;
 	--cached)
 		cached=1
 		;;
@@ -609,12 +601,6 @@ then
     fi
 fi
 
-# "-b branch" is accepted only by "add" and "set-branch"
-if test -n "$branch" && (test "$command" != add || test "$command" != set-branch)
-then
-	usage
-fi
-
 # "--cached" is accepted only by "status" and "summary"
 if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
-- 
2.36.1.1239.gfba91521d90

