Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71FFC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBA96108B
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhE0AAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhE0AAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:00:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8DC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:59:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id i12so2265426qtr.7
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BKtqBAK6KoFTvrqdQTvU7fQcusgU1FwT0pcqmfU6zHw=;
        b=KNk+9WYl3MJ88qzr8LhBIn+rukrdY6RoqiL1AQvA3V4ok+geeYUuj2jYfCHCa/Ii0g
         +wXfZcgltYD+BvhzIlI47W9zr0sghbACynRKQRn0mL0oYkrV0gIRfLQnkdMOiodNGAZd
         0kMYFkRFjqVnljnQsqvkQ/TcU1d0WPj73YfFwEgE7pghL0oH5uBOTJvfRzXvufIdxUG8
         fAsQcW68/r4CUm5nqOu95+4y/jEcGLmepVJEd5VEre+HiUPFHx2AezU7FfmwjrPF06T2
         XHaX9/+MssXHLtYMpYy2JDPR1lmR25Cm04aVESud5J8IZ6pqqLz1BDzE6x9myocb8g3U
         4+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BKtqBAK6KoFTvrqdQTvU7fQcusgU1FwT0pcqmfU6zHw=;
        b=F2Y5JKe7JWdm0XeP4k53pPXPW5JuWWFqh4G3XO3gWpJX/6p3AYTTW0hzo4ECjTFrF0
         GS+xXu0c6VzwLckGPfZX4S+/p5dAzgxMvuuT678NhjebNzVu9E37dtOaGbb4Mh21NULV
         o1jOAKKWvg+zKOopdDgcT3nY0d5esDJ4juemAPnLpKIHnJAinS8S04i42UfhABZ5cxSw
         XMRfesfeIEbuxyMJ3Ub6zxZshIW7hsTM3MEHnWzyO2vd3a/oVyw4KRcfaNPkA1xcdwBT
         gQZdB2u+RvHPi8Q1tvmjp8PA/wC9YckwASfobWQ+5l6H87LH1GYeA6O3OntwF0DAN0/Y
         ke6Q==
X-Gm-Message-State: AOAM5327ya+7caG3ITarsm4F4P6P0mZjvOiGQrxjwLSyOiOJTUOeAEv8
        7sAgPauJqKQUQnKw6u4lkVo6og==
X-Google-Smtp-Source: ABdhPJyxwvnFoS2bcJ/C/yJa+LcZZnqZSvegFYHv16XVe2PmURAWATCKNf+6wvHxi6O4+XXxONxlCQ==
X-Received: by 2002:a05:622a:2d1:: with SMTP id a17mr713966qtx.88.1622073548576;
        Wed, 26 May 2021 16:59:08 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id y19sm332250qki.15.2021.05.26.16.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:59:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: [PATCH] t2080: fix cp invocation to copy symlinks instead of following them
Date:   Wed, 26 May 2021 20:58:56 -0300
Message-Id: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t2080 makes a few copies of a test repository and later performs a
branch switch on each one of the copies to verify that parallel checkout
and sequential checkout produce the same results. However, the
repository is copied with `cp -R` which, on some systems, defaults to
following symlinks on the directory hierarchy and copying their target
files instead of copying the symlinks themselves. AIX is one example of
system where this happens. Because the symlinks are not preserved, the
copied repositories have paths that do not match what is in the index,
causing git to abort the checkout operation that we want to test. This
makes the test fail on these systems.

Fix this by copying the repository with the POSIX flag '-P', which
forces cp to copy the symlinks instead of following them. Note that we
already use this flag for other cp invocations in our test suite (see
t7001). With this change, t2080 now passes on AIX.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t2080-parallel-checkout-basics.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index 7087818550..3e0f8c675f 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -114,7 +114,7 @@ do
 
 	test_expect_success "$mode checkout" '
 		repo=various_$mode &&
-		cp -R various $repo &&
+		cp -R -P various $repo &&
 
 		# The just copied files have more recent timestamps than their
 		# associated index entries. So refresh the cached timestamps
-- 
2.31.1

