Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D5C64E90
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB53720866
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6tcLtp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbgKXNa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388288AbgKXNa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:56 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA04C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:56 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id l206so23705195oif.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SnoBkZ3kSMVpgqZ5NeBlt0BY1cD/WY+UmHuiONhlg8=;
        b=T6tcLtp/611yoXcBhFuJOflPX795XboTl827QVCJPwo5OABcd9ROZnOJen3rvu3pE9
         HixovB2/jp1sOruVtAC6Zn+Exrt3Y2sF8xVm27e0tjFEXWUdjJISJaYpT7NUG4sVIcBe
         LBbB4rekKW0o81B8+p4e5t/xYIEecg2crYyBR94lYhP3iD5hiFCAciPzo/uPYfEg7gZ9
         6mZZ0dqszN0mMswLOruc71IR9zG01hri7/xTPZFUJGr1QBTCIXGKxMiQSlv47yXiQZPa
         RXTopw05YP1MembqPnyIjEt85t7HchHVYGaEiAh1Z3rnHLWfDbjrMcet7nK2J0ArMsc+
         C4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SnoBkZ3kSMVpgqZ5NeBlt0BY1cD/WY+UmHuiONhlg8=;
        b=izdazkQQfFz0ygWv90zaD9SruwOqYhIueWIaOBwNVAhm6US9gsc7w5N8W9UHUDK8Cb
         /NguNBguXayDN0UvKwJjvP1A4I/wv0opag24ZlqXSMJFPOYSePLmAEDUU+70V8iJF8iI
         1F4u1F/ZHlL/wLM909cKBQJ/kJuAga//IF9TWi6Cabj9b0ESXBj0ek7G5OJYt7e98voV
         pD9zrEncLGqVRNtVvmtP+WYVSa1RLXKnOjhzKCEJKHcqKEq5bKTgHFNiS4iD0AKbYIS7
         9lCbZQEekAsYpOkkMTaGMKyj1BoBuFdaQe542kGfZMS9AtkaUjczXsWPgntiZW2TL4qa
         AvBQ==
X-Gm-Message-State: AOAM530LV550DVaxEqUQDocr82zSQFQ3qIFdvKxn8IalE674AzawD3IC
        j1D7g55kYxOQV+PUgN8lXuJwXu6XHN/Prg==
X-Google-Smtp-Source: ABdhPJxhDJzMAQ1GqVPjILno+7aUA4/DPjE7nGVDQRQG/yqr3scXib+gb/UAt9FigkwyAIrUd6K5lA==
X-Received: by 2002:aca:db0b:: with SMTP id s11mr2584661oig.51.1606224650802;
        Tue, 24 Nov 2020 05:30:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b28sm9820409oob.22.2020.11.24.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] test: pull-options: revert unnecessary changes
Date:   Tue, 24 Nov 2020 07:30:37 -0600
Message-Id: <20201124133037.89949-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133037.89949-1-felipe.contreras@gmail.com>
References: <20201124133037.89949-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d18c950a69 changed these tests, but it's unclear why. Probably
because earlier versions of the patch series died instead of printing a
warning.

Cc: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5521-pull-options.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..1a4fe2583a 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,10 +11,10 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_success 'git pull -q --no-rebase' '
+test_expect_success 'git pull -q' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
-	git pull -q --no-rebase "../parent" >out 2>err &&
+	git pull -q "../parent" >out 2>err &&
 	test_must_be_empty err &&
 	test_must_be_empty out)
 '
@@ -30,10 +30,10 @@ test_expect_success 'git pull -q --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull --no-rebase' '
+test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
-	git pull --no-rebase "../parent" >out 2>err &&
+	git pull "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -46,10 +46,10 @@ test_expect_success 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v --no-rebase' '
+test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
-	git pull -v --no-rebase "../parent" >out 2>err &&
+	git pull -v "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -62,25 +62,25 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v -q --no-rebase' '
+test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-	git pull -v -q --no-rebase "../parent" >out 2>err &&
+	git pull -v -q "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test_must_be_empty err)
 '
 
-test_expect_success 'git pull -q -v --no-rebase' '
+test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
-	git pull -q -v --no-rebase "../parent" >out 2>err &&
+	git pull -q -v "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
 test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	mkdir clonedcleanup &&
 	(cd clonedcleanup && git init &&
-	test_must_fail git pull --no-rebase --cleanup invalid "../parent" >out 2>err &&
+	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
-- 
2.29.2

