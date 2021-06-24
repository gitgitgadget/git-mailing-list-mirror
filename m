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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD436C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86CC613EC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhFXT0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhFXT03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA072C061760
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h11so7884940wrx.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD2grX/xGfpeqpULxpW8NyqZqnuUgy/1EvFSNN/4d74=;
        b=C0O/LlZqMteUZuX5GJVXxq0ajR2vc5FJBZ3GtnBhb3pb3YyJU6bkJmvAbHpVnMmlyw
         CuPIUwybKHXQ3X3MyH78fA5W6/VipmVqy0RC98Z85BOIQ0eisUn6Zl7JsYgz4lTnnvL7
         4ep2SwvZiNtvWdLnrwAz94mboGm7wk+Vq1OwL1Iwz9GTMPVS2GeFkYAc1xeXUkWr+Zok
         +W5HcfS8K73+KmRW8Ma7blV+GBj7N/Smk/I9ePoM9ant/kAl0aEwFoxMyiBPCtzLlD16
         YjI7smJWD9/eqKLWbKMIHUknwo0eprqw9sa/9C7KCgtL8OodiMe3orCN/4gnvVBFXAbW
         4J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD2grX/xGfpeqpULxpW8NyqZqnuUgy/1EvFSNN/4d74=;
        b=SxNl3QYmr83/A3ZSh2cxJMn6bVnt2h2/pfHYE3DWSLyc1hQ0FgZuhoHqOYt22pK+C3
         Sisw7YQTTj6+086gNXcCdsKCxMdM6nGB/MwcwAisJIme1Ju+kNkj/9l82R9bQkVTGZ48
         1Aeq+H2wCumkSSZMpF54ml9//yxJK/aCQiVc/EvU0Ematb9YU828as7lTeD6kbEL4MNp
         zSHWDSCgv/2HX0KILEkMRWvEMI0BCbqmHObiM+jo4neVJKxZ7WyzK+KeyqcN4fmyvHVD
         8obvnR0I2kcudeuCyKUjfMcBV9uXTgTF6ZD2aYvx7MUdE0vGWee1nX4aBN/NjdBlTsMN
         O9qw==
X-Gm-Message-State: AOAM533i8x+LpBJS9TlSHcBFQIXcETyKChDyYZ6S0wvnbyV/CaArsK3Z
        3c1g6xSXYRfmy1nXXi3dGu6l8kr9jLGiLw==
X-Google-Smtp-Source: ABdhPJzcZXAynNolry6OdyROvY697wJL1mwfSm1giwNkA8S4PSU7gpfnAW3NE51hmMXnkSmGll5iQA==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr6305439wrs.21.1624562648320;
        Thu, 24 Jun 2021 12:24:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/21] rev-list tests: test for behavior with invalid object types
Date:   Thu, 24 Jun 2021 21:23:43 +0200
Message-Id: <patch-05.21-8eaf0e6ddda-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the "rev-list --disk-usage" feature
added in 16950f8384a (rev-list: add --disk-usage option for
calculating disk usage, 2021-02-09) to test for what happens when it's
asked to calculate the disk usage of invalid object types.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6115-rev-list-du.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b713..edb2ed55846 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,4 +48,15 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+test_expect_success 'setup garbage repository' '
+	git clone --bare . garbage.git &&
+	garbage_oid=$(git -C garbage.git hash-object -t garbage -w --stdin --literally <one.t) &&
+	git -C garbage.git rev-list --objects --all --disk-usage &&
+
+	# Manually create a ref because "update-ref", "tag" etc. have
+	# no corresponding --literally option.
+	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
+	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage
+'
+
 test_done
-- 
2.32.0.606.g2e440ee2c94

