Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC0C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6673120774
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0t8m5iE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYFzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:17 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46781 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgCYFzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:17 -0400
Received: by mail-qv1-f67.google.com with SMTP id m2so468759qvu.13
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i5YJcHss20tP7ZQ/brMc62KBT/ftaRdKhsrYV2CBJ6I=;
        b=c0t8m5iEEisWSubSs6B/ueGeNcQVOiUNxzdkDYmL3ZfkijihxFaMGMxVDZr93qdnhS
         gcNlD/P7nrZYo9oti/Vaa76Clp3oiNTzk6z9HrhaBsN4lhuXX/Jw6SO00MK22tiLPspc
         cZXTLziuJ5hAPJSK+GI7LgULUdqa4KHtJ/gvQBGQt/OBnIjX/0Ms9O6bkTTp51CoHCqe
         hE7Sp8Zy/bftYCxZowu3hmkM37O1LQPLSnpZmvwEd8hnMiiiSIq2f0tfgqecuOSXp4nD
         eUTbg/Ki2IatwiHQwOdC6NXY+rJsj3lffu+fq43Z/7/F1DNVA1ojomE1msOXPyqJZ0G0
         CCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5YJcHss20tP7ZQ/brMc62KBT/ftaRdKhsrYV2CBJ6I=;
        b=lghv0FMp8vmAzUUYiIatX58lWipQb1KltN7ltiD6m4gWLuZJtfzbuM3FbhnQX/6OZr
         KSdignRVLQHrfhsCD7+BejnkZNrTWCgJQHXoSDWYN2TTZNGZhXaQBNj1wep4YW9V7+b4
         WwQE4N4hWlJ3q8qXyl7PUMvy/zM5QYZ4q4/7h2jR+93dDXiWbBoq+L2kl4k6kLFCHa2p
         RJZgWURenzYf0K8R8JG5gMVoojCohm7ix7V1jB9v4QMnxfCXJ8FF8go/ZGU71+l0G7TG
         d8JWx1Tiu0XIj59l1OKj7EEFN+PVw4OMSq4lHnq0hQkPBRygojOIIxPYGCY08Uz8Cv0L
         o0Wg==
X-Gm-Message-State: ANhLgQ2QAcBG2OBtBz2Yzq29Frt7FsMroE4AcDM4PxDOdN6fJzVXKFY7
        ci3f1qt0k1nO1+WrVH6ITM28WMyF
X-Google-Smtp-Source: ADFU+vvfdGuOcOZDqlxkYlx8/Q0fKj/VRiwsjZjCMUB42hN0CiaaBo2Z6GckMCWfHyiAd5588enSKg==
X-Received: by 2002:ad4:46d4:: with SMTP id g20mr1634338qvw.179.1585115715753;
        Tue, 24 Mar 2020 22:55:15 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:15 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/8] t5512: stop losing return codes of git commands
Date:   Wed, 25 Mar 2020 01:54:50 -0400
Message-Id: <b3addeb98547783a31e2e2b876478a5dd96e04ec.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that their failure is
reported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 62d02152c7..fea64eb5c2 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -21,11 +21,11 @@ test_expect_success setup '
 	git tag mark1.1 &&
 	git tag mark1.2 &&
 	git tag mark1.10 &&
-	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
-	(
-		echo "$(git rev-parse HEAD)	HEAD" &&
-		git show-ref -d	| sed -e "s/ /	/"
-	) >expected.all &&
+	git show-ref --tags -d >expected.tag.raw &&
+	sed -e "s/ /	/" expected.tag.raw >expected.tag &&
+	generate_references HEAD >expected.all &&
+	git show-ref -d	>refs &&
+	sed -e "s/ /	/" refs >>expected.all &&
 
 	git remote add self "$(pwd)/.git"
 '
@@ -173,8 +173,8 @@ do
 		test_config $configsection.hiderefs refs/tags &&
 		git ls-remote . >actual &&
 		test_unconfig $configsection.hiderefs &&
-		git ls-remote . |
-		sed -e "/	refs\/tags\//d" >expect &&
+		git ls-remote . >expect.raw &&
+		sed -e "/	refs\/tags\//d" expect.raw >expect &&
 		test_cmp expect actual
 	'
 
-- 
2.25.0.114.g5b0ca878e0

