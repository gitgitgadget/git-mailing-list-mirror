Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2AC433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE8761A01
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhCXIhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhCXIgn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 04:36:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBDC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ha17so11367767pjb.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPD7sCID0VXn8yIgbuQ7c1tD2tj8rOHNIJKo8TfsTso=;
        b=a6ppjBMbxrYjQat0ZAqcT7spbCSgUyh1uptgbrvYugb1aHkOdNdOgb2Z6c9tFWkYrk
         Q/6YiL/Z+h2DCkC0obtncUjEZuESWpMm8q/R4u8aE7RZGchjaIpTcXT3B/vdQvMV3H0L
         KsNtU2fO03vyLU3nUaTCjBe78NovzIHBgBoclNTcKG+PJzwksyddSCCbiLLB/pR0q9dF
         9suZ70e/gYwSozPy+Ni5WZi8oOa5g29z9re/GjtL8XYuwGBxwCFir/vG7aBFTuy6PTlw
         tXsG6oIKEWQXLaxuyoMlSPPJWa/daljeIq+VMA9SgernikJR20Aif5QCfifg7W2O6cYA
         2/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPD7sCID0VXn8yIgbuQ7c1tD2tj8rOHNIJKo8TfsTso=;
        b=lj3aBOx01QXpzH61zFbL5pXcYZS6qVd52X8Qn90WlD0GPMn2KlORxHc32rh+WBcL/V
         11cGVjMjv60+S4Pj2ss5anqS+/J0KP1TFmeB13iY3+cmIiwZEyfpP/p1PWYsrL1f8s//
         IlsTzWpz+N3GRdbk59UJXaIRFjDtgrOFI1ZLnmkWXyeHxB8PbwUXTYgvkK2WhgEiclfs
         0pElX9oYFU1xPbLjvpsLlcAIc31IRLM7fBQ9A/JqaryFBgqTRqCBjkG2jjvPhfe8agGP
         952m+0ncUTIj1bvfIIsdEEPxEPo0uw/8wEEGz0ksmHDzg8M7cvYpohIwJoqmvDnVRTBt
         xH9A==
X-Gm-Message-State: AOAM533JyHHLukwHWCE7KLVuHN5rMh5bODZB3C60LN/b1qqzkwM4Xyv+
        y87qgGzt2WXdfNYxxwsT0OKZ6Skoozw=
X-Google-Smtp-Source: ABdhPJzO6t7f/fe9WcBAzunT0xL9iyzMF6JLDiplEN3qyilFWoEKACvrAZy2TIDMjP0/8cnYWcrlYw==
X-Received: by 2002:a17:902:eb11:b029:e4:a5c3:4328 with SMTP id l17-20020a170902eb11b02900e4a5c34328mr2621589plb.7.1616575001868;
        Wed, 24 Mar 2021 01:36:41 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a15sm1609361pju.34.2021.03.24.01.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:36:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] git-completion.bash: extract from else in _git_stash()
Date:   Wed, 24 Mar 2021 01:36:28 -0700
Message-Id: <430d5acf972f39aa8cfc9b266dd658aabcf1babb.1616574955.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1616574955.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com> <cover.1616574955.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To save a level of indentation, perform an early return in the "if" arm
so we can move the "else" code out of the block.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 73 +++++++++++++-------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a2f1b5e916..8d4d8cc0fe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3035,44 +3035,45 @@ _git_stash ()
 			fi
 			;;
 		esac
-	else
-		case "$subcommand,$cur" in
-		push,--*)
-			__gitcomp "$save_opts --message"
-			;;
-		save,--*)
-			__gitcomp "$save_opts"
-			;;
-		apply,--*|pop,--*)
-			__gitcomp "--index --quiet"
-			;;
-		drop,--*)
-			__gitcomp "--quiet"
-			;;
-		list,--*)
-			__gitcomp "--name-status --oneline --patch-with-stat"
-			;;
-		show,--*)
-			__gitcomp "$__git_diff_common_options"
-			;;
-		branch,--*)
-			;;
-		branch,*)
-			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
-				__git_complete_refs
-			else
-				__gitcomp_nl "$(__git stash list \
-						| sed -n -e 's/:.*//p')"
-			fi
-			;;
-		show,*|apply,*|drop,*|pop,*)
+		return
+	fi
+
+	case "$subcommand,$cur" in
+	push,--*)
+		__gitcomp "$save_opts --message"
+		;;
+	save,--*)
+		__gitcomp "$save_opts"
+		;;
+	apply,--*|pop,--*)
+		__gitcomp "--index --quiet"
+		;;
+	drop,--*)
+		__gitcomp "--quiet"
+		;;
+	list,--*)
+		__gitcomp "--name-status --oneline --patch-with-stat"
+		;;
+	show,--*)
+		__gitcomp "$__git_diff_common_options"
+		;;
+	branch,--*)
+		;;
+	branch,*)
+		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
+			__git_complete_refs
+		else
 			__gitcomp_nl "$(__git stash list \
 					| sed -n -e 's/:.*//p')"
-			;;
-		*)
-			;;
-		esac
-	fi
+		fi
+		;;
+	show,*|apply,*|drop,*|pop,*)
+		__gitcomp_nl "$(__git stash list \
+				| sed -n -e 's/:.*//p')"
+		;;
+	*)
+		;;
+	esac
 }
 
 _git_submodule ()
-- 
2.31.0.rc2.261.g7f71774620

