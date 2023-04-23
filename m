Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4BBC77B60
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 13:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDWNq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 09:46:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57E170A
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec81773d50so3534245e87.2
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682257614; x=1684849614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2unZZ0tkwjTB6Nef/MJvYMRgoZQUGroeYnEdH+E8r0=;
        b=pLm95TUs3aC/0wFh7nGg1f7OSJvmaMbVKJivJlKaVvNZAb8XCMh5zETJ7Szn2J+A3k
         58WAMS5OP7mNrgADE4hKpmEY+oojweM7AKd1IZEoNIUhKjfjsra4wzq6XhBLjNcWxinD
         fib4NQGRwUO2O6Hp970RpoHq15Lg4RgpxtDyu3u08XMtsTPFhuy2/h5L79aruNJH5XwF
         AadLze0I7tsXApBQcxPbqmUk5j/3PkI16XnAx51ez1JwyakOlpbsr0iPEvqJiXc+sA7w
         XENZS6HwNAz20J/PNsIErEDnatYlpIctpaDlpIKaOEjHoMXUuytqaitqvt/gTyPFxVds
         3aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682257614; x=1684849614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2unZZ0tkwjTB6Nef/MJvYMRgoZQUGroeYnEdH+E8r0=;
        b=gMNP80hk7+JIoU12k0ah17mn8TpVPBAnKQtyzwxJ5TP1fyZGT+fbpdPPqQp77RINTv
         R46y9Db/2SCi/SOiUQs53c1FTygUjhwoozAE5pD3Wg/BmzNsCx3jcNOZa7TRsXdV1S+S
         RaPR0KLQLgFuJy4ogt9eAD/P7Nz3TmuAzJUH8ZANHpVqtU0BWbvss032jCVgnuKcXCj+
         Pbo/9xK+Q/7OD+bQM+9knFUp3G+XrZU8tvEeOr5dXLDBW1OStYUTwQUD+qI1S42DPLfM
         WngGaRLciUzm9DxFnho13UPH0SXPwEpm3yEProY4f+PTPdHrZT45KEIMwGS1Pm5BaTnr
         sRKQ==
X-Gm-Message-State: AAQBX9ezv4kA7LZxBmd23Pea+p2NYs4yxFp3QnNV539C1OITisvSAghP
        hCJMr2K4n+CZlHc0qMQFByDqG1/fichwS+4XOi0=
X-Google-Smtp-Source: AKy350Z3Z5P35qnuRAj2RC74bJHrckiyYEeoOsr4ioLLV2i6iPNfRdTXE8+WMDh1xF3NANHqHs2NHg==
X-Received: by 2002:ac2:4910:0:b0:4ee:8ff3:c981 with SMTP id n16-20020ac24910000000b004ee8ff3c981mr2514927lfi.10.1682257613666;
        Sun, 23 Apr 2023 06:46:53 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.55])
        by smtp.gmail.com with ESMTPSA id j24-20020ac24558000000b004db3eff4b12sm1272641lfm.171.2023.04.23.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 06:46:53 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] t1300: drop duplicate test
Date:   Sun, 23 Apr 2023 15:46:47 +0200
Message-Id: <20230423134649.431783-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423134649.431783-1-rybak.a.v@gmail.com>
References: <20230418175034.982433-1-rybak.a.v@gmail.com>
 <20230423134649.431783-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two almost identical tests called 'git config ignores pairs
with zero count' in file t1300-config.sh.  Drop the first of these and
keep the one that contains more assertions.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2575279ab8..696dca17c6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1458,13 +1458,6 @@ test_expect_success 'git config ignores pairs without count' '
 	test_must_be_empty error
 '
 
-test_expect_success 'git config ignores pairs with zero count' '
-	test_must_fail env \
-		GIT_CONFIG_COUNT=0 \
-		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one
-'
-
 test_expect_success 'git config ignores pairs exceeding count' '
 	GIT_CONFIG_COUNT=1 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-- 
2.40.0

