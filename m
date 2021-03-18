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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA63C433E9
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2D264F38
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCRJr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCRJrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 05:47:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3068AC06175F
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so4710605pjq.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IIpYMGylFiunIm+41k6WE5Knld9pqSRDVCcGITfr4qo=;
        b=cl8Qtnoi9O6biUEifnGx2m1qk+kxkOxEZbyDS7tCpNUKfQfIR0HR0O6hW7Ra2pxb5u
         Rce+gs6Pt0nRuxuKaOlwTQ4BaAS+MK5v0CNCMnxyag6NmzmZpuhPaQUsvuHUUXKbGFlZ
         3OQf4fe6ydHbKdkZ+KGQ7Hgmp2suXwVTql2rjnDvgpGWWzWBI4Ae+LGlTRNROZCBiqy+
         rf2NC24b6KYLKCMusOB/EgG3Ipkp2739VwwvznyTXKjusrWeuDSlHSy3mVWAlGqqPq2Q
         if+IZW9xbPWgV+eo3lEaYfiWMo9YRanJ7U2H+kE6wNfp/urz+xdkkcJBqNcDG4MewEER
         FxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIpYMGylFiunIm+41k6WE5Knld9pqSRDVCcGITfr4qo=;
        b=coR/FGerUSNtZ2/sc4JkOyDJvsrgdkeH89zvVykTJfx67DDMqkvzswHuXWUxBHN1zN
         FPGuL/tDMhK/c4mqaAx525XrLGSFTatsRLBvLTL+pVuU2rE1O2ivHtTJSW3KOas5MBay
         ooSUA36hutA5N0Wub2aVcurfQlHM+62odvqdF2POcX8PrF85dALoQNcCgomwUu+zZbPa
         v2DiJdsUf685ewR3pDgwya0wTnSxqMKnYCGF6oRB0lDnp2ffBcWR3pT75ebiKmMWtYPp
         QfqAHQvGh3GpY/A4yw5OzqQ8hCakvonkpsVgswA7OFmKuUwE5ChkGXbRFTkVWMuV/yvq
         Gt9g==
X-Gm-Message-State: AOAM5306+ABj+uRT7UsI6iEU40QvgRduKFQelUVigcve8zVgpFYj4LCF
        AksQ/50t8WCp04/yFrQRM7XXADHpdko=
X-Google-Smtp-Source: ABdhPJzNys4lFbL6jrNZ0bqMvqb1pHE79UNQWDPCcFzSd4OWM0QnpFm1EpEdUZVq1EF0/zN1TC1haw==
X-Received: by 2002:a17:90a:69c6:: with SMTP id s64mr3339447pjj.37.1616060826546;
        Thu, 18 Mar 2021 02:47:06 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id b186sm1902326pfb.170.2021.03.18.02.47.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:47:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [RESEND PATCH 1/3] git-completion.bash: extract from else in _git_stash()
Date:   Thu, 18 Mar 2021 02:46:54 -0700
Message-Id: <a2d9bc4a6651ea5212ebf7a3ea5441bbd58c1aca.1616060793.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1616060793.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com> <cover.1616060793.git.liu.denton@gmail.com>
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
index 7dc6cd8eb8..fe79f6b71c 100644
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
-			if [ $cword -eq 3 ]; then
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
+		if [ $cword -eq 3 ]; then
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

