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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C4C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEAD22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbhAETou (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbhAETou (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7295C06179F
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r7so346742wrc.5
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WIjBFfNv1h/HVQS42c1uH9CIVsBC3PyVvLQO43R9WU=;
        b=HxTwDTTiHREIYSqxzH1gAms93MWsxwWbySoXbHz1yithOHMyNJ0CIV03+0RoeCsYxt
         qigxfHuSGEJ4jmHEoDhUjFPPv2zRYLEQBvoZbGDOjzyB4XcnRpTvp5yDxyRZ6cI0092C
         u7iSp7BwlR4svNExKVTyhid4e6KuHdIeoRCMzBYFPWf6k5bdZ32Oj8DZEPd6y6DTnkNC
         TxQJHpyqwPyBcKH+I/VfW9iuKArZSAfezMO3NqscWv7cJmjp5TPQu0eIrVKszzyxHdov
         yFpq4nOv7MlHqnbtY/N1YuVE5ELKnEuqRdzO2c7hu3iGKhozrtaJE8bGiVsHnFEAewq2
         LscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WIjBFfNv1h/HVQS42c1uH9CIVsBC3PyVvLQO43R9WU=;
        b=UGNtW9tovmCNTfO4XZ1hgD6k9Nzhcl5kMQb8HqFBXLk9n+zN46p6wGls0lCLw/gkdH
         HYp21qYk7hXLeJeqdUZ0nuitLkI1HINjel1LLfbB5JwNdn3gtTpBdY/Jcm6/YBvUh075
         wsPNxIjDNLgzebMbYrwAHEw3N43vbzzZVsBdDMB8KCcb4MtgDMEByNwpI+pCLpU1Qirq
         DSYzMnIxyqU70QKAMF7Y6pS+2FTXnz8i1ckkzSjrvspw1kdK6FDwKusxcw9jM3VkDVFr
         7bdolyQQQuXVd3CUoFAFjF6pVR6LMlS+zqPziSHTjwouWafaUum0jqmQlNIcnHaw/oRT
         o6hw==
X-Gm-Message-State: AOAM531lDR5VYJ/udpt3B5rpOJNbCSpUrI4wujOkHRiw27v2yjOCnX4h
        XsqJAJgnzfTFuACepmgDy+HK452Xvvzh6Q==
X-Google-Smtp-Source: ABdhPJzYGGFsOn158aQdaH2z9X/WekRsV7lunubC8yMmrlvrkyx/fbguhkexXlzZRgKaTEBSugt8zw==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr1137087wrp.14.1609875814281;
        Tue, 05 Jan 2021 11:43:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/23] mktag tests: don't redirect stderr to a file needlessly
Date:   Tue,  5 Jan 2021 20:42:36 +0100
Message-Id: <20210105194252.627-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the redirection of stderr to "message" in the valid tag
test. This pattern seems to have been copy/pasted from the failure
case in 446c6faec6 (New tests and en-passant modifications to mktag.,
2006-07-29).

While I'm at it do the same for the "replace" tests. The tag creation
I'm changing here seems to have been copy/pasted from the "mktag"
tests to those tests in cc400f50112 (mktag: call
"check_sha1_signature" with the replacement sha1, 2009-01-23).

Nobody examines the contents of the resulting "message" file, so the
net result is that error messages cannot be seen in "sh t3800-mktag.sh
-v" output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh   | 4 ++--
 t/t6050-replace.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e1a2892f58b..c542c3e1a8e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -222,7 +222,7 @@ EOF
 
 test_expect_success \
     'allow empty tag email' \
-    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'git mktag <tag.sig >.git/refs/tags/mytag'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -350,7 +350,7 @@ EOF
 
 test_expect_success \
     'create valid tag' \
-    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'git mktag <tag.sig >.git/refs/tags/mytag'
 
 ############################################################
 # 25. check mytag
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c80dc10b8f1..0dbe086118a 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -129,7 +129,7 @@ tagger T A Gger <> 0 +0000
 EOF
 
 test_expect_success 'tag replaced commit' '
-     git mktag <tag.sig >.git/refs/tags/mytag 2>message
+     git mktag <tag.sig >.git/refs/tags/mytag
 '
 
 test_expect_success '"git fsck" works' '
-- 
2.29.2.222.g5d2a92d10f8

