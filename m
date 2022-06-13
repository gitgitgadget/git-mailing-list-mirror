Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23CFC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiFMWjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiFMWjN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F56617B
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z9so3714938wmf.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYF1p9Qh3biEc8ny6hA7NyQpg8u/a+PrYS71lAh3LpQ=;
        b=m9/6NxyvWFIVKrSvr3P5P3dj7NLZOXP26WmHMaMfmY3jOnVa9zgTHEAk0BD2v5w1np
         wEk3Xcl11rxz0NtQnk+UWzO6abYQEAlOJlBmJ+wFyoge8jegKa9gXL91RMYzcRnGpypq
         LOx/yLnxIUh3fUAu97K0Wf3TkrPu3Q7pzWTA0/QeGyI787B0Os9eYjB2FwkpSvSNZ+RP
         bUkc38s4vFYdlHI+kzSEgb5T4FlsQx6HjMoUK2gfLsDO7p39JDjZQnHSvH8G6ailRdpT
         M0bC/tEvD2Y5wJp7HGfwgsen/D3c2Fg7YGGlNelChBGCJT9tOChb4e9xR+PhqjJttiuc
         tCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYF1p9Qh3biEc8ny6hA7NyQpg8u/a+PrYS71lAh3LpQ=;
        b=JMrw3wqM/27tUzZ5MV8JK9J3GXtY1WoaPb/PSg9+wcW2Il6VnxhwQ/k3rYREp+0XKt
         V5nHqEOSvBSRGoqWJW0V/FuBlB6VMr3eKE90ZBT4s48wFz/SAx9RfuHxwExp1Rn3YtUV
         z0NNth4xDSF/Y9+6iKZKPPADdoGp/qI267mLBWYjZiYWTjNFEiVESFu5//gZ5IfIkBDe
         9MCX7olthu6pnXIX9+xKAHEYF/v7nr9/IW3uMbqP49WfnrdlgRVyIyFKKWJ7IzVdCM2q
         08efMy4r6NL8Ish41YoNkK5dQqDYuOSy93KKthc0btPw60eT6IXvvAwIqM0ZvXihpxQu
         GiYQ==
X-Gm-Message-State: AOAM532evpDADKpEaIBki7cg1y4nazDHpY7JBCsYwGr6wvVFNSBOCpCq
        H9wZXLE2X6VNZbF8sOtSqZdxJAEQXPKTBw==
X-Google-Smtp-Source: ABdhPJy13ZynDBuoUCTt5tTnG7fPNZN4bXlIPD0gBl4JJQab5kGOAks+fxwSWk6j51zQU7AjgIc/Bg==
X-Received: by 2002:a05:600c:3b0c:b0:39c:7d91:26d0 with SMTP id m12-20020a05600c3b0c00b0039c7d9126d0mr932651wms.40.1655159950770;
        Mon, 13 Jun 2022 15:39:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/12] git-submodule.sh: remove unused top-level "--branch" argument
Date:   Tue, 14 Jun 2022 00:38:55 +0200
Message-Id: <patch-v2-04.12-fd328329b68-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
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

So in addition to never having documented this form it hasn't worked
since b57e8119e6e was released with v2.22.0 it's safe to remove this
code. I.e. we don't want to support the form noted above, but only:

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

