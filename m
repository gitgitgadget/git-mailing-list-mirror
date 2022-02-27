Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B00C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 12:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiB0M04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 07:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiB0M04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 07:26:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CA6D87B
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 04:26:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so8657226pfe.7
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 04:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaghvTKVuxaxh8MsTeOjjXrZgUTP2ThDdUBjs8+u1Ys=;
        b=pnmIFQi4THi+HQ256aytO/Krhm3FjYn1oLqeq2BAan4F9FvEhNTaN0HmFYn+27mQq0
         RaEgRN+fIDn8zGaWjxD1Y4fqwToXcNwA0pF1/K8xojV76tPH+VltEgj7zp1fT56aMw4n
         6mTkEfx8r7j91F+OM1IB5OD0vjJDpIqpdyKTb34KK787j9dx89MIn277Ll40py8JafFQ
         HPC15PcDT+cHEe4qZCa+LO2qPIuBDC3AMlKzj+5BIe+8OMRpMJKbzSWwwTVRFRuc7Kz8
         kMTncviDaoW2s/oGyKzNQXf9nK09iMAbutHXK5tvI00EjwYfxqHZt0YAykPSfFDpeM47
         bE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaghvTKVuxaxh8MsTeOjjXrZgUTP2ThDdUBjs8+u1Ys=;
        b=BYr+F6hJWn1ciRf9cv7AaEs/Fcftd5IU/10AWqwUiDuqkPkYcwydgR9czJEjlbrdkN
         X921RX2W09NxP660HZJp7WpJFBC6dD/y/HwJen3hIgVACz3BgCu36NFy6QVTWaDEi+zQ
         26OebtWrR4m68BWTb9r2w4SZ5+HXOQWNCC3Y1qAzwaLamhUH+g14mGE2F/hQu1QxJSTv
         /6xZkJprQcwUg7jFtJBqcy+5V/RD6I4fDmgXDEc5lI4G9hleRtmVqegoJW4WGbyxGWa5
         4o5bIl4VO72giIgwl8mvLRN5IMcJsXLCjhbhLE+QV340lzhCefPicxg1jYjufzpGREgh
         R+8w==
X-Gm-Message-State: AOAM532MJrvMQGh2UrFYb+P3lUK1wvMVp1lMxknqgkYIrSFOKY64Cn1A
        dXoZvt++JX1+ZS8EctfkfrzrSGTqdJX+s4ha
X-Google-Smtp-Source: ABdhPJysi5gqtW47Omd/ej8snjr79ePzki6QUi70gMSBxpIkGlNUJi+CMHMUPoFgvHACgtPG6HC6qg==
X-Received: by 2002:aa7:8882:0:b0:4df:7b9e:1ccb with SMTP id z2-20020aa78882000000b004df7b9e1ccbmr16626217pfe.41.1645964779215;
        Sun, 27 Feb 2022 04:26:19 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.152])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm9802969pfh.174.2022.02.27.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 04:26:18 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v2 1/2] t0001-t0028: avoid pipes with Git on LHS
Date:   Sun, 27 Feb 2022 17:54:52 +0530
Message-Id: <20220227122453.25278-2-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227122453.25278-1-shivam828787@gmail.com>
References: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
 <20220227122453.25278-1-shivam828787@gmail.com>
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
index b007f0efef..b5fa76059b 100755
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
 
@@ -1104,12 +1105,13 @@ test_expect_success 'very long name in the index handled sanely' '
 	>path4 &&
 	git update-index --add path4 &&
 	(
-		git ls-files -s path4 |
-		sed -e "s/	.*/	/" |
+		git ls-files -s path4 >tmp &&
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

