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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A96EC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A43B64EB8
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhBIHar (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhBIHae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:30:34 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AA0C061793
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e9so9263367plh.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNSRZvmx9+OCMyIXehfEVMJ0vxwEygopOVzVXTd4+OE=;
        b=VzwERgGIZYSylXTltmjnS5PIAiB/cM+urjkF8Mm6jPs9WvQU9+wLhRpNlGxoB5jc6Q
         H0DjuRIYawB0qbuJlICDPY3BPqEZiJRbkTgJmabqs56HDhz0QQoUWL3g+tLRV5ZM9oh5
         y7sKlbIucd/5E+Y1My/gqaAF9Etp5fkkN/ttnWTWo2pZVrGsOGQC0DoYXhiYvGEy3YMn
         YcFgio75V8NFuBJgCC0nixyOu6tZFqd0eKaV8+anpGfdlm7GuXdV1ZhC5O+4ldpqlbeS
         XcFUV8vyam/ZBKROL4ZnA/7wzWaQ57cU+CcHevGPVK8FmNj0t9U8yvT3RJvsii4xdy8Z
         I/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNSRZvmx9+OCMyIXehfEVMJ0vxwEygopOVzVXTd4+OE=;
        b=Xz3WhJIRI2LBIaOk4MiySYJj5inAvl/5J1mpcVTjm+fr6Hk5ubas7w/W1x1uG5m/L6
         i4+0JqrxeSTFdXRx+Ej5GRSAHYfYYSkHRrfrzRqqYpJcemwV0jKGdIaaF8RHmmALsWHW
         PgDhTFrM2LCLv8vTquQKQUeNl7KeRnK9NTCt6ojn2xt2Ahxm+MsQ/epDeb2NGItAtypP
         tYybzmxNOk+ZNYUtfeMfbrJbs0PiwKO+DgAxHug0I16zCHn8qxMa+Yswh/boVffdFW5C
         RlD3kz7ioIahtFCSNZ/gCsTdQcgyPL6kyn0+MdWXU+dtiQ7fAT2nJWCBvGUR4Nu4S+If
         CjWw==
X-Gm-Message-State: AOAM530KT1GmgoQiTmY0PMbvtOK1gn12Qt/nmT6WEX/kcd30UQ5Av2l2
        P0K4Fiyu9Vrgbki0UUGfUacFYZscTtU=
X-Google-Smtp-Source: ABdhPJwIzSGRVh0eU4MNIznOm6FAIp+T9MZBbqpHJ7O+rzA2gsiNckqE/jIUg4IIZSNCOQmARZS8WQ==
X-Received: by 2002:a17:90a:9414:: with SMTP id r20mr2875839pjo.158.1612855756934;
        Mon, 08 Feb 2021 23:29:16 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:16 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/9] t3905: replace test -s with test_file_not_empty
Date:   Mon,  8 Feb 2021 23:28:51 -0800
Message-Id: <2530883b6ca664d22ec54c4dd4fd3137c52bcd6c.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to modernize the test script, replace `test -s` with
test_file_not_empty(), which provides better diagnostic output in the
case of failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f008e5d945..c87ac24042 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -169,9 +169,9 @@ test_expect_success 'stash save --include-untracked respects .gitignore' '
 	mkdir ignored.d &&
 	echo ignored >ignored.d/untracked &&
 	git stash -u &&
-	test -s ignored &&
-	test -s ignored.d/untracked &&
-	test -s .gitignore
+	test_file_not_empty ignored &&
+	test_file_not_empty ignored.d/untracked &&
+	test_file_not_empty .gitignore
 '
 
 test_expect_success 'stash save -u can stash with only untracked files different' '
@@ -189,9 +189,9 @@ test_expect_success 'stash save --all does not respect .gitignore' '
 
 test_expect_success 'stash save --all is stash poppable' '
 	git stash pop &&
-	test -s ignored &&
-	test -s ignored.d/untracked &&
-	test -s .gitignore
+	test_file_not_empty ignored &&
+	test_file_not_empty ignored.d/untracked &&
+	test_file_not_empty .gitignore
 '
 
 test_expect_success 'stash push --include-untracked with pathspec' '
-- 
2.30.0.478.g8a0d178c01

