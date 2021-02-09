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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065CFC433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C188464E9C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBIRdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhBIRds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:33:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A305C0613D6
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so12923407pgj.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BSnbbSUu+63F9e8TJQ78/CnLDEF9hGiUb4HH1gTdE3o=;
        b=ir04arsSN5VRGQwaQvUv4AGAxjrvf2+vT+Y1EmWqwm0NXTC80wpMsKaqxY13gEXcy3
         sHIDFThcPLUdyAcLHQPVgH0/SO7H9n1M88BUnHL54jOX5gU3T8ouk7zasGONWg9+5ubd
         GntlKjYkLuhx5K/gVBiQPEI8rE3VzUTDffPKMSS17j5rJ1SlMPXhRMhGj9RpKTCmQVvK
         E68jCc8yB/R7mk3r7wLGqdmSvRwa6tRnu7NaLH/hIES5zr5Yy0uA6+0x/KC9X0sgZ5Mu
         wWA4J8xc+FKO6QarpzsPAqf7A30SaUW4NjArL2NPfvvwad7TrQ+KKOTzxi2OZGa+6Gmr
         H7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSnbbSUu+63F9e8TJQ78/CnLDEF9hGiUb4HH1gTdE3o=;
        b=GwI0K88H/ZSC2RfyDxfJnmh1N677Pb03xqyZ9kzjYojbtTCikjdV5m/LfPtXvsbMTv
         wjgalky3TgxL6TS/sKFg6J+2kRouwjYWsgQQoVBticmQ5511nbj9WWigX1Vgm2I3akUg
         KVfE+2xctBFWso5cM/8sEGVq4DAp4iN+9KjNnxokwutBfEObe81F5AdOU3e6i2+g/pcu
         uIRo5mDs9N4u+nNpAqc1/t1eD/igLQpHqqaNpK8ngqg0UoLXWL7bsh65oucUTzUVGcfM
         DPFwI49SB0THsyYJbpIX4uBaZa58ywCBVoWSfVq/Ijwwwuo7u+r8NV+QyquR/XXyDrTd
         GTTw==
X-Gm-Message-State: AOAM530TjWDlBaTQeCuyyk5wjeulaY1m8zQdbh1PjfNrAbiZAUHMCyNj
        ifH6XBUoZV5IiYtZcXf19uoDzxX0gZ2E4w==
X-Google-Smtp-Source: ABdhPJwkEeX6Xl6cs/wQzynyKZfg51/7tg/PJyfRrq2VYMqSs1bDyBr5rFHKMmMOnZRM6VCsujqjOQ==
X-Received: by 2002:a63:4405:: with SMTP id r5mr22515887pga.168.1612891987334;
        Tue, 09 Feb 2021 09:33:07 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:06 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 03/10] t7001: remove unnecessary blank lines
Date:   Tue,  9 Feb 2021 23:02:47 +0530
Message-Id: <20210209173254.17712-4-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests use a deprecated style in which there are unnecessary
blank lines after the opening quote of the test body and before the
closing quote. So we should remove these unnecessary blank lines.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7503233814..f63802442b 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -182,7 +182,6 @@ test_expect_success "Sergey Vlasov's test case" '
 '
 
 test_expect_success 'absolute pathname' '(
-
 	rm -fr mine &&
 	mkdir mine &&
 	cd mine &&
@@ -196,12 +195,9 @@ test_expect_success 'absolute pathname' '(
 	! test -d sub &&
 	test -d in &&
 	git ls-files --error-unmatch in/file
-
-
 )'
 
 test_expect_success 'absolute pathname outside should fail' '(
-
 	rm -fr mine &&
 	mkdir mine &&
 	cd mine &&
@@ -216,7 +212,6 @@ test_expect_success 'absolute pathname outside should fail' '(
 	test -d sub &&
 	! test -d ../in &&
 	git ls-files --error-unmatch sub/file
-
 )'
 
 test_expect_success 'git mv to move multiple sources into a directory' '
@@ -232,7 +227,6 @@ test_expect_success 'git mv to move multiple sources into a directory' '
 '
 
 test_expect_success 'git mv should not change sha1 of moved cache entry' '
-
 	rm -fr .git &&
 	git init &&
 	echo 1 >dirty &&
@@ -243,7 +237,6 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	echo 2 >dirty2 &&
 	git mv dirty2 dirty &&
 	[ "$entry" = "$(git ls-files --stage dirty | cut -f 1)" ]
-
 '
 
 rm -f dirty dirty2
@@ -266,7 +259,6 @@ test_expect_success 'git mv error on conflicted file' '
 '
 
 test_expect_success 'git mv should overwrite symlink to a file' '
-
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
@@ -279,13 +271,11 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	test "$(cat symlink)" = 1 &&
 	git update-index --refresh &&
 	git diff-files --quiet
-
 '
 
 rm -f moved symlink
 
 test_expect_success 'git mv should overwrite file with a symlink' '
-
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
@@ -296,11 +286,9 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	! test -e symlink &&
 	git update-index --refresh &&
 	git diff-files --quiet
-
 '
 
 test_expect_success SYMLINKS 'check moved symlink' '
-
 	test -h moved
 '
 
-- 
2.25.1

