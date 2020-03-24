Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC1C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D54920786
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 09:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aayxIQ7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCXJf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:35:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33346 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 05:35:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id g18so7201392plq.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kQfAUSo1GXq3u2frNdP9C4pqUFHY9D7A+wHs/Ir7+U=;
        b=aayxIQ7NKdzuVO/+tIn96WCZJQAfjItiArh5tNO95rhNcDVbAlTfZ/5QLuMejXYVr0
         fD5gbBBLrBYjIPUp3h3wkt6OkgM8xVOLVw4epLkL6sFlH5DkQoHOuJ8p7BTaaFSXbbLR
         UWjsw2JJqA/WaZMsLABgPncdEjYwmyxbz+o+5DFPxx9UZkYk/XsIUmlwO5jZB3/jrgJe
         7Z2zbkK2LRdKZnvb1UKEiKi8sqAkFQTJs6L6kEBH+dQ691sC6xbtaOHgv+MkTCG1GrdJ
         eJdNMIjp50pVImtw2rlB39wN9JH53Idi1JiXMILuYqFjT5kyzQpWaQpHSKcddnfFTvUv
         b+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kQfAUSo1GXq3u2frNdP9C4pqUFHY9D7A+wHs/Ir7+U=;
        b=QG3dbmBkMoV+qp9Rwmd5V78no6MU6d9AT2IghWjw/9g2+28drh7tgGiXqGrVDQWH+n
         UE1yFpf6lT68reeXvzSA2jv9iz5aODUgYZ3Q+5Sc8OfKdtMdbJH2I9Wl8sMqr3F1hAia
         fHXHL9gr3gvJmSBHu+s/nn9yPic2EEH69HDuH5nqYqXe27ndfofQqf28e6I9+CzqVuE4
         +DgE78uY70sET1BbfLLG3mMBgvYj/oeCQNLP+ZXipokAiqWY79ier9S8DiMehNBTTQJF
         MW2Oc5c40DiC6nb1NhZENtgrqVfyQt2mOuOLZbUl1p2q0O/pLggZV5ctKgI4+KF90GuG
         sa0A==
X-Gm-Message-State: ANhLgQ22Iv0TfNhJrIvVXKb1QRtHkiMTUKGEa8GzzwkmGAppUf2IVAZM
        faLy4bW0Zu8qi1Dpj5kZAXZ/oET9
X-Google-Smtp-Source: ADFU+vuiq7HsyQrlBDEc5L/BboDiRQowR3wBjuXtgCDEDSzFM9y7latdKUxqRrOvfdLA6Gm2fHaEBw==
X-Received: by 2002:a17:90a:1788:: with SMTP id q8mr4575833pja.120.1585042527224;
        Tue, 24 Mar 2020 02:35:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:502a:2eb6:bc07:ee9f:893c:3b0b])
        by smtp.gmail.com with ESMTPSA id d3sm15647935pfq.126.2020.03.24.02.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 02:35:26 -0700 (PDT)
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
To:     git@vger.kernel.org
Cc:     Shanthanu <shanthanu.s.rai9@gmail.com>, tboegi@web.de
Subject: [PATCH v2] t9116: avoid using pipes
Date:   Tue, 24 Mar 2020 15:05:02 +0530
Message-Id: <20200324093502.32394-1-shanthanu.s.rai9@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.28.g7fcb965970
In-Reply-To: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
References: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) recommends to
avoid using pipes, since the exit code of upstream in the pipe is
ignored. Hence, redirect the output to a file and parse that file.

Commit de26f02db1 (t9001, t9116: avoid pipes, 2020-02-14) noted that
this also allows easy debugging in case the test fails, since the file
will be left on disk and can be manually inspected.

Signed-off-by: Shanthanu <shanthanu.s.rai9@gmail.com>
---
 t/t9116-git-svn-log.sh | 53 +++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 0a9f1ef366..56d68e4aed 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -61,12 +61,16 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
 
 test_expect_success 'test ascending revision range' "
 	git reset --hard origin/trunk &&
-	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
+	git svn log -r 1:4 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r1-r2-r4 actual
 	"
 
 test_expect_success 'test ascending revision range with --show-commit' "
 	git reset --hard origin/trunk &&
-	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
+	git svn log --show-commit -r 1:4 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r1-r2-r4 actual
 	"
 
 test_expect_success 'test ascending revision range with --show-commit (sha1)' "
@@ -74,7 +78,8 @@ test_expect_success 'test ascending revision range with --show-commit (sha1)' "
 	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
 	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
 	git reset --hard origin/trunk &&
-	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out &&
+	git svn log --show-commit -r 1:4 >out1 &&
+	grep '^r[0-9]' out1 | cut -d'|' -f2 >out &&
 	git rev-parse \$(cat out) >actual &&
 	test_cmp expected-range-r1-r2-r4-sha1 actual
 	"
@@ -83,67 +88,87 @@ printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
 	git reset --hard origin/trunk &&
-	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
+	git svn log -r 4:1 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r4-r2-r1 actual
 	"
 
 printf 'r1 \nr2 \n' > expected-range-r1-r2
 
 test_expect_success 'test ascending revision range with unreachable revision' "
 	git reset --hard origin/trunk &&
-	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
+	git svn log -r 1:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r1-r2 actual
 	"
 
 printf 'r2 \nr1 \n' > expected-range-r2-r1
 
 test_expect_success 'test descending revision range with unreachable revision' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
+	git svn log -r 3:1 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r2-r1 actual
 	"
 
 printf 'r2 \n' > expected-range-r2
 
 test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
+	git svn log -r 2:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r2 actual
 	"
 
 test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
+	git svn log -r 3:2 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r2 actual
 	"
 
 printf 'r4 \n' > expected-range-r4
 
 test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 3:4 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r4 actual
 	"
 
 test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 4:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r4 actual
 	"
 
 printf -- '------------------------------------------------------------------------\n' > expected-separator
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and no commits' "
 	git reset --hard origin/trunk &&
-	git svn log -r 5:6 | test_cmp expected-separator -
+	git svn log -r 5:6 >actual &&
+	test_cmp expected-separator actual
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and no commits' "
 	git reset --hard origin/trunk &&
-	git svn log -r 6:5 | test_cmp expected-separator -
+	git svn log -r 6:5 >actual &&
+	test_cmp expected-separator actual
 	"
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 3:5 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r4 actual
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 5:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
+	test_cmp expected-range-r4 actual
 	"
 
 test_done
-- 
2.26.0.rc2.28.g7fcb965970

