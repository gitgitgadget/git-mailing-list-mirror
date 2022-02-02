Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F999C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbiBBLPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiBBLPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:15:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FAAC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:15:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso4310753wmh.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJ4KTcaLjOL/QnP/LBrbFdGCMjD7x3yBl5kGcKtwLSg=;
        b=Fdi2xaP0dp7YM28TJsH044mAIsgkZPbFa55AVEE1x5nvXAXSrUFAIGtXXwUloilOmn
         bqhSzQ+BglVokM+PQevdu6n4DndOJD3ClwBp/+VlmLjitvWrc80S+MfF0edOBTnqGBoV
         uaoCjsY877T4Hg34ElBpCQkA3wqCiAFHbe3EUI5ydVTPGxPqraMEdLKeG+XuiA+AJt4g
         so0urwEdAmoujRasRuz942epRu7snwPYVPBg6C+5upCi7tyir1gWfS14f1uJPsHlqKG1
         U1kMWt2iRkmHIR1JMTWhp7cZbYqMlKVbHWLcvmIqOWQeEticdcvgWl1jrRHrPJ++RP3c
         29cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJ4KTcaLjOL/QnP/LBrbFdGCMjD7x3yBl5kGcKtwLSg=;
        b=c2TWyx8+rOdfHPjsCi2VNF9g0CjKC7NrmPFkTnyP8Rg515kSQsMfKRpdeVWksk26Hn
         OSav1rAvX4Emt1Dplx4fbI2IH9eO6VMo8In7fYFm8d/+lTU7vClq8otvUljfHk7lQIJA
         tv4YgAS75qhEpNb8nbgdDCt5IInqNzNd554LEjrYi8Eetq8fvi7SKx5eqjmX8u/No2Rt
         OfmFRS9PdtAqVVf/IGBLBg5jvKtRDWasyL1GwndeJFxZ75Px8EBRaw7Z0nLfydcJUMHn
         ZIi+hbtGALMET/5y/bMVhNrJxqWruhw30FXTczJEOK/d4Zq7lIir1cp0JGWvfDCbg0CR
         WLqA==
X-Gm-Message-State: AOAM530DNzOWc97xJxqRyZ3HAXCqeZKJRUlun+ASHm0R29MYEH19mVJ2
        2TUp3BIHrzGlR2OoVpRV8HUfTuHAkexjrQ==
X-Google-Smtp-Source: ABdhPJwKkcKn2r+0+m4cLE13PKOJyXb6BJsrnsI9mAB1ucSrjgcaIrSKZe7/ptdXNi4aopBS1Mwt/g==
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr5662121wmq.41.1643800517938;
        Wed, 02 Feb 2022 03:15:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm18266603wrs.51.2022.02.02.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:15:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Victor=20Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
Date:   Wed,  2 Feb 2022 12:15:10 +0100
Message-Id: <patch-v2-2.2-2e2e3569e02-20220202T111228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
References: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_COMPLETION_SHOW_ALL_COMMANDS=1 configuration setting to go
with the existing GIT_COMPLETION_SHOW_ALL=1 added in
c099f579b98 (completion: add GIT_COMPLETION_SHOW_ALL env var,
2020-08-19).

This will include plumbing commands such as "cat-file" in "git <TAB>"
and "git c<TAB>" completion. Without/with this I have 134 and 243
completion with git <TAB>, respectively.

It was already possible to do this by tweaking
GIT_TESTING_PORCELAIN_COMMAND_LIST= from the outside, that testing
variable was added in 84a97131065 (completion: let git provide the
completable command list, 2018-05-20). Doing this before loading
git-completion.bash worked:

    export GIT_TESTING_PORCELAIN_COMMAND_LIST="$(git --list-cmds=builtins,main,list-mainporcelain,others,nohelpers,alias,list-complete,config)"

But such testing variables are not meant to be used from the outside,
and we make no guarantees that those internal won't change. So let's
expose this as a dedicated configuration knob.

It would be better to teach --list-cmds=* a new category which would
include all of these groups, but that's a larger change that we can
leave for some other time.

1. https://lore.kernel.org/git/CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com/

Reported-by: Hongyi Zhao <hongyi.zhao@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++++-
 t/t9902-completion.sh                  | 31 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 377d6c5494a..2436b8eb6b9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -49,6 +49,11 @@
 #     and git-switch completion (e.g., completing "foo" when "origin/foo"
 #     exists).
 #
+#   GIT_COMPLETION_SHOW_ALL_COMMANDS
+#
+#     When set to "1" suggest all commands, including plumbing commands
+#     which are hidden by default (e.g. "cat-file" on "git ca<TAB>").
+#
 #   GIT_COMPLETION_SHOW_ALL
 #
 #     When set to "1" suggest all options, including options which are
@@ -3455,7 +3460,13 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				local list_cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config
+
+				if test "${GIT_COMPLETION_SHOW_ALL_COMMANDS-}" = "1"
+				then
+					list_cmds=builtins,$list_cmds
+				fi
+				__gitcomp "$(__git --list-cmds=$list_cmds)"
 			fi
 			;;
 		esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index c9805f2147d..c6d6d6ef896 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2440,6 +2440,37 @@ test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
 	)
 '
 
+test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_ALL_COMMANDS' '
+	(
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
+
+		# Just mainporcelain, not plumbing commands
+		run_completion "git c" &&
+		grep checkout out &&
+		! grep cat-file out
+	)
+'
+
+test_expect_success 'all commands are shown with GIT_COMPLETION_SHOW_ALL_COMMANDS (also main non-builtin)' '
+	(
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		GIT_COMPLETION_SHOW_ALL_COMMANDS=1 &&
+		export GIT_COMPLETION_SHOW_ALL_COMMANDS &&
+		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
+
+		# Both mainporcelain and plumbing commands
+		run_completion "git c" &&
+		grep checkout out &&
+		grep cat-file out &&
+
+		# Check "gitk", a "main" command, but not a built-in + more plumbing
+		run_completion "git g" &&
+		grep gitk out &&
+		grep get-tar-commit-id out
+	)
+'
+
 test_expect_success '__git_complete' '
 	unset -f __git_wrap__git_main &&
 
-- 
2.35.0.913.g12b4baa2536

