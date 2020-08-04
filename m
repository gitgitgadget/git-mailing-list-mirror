Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B3C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A3A207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqiWZdOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgHDWB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgHDWBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:01:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C14C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:01:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so39982471qkk.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cESbn+0qRyw1H9cXdRoCr2DVijcyjakrqE0qFSjWkWY=;
        b=kqiWZdOcOjW3apjJkfhpwSWpT58RVlMPqH3G33eCNxGqKQok6mBtct4xakqX3YDLmi
         w1+3fvUL6ENDQ0TUWHTyO2U8IGzu9qvKVUWU9aVcRdOH6Q+SKoLGWymQ1AQpDxIOpvg2
         szF/csZYteQPmqueuebJxCtlfvvKnT9Bx/D7gI/GVbKnKVt9XB+qu+vU5MMcBOoQzQai
         DM0hWZpZe89SN40Q794KCBQulkmSzw5Orj0Bpv/VEWqp2eWfHDAeavBVHQNqU6tlpevr
         blomG1ix96R90yAPKxBjHNEgJZ1mXbJtA82ePAPLH54T4AMJj3uCdAUFYKgVvQ89liQT
         AX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cESbn+0qRyw1H9cXdRoCr2DVijcyjakrqE0qFSjWkWY=;
        b=FZUs+X4RiqyvhQ3wjFunU2wfelDMASBaLKcfQeTOUHP1qcaA1spGucuEqi1dZrDJCe
         Qv9nkAAuyGRwvqoGIBoU/iFwf0WP3rPpv9ZRiCHhDxAz/c83X8qlo1AA8LJ+WAa0HPdV
         DWDUZb0IKXFIHJgGbf1Zu6upJduyZm1w5pg8znsKWbf2Cm1hgQTCjNqjtsFkkOqeYQpb
         u8gcQqmJqTrIvwu2e6m7BsOly78iGySdl8G3aidbxnxVlJf+UJQ7RbtxmCAy/+yMG67g
         sJlPe6RWdRWBK2Dyq+4leSXt+uUodFUB05DlwJ8oKg6tyAAErwY1Vy9o6jcimU0ST3Z1
         LVRw==
X-Gm-Message-State: AOAM530BXz7mr45JS2q77Kub2VJh1ImjEbW0RlrvdjCqZD5wDItXSog6
        IblLDOpclNJ3R1c/Nv9V1TVQPnmPTVoWHg==
X-Google-Smtp-Source: ABdhPJzrJ0fBDOmvJxi8nl+AELbSV3cIPD2MNqtZXLftXLv3lXtF1U1q+2cwXVOOd2LKnaJGIsqNUg==
X-Received: by 2002:a37:4f07:: with SMTP id d7mr409062qkb.144.1596578481546;
        Tue, 04 Aug 2020 15:01:21 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n33sm231724qtd.43.2020.08.04.15.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 15:01:21 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 1/5] t6030: modernize "git bisect run" tests
Date:   Tue,  4 Aug 2020 18:01:09 -0400
Message-Id: <20200804220113.5909-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com>
References: <20200801175840.1877-1-alipman88@gmail.com>
 <20200804220113.5909-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enforce consistent styling for tests on "git bisect run":
- Use "write_script" to abstract away platform-specific details.
- Favor current whitespace conventions.
- While at it, change "introduced" to "added" in the comments to make
  them read better.

Thanks-to: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 86 ++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 36d9b2b2e4..a66c4b89bc 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -243,32 +243,30 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 '
 
 # We want to automatically find the commit that
-# introduced "Another" into hello.
-test_expect_success \
-    '"git bisect run" simple case' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Another hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start &&
-     git bisect good $HASH1 &&
-     git bisect bad $HASH4 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+# added "Another" into hello.
+test_expect_success '"git bisect run" simple case' '
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # We want to automatically find the commit that
-# introduced "Ciao" into hello.
-test_expect_success \
-    '"git bisect run" with more complex "git bisect start"' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Ciao hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start $HASH4 $HASH1 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+# added "Ciao" into hello.
+test_expect_success '"git bisect run" with more complex "git bisect start"' '
+	write_script test_script.sh <<-\EOF &&
+	! grep Ciao hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH1 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
 # but $HASH4 is good,
@@ -295,24 +293,17 @@ HASH6=
 test_expect_success 'bisect run & skip: cannot tell between 2' '
 	add_line_into_file "6: Yet a line." hello &&
 	HASH6=$(git rev-parse --verify HEAD) &&
-	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "grep line hello > /dev/null" >> test_script.sh &&
-	echo "test \$? -ne 0" >> test_script.sh &&
-	chmod +x test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	sed -ne \$p hello | grep Ciao >/dev/null && exit 125
+	! grep line hello >/dev/null
+	EOF
 	git bisect start $HASH6 $HASH1 &&
-	if git bisect run ./test_script.sh > my_bisect_log.txt
-	then
-		echo Oops, should have failed.
-		false
-	else
-		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
-		! grep $HASH3 my_bisect_log.txt &&
-		! grep $HASH6 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		grep $HASH5 my_bisect_log.txt
-	fi
+	test_expect_code 2 git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt &&
+	! grep $HASH3 my_bisect_log.txt &&
+	! grep $HASH6 my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt &&
+	grep $HASH5 my_bisect_log.txt
 '
 
 HASH7=
@@ -320,14 +311,13 @@ test_expect_success 'bisect run & skip: find first bad' '
 	git bisect reset &&
 	add_line_into_file "7: Should be the last line." hello &&
 	HASH7=$(git rev-parse --verify HEAD) &&
-	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "sed -ne \\\$p hello | grep day > /dev/null && exit 125" >> test_script.sh &&
-	echo "grep Yet hello > /dev/null" >> test_script.sh &&
-	echo "test \$? -ne 0" >> test_script.sh &&
-	chmod +x test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	sed -ne \$p hello | grep Ciao >/dev/null && exit 125
+	sed -ne \$p hello | grep day >/dev/null && exit 125
+	! grep Yet hello >/dev/null
+	EOF
 	git bisect start $HASH7 $HASH1 &&
-	git bisect run ./test_script.sh > my_bisect_log.txt &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
 	grep "$HASH6 is the first bad commit" my_bisect_log.txt
 '
 
-- 
2.24.3 (Apple Git-128)

