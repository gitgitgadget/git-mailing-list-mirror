Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299DC43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDBA2076E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjXcWKQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIUKk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgIUKkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74246C0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so12081018wmj.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIpGu/BlZhK1UMQoCY7S/TRXIzisxVp5wrWe1HQx4ac=;
        b=ZjXcWKQikTVcVBQ+k3m9zbo2vBGAqlCQoTWaDRYWhZ4j0si4kICuqMOaMWaXg3U+zb
         VSSWHtaU/2QtBk2VWKt0E/AFOvD6tE96nT7pL+F9VGLJ/Ww1CMlLiubXyNshbhtBCUR8
         T8oEMNra8kr2uwFfR+NC6LM1L9iRAyNIuUYaXJQp6CpDFL9vonR5Ri/JjEZt+mXhKlrw
         +hP+MAxf4pWHLU+mR6HqNWwK644Uwry3rphwHINTLSj/dInmQpi1DKKE8cmIemAoR0Vf
         +Y8rka86X0ZZ42RiYHTL5UBZmw5yC27KVSxZT8xFF/8npIwPR75SdpgN3devIfr7yKbA
         Im1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIpGu/BlZhK1UMQoCY7S/TRXIzisxVp5wrWe1HQx4ac=;
        b=D653pTqrCaPTJqwqQaxKEUMheAmvljw6efUu1BNO055E7TUzRQsN8Idu9cmuAf2fUr
         uYNtkrtuypA7RgULbgzDcPYrnwiisenJeRyzroK6nvemww9kuhkTXfvpk7dnHpb2QFiZ
         qaZFFBIKvL+69rHv1TRsbl/5T0E9q0CqH0xg5xWJ6qv5F19x5F+kOVEzwK7eo/TRIMYn
         pdGhtJZ+SqBRlyjJfQMFohfLEsjuJUAOPLiDuASPn3WaSoGlwbMDyIbnqXbEGR/Hy+hM
         libGnyZ5ILBvgkGVnrQXeSu06klhFP8S1NDN0naP6JIiQssMkHGALxyJZuJrOZMUEIVh
         /lEA==
X-Gm-Message-State: AOAM532hgoQEO88iZO5T0jGev+9cHvtY2Nuq7keTOQTUHr7fDRD9qLpR
        bXVUK1CHknYk4zPGtH0oGcC0boJHg9n2QA==
X-Google-Smtp-Source: ABdhPJwN/+TbwHDXnuYoJj8IjgGDbrgYNcsBTGfK+zUFkUloF2yPBqG478FKR0faWMp7KGt1lhTOyg==
X-Received: by 2002:a1c:488:: with SMTP id 130mr23112545wme.164.1600684819974;
        Mon, 21 Sep 2020 03:40:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/18] remote-mediawiki tests: use a 10 character password
Date:   Mon, 21 Sep 2020 12:39:47 +0200
Message-Id: <20200921104000.2304-6-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In more recent versions of MediaWiki this is a requirement, e.g. the
current stable version of 1.32.2.

The web installer now refuses our old 9 character password, the
command-line one (will be used in a subsequent change) will accept it,
but trying to use it in the web UI will emit an error asking the user
to reset the password. Let's use a password that'll just work and
allow us to log in as the admin user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index b6fb0b3993..3ab56c7165 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -3,7 +3,7 @@ WIKI_DIR_NAME=wiki
 
 # Login and password of the wiki's admin
 WIKI_ADMIN=WikiAdmin
-WIKI_PASSW=AdminPass
+WIKI_PASSW=AdminPass1
 
 # Address of the web server
 SERVER_ADDR=localhost
-- 
2.28.0.297.g1956fa8f8d

