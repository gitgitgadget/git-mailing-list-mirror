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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A3CC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35FC207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbhAACRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbhAACRn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:43 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64988C061757
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:28 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id f132so23397406oib.12
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfoJlJLdcALi0L8dTmfuSBOstRpoEMOE2md1G9Q8nyA=;
        b=qhEXGzklA4b9Izzjj5uPD86w3hA3YeQw45IFHIPxb/1TrDf+49U2hWcSR5j9mUdWuZ
         VwAtKJZpILD/LZMrQszQe2WKuzJd+Fm0/DihR9yd3UuDdbn5aqjF1+OGM8YeGy/SNTYn
         bCpJNbvHF5FYnd7qTIknj8C12oyBaxEZD2agCmRQ+7LtU8cvOaPgEOc/xjVE0Cgn7YGb
         kT3Q+0tK9iNlvm0Q1q6pKauXlntt8wTrKcdbo8RH/dMe9duMeiVaWHeJgp49F+LeD5HV
         hvvzAolE2ojxrDbTEVigieNgogkoF/KSbYERetIoj9iC6Cd60vxdpcin1uHwkjJai0Kq
         dFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfoJlJLdcALi0L8dTmfuSBOstRpoEMOE2md1G9Q8nyA=;
        b=CBvaJ9I67Hv/eh7mB13aJOPXtWaZb5IInOpJ1Kwvv/40Ovi8CCn28E8/iH5MdzV4la
         0ufEZB2OIGCJrD4IJq9jWGBHkIOTqrjmEtaGiIGNkLf+Iy7gudo/eg0wu7e4JFQQarWu
         lrMD03oe0PFioYY1+TevV+gQ6Lo2sYKBlGa3FukSgRRnM2zGnHHcokAKzLqbDFrH7hmB
         tQSLx7Gi5aNo08CjrzRxdokJPnAB74dbOO/t0tbUr0BW+PAjzXh5PU1BN4DarvEGDXL9
         IUstPJd2HiZVdhEHjwUurZ65EVhj9bIuNplbTKL9L9vZMStTfQv8cnvy55zqrDuRuNTM
         bqiQ==
X-Gm-Message-State: AOAM531GmV2ZIwcYfCCR9MppIDnDf2vu3i4f6SqHau4xtLDgtYzcHcdR
        r/g4BaNHN0M219lQwhmlVrZndn0Or5ahIA==
X-Google-Smtp-Source: ABdhPJyl4PDNBM1p1IaxfxW77ycJIKzp1I/JneCH4h2Mqa5Xy+9MUdORJD1nBU9FsB2KBSCYwNxQDw==
X-Received: by 2002:aca:4307:: with SMTP id q7mr9325797oia.122.1609467447650;
        Thu, 31 Dec 2020 18:17:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s23sm11562879otr.59.2020.12.31.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:27 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 40/47] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Thu, 31 Dec 2020 20:16:15 -0600
Message-Id: <20210101021622.798041-41-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove temporary variables.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 040391f881..9918998848 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -341,14 +341,13 @@ __git_dequote ()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local words_ cword_
 	local exclude i j first
 
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword_=$COMP_CWORD
+	cword=$COMP_CWORD
 	if [ -z "$exclude" ]; then
-		words_=("${COMP_WORDS[@]}")
+		words=("${COMP_WORDS[@]}")
 	else
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
@@ -368,9 +367,9 @@ _get_comp_words_by_ref ()
 					((j--))
 				fi
 				first=
-				words_[$j]=${words_[j]}${COMP_WORDS[i]}
+				words[$j]=${words[j]}${COMP_WORDS[i]}
 				if [ $i = $COMP_CWORD ]; then
-					cword_=$j
+					cword=$j
 				fi
 				if (($i < ${#COMP_WORDS[@]} - 1)); then
 					((i++))
@@ -379,17 +378,15 @@ _get_comp_words_by_ref ()
 					break 2
 				fi
 			done
-			words_[$j]=${words_[j]}${COMP_WORDS[i]}
+			words[$j]=${words[j]}${COMP_WORDS[i]}
 			if [ $i = $COMP_CWORD ]; then
-				cword_=$j
+				cword=$j
 			fi
 		done
 	fi
 
-	cword=$cword_
-	cur=${words_[cword]}
-	prev=${words_[cword-1]}
-	words=("${words_[@]}")
+	cur=${words[cword]}
+	prev=${words[cword-1]}
 }
 fi
 
-- 
2.30.0

