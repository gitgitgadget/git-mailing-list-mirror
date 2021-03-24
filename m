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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B5DC433E8
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EBF61A02
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhCXBti (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhCXBtV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613AC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so22795108wrt.8
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0onei1C+5pd5GD0STBmR0XOYKoIFSx8IBOIdC+S31Q=;
        b=CbyrLc4KH0L/jDCM6ZoZqthsQxJcDH23gq4p0vd7Q9M5C/YfRcKHWHaQIMMF5f5mg+
         2bbY+JMYRo9ZP5vCNxWT4O3H7lENbOMaN/S87UUUTqYnrYsPCsXPYN/1/cNTLP8ffphs
         BEgloKt403aE7BudFvpW2bN17p4Llze/VIBSm+CGJnPZ2+mC/nWxUcYwjS7ThBxCHrMM
         msR6pjFJzMkeXqgWLUnMNbNaeHkUrhSxmyhUOPN09sDxsPAbaP/iRHAHvtlKJyWGEysW
         NAZyfngvYhtTc/biURFZagdadKuglJdDA5hT+LqtAeU2qCSYmWwWE88jjYT8hr1bxamL
         /VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0onei1C+5pd5GD0STBmR0XOYKoIFSx8IBOIdC+S31Q=;
        b=sMIA6q2MIEBzAIaWRYd42e/9qmpkkUyDZeWjBMweZDgGocQHnN3TDH+URC7QTgvfE8
         8CsmB5tge6X4lt+t0e75CARF4fd9Ky7Atfg2/doZ3nGtliVVl095hPhxZtrjm/RHQH5v
         GVrqjQLmjxquK3fKp2wjNU6IHw9PSn9tMzS5eeeqKMVovB1QojIkYDA6OAO2c1EXguHd
         2Nn6al6s/krxKY0qycLyH4jSvBZDUb2RkNXP3oj0t+PMbaEkCz+3FnRB1yEpizD+mlrx
         x3WaksFxpeZGiA8NmT87xiysP7Zlj/knkqOdBCa/QI1X5ahvhseg/q+Ud4SaGoPzrllc
         9WgA==
X-Gm-Message-State: AOAM53025VvhSJU66OelxrCFACkSUlJncgFSvfiZ1B3LR/dZlZry/AEC
        nV1I2SuI5kWTATPo9JwLev0kBqbET35OIg==
X-Google-Smtp-Source: ABdhPJwwyS9z4Yw70BUIvw703823ctNVFvVEVyrI3vB2hRHVmJkINH2DBiGBeOAPHM0yYpjDVv3ucw==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr738950wre.183.1616550559147;
        Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:18 -0700 (PDT)
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
Subject: [PATCH v4 06/10] userdiff tests: explicitly test "default" pattern
Date:   Wed, 24 Mar 2021 02:48:48 +0100
Message-Id: <patch-06.11-862f6ab5d66-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
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
2.31.0.366.ga80606b22c1

