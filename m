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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774EC43381
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43F664DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhBOQCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhBOPry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB34DC061226
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so9497395wry.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSgVcZNYNkSHm+EwazDbLczuIlHYxp+++JQ4nahIM6k=;
        b=Ee+ia+NsH9QaGSxfGnBRaGGyZj+aqhEC7q4uUd7ARmL3Illm5irAgc2xsh8r6mjBa0
         e458+Lemx8GsSoOinXQZ5+YqFBnL38C6JfWbU47EchjgUopusA0uSdlAqXB4s7PMTe5b
         AoNelHEJyNeAwR/qEPXgOTT1IAXIiuzLdpiarXHFti+BzqpLEkdmSU17ERIj9E+S12wC
         9juYNXce2cLvIZ08Jyz2k3ZzYBdwjkjksD6mk+iDvRw0BpyBkqKCbciJnT4TWpc0JwB3
         xn0L5aI6MAGFf54jj6QLS9QEy7xMxBceESLbKZfjsO+Eao6Uhw2dC16puj0FEmBH4+hq
         ZJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSgVcZNYNkSHm+EwazDbLczuIlHYxp+++JQ4nahIM6k=;
        b=By5yPaXfNqnEdQ36Utbvq19rfSUvGqCqsL9yvRXANdVR5epHMXZ2o27zu8tL1tuoIv
         9qIoLlsmQOl7VkC5ZtQHZDsh2LBXIdbN9L8tOQd3EsuXYjOwDlywvIfE1OQ3XPm0asC+
         bm9vzypMHNbVSiYhUTBOwPNcSaH6V1MYs+RO+slsezfakqzIPZBn1pAJPl5YM98s9Nth
         H0/6wUhn4tCDt4IbCprKeyHqrkixspFOTEeSdey/AOoQy2DSgnU2lL4k7Nm98TM4Lg1w
         sfPFUKlu8iCT72ywMjz6ODuEQ1iJtPbCKGZfowcrYsme1I9WcHTolQpjQz0692rYNYAh
         GHOg==
X-Gm-Message-State: AOAM533Tu15uZWk/a/J7aqYNWkdZjZXF8Mi+lEY0SWq+z9rspM61NO2F
        RU9vWdNBhT2FvIzlj3GXIvTukcPkq7dLOQ==
X-Google-Smtp-Source: ABdhPJwtl9m24ZKcENjQXMOGkQPGGi2tuDAeeZmQRArS+zcb672Cccb/ggODWVairtYi4e6nEVXndQ==
X-Received: by 2002:adf:fc86:: with SMTP id g6mr19201317wrr.20.1613403899453;
        Mon, 15 Feb 2021 07:44:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/27] userdiff tests: do not do compile tests on "custom" pattern
Date:   Mon, 15 Feb 2021 16:44:16 +0100
Message-Id: <20210215154427.32693-17-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since f1b75fbaf1 (t4018: convert custom pattern test to the new
infrastructure, 2014-03-21) we have been doing the basic sanity check
of whether patterns in userdiff.c compile on the "custom" patterns.

That we were doing this was an emergent effect of that change and an
earlier refactoring in bfa7d01413 (t4018: an infrastructure to test
hunk headers, 2014-03-21).

This was never intended by the test added in
e3bf5e43fd (t4018-diff-funcname: test syntax of builtin xfuncname
patterns, 2008-09-22), nor is there any point in doing this. We'll
error out in the custom.sh test itself if those patterns don't
compile.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index d80a2ad4a4..3ba9d657b1 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -16,12 +16,7 @@ test_expect_success 'setup' '
 	echo B >B.java
 '
 
-diffpatterns="
-	$builtin_drivers
-	custom
-"
-
-for p in $diffpatterns
+for p in $builtin_drivers
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
@@ -74,7 +69,7 @@ test_diff_funcname () {
 	'
 }
 
-for what in $diffpatterns
+for what in $builtin_drivers custom
 do
 	test="$TEST_DIRECTORY/t4018/$what.sh"
 	if ! test -e "$test"
-- 
2.30.0.284.gd98b1dd5eaa7

