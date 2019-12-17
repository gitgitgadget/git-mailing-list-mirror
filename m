Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438DCC2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183A1207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0tezVXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfLQMB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35188 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfLQMBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so4495551pjd.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8XNbQ+GgBYygTvD2vAIrwNfJPbbfGy3wwVKh2xbuCM0=;
        b=h0tezVXpKUc8vblQwEJc2hStPsKdHaGwSavF0tDa8lgKoWvuWurSoQysIQkOYRYZqL
         fzXpPmUfZiYz9/sr/yWP4R5uAQ6jFwQcY6JoZrgDER0gbvFhV94fwmDAujIHzM2Ikq0k
         0EntQ1gw/7eRf39aWam0/jC3qfWET7CS8U/x6yN9EmPTrTAGe2g+eJfDFsEe/FmjfwTZ
         voML/9owE3FIdL9rrywFkLdzJWHUuC0QG1FKrEE0ZKqar+CLOmbrbR933pzgWE8aIWkU
         v3VtOX0iXek/jO7956hRX0+ETvwTKtSbOWvEyUjLod4JMfJ4Y3I59oQKHW0rXoBnSzTL
         L6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XNbQ+GgBYygTvD2vAIrwNfJPbbfGy3wwVKh2xbuCM0=;
        b=kboI5S++W3SuDKB8/FMUuq3ZKALLfsk+MDH1kCpOVQHKSOt1wnNXQ6LahWFMRpHaWF
         VVo/ucdWrOg/IZ+bhq19TfaIO9J1pVQvJX/y8MuswSBEm8fRYHWkRif3IerbdpeJa2zH
         KGwP/E/vgo4nqjw1SL0YDv+0E1fpHTwvd22OixNb8ykIku3ACtB+lYHvuV7Q9N3gWuMG
         UIIgV/A2UdeffPTB7b68b1T6jc1DnJIkJtleOdYP3vtSZLMx53a9CcNQCpO8SoyKzfAE
         EtvqZLiTTn6d88JgceaekXpm2cr3cKjYoc9MXzSAnSBRSzXQWxNFAHvXpCoNb+BqEq9e
         uhvw==
X-Gm-Message-State: APjAAAX1zJqWaRwMaHdBgsn/KhbhijnGNlt/l5G0O4g8Ljk+EG+JR7WF
        mda5viSeIqncfeZyDNqSkcc0O7ER
X-Google-Smtp-Source: APXvYqzD6r+fCOqti0q94wD73QsnNT4JlyFa7dltsGvMxS1qeAbgPhwdBm5AwWyDzJWkdI+PSxE9Vw==
X-Received: by 2002:a17:902:5a83:: with SMTP id r3mr22698614pli.145.1576584112517;
        Tue, 17 Dec 2019 04:01:52 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:52 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 13/15] t1409: use test_path_is_missing()
Date:   Tue, 17 Dec 2019 04:01:38 -0800
Message-Id: <27b32962427e5b74569b08dc4c0de40b67388615.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we should assume that external commands work sanely. Replace
`test_must_fail test -f` with `test_path_is_missing` since we expect
these files to not exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f74d890e82..be12fb6350 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -27,15 +27,15 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'do not create packed-refs file gratuitously' '
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $A &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $B &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $C $B &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref -d refs/heads/foo &&
-	test_must_fail test -f .git/packed-refs
+	test_path_is_missing .git/packed-refs
 '
 
 test_expect_success 'check that marking the packed-refs file works' '
-- 
2.24.0.627.geba02921db

