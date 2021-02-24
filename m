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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31178C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB24264EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhBXTxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhBXTxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00711C06178C
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so3051269wri.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJfrO6oxVRVCU+9c3QNry2H+uZwTWYg5ucIJmHd2vOA=;
        b=owNs0Nqp0wklv2VaqXVMXpnHbp2wNNXdSCUklKP0E5dU9EdzGMof8SPi0mySXc0lrN
         C7Ok/e6nPWo88f5RbVPylXej3eKTTv0O9itQBVBJNf/ckPQ62NIGUrZUCmheBe/qw/am
         qc6ygDED/gGChqhfjGi7h17UQQEIVR/KLk5cl96jgxJn3zqBVExH/enRGMp/TQX6Dz7q
         2VEeY/JmwxCSn1BenfAGfTcUdQFR/7eFzp5UvFAw1x1m98Ymo7TO6kgRfCPxVSxu1Nyy
         +fAVjl7v5TGOG8kL0atbRH0o/9FldweVJhB/Eg36mTwgobpXFmuFEGebs08RYPvAzdNq
         tLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJfrO6oxVRVCU+9c3QNry2H+uZwTWYg5ucIJmHd2vOA=;
        b=FsA5dcwFOqzjwnEx0e+loxv7/GcLwTM2VWZhcRHP6u3FkbvLbpRvjYC5EvsLKYl7D9
         RwvZimS3+Bot9q8XubeacZA3CpntzlS/8b6wqo272DDFXZTHKC84HX//qrYnvQOM8QlI
         RyRMlPINxzDDro9k8c1YCWTHUzdKMX4UEDKur2xLVkhuovN0n87jIY5sHbYo1SC2ANnj
         mn93o3S3O8qNN5V7T8EiayLrBi/zKlKQBjDy0bpQORFJYVE8JvhafsfosfMysbbam6zb
         ExjcMdguU0nrM2Lmw68Y6iOued17CMXfoxO217CcZF5WFynBYvg3PAdKeow/mZhKhzip
         XQpQ==
X-Gm-Message-State: AOAM531HSzrtGS85XlryIkVJsjBG9CP8MUUU1DO667vW7r5tWvR442HL
        RDf/gZNxgyDa3JPC45x3oYpXNgKtnpzsbg==
X-Google-Smtp-Source: ABdhPJzWWObWD/wgqc/GK+m1LJFhI62Srvywp6Jk0vOOltlke4Ewk6SQB7SXIutU5XxHXjq3mWOxyw==
X-Received: by 2002:adf:9564:: with SMTP id 91mr32313025wrs.207.1614196317501;
        Wed, 24 Feb 2021 11:51:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:57 -0800 (PST)
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
Subject: [PATCH v3 06/35] userdiff tests: explicitly test "default" pattern
Date:   Wed, 24 Feb 2021 20:51:00 +0100
Message-Id: <20210224195129.4004-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 122aa6f9c0 (diff: introduce diff.<driver>.binary, 2008-10-05)
the internals of the userdiff.c code have understood a "default" name,
which is invoked as userdiff_find_by_name("default") and present in
the "builtin_drivers" struct. Let's test for this special case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db2..cefe329aea7 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -49,6 +49,7 @@ diffpatterns="
 	ruby
 	rust
 	tex
+	default
 	custom1
 	custom2
 	custom3
-- 
2.30.0.284.gd98b1dd5eaa7

