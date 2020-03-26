Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA1CC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950F420772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj6ZDB8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCZI2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40228 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgCZI2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id l25so5548824qki.7
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bzkaWAt8EfYKTgpQaYXO6UoJakK7hxGA4NEVWLmilGI=;
        b=bj6ZDB8LRITOhHZUBw9WQ1lwhfVEs213nkg7/cVmSKldYaNJ/U49s8hvpQzLicOO1T
         kVQskz84/92y9FEv89Hnb3jPjv7p5TYGQZUisyfgzd6SjxDxqnUDojDonj+MxqPJVPaj
         uSz+erAcjSo2tp9ecq9PwahO0ogiOlSXRVQ09CwFIzyD3VlNj0U9d2sLC6DElI489agV
         MKKUnK4G1bCIyKewzO1fotwdkLkwm2RN+R3tbErzbDv8Zf93FdUkxGufwutNuvszoEJT
         2kFp7IVxowz7MnoQU1uIbMou9jAerz5zwk97FKkyExZ4KJj8HS8tzrF9C1QqrjJSTqeV
         wlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzkaWAt8EfYKTgpQaYXO6UoJakK7hxGA4NEVWLmilGI=;
        b=QssDkn32kqucYcXLFfKxH2QeWDeNn1rsW77WFd0RNffZb/mnI9QF+nysApgTlA+fUI
         NylrHm89ZeVZivPteSRt7atW2SNuPT06qnVA5kYUatHYF7L6jZEx7AHSuN5cfrQEEHW1
         cwXCDJ3neZMl/fOHBNnZYDrUSSEE9sH01d0xcGEBqSRri0NZSSLK34ZpcUOcTOfYwJAT
         PDuBxs7VD2DHyjWIKs5+BO/t5x3/WpEEfJkhND6iZ7QJ3z895jGey6DahRoDjLa7bhtx
         DAruy8Babtn+zMdcnEHxZlMzHVK0JpEeiWUB8wTqSziLawvFTNPE8gF/pvh4TlzZ64jN
         /vWg==
X-Gm-Message-State: ANhLgQ2FBkdE8skHLYfcZnuMBLf1sjFa/4uQfmvSNL1uRuySK/9pk5lc
        Hjx7IF4F21OX6H8t4Zn9O2Da4WIT
X-Google-Smtp-Source: ADFU+vuzN2XV3ecaByLKFiEPTlYhyIgYpzcTz75FBsvcH6ptmRd5WF+kTI+xsUBTT4XX+QDpLAuvlw==
X-Received: by 2002:a37:a807:: with SMTP id r7mr7167873qke.5.1585211313316;
        Thu, 26 Mar 2020 01:28:33 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:32 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 7/8] t5612: stop losing return codes of git commands
Date:   Thu, 26 Mar 2020 04:27:54 -0400
Message-Id: <bc0e90d5baa73312bf77501c910e3457761b77f5.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
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
 t/t5612-clone-refspec.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 28373e715a..e3b436d8ae 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -71,9 +71,9 @@ test_expect_success 'by default all branches will be kept updated' '
 	(
 		cd dir_all &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# follow both master and side
 	git for-each-ref refs/heads >expect &&
@@ -104,9 +104,9 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	(
 		cd dir_master &&
 		git fetch --force &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow master
 	git for-each-ref refs/heads/master >expect &&
@@ -126,9 +126,9 @@ test_expect_success '--single-branch while HEAD pointing at master and --no-tags
 	(
 		cd dir_master_no_tags &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow master
 	git for-each-ref refs/heads/master >expect &&
@@ -156,9 +156,9 @@ test_expect_success '--single-branch while HEAD pointing at side' '
 	(
 		cd dir_side &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow side
 	git for-each-ref refs/heads/side >expect &&
@@ -169,9 +169,9 @@ test_expect_success '--single-branch with explicit --branch side' '
 	(
 		cd dir_side2 &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# only follow side
 	git for-each-ref refs/heads/side >expect &&
@@ -223,9 +223,9 @@ test_expect_success '--single-branch with detached' '
 	(
 		cd dir_detached &&
 		git fetch &&
-		git for-each-ref refs/remotes/origin |
+		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
-		    -e "s|/remotes/origin/|/heads/|" >../actual
+		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
 	# nothing
 	test_must_be_empty actual
-- 
2.26.0.159.g23e2136ad0

