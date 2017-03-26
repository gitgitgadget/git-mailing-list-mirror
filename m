Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A612B1FC19
	for <e@80x24.org>; Sun, 26 Mar 2017 09:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdCZJPw (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 05:15:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33841 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZJPv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 05:15:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id o123so2653034pga.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bq39gzChuZuBk2zRdWFljgvebCG5eQBzilKFaa6fBI=;
        b=RK6StznelDGbz7oh1EDgSczRHYSYCrmIjqVAknxPjKGosUVgJpIhhsXxkZXY9Kch8A
         efmFV6tInFF9r+sP49+AJhRTgJIBDjlpc/XzuelkQRTWuqZhYDp26BDVE6oW5etY5FJ2
         uwX02uzv6FwrrAZlTz1QlSNnnszRwdg4e5KFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0bq39gzChuZuBk2zRdWFljgvebCG5eQBzilKFaa6fBI=;
        b=gKcf46teMGBCbI2FfOXOfVzekRS+WCjVWiuLEjdO0m85mHiw9menZTVSiTrPj2r9oE
         8o3ZJqKPTdv/pXHumBn3y+IWjK5LNpOkY128vFiBnezqlMq2nJQNdLpWHnWGaB+2/5on
         Sgvp3VwoseL0AhDf63Bk26Fs/Mb7fxPQPw8+arT+S9cOAWIeenSdUjrA3QIRMzILhMDu
         hWTOYJ0c/tvm3M1FIqQJnbnyFPtLHU6eDnJH+fu+0/EgTJAEuB2sbtoy8zPkWXZ4GMzW
         07qCrQimeJoD+mjCL5Zt0mguY4MqY0MKjizYVduWhuQBAoeV/1f0QRlNbmypLXt5LGCj
         feFg==
X-Gm-Message-State: AFeK/H2obAdZ4hY+jdkSZSFQpbCr81DAVlvxttmjtQ5oXelJFZIdHk9t0OSWNpwlWhN8sg==
X-Received: by 10.98.138.132 with SMTP id o4mr19111186pfk.70.1490519749831;
        Sun, 26 Mar 2017 02:15:49 -0700 (PDT)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id p24sm14307977pfd.26.2017.03.26.02.15.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Mar 2017 02:15:49 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: add failing test for name-rev rather than symbolic-ref
Date:   Sun, 26 Mar 2017 10:15:37 +0100
Message-Id: <20170326091537.2707-2-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
In-Reply-To: <20170326091537.2707-1-luke@diamand.org>
References: <20170326091537.2707-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using name-rev to find the current git branch means that git-p4
does not correctly get the current branch name if there are
multiple branches pointing at HEAD, or a tag.

This change adds a test case which demonstrates the problem.
Configuring which branches are allowed to be submitted from goes
wrong, as git-p4 gets confused about which branch is in use.

This appears to be the only place that git-p4 actually cares
about the current branch.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9807-git-p4-submit.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index e37239e..ae05816 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -139,6 +139,22 @@ test_expect_success 'submit with master branch name from argv' '
 	)
 '
 
+test_expect_failure 'allow submit from branch with same revision but different name' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file8" &&
+		git checkout -b branch1 &&
+		git checkout -b branch2 &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.allowSubmit "branch1" &&
+		test_must_fail git p4 submit &&
+		git checkout branch1 &&
+		git p4 submit
+	)
+'
+
 #
 # Basic submit tests, the five handled cases
 #
-- 
2.8.2.703.g78b384c.dirty

