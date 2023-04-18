Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC8DC77B78
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 17:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjDRRuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjDRRuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1279AF34
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso2374116e87.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840240; x=1684432240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS+eJAC+tQD6AE2KEtPmgNZ4XUTSlytBBlAUIfOxx0U=;
        b=L/mbGZlWuZs19zCgLOtud2T8Ch0K9hCg+un29u1G8TJEwmXk0s/3uBdfQgx1jFeraZ
         l2w+TWAQSRExAFQDI7pOohAbGSignmjxjXWV3nMTJjOhjqiWrk9YQkw8h+ZaFzeuhotf
         oHRC7ZcuAPmNfPmg5LaYBQ4yOUJGOEQYB3zsf9vUzlgGoZ+s0HKRppYoIlDB83C+RBPe
         9GQJnoLl3+klSqUSH4PQmmiIbg/KS6xAw8bTf9pdNQURAVERbQYAcZ6pXzJ4x8Tu88yD
         qxzcrY24OGdgGqYafpHVZccBucLTbdkzYia3WZmJUTY1OO9K+cVwA7+0SKIGiwA8SMaE
         JMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840240; x=1684432240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS+eJAC+tQD6AE2KEtPmgNZ4XUTSlytBBlAUIfOxx0U=;
        b=jflPdXU1jP8xhwpzwEvv6tucuybxTAES96rSt4QnRZrQY1rouRo87DdVj05MENXIBa
         UzOElVum3/FqccKzDvHo0XO6TDZVOyNtSlEZe3wqBFHy2+NX9hT/5u4dDU9XRBmm+DYs
         cTIConoalctY9RwKL79Bpo9MrV9KIV5H1qsCYRaFtybOmYTU/6UXpDKczAG9kmfrniDd
         u2HumZeKEZ7ZJJ0xTx2MyDA4xQNnkvFSRIfni+YYGQBUkGl0QM5oaCnqs71n0owDd7fQ
         KSegwAsvQDNF7g+CckbkAKsn/i5za9IjspjVAiPLAeEDHrVQxVmstWKmlBU/gLEIJGxU
         /Txw==
X-Gm-Message-State: AAQBX9cxsPXvitGp3dX/o0NUXslSepJgVRpbftgFro8e0tbMPPhsvkZM
        U35YxpeC8rE4MZqcjh+oRcjWZmrdsn6jWkxY
X-Google-Smtp-Source: AKy350ZdloVvO6GEMN4VUbJv9gGqTMmJeh6Wnmx7hfHnMOe65uCQwLrBa5Hqzf8h71ad43s+KTPidQ==
X-Received: by 2002:ac2:48b2:0:b0:4ed:c76b:6aaf with SMTP id u18-20020ac248b2000000b004edc76b6aafmr1755238lfg.56.1681840240354;
        Tue, 18 Apr 2023 10:50:40 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id l20-20020a19c214000000b004ed149acc08sm2294998lfc.93.2023.04.18.10.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:50:39 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] t1300: check stderr for "ignores pairs" tests
Date:   Tue, 18 Apr 2023 19:50:33 +0200
Message-Id: <20230418175034.982433-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418175034.982433-1-rybak.a.v@gmail.com>
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
 <20230418175034.982433-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests "git config ignores pairs ..." in t1300-config.sh validate that
"git config" ignores various kinds of supplied pairs of environment
variables GIT_CONFIG_KEY_* GIT_CONFIG_VALUE_* depending on
GIT_CONFIG_COUNT.  By "ignores" here we mean that "git config" abides by
the value of environment variable GIT_CONFIG_COUNT and doesn't use
key-value pairs outside of the supplied GIT_CONFIG_COUNT when trying to
produce a value for config key "pair.one".

These tests also validate that "git config" doesn't complain about
mismatched environment variables to standard error.  This is validated
by redirecting the standard error to a file called "error" and asserting
that it is empty.  However, two of these tests incorrectly redirect to
standard output while calling the file "error", and test 'git config
ignores pairs exceeding count' doesn't validate standard error at all.

Fix these tests by redirecting standard error to file "error" and
asserting its emptiness.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 696dca17c6..20a15ede5c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1462,24 +1462,25 @@ test_expect_success 'git config ignores pairs exceeding count' '
 	GIT_CONFIG_COUNT=1 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
 		GIT_CONFIG_KEY_1="pair.two" GIT_CONFIG_VALUE_1="value" \
-		git config --get-regexp "pair.*" >actual &&
+		git config --get-regexp "pair.*" >actual 2>error &&
 	cat >expect <<-EOF &&
 	pair.one value
 	EOF
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_be_empty error
 '
 
 test_expect_success 'git config ignores pairs with zero count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=0 GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one >error &&
+		git config pair.one 2>error &&
 	test_must_be_empty error
 '
 
 test_expect_success 'git config ignores pairs with empty count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT= GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one >error &&
+		git config pair.one 2>error &&
 	test_must_be_empty error
 '
 
-- 
2.40.0

