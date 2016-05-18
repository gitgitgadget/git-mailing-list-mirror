Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612D71F407
	for <e@80x24.org>; Wed, 18 May 2016 20:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbcERUQL (ORCPT <rfc822;e@80x24.org>);
	Wed, 18 May 2016 16:16:11 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33952 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbcERUQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:16:08 -0400
Received: by mail-io0-f196.google.com with SMTP id d62so11534579iof.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:16:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7DoB2xt1BMM27ph+MSYQY6KQtfKXX2ydtEAHOsV2i8=;
        b=fdA46uaI9CfGo3PBWGow6eaKgnsuod0SNqIgDJX6NYGxPcI205IzD4Fu2W2AHuJ5MQ
         t2HhvIbE3p6srHX/KZgDONLVzOetJ1gl/NRV9tloSMIhemSvsUFCa/LJf76Ve2zTWmM7
         J8MFnACDe3b3ekbo4hRtlYTdTnRB1sFEQSYHianTFecZYRSpsLC8MCIYV//3h06O+6a0
         FNCy31bCEhbiCQ90UqsEDqXzHyce0JqrIaERqWa+EGvSXC1hhVb5CTHyG3N/ng53PjWX
         mf11fBc2Ur006QRkC/XtSERoCQ6xgVm5/UIUEnn+xRZCMJu41E5ODvY27ZkMqissrHkt
         rXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=z7DoB2xt1BMM27ph+MSYQY6KQtfKXX2ydtEAHOsV2i8=;
        b=eVf8GjZFg6c2UxrUMMgP8UGNYiSCnFS6vO3Xt59L1JxafI5UtjdBYYclbp6fqU6wj+
         GYkJyCRpaXRvk1huGJLeALD48sJTO1s5oAdMDmZs9odfVRxsB++TEAZEg+Y1P1bqArWK
         kGyybVJBBx5CyaQ24SLMl8rR/WcEtPLFu/QGkCdeaaPjEUaHbX/gsQeN3V9xz+teDKSj
         ad2U5SYWqBtYtR3Ewa8/76NNPnC2rp8IjfBGIYprZw5d/RC3guQS0pm3K+TjZxOtZNNJ
         iAm6rK6I/KHrsgW9E4UwXjUh0FlhZsyoOMOimDHj5mHDTRFcZXZri5WM182/W/IC4o9U
         gCSQ==
X-Gm-Message-State: AOPr4FXLaGYVo1yle8HP8RxAHslF02rGX7XDORqwDd2zUTFYtiTCAG+2HY+UBeLy1ir/sg==
X-Received: by 10.107.17.19 with SMTP id z19mr7954823ioi.43.1463602567352;
        Wed, 18 May 2016 13:16:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q15sm3241137iod.6.2016.05.18.13.16.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 13:16:05 -0700 (PDT)
From:	Eric Sunshine <sunshine@sunshineco.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/5] t1500: be considerate to future potential tests
Date:	Wed, 18 May 2016 16:15:41 -0400
Message-Id: <20160518201545.9113-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.8.2.748.g927f425
In-Reply-To: <20160518201545.9113-1-sunshine@sunshineco.com>
References: <20160518201545.9113-1-sunshine@sunshineco.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The final batch of git-rev-parse tests work against a non-local object
database named repo.git. This is done by renaming .git to repo.git and
pointing GIT_DIR at it, but the name is never restored to .git at the
end of the script, which can be problematic for tests added in the
future. Be more friendly by instead making repo.git a copy of .git.

Furthermore, make it clear that tests in repo.git will be independent
from the results of earlier tests done in .git by initializing repo.git
earlier in the test sequence.

Likewise, bundle remaining preparation (such as directory creation) into
a common setup test consistent with modern practice.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..0194f54 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -37,6 +37,11 @@ test_rev_parse() {
 
 ROOT=$(pwd)
 
+test_expect_success 'setup' '
+	mkdir -p sub/dir work &&
+	cp -R .git repo.git
+'
+
 test_rev_parse toplevel false false true '' .git
 
 cd .git || exit 1
@@ -45,7 +50,6 @@ cd objects || exit 1
 test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
 cd ../.. || exit 1
 
-mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
 test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
 cd ../.. || exit 1
@@ -56,7 +60,6 @@ test_rev_parse 'core.bare = true' true false false
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
 
-mkdir work || exit 1
 cd work || exit 1
 GIT_DIR=../.git
 GIT_CONFIG="$(pwd)"/../.git/config
@@ -71,7 +74,6 @@ test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
 git config --unset core.bare
 test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-mv ../.git ../repo.git || exit 1
 GIT_DIR=../repo.git
 GIT_CONFIG="$(pwd)"/../repo.git/config
 
-- 
2.8.2.748.g927f425

