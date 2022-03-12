Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455FC433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 06:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiCLGXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 01:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLGXH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 01:23:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B8EF65D6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 22:22:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso10011752pjo.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 22:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVgtlJdjW+0MxAdzgbROFhHmBUxuPeSn8CXMry57ptw=;
        b=Tk+3GHk+gj794KkQhGuNfux5IsNIt2O7igbhGOFEnd8K7USDRamwacWhT0M6RtcupD
         hXBhXnJZKCrFrWkb+9ENO3WiOUjC9FkHGQf3geOFtw/iG6N+d2TkSzkTbxIMsTbGceH/
         IfEpb+vyAm+Qss++vo5cOz/CfgtmztVFCRXv3/stveouqdJRhyqlE/bMoJX+YiMZYubd
         7rmenMrf/Xa1F3ReWHGNeiKzDD9sCNFcjuzdfhGGlvIQcHiVDVeqKhPHgr+OrgiJTZ3b
         W9cW9YjMZBvj6WFcHL4laAWhBD74qjSvohkLjQAX8jwvQwIwbTaN6OSDDjRYjJ695fw2
         Fk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVgtlJdjW+0MxAdzgbROFhHmBUxuPeSn8CXMry57ptw=;
        b=AZv2MJWViyVKTh/x83bK3AB+MkmwCSiMbxBpnI6X1RfWjEpLLJ7P/j2CvHw33iVYdA
         LG0wx5SIp8vN2Woq+CiFp/NaccLLqw55xgbEySmZyGaOeXQQLPIZXdsRcqy3kGzNRdGk
         t211SRWFLNsVacIS8b93e3V+0sPhj9KZu494FcJzStbEr10Gf6KZyLtufC6xI6fuJUrV
         Oi+qJMo60qEAs2RA/Nxx9Anv+m30R32O57JhNS7K9tM7qUe65Yr83T5I5mvHBo3jH9hE
         wx9MlLOecRfXPDZMZZXfykwaITh60w5z7Vb1bnY/FG9cHPj4G79BQdarpVlm5q0djc2x
         QAQg==
X-Gm-Message-State: AOAM530cLjPAEu9YNWeQpKcfvX3vIREGgNnl7t0foGeeUmtTUEI+gziw
        pmdKSWuzldX3c1UjIQvs7JEiGprkzNijDFI3N8s=
X-Google-Smtp-Source: ABdhPJx10BwVb3QDxGGGqAB0I8pYK1s/Nqa1DPEheKfnapXVrmDy8ie4GQW8GYkm4xPB55AkLai2MQ==
X-Received: by 2002:a17:90b:228a:b0:1bc:7ca4:efaf with SMTP id kx10-20020a17090b228a00b001bc7ca4efafmr14482388pjb.245.1647066120064;
        Fri, 11 Mar 2022 22:22:00 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.246])
        by smtp.gmail.com with ESMTPSA id z25-20020a637e19000000b0037c90292bebsm10225330pgc.55.2022.03.11.22.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 22:21:59 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, me@ttaylorr.com, kaartic.sivaraam@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v3 1/2] t0001-t0028: avoid pipes with Git on LHS
Date:   Sat, 12 Mar 2022 11:51:25 +0530
Message-Id: <20220312062126.31988-2-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312062126.31988-1-shivam828787@gmail.com>
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220312062126.31988-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes ignore error codes of LHS command and thus we should not use
them with Git in tests. As an alternative, use a 'tmp' file to write
the Git output so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0000-basic.sh            | 10 ++++++----
 t/t0022-crlf-rename.sh      |  4 ++--
 t/t0025-crlf-renormalize.sh |  4 ++--
 t/t0027-auto-crlf.sh        | 12 ++++++------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b007f0efef..9dcbf518a7 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1089,7 +1089,8 @@ test_expect_success 'update-index D/F conflict' '
 	mv path2 path0 &&
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
-	numpath0=$(git ls-files path0 | wc -l) &&
+	git ls-files path0 >tmp &&
+	numpath0=$(wc -l <tmp) &&
 	test $numpath0 = 1
 '
 
@@ -1103,13 +1104,14 @@ test_expect_success 'very long name in the index handled sanely' '
 
 	>path4 &&
 	git update-index --add path4 &&
+	git ls-files -s path4 >tmp &&
 	(
-		git ls-files -s path4 |
-		sed -e "s/	.*/	/" |
+		sed -e "s/	.*/	/" tmp |
 		tr -d "\012" &&
 		echo "$a"
 	) | git update-index --index-info &&
-	len=$(git ls-files "a*" | wc -c) &&
+	git ls-files "a*" >tmp &&
+	len=$(wc -c <tmp) &&
 	test $len = 4098
 '
 
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index c1a331e9e9..9fe9891251 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -24,8 +24,8 @@ test_expect_success setup '
 
 test_expect_success 'diff -M' '
 
-	git diff-tree -M -r --name-status HEAD^ HEAD |
-	sed -e "s/R[0-9]*/RNUM/" >actual &&
+	git diff-tree -M -r --name-status HEAD^ HEAD >tmp &&
+	sed -e "s/R[0-9]*/RNUM/" tmp >actual &&
 	echo "RNUM	sample	elpmas" >expect &&
 	test_cmp expect actual
 
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index 81447978b7..f7202c192e 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -22,8 +22,8 @@ test_expect_success 'renormalize CRLF in repo' '
 	i/lf w/lf attr/text=auto LF.txt
 	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
 	EOF
-	git ls-files --eol |
-	sed -e "s/	/ /g" -e "s/  */ /g" |
+	git ls-files --eol >tmp &&
+	sed -e "s/	/ /g" -e "s/  */ /g" tmp |
 	sort >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index c5f7ac63b0..0feb41a23f 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -311,8 +311,8 @@ checkout_files () {
 		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__CRLF_nul.txt
 		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crlf_false_attr__LF_nul.txt
 		EOF
-		git ls-files --eol crlf_false_attr__* |
-		sed -e "s/	/ /g" -e "s/  */ /g" |
+		git ls-files --eol crlf_false_attr__* >tmp &&
+		sed -e "s/	/ /g" -e "s/  */ /g" tmp |
 		sort >actual &&
 		test_cmp expect actual
 	'
@@ -359,12 +359,12 @@ test_expect_success 'ls-files --eol -o Text/Binary' '
 	i/ w/crlf TeBi_126_CL
 	i/ w/-text TeBi_126_CLC
 	EOF
-	git ls-files --eol -o |
+	git ls-files --eol -o >tmp &&
 	sed -n -e "/TeBi_/{s!attr/[	]*!!g
 	s!	! !g
 	s!  *! !g
 	p
-	}" | sort >actual &&
+	}" tmp | sort >actual &&
 	test_cmp expect actual
 '
 
@@ -617,8 +617,8 @@ test_expect_success 'ls-files --eol -d -z' '
 	i/lf w/ crlf_false_attr__LF.txt
 	i/mixed w/ crlf_false_attr__CRLF_mix_LF.txt
 	EOF
-	git ls-files --eol -d |
-	sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
+	git ls-files --eol -d >tmp &&
+	sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" tmp |
 	sort >actual &&
 	test_cmp expect actual
 '
-- 
2.25.1

