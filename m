Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C92ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiIESua (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiIESuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D227CED
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 11:50:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so18691194ejy.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=61K8GDvz2r6pU8GbYTRiOQUnd/QhKTuHUZ2QZFEDIz8=;
        b=Kjtol8OV0qpDHtVB/SJ3IF47YCurE0Jo6pAKprJ/1BUoIbkxV4QGI7Vye4/WVymzyK
         K969xZ0DXgqRfrfitrOY//7eGsUgdjU/u1Xk8hQ1neUat8i8xPjVrxP+5YyZYYS77uL3
         ocSGDLci6NQim1NAIXVJuWhrxfDtRHjBnfbDC33exIJiyJIyHILZfv74Z1Rycy4/NAzD
         mX0eRarHj6+6ZL4nwOiNlw/124dLlWnoRFqxeIvVg/tckRxK/9OCYKnw+5TMfZmOSb4j
         n9CXreYK5DTJAGNpMELmRGEI9BgPUXCzjz/aZzvMLkh3EyCJhbPqEym1fxwY5lGdN/Xv
         1Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=61K8GDvz2r6pU8GbYTRiOQUnd/QhKTuHUZ2QZFEDIz8=;
        b=4i5WNG+j5D+2B1Jh3RmXj48UUORUAlZjL0CVl7JfwnnkzGTsJljCvhEMIbyRYf2KQu
         4pJKlTisbt3pyi6O3Yxhr1YkK4dELnB8e9uYUWbzbhPRQCOp1j1N7uww7Fz+Oqx/RjLK
         N8r1P3Mh20Zvd+cpCl6VI5d1ZJCWMIrtTFerCEMLT5FNNKoC6mgDcFWaoHSFSCu/W6UZ
         5Ke8bTJgzvIp6v9nWWIrzFz1II1CyWnjkKOgZGRMINNDj8W5VjqgVbTaA5vD5k5/n1fK
         5DP9OnSGnfZp9k3GwUxniGJ/Ea/V2MjpIdF4mjQMtkUiv3oGcXpFX6z8vfV6g16jcn8F
         whaQ==
X-Gm-Message-State: ACgBeo0VSuCoMO+yLaeqGJX7YKm+hmwbr61atlVMfaDnnxRzxsYpcez7
        YD0Z1ZsR7KCNyQV2KIpV7yxLQ7hUing=
X-Google-Smtp-Source: AA6agR6DH7g4TFDVoZFZDFMnJggZ/PBJO4HPe46A5ZY3/EhONaOEfQAD5+KniiTjLGE3rV3a65cSWQ==
X-Received: by 2002:a17:906:8462:b0:741:6003:71e4 with SMTP id hx2-20020a170906846200b00741600371e4mr29027562ejc.170.1662403818624;
        Mon, 05 Sep 2022 11:50:18 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id ky10-20020a170907778a00b0073d68d2fc29sm5339524ejc.218.2022.09.05.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:50:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] notes, remote: show unknown subcommands between `'
Date:   Mon,  5 Sep 2022 20:50:07 +0200
Message-Id: <20220905185007.9042-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.989.g4c3dfb3304
In-Reply-To: <20220905185007.9042-1-szeder.dev@gmail.com>
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220905185007.9042-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the "unknown subcommand" error message in 'git notes' and 'git
remote' to wrap the offending argument between `', to make it
consistent with the "unknown switch/option/subcommand" error messages
in parse-options.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/notes.c  | 2 +-
 builtin/remote.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 60410af572..be51f69225 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1017,7 +1017,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 	if (!fn) {
 		if (argc) {
-			error(_("unknown subcommand: %s"), argv[0]);
+			error(_("unknown subcommand: `%s'"), argv[0]);
 			usage_with_options(git_notes_usage, options);
 		}
 		fn = list;
diff --git a/builtin/remote.c b/builtin/remote.c
index 272c7b8d9e..07117e4c9a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1768,7 +1768,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		return !!fn(argc, argv, prefix);
 	} else {
 		if (argc) {
-			error(_("unknown subcommand: %s"), argv[0]);
+			error(_("unknown subcommand: `%s'"), argv[0]);
 			usage_with_options(builtin_remote_usage, options);
 		}
 		return !!show_all();
-- 
2.37.3.989.g4c3dfb3304

