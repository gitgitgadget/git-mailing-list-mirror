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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940DC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBC3230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgLETyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgLETyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:50 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96DC08E863
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:45 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id f11so10503024oij.6
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32vlhwz0aXXfZWItJvhvqAt2z1EPs0fSK/cBA/4mVks=;
        b=AIqx8XkmJPwSzi3cCkk+MnlxdV9nnAJbe83qJlnqhecJ1HgxxlGTUvufuA32T0d4dZ
         COK2LHb/5qYTh14KDA0QSCxs73BpHXnB4YruvJT9YV3oEUSnK0jBle71AEZ5vxt+iN9b
         aKZP6vIBg1IwEZzpYhRP9y+0JhG1cJGOefvsDF/hWwSuR4uv7AIhoR/ygQEGm6NW6vKk
         f37q9mgyL4KoXxCFjHAtlrL2zur6DgAg6XbclTKO1W7jIVsUXC8vI7v+z4Ox9bMeUJhb
         +zeUm4zbtWpLyL37PYPe4zhnhcGwGoyBiicMGu+MM4gYaAwq8PQ3jj8ae1Am1KpsxPpl
         2FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32vlhwz0aXXfZWItJvhvqAt2z1EPs0fSK/cBA/4mVks=;
        b=nC2/cKvhcmY6tMMRUqnm3f2P9V8/t2DMN8LV2f32QvmsRfhXi7cvTNzdhwr6vwNzuw
         o++Dqvbe2hQ0gEonI+eqoXrcfIWarFN8b+ZnGdOVUm9KOkATTAAqkcNOGS0qyHO9dkE0
         1H/3NDknzc9o58SowZrmP84S1MPZKJeeEJCcc22VoP/J1EI6e7VBEZbESWsYMs21CYed
         Kv+vkrqRxssUdodEKy+tCYml0gv+Lch5NwgdDtqWhr40JV8S8IfDk7RYViOBvu3GMYLw
         WbwG/SFOipqnuMG/FeO6pYc0xxDi4p3TdrdAODwkhb9rcfPGZCZLf6l3vFscnYZJfGbr
         cWUg==
X-Gm-Message-State: AOAM533FUWAYLVCmFtwJxWk3oIjIQxPEJaUEKiuzxzJSiwYsglUs+CGG
        fqGXiH9p6QxsZIOKt483NG9J2uwSK++Ufw==
X-Google-Smtp-Source: ABdhPJxZ7OcncUd6DvFMQ78j+lsdcS37lBkeKG7OUhsD5oegnUI6pwqYeoN4U765r9JBT0QhjtSICQ==
X-Received: by 2002:aca:afd0:: with SMTP id y199mr811991oie.7.1607198025013;
        Sat, 05 Dec 2020 11:53:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a21sm1603356otr.36.2020.12.05.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 15/16] test: pull-options: revert unnecessary changes
Date:   Sat,  5 Dec 2020 13:53:12 -0600
Message-Id: <20201205195313.1557473-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d18c950a69 (pull: warn if the user didn't say whether to
rebase or to merge, 2020-03-09) changed a number of tests in t5521
and added some new tests in t7601, but it was not explained why the
changes in t5521 were made.

The reason seems to be to silence the warnings while running the tests,
but we want to see the warnings if they happen.

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

