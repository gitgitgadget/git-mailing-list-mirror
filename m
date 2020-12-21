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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623BC433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A7223104
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgLUSMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgLUSMj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:12:39 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B87C061257
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:11:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o19so25936540lfo.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=R2GdxwUKx1iSHWEYKeyUQZB++26QjOIo2eFU1iBdnV+T6abcaXKYJ7YNnjKhCoTuum
         iDfKAY7SRGgCRNk4V8Eyig2lURP6AgRFDMQNM8tMVDyEdPHQLVegkMkt08l2E8znQOGi
         JdKt2Pm4G6f8GqgAmMaJGr3ezT4B9sFIddA7tj9cYhFippTUMFsT7kw6rNK72Hbe4wef
         kQuq6mgN/KGPexw8sKGYDVmuqbs8P0YTjfg1mpupXfRClO34VhbIf31kpG8aIhZyUSQP
         woQD+0rJXgNjYGW7pXScHr5++A6KJvPLAlBDverkZ5EPhZVxWksABevKvnIT74OAFgkJ
         pVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=q/uEoIMSMfhZ0SN1E+onnzVJCE94+T8MXhD1BpQu4Fgbg5TPx3lvV5fC4m54KZWn78
         +K7XGjvUaIoxsBe3EX+u+DehZNT10yDlqG1ZdVOG++ewEKbTmOcu3gQf4PnznViMg8pL
         /5i2WyUujdpkH6WPbNfTL+Bv4/3M5uRWHiSvXVvOyZL7V8L5OSQ0nk1+p1zgYcY4FYPc
         NZtWj9l/GFf12y0dSi3ij75a8n6UGObajGbU8HO54Nt9b2mS4INc0QNxf8JTnc4o/oRL
         /Eyha8F4UkN5kh2h9d74MlNYx7u3fKJBmf46j/I00gpf/O3XjdLEWERh7amfjvFe7HuJ
         sOqw==
X-Gm-Message-State: AOAM530G1yRPVne+22E5GCaU4GxtlnxMdpPPKaYm5uUNH+/OXzo+9S6k
        DYhwbG4TQEOyr9Pn5hSae6CIm66tXwk=
X-Google-Smtp-Source: ABdhPJzVe9eo/p2lL5ZOo7jXtBl9F/CECCva2UTKrXwYPWNT/GIsk44mgBPgjWxCFMHsrF3m+3aOaw==
X-Received: by 2002:a2e:9906:: with SMTP id v6mr7876978lji.361.1608564051137;
        Mon, 21 Dec 2020 07:20:51 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:50 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 15/32] t4013: support test_expect_failure through ':failure' magic
Date:   Mon, 21 Dec 2020 18:19:43 +0300
Message-Id: <20201221152000.13134-16-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support to be able to specify expected failure, through :failure
magic, like this:

:failure cmd args

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4f1..935d10ac0572 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -174,6 +174,7 @@ process_diffs () {
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
+	status=success
 	case "$magic" in
 	'' | '#'*)
 		continue ;;
@@ -182,6 +183,10 @@ do
 		label="$magic-$cmd"
 		case "$magic" in
 		noellipses) ;;
+		failure)
+			status=failure
+			magic=
+			label="$cmd" ;;
 		*)
 			BUG "unknown magic $magic" ;;
 		esac ;;
@@ -194,7 +199,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
+	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
-- 
2.25.1

