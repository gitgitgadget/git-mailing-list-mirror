Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA56C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DB622263
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVamwvnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390681AbgJOR6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388468AbgJOR6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:58:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15306C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so2030342pld.5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jf6MzmauecmMAGvlhgLkJUJ1LHylOTi1Hh+wBxlkTMY=;
        b=lVamwvnX/zv+G7iR6HLPBZbPnlOwtZ9aytiINb2suBn/F1NN62jTU1k3qf7bGNDm6K
         x1hyMKXHGGEdMPoeClYkk0+J8lDMGkfiY57MXbgI1b/sZgrkH6xhGT4LGRN/2gDGz+im
         qTzwuidlxkpgGEpSNdJoOYRFjCXQGlxHEemKnKONyMWlz7YmBVS/AeuTrpklR1Mwi08L
         PUmrJyOoN/POXO+cPfWdrdvV6gkOttKYkrcSxqwAS0AcDX0gogwQvC/IkVQWg7sgoTH7
         nyA3F9rV66qon8eGsrJ2SqSmI4069rqoyLPwJWygrznYtCLysFR9NERru2eUIdBWSukF
         H0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jf6MzmauecmMAGvlhgLkJUJ1LHylOTi1Hh+wBxlkTMY=;
        b=S++1pwlb6LuGw2bBSWOb2dlS0HqpMkk5QKuGU8QuEnMXiEE+DfaIut2BPCYBg1cbQV
         5EmlMM2/a0dbeWS77DV7Uk1udm2HmIn2msApNjdp82C4gvC0OrQ9TQLYpIVUIbJ4ejDM
         ZQh5ihzBaipisma5/CoYSx5olIq21lNRbVfSiEYos+4GcwUkLNxSSKXKOgYeTSyDlAAn
         9goa/B8wsMPZaFN2lh2IuzJyubMCzRuMf8BrlF9lcCVZjHOqcS4ryeH7Dm+fMk9SM7tt
         dkiS4fu2HMz4tnz9w5w3qa/vYf4320/eYClzvkTUUPp82UodTI5TN4oN91oEaN1ZiatS
         4IIw==
X-Gm-Message-State: AOAM533TOdwJe3Ij3JDKgRsEuLbkZZ6qCOohtOpQ6+CJrctTqYBW2jUf
        +MrC/rBx8DHfsNC4IKdZwjjMy2NGBbI9M3+E
X-Google-Smtp-Source: ABdhPJy0kDTNtmDH01mIAnzE4k/1CGYDW2qsneABS0sLtj9FLCL2zKBFK9yvCJwpY3WSQO8POMUIxQ==
X-Received: by 2002:a17:90a:c68e:: with SMTP id n14mr57648pjt.158.1602784711434;
        Thu, 15 Oct 2020 10:58:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1309:c8:79e1:6677:5d35:9a95])
        by smtp.gmail.com with ESMTPSA id n139sm3945930pfd.167.2020.10.15.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:58:31 -0700 (PDT)
From:   charvi-077 <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, charvi-077 <charvi077@gmail.com>
Subject: [PATCH 5/5][Outreachy] t7201: place each command in its own line
Date:   Thu, 15 Oct 2020 23:27:09 +0530
Message-Id: <20201015175709.20121-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201015175709.20121-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple commands on one line should be split across multiple lines.

Signed-off-by: charvi-077 <charvi077@gmail.com>
---
 t/t7201-co.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5898182fd2..b36a93056f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -157,7 +157,8 @@ test_expect_success 'checkout -m with merge conflict' '
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout -m simple &&
@@ -180,7 +181,9 @@ test_expect_success 'format of merge conflict from checkout -m' '
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
@@ -205,7 +208,9 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 	git rm two &&
 
 	test_must_fail git checkout simple 2>errs &&
@@ -218,7 +223,8 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 	git config advice.detachedHead false &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
@@ -237,7 +243,8 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
@@ -254,7 +261,8 @@ test_expect_success 'checkout to detach HEAD' '
 '
 
 test_expect_success 'checkout to detach HEAD with branchname^' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout renamer^ &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -269,7 +277,8 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 '
 
 test_expect_success 'checkout to detach HEAD with :/message' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout ":/Initial" &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -284,7 +293,8 @@ test_expect_success 'checkout to detach HEAD with :/message' '
 '
 
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout HEAD^0 &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
-- 
2.29.0.rc1

