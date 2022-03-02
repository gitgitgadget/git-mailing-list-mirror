Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CEC4332F
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbiCBR3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiCBR23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:29 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF6DF9A
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 19so1327934wmy.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1edbebZXhnVH1I/m7MAQDheXpzx9CjcZTWDifU35E0U=;
        b=SAPzM2elc5CCNqWiCApllUUxxlljcp7QDLigTiAIGbiVOno2nOz6fgXaRyCDbcidzj
         DaRpmHZUNhIZPVp33ZNQ5Iuw8OwWyTYhWqpMZJId9zo0nyXmj+M4Z6MdE3XRdtvPM20N
         MtzhYlFKYDyr4OCu19gfmzHPG69tW8i/2lr5kn3LS6f/1UqeQVW8B4g18E7aA/ucXMBY
         D7dqsuAZ+2ANAwpY8xpCPnrKkdUwC5UsNvqOfNt67t/BlsB276EWGoje+gLp9DYRONk+
         aLM7svn2sa+NsAr1RhSQcoNAeSp9Gkljj+KudhQfKZB9kACX49BILj1ozvfX5ndB4dhM
         hZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1edbebZXhnVH1I/m7MAQDheXpzx9CjcZTWDifU35E0U=;
        b=1Q93cu/KbSfZHKoXz379P7PYKuXiRS3QSVyj+XeXZXjsF/8+CBdEZVl/4uAM5R0/9z
         4LKJ8zWZJC1F74zjZhu2pd/+V1tzE0y7nF7m2k3buWlkrt4Ccvu3KVeQ0wetMJme/4Dx
         5SJ56mv5YergMF7UJGSx0JSZ/se++Fs46xPvtLUavzprBTt3xUJjGRhtuqUzl2LTFBWC
         3FMzyZ7TsVEfQYXB3EYUOzFbh/z9EL5RbLLu45H6NYw6XjaLwyfwNq2KMC6zOc8C0HHV
         Iil3FNQGDQGh0a4WPG+dZ9maenCvCsDiZ1jXLPZ7YJKCGk/aPz513MxJt9rLfY5iqCcM
         A3Hw==
X-Gm-Message-State: AOAM532FAALY7eKHHgjcpznCvetQgmoX1j4e+5sll6V8wEQlAiDHWbfz
        Lu5HKtESuJwHUhmfycuDbI+QV+bRwcGzBg==
X-Google-Smtp-Source: ABdhPJyZ6+R4/bJOvCXnkhnAq4su+UN3V8ALoz1sum/Q8POu/PufIeDkBXzmi8FqMKr4ZqAH67whqg==
X-Received: by 2002:a05:600c:508:b0:380:fd39:2c42 with SMTP id i8-20020a05600c050800b00380fd392c42mr664034wmc.178.1646242053510;
        Wed, 02 Mar 2022 09:27:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/15] diff tests: don't ignore "git diff" exit code
Date:   Wed,  2 Mar 2022 18:27:13 +0100
Message-Id: <patch-04.15-a425ced5609-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a test pattern that originated in f1af60bdba4 (Support 'diff=pgm'
attribute, 2007-04-22) so that we'll stop using "git diff" on the
left-hand-side of a pipe, and thus ignoring its exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4020-diff-external.sh | 49 ++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 54bb8ef27e7..879ee04d291 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -37,17 +37,15 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment' '
 
 '
 
-test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
-
-	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+test_expect_success !SANITIZE_LEAK 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
+	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
-
-	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
@@ -83,16 +81,16 @@ test_expect_success 'diff.external' '
 	}
 '
 
-test_expect_success 'diff.external should apply only to diff' '
+test_expect_success !SANITIZE_LEAK 'diff.external should apply only to diff' '
 	test_config diff.external echo &&
-	git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+	git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 '
 
 test_expect_success 'diff.external and --no-ext-diff' '
 	test_config diff.external echo &&
-	git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 '
 
 test_expect_success 'diff attribute' '
@@ -115,17 +113,15 @@ test_expect_success 'diff attribute' '
 
 '
 
-test_expect_success 'diff attribute should apply only to diff' '
-
-	git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+	git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'diff attribute and --no-ext-diff' '
-
-	git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
@@ -148,17 +144,15 @@ test_expect_success 'diff attribute' '
 
 '
 
-test_expect_success 'diff attribute should apply only to diff' '
-
-	git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+	git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'diff attribute and --no-ext-diff' '
-
-	git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
@@ -177,7 +171,8 @@ test_expect_success 'attributes trump GIT_EXTERNAL_DIFF and diff.external' '
 
 test_expect_success 'no diff with -diff' '
 	echo >.gitattributes "file -diff" &&
-	git diff | grep Binary
+	git diff >out &&
+	grep Binary out
 '
 
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
-- 
2.35.1.1226.g8b497615d32

