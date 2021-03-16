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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F1C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D7564F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhCPAyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhCPAyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:54:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93DC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u18so16126315plc.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IIpYMGylFiunIm+41k6WE5Knld9pqSRDVCcGITfr4qo=;
        b=tn1EhW/5j4NbaE1I90KiHqv3vOi90PrT9Esi4sifO2mRABaZZaWp278JlVASOeUOHf
         uU1ZmRMUrdDopqedQkHzg2OtVv8M5Y3QEJC2ZPFwUw/loeHmmty4O22gLz6DsKapu71v
         4pd6yzzxO0vBNamv9JBLHOPb/55Wr8ei4BuM3NII2NjBThIKGKVh++s/gpQ3ivirlEuN
         Fd9IIKWaDW7cdVgYIr84GFcTGYBiRx/PQ06jC7YWu7flY45yhzlXHvUQxssyd0VxGQvg
         /TfoKHu0wqXAHX/MGH2BDf2/huucOvm7/7h5qlovtdjrXBG13EkN1cI7uTRDUYUgoVg/
         EvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIpYMGylFiunIm+41k6WE5Knld9pqSRDVCcGITfr4qo=;
        b=cfcabcbAG6XUPKrWAWlrVtDJP5h3tP+CUKWqmvMDvDK3gAH7enmixMGoAXgom1R5/S
         noY9F5xqPhMn7jPRBZ54qtwOl/eGleettYoUOVs1qcBGtDVAB5AsE6/OY7KsJEAqFFju
         J8R0qQcl42Mfyoj0JqENEB7fNUrGuDECpoHeJjijIMYOtT0HtqjmvfJr2DRPXV9Kmq1C
         EyMQAxeYOTwGYoG6a/h5vzlexczvEqtFKQYHFIinUX4tGOiA5IaxRdJc3UbkYp77sE5Z
         YWXheM7TLlGvCQdZWf7mRdfngnHL2DQcsdUmAybYdpRsuTRL5RAvuAWrWqR/ZDGTVVhR
         rvkg==
X-Gm-Message-State: AOAM533uK82Ew43qMyPK2Q7ymvXLRcS7ROJR4kMWptxOdOVv/a8E7OlV
        F5XP/06I3t5Ce7xUTEwLUe3OLdDEGY4=
X-Google-Smtp-Source: ABdhPJzp1tyix/9rfrz3LQb/05v7jySs8zAdcco91AN3JRwfQt2UROvD6cloeqF9fXSyqYpFvuY0qQ==
X-Received: by 2002:a17:90b:686:: with SMTP id m6mr1908426pjz.26.1615856074270;
        Mon, 15 Mar 2021 17:54:34 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id y24sm14449791pfn.213.2021.03.15.17.54.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:54:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] git-completion.bash: extract from else in _git_stash()
Date:   Mon, 15 Mar 2021 17:54:18 -0700
Message-Id: <a2d9bc4a6651ea5212ebf7a3ea5441bbd58c1aca.1615855962.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615855962.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com>
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

