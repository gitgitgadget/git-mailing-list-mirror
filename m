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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAA1C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D3760F43
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbhIWQuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbhIWQt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D2C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 09:48:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u15so19010977wru.6
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6kEiGS1M07rMAryhLKiU3iGCWhpNvWuzAXUlmWPyk8=;
        b=Ab4S55+/C6O+59/aU6YvqV0VScIhO11M7W9mLbspA5yFPUCDxQ2mhafSNuIx9hTd2C
         whrx2GJzS/IMi3Jf9SxbMwumLWq3a3RH+yj9JuX+ppa3MQhHytVQ7/M+yX1WuXSKQlAT
         g8ErCfOeaXsbJHTy0soLu4NEH8N0KV1JiIngq+lkZHloWBMsUK2UYkayT5txAGmkPowD
         RKO9LYAuOosuHQcDD4ddyzEhGMvRkZO43taSHpX9Wo26YnYEFB8Y2A51FLuDqm7xHeZ3
         YbNNU7kOW6cSyT2g7Y1FEoFEKxufptR/cnhpIM1nbg856DyphEaJB4SjdZFZPUppG7Ff
         8V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6kEiGS1M07rMAryhLKiU3iGCWhpNvWuzAXUlmWPyk8=;
        b=QUmVqoJm230RpmTO0+IRL508LosDD1BnA6G4u5qoRXnOPMcJMX4bA+0RswIZIQmCNq
         Fllev0k3JmWPCZl2yyy6PRsluUdDjSQ6z/oKgY+pHna5FBKoQcYhhi9iYmddmXsuICTB
         SNiy/2l7ty/eiZCOMwx/Bx1WekNXFtF1CyTaeJvRIAE2zf1eaUjD9OFyU7zTzHS6cYfH
         T3PPPTIekjfLotiFJhCqrqZwJVbLNFa78H7OyFtY11gF2QMA/OiqihRnHRpll1IBh/dj
         w2Ip52RBiORV0xVZBx7AyR2JWTMba7ZTLYR+uqed8hu14Ug7OuvzkAmOZHYCz3G0x1At
         UW9Q==
X-Gm-Message-State: AOAM533RgQcYyl7SR7K2ofHU1TRgTXspI5GJZZWFOQXRkFj0MZk/F7rP
        zkSSblibXCD3gAZxqLqrIMQI3UgO8ks/NQ==
X-Google-Smtp-Source: ABdhPJypeVZrbTUpW/QxlQLsFFItxOUI4G4DZBnbYrRnV7Ln0Svo+czSX2/sw8uZ59BO9frx1UHm2A==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr6413081wrs.262.1632415705582;
        Thu, 23 Sep 2021 09:48:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j21sm6200598wmj.40.2021.09.23.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:48:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] bundle: remove ignored & undocumented "--verbose" flag
Date:   Thu, 23 Sep 2021 18:48:22 +0200
Message-Id: <patch-1.1-d61f4b28dfd-20210923T164636Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1231.g24d802460a8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 73c3253d75e (bundle: framework for options before bundle file,
2019-11-10) the "git bundle" command was refactored to use
parse_options(). In that refactoring it started understanding the
"--verbose" flag before the subcommand, e.g.:

    git bundle --verbose verify --quiet

However, nothing ever did anything with this "verbose" variable, and
the change wasn't documented. It appears to have been something that
escaped the lab, and wasn't flagged by reviewers at the time. Let's
just remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As a follow-up to the discussion at
https://lore.kernel.org/git/87zgs593ja.fsf@evledraar.gmail.com/ I
looked at whether any other subcommands accepted "git cmd [opts]
subcommand", here's another special-case we can safely remove.

Perhaps this was from an earlier version of
https://lore.kernel.org/git/20191110204126.30553-1-robbat2@gentoo.org/,
but I could not find v1 and v2.

 builtin/bundle.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 91975def2da..5a85d7cd0fe 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -39,8 +39,6 @@ static const char * const builtin_bundle_unbundle_usage[] = {
   NULL
 };
 
-static int verbose;
-
 static int parse_options_cmd_bundle(int argc,
 		const char **argv,
 		const char* prefix,
@@ -197,7 +195,6 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subcommand")),
 		OPT_END()
 	};
 	int result;
-- 
2.33.0.1229.g7e7cef8c419

