Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7EC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F030F61108
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhJVTin (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhJVTii (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB0C061767
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m42so3874573wms.2
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLARhRGoHASyxNBB/aFlcZ/aSXEp5Xya/q+j+8DNzM8=;
        b=RIJxyXzKIET5DeJQBs8uE2Eevh9XspGjvulpMuqh6zYZ0Os3LPNsBnYK6jC4EbNPg7
         hpPtWQYUYAGeO93Z+HGiBxWl6iR2kpiYo/1nRyimFda5XPJ1FQfmEWgYDJIK9qCbkbEI
         wbDgWM/YOW6auSHUz80AD608ZDQB36rcNjVON7X83MyoWeeH5PWaH6kAAhnsJIKWyecS
         iK9cFjdEM3ez94PZWaoW7hpyFXCXf2Sszqoq/UsHCDCxYoIrv5pSS98tjrf5HP2OBTA6
         t4cXtVNcREeprOpl0Fp849s7Q6HsfR2YQdQnygl/mZ24ghKJpvyfzXG6mivs8f/y8Uw3
         gO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLARhRGoHASyxNBB/aFlcZ/aSXEp5Xya/q+j+8DNzM8=;
        b=sJe49p7F2T1oLH96vOruijsdhxHqVxVm7cdXU61B7KykaD2TMdT6tracBK2i7Gwtjc
         gAl3h+Tm/t5npKyDMoIXhpkcMiZ3T5x/egU2++QSmXEQ3JC7bApEdXjja/rL2NTd0d6N
         ylwcv7ciSZkfR1/LoAdR7E0zo7uppzPETJUZWaNIsuwQeHw27twEvtg6ecD2FI/bQf0P
         dB2wqImjqODLEP7crmI1ykRkvOEb9ee+eUaRovPqJDbpdbWnK7NAj1fon4o0Z3h/5+6z
         dVuj+1vHfwFXTLxPMmSHmiOaeej0Tdx8HUBZc/aMO4JIMwrPXtdfJG5c1VLF4vdHVrl+
         f3IQ==
X-Gm-Message-State: AOAM531RrWECSFuoNgcWrl/+UxtaU6caET8/MU6cdv5LcAAwe+hlb8pl
        quiFpNNTkoHLhp8RueBuF4pi3Rdwl4E7mw==
X-Google-Smtp-Source: ABdhPJzJHzr+fYjp7vj6E0oM0dgvF0Y/Kc9xjgxMQ2+iRXqU0/RUWQTb1RKxFXM2zmA2oP8412hrEw==
X-Received: by 2002:a05:600c:1989:: with SMTP id t9mr1873071wmq.48.1634931378513;
        Fri, 22 Oct 2021 12:36:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] generate-cmdlist.sh: trivial whitespace change
Date:   Fri, 22 Oct 2021 21:36:06 +0200
Message-Id: <patch-v2-02.10-5e8fef90e42-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes a subsequent diff smaller, and won't leave us with this
syntax nit at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9dbbb08e70a..5114f46680a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -10,7 +10,7 @@ command_list () {
 }
 
 get_categories () {
-	tr ' ' '\012'|
+	tr ' ' '\012' |
 	grep -v '^$' |
 	sort |
 	uniq
-- 
2.33.1.1505.g075a284c562

