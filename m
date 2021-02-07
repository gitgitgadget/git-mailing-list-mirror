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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714CEC433E6
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA2364E32
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBGSUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBGSUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:20:00 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B56C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:19:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t11so5107543pgu.8
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+e4ao46tApa7F9HStwwz7Z9Ey+YKregUZUfolMkUm88=;
        b=fRAszcjp9xHCZ3djiLrMxu7V7pDZFyX6kQNEXHCOrGlS+jYRMBMyt9IyidMiWamRSN
         LkRbjNmf/XFa6Lo1jStNnyLgjMOwAIfvrtIDjbl41ODUY+Qqg5s7TUjLcVcV0+q1sR3V
         AMCxCCO5FyimckD8iaZ5bQtQLtU5Vq4qBG686u7f+16a2ruTL+bOHkgwYcwfZ82T0udq
         aWeIA7B4k/ZVXOqYPMNizQSEsSVxaH3uDnfKoaZAKvS2njuqjaftwC4PBEJo3sjsf6/x
         csgJVPhisOJi3pti07xF9h0gS8a3ObS/++OInmcvklkYU0WZsOGxVN8NTbkbvxQWt0ai
         QV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+e4ao46tApa7F9HStwwz7Z9Ey+YKregUZUfolMkUm88=;
        b=uY0q016Wh/FZoL04qvVvZRTgJdCpKAdfbdVmtcGtbozL6oBxuwE4jJ1zh5LNcSNDkB
         nKolTDdTeLp0UtR8PTO7NpfGlfQWTNCnP2QFbucXec4t7wJ80yWGPNeJWZoatrh6d1nb
         nWG94ugnkUP4G0h8aheg7LfxuhB3K66guEHQkjcfAotUIpoBEOijCEpUs5InAEFE16N3
         hLNfBUYBxUohj/OeXcHyionQBpybhDOutFkgT3Ny2urZWp+IvvHRe39iIgiUDNsL9S62
         aNB5vRhgZ4bJIAY7bX1b2iH7KzSEyEwTWoDaCMJOBcQj5W5LrcPCoVDduHoAjrA9EK3D
         X28A==
X-Gm-Message-State: AOAM533ojnzywhcukmtcb48rRmIz1pfeocacDm9G90UVqW5GqCUjS5LS
        oKhwapLMTLXz0quaxeYIx5Aqi4h5dJRf/Q==
X-Google-Smtp-Source: ABdhPJzcWpJtWBUEMe+40BAZtMxKc5J4+qwuid9jFFMqtJYJbjnkcmE0W+5CfovkkNExjjzIUaUHKA==
X-Received: by 2002:a63:e5e:: with SMTP id 30mr14413624pgo.181.1612721960002;
        Sun, 07 Feb 2021 10:19:20 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:19:19 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] t3437: fix indendation of the here-doc
Date:   Sun,  7 Feb 2021 23:44:38 +0530
Message-Id: <20210207181439.1178-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test scripts, the here-doc body and EOF are indented the same
amount as the command which opened the here-doc. Let's remove
one level of indendation.

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 62 ++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 36dee15c4b..3de899f68a 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -38,13 +38,13 @@ get_author () {
 
 test_expect_success 'setup' '
 	cat >message <<-EOF &&
-		amend! B
-		${EMPTY}
-		new subject
-		${EMPTY}
-		new
-		body
-		EOF
+	amend! B
+	${EMPTY}
+	new subject
+	${EMPTY}
+	new
+	body
+	EOF
 
 	sed "1,2d" message >expected-message &&
 
@@ -70,38 +70,38 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
-		amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		EOF
+	amend! B
+	${EMPTY}
+	B
+	${EMPTY}
+	edited 1
+	EOF
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
-		amend! amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		${EMPTY}
-		edited 2
-		EOF
+	amend! amend! B
+	${EMPTY}
+	B
+	${EMPTY}
+	edited 1
+	${EMPTY}
+	edited 2
+	EOF
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	echo B3 >B &&
 	test_tick &&
 	git commit -a -F - <<-EOF &&
-		amend! amend! amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		${EMPTY}
-		edited 2
-		${EMPTY}
-		edited 3
-		EOF
+	amend! amend! amend! B
+	${EMPTY}
+	B
+	${EMPTY}
+	edited 1
+	${EMPTY}
+	edited 2
+	${EMPTY}
+	edited 3
+	EOF
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
 	GIT_AUTHOR_EMAIL="rebase.author@example.com" &&
-- 
2.29.0.rc1

