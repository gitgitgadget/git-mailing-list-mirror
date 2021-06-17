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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0697CC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9474613E2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFQDTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhFQDTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 23:19:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DCC061767
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ei4so2949099pjb.3
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLHUByq7aB6vq4b3hZES/YJJjEiOxy8V8jot7W8FeYY=;
        b=rmi6mSclmN2d94S+7N3WVc6Zvdd3OWqm2VqM05WpEOdvT5SAwJ4P7XTN0uUl2yAtxE
         mDUVSLTHyt8sGe9Gfvr4cilcJBRRJzBAdakEZ2oy3VeSrbvtdk8r52k03dxp48RBVOwz
         4bEVK1czom7oN9cIBbBwjReZCCrlc2JLz5qYZpLAPmF9FSOlnD04DRQREIRxv7MF2bok
         NSppKB9HoC/KsFvOS8C7DZ8V5v5qP3lVaaV9zunrPhDPwvcNT3j2jIxjJVGC2+748CQk
         xJ2ly1ZjMTDN2YgkKOsL5q3m/9WkGQHDTUluLCtglAto2vuPqavexwu3MVuIdHyQrssg
         gtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLHUByq7aB6vq4b3hZES/YJJjEiOxy8V8jot7W8FeYY=;
        b=tQMbovUcCXat/sTmNEzn0Dl/67EXRDKB8DtPueH5cbGD9Q98pU1XTy9U5Iezg/NLVH
         wQRZ8cfwTLYDVJGj7bGF223ktyvhbQM8C5AW+hCE0p1WTIs3Q3wEiubC9UphwzZM1heR
         xoTM9Q+c/NuCUjvyQebJV/LOa/6MTF3yEG1Olg29xxHYa1ZIssOxeZ/KWv7SJNmvcHUj
         mc/cn2QzkuX4oSgSAvVBf7RHuq0HWC8IN92arqtsjYDbMgfpb1PbeIEJLnseYfWHP1TX
         CVz19BwL/gBg+bVhx3QqzNxd44Oqv0zK1WnNzrwSjCpW4LFg7SS1vxnK9wqHi0xy/NTi
         vZoA==
X-Gm-Message-State: AOAM531sdEph7oo/FAzMgRdphGmbFPRfG6AMC6k+GhdVfCak5GyiD69U
        MtZgh3mktCIWNHyH6hxUVAs=
X-Google-Smtp-Source: ABdhPJwpPEsjOJMfDyinx4TfqiSppPORJJ315pVMXXZDwl7NLRcBLPpJRx5cyXYqDhd/+bAzF3I1CA==
X-Received: by 2002:a17:902:8309:b029:115:c2f3:2aed with SMTP id bd9-20020a1709028309b0290115c2f32aedmr2492488plb.57.1623899857718;
        Wed, 16 Jun 2021 20:17:37 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.151])
        by smtp.gmail.com with ESMTPSA id ei10sm3301726pjb.8.2021.06.16.20.17.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:17:37 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 3/4] test: refactor to use "test_commit" to create commits
Date:   Thu, 17 Jun 2021 11:17:26 +0800
Message-Id: <20210617031727.81105-3-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
In-Reply-To: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
References: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor function "create_commits_in" to use "test_commit" to create
commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh | 25 ++++++-------------------
 t/t5548-push-porcelain.sh   | 25 ++++++-------------------
 2 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 6c347b4caa..b9c6adecf5 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -6,29 +6,16 @@
 # NOTE: Never calling this function from a subshell since variable
 # assignments will disappear when subshell exits.
 create_commits_in () {
-	repo="$1" &&
-	if ! parent=$(git -C "$repo" rev-parse HEAD^{} --)
-	then
-		parent=
-	fi &&
-	T=$(git -C "$repo" write-tree) &&
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
 	shift &&
 	while test $# -gt 0
 	do
 		name=$1 &&
-		test_tick &&
-		if test -z "$parent"
-		then
-			oid=$(echo $name | git -C "$repo" commit-tree $T)
-		else
-			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
-		fi &&
-		eval $name=$oid &&
-		parent=$oid &&
-		shift ||
-		return 1
-	done &&
-	git -C "$repo" update-ref refs/heads/main $oid
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
 }
 
 # Format the output of git-push, git-show-ref and other commands to make a
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 2ab7c3cf5a..c8f18a7a12 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -14,29 +14,16 @@ test_description='Test git push porcelain output'
 # NOTE: Never calling this function from a subshell since variable
 # assignments will disappear when subshell exits.
 create_commits_in () {
-	repo="$1" &&
-	if ! parent=$(git -C "$repo" rev-parse HEAD^{} --)
-	then
-		parent=
-	fi &&
-	T=$(git -C "$repo" write-tree) &&
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
 	shift &&
 	while test $# -gt 0
 	do
 		name=$1 &&
-		test_tick &&
-		if test -z "$parent"
-		then
-			oid=$(echo $name | git -C "$repo" commit-tree $T)
-		else
-			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
-		fi &&
-		eval $name=$oid &&
-		parent=$oid &&
-		shift ||
-		return 1
-	done &&
-	git -C "$repo" update-ref refs/heads/main $oid
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
 }
 
 # Format the output of git-push, git-show-ref and other commands to make a
-- 
2.32.0.rc0.27.g7b1e85181b

