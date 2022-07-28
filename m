Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D3C19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiG1QRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiG1QRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2970E6E
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b26so2861074wrc.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IRSnY6Hhm44Uwnqul2VkTvmTPmCq/s3nb8V1FM3TYf4=;
        b=oZzcXzO/8C8kuMbSuk0Z1hqMGgUlKVJmCWSH4qcRuPlkaSd1QtY6KeYnVbiq9Uy+hF
         4WXG45hY83TS3zqQcEO+3Z5KgSc1oz+k2AB9RkPgga7PS4sFjKqs6U2du89ek/9ljtFF
         etN+1p/mBc4KpDpYywbwkmE5GC0+EfzFddZ6gw/lriPm6n48w5vgQZS8wthit8RdI6O0
         HH8QvoEfRe1STbKQD4fhNdPODmdZ3cOjBlNC5Tgvyx28kZ5EotQLWS/oMuLJiel+ci1i
         3z1p86PKpzaox5fUKob8NsqaxGgnEnodD18GOlz5mygqHSckEzRnaOcMAzwLaLraGRaK
         kuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IRSnY6Hhm44Uwnqul2VkTvmTPmCq/s3nb8V1FM3TYf4=;
        b=6rIAnzb3+KUFsWJttSLHQXFU1+7nFt/6T0zDUFyFRcDYJCz4duGcP3Wyv9uT09yxsx
         yPTIeb6fftQ+BaUzpZlC7Zu1QS1OrdgzHqZnaY8h3nLvV9Qa9TpaCMB6RetvY585KTF8
         BEV3Lxe+QnF+Ja3bQyFamVM5Vup8xLmvDNnwgclXrru92VOHz3OVe54bju4o1mED1ggI
         dmz783gc7f7TebmIVZcfY7Qq9XYp+f0CY/5uL6Vpbxo6VL5S/ssLnfdCyJJRbiQtZ5kw
         VPztBLbiXyNV6z5uaPCDM3idCCv6f67b1XoxzZjUj3uiUwEfxpiWEdZh8VmZZbFn81qT
         sBPA==
X-Gm-Message-State: AJIora+/tJw6WOwCAEqFh0+AmV/MS7F/CzLrCEpNWZaokhg+ATt39X9F
        7EAuz5hVkdWXEznJfs7HUwQMNQTP5zayHg==
X-Google-Smtp-Source: AGRyM1uSTwoPh6NtTwBEk9q4yAXJaPDIu1uxQWkc1B5XIuoQisWn70020PAbjnpFB2dGyeuCO2lRBQ==
X-Received: by 2002:a05:6000:717:b0:21e:a29e:b8b6 with SMTP id bs23-20020a056000071700b0021ea29eb8b6mr9153035wrb.164.1659025037352;
        Thu, 28 Jul 2022 09:17:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/20] test-tool submodule-config: remove unused "--url" handling
Date:   Thu, 28 Jul 2022 18:16:50 +0200
Message-Id: <patch-05.20-9fe8deb165a-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No test has used this "--url" parameter since the test code that made
use of it was removed in 32bc548329d (submodule-config: remove support
for overlaying repository config, 2017-08-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-submodule-config.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index e2692746dfd..22a41c40926 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -15,14 +15,11 @@ int cmd__submodule_config(int argc, const char **argv)
 {
 	const char **arg = argv;
 	int my_argc = argc;
-	int output_url = 0;
 	int lookup_name = 0;
 
 	arg++;
 	my_argc--;
 	while (arg[0] && starts_with(arg[0], "--")) {
-		if (!strcmp(arg[0], "--url"))
-			output_url = 1;
 		if (!strcmp(arg[0], "--name"))
 			lookup_name = 1;
 		arg++;
@@ -57,12 +54,8 @@ int cmd__submodule_config(int argc, const char **argv)
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
-		if (output_url)
-			printf("Submodule url: '%s' for path '%s'\n",
-					submodule->url, submodule->path);
-		else
-			printf("Submodule name: '%s' for path '%s'\n",
-					submodule->name, submodule->path);
+		printf("Submodule name: '%s' for path '%s'\n", submodule->name,
+		       submodule->path);
 
 		arg += 2;
 	}
-- 
2.37.1.1167.g38fda70d8c4

