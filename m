Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A6C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjDQTLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDQTLK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:11:10 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3657D8A
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bz21so3693801ljb.11
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758653; x=1684350653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPA6VephNu4ae9tYi/0aHGAe7CNAeibjD4ifce3lHUg=;
        b=sJQEq0ejHJAvRQdC9Ttw/0bIkernAuHOX+SQ2wGK5yFW2+OpPnCUAlqEpo7ATD/ozS
         d4t+KirchIC93d4ebN6XFrYhp32xrmrESmCuDIWDsB6Y4ubiqBBUYlRSe11vlNwZYjUr
         9B7M+LCEjLsWvYxCO3ISYuNI3t0jf43YCD6jSqKhGb7YbtFvcL0W0M5TQFocxsDnGSm3
         GJ5FeXgujyvRvvNua/QqbkWXTGU+/6I5fxohgMTa4sG2SAeFKL4wIhf/go/FswJhGCNI
         noWG6IT/5qgPQm0yC1pDYso90h+umbj5iRdFyqNNvjPLbCjWV/OmfvkNf0zXP7XUCRu0
         aP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758653; x=1684350653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPA6VephNu4ae9tYi/0aHGAe7CNAeibjD4ifce3lHUg=;
        b=jjeG2ttuvRSjvnbPZsJPKjCBkxBpzNdN7nvGFMUHSDsgrjUNkQlnOtc7Oz/M4/V9K8
         k1fF6paJ6WsJQIeJUxh5to27rk7aZ05TORP0Lb5dsdo1Gfj3pn+jWABHnXyzoxM5bvi2
         dpV3lFVu8JLU9tu83i72dWVRynp+9fMZIvJgZDAanhoLqOg5uutJlz6QGIsPzBDJelrS
         4xgLj9UuuS9h+b1psuIcIoA6ce4HLYyE5Kr3Ll9pc+LXP6WVOfMmaoG7t4dUSU80z667
         klwEqMg+xItOXumoV8bSPdC6ymCtK60mcBmphakyAlYq0JQxkTG16++gPmR75HyzHIxs
         Y/bA==
X-Gm-Message-State: AAQBX9dnxFG2rPqDopi2243fbUUppBopNaRgPf92WidwiMFpsC7Ehfl0
        4Fg1HX18HzaCyl06UO7f0OpjuheUKEmcsg==
X-Google-Smtp-Source: AKy350aDG5OCJx9CkIHbfVteVWUkjWq0gkvOAb4OizsLCBokcocoCSejQbZPDpWO4vKhIPkJp+FprA==
X-Received: by 2002:a05:651c:550:b0:2a8:c45f:7e16 with SMTP id q16-20020a05651c055000b002a8c45f7e16mr1297855ljp.15.1681758653084;
        Mon, 17 Apr 2023 12:10:53 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:52 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/6] t2019: don't create unused files
Date:   Mon, 17 Apr 2023 21:10:44 +0200
Message-Id: <20230417191044.909094-7-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t2019-checkout-ambiguous-ref.sh redirect two invocations of
"git checkout" to files "stdout" and "stderr".  Several assertions are
made using file "stderr".  File "stdout", however, is unused.

Don't redirect standard output of "git checkout" to file "stdout" in
t2019-checkout-ambiguous-ref.sh to avoid creating unnecessary files.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t2019-checkout-ambiguous-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 2c8c926b4d..9540588664 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup ambiguous refs' '
 '
 
 test_expect_success 'checkout ambiguous ref succeeds' '
-	git checkout ambiguity >stdout 2>stderr
+	git checkout ambiguity 2>stderr
 '
 
 test_expect_success 'checkout produces ambiguity warning' '
@@ -37,7 +37,7 @@ test_expect_success 'checkout reports switch to branch' '
 '
 
 test_expect_success 'checkout vague ref succeeds' '
-	git checkout vagueness >stdout 2>stderr &&
+	git checkout vagueness 2>stderr &&
 	test_set_prereq VAGUENESS_SUCCESS
 '
 
-- 
2.40.0

