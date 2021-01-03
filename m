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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4473C433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4C207D0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbhACJio (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 04:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbhACJin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 04:38:43 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA317C0613D3
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 01:38:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so57647794lfg.10
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 01:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTsPTBuSCgGq6w0FtryVXQm3qWN5d7A8LdtMbVglqxM=;
        b=WpFVz/N8YBGOravPMYf0ynL9W7zV6R1yMvKjIDGXnQMNROztL+LyZhjkBBWaa11KXK
         obtn399Rj+8X81/xFYwJ9wNkBdIpLOtgm+GTvCE1Jo7EYBvxWJ3rluK9RoapgUOGKknO
         AU9zUSLTc9bcancj0J9iTy4W0Iw18UtMBGX71drAi1uHFo8CRDt/9BcFJmgGSAlEME2E
         a0UswGvbkZeSvDUvYZU0+crQyBDf5rNxiEV/nSyrBT4rZfrNWgIH+ucNUg7q1vJsvqcB
         ZmfNXFe2a5fLMAfvWNqDPxIcVHPsVS0ZcXPNULPXviCjH4pZHmXJl4d6C0bNzmjfbrYk
         XoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTsPTBuSCgGq6w0FtryVXQm3qWN5d7A8LdtMbVglqxM=;
        b=lQUPVwBIg5QRHFs3Fsjgl0YB13JgnCVmoUqAe2tITZJx/3iIpL+1Yybb9pd560NhGS
         9XeXVET4lVcibluEfm5WxAzzYvCaK9rSh/tFBtRPjN9bW5R+X0b3pGoLIoiDOPv0fQLg
         tz50h6wgKxxFhQdCeS57wE6Aw0UHonnr2vkG3rHnC577MhaRo2CdS1QsaNY6mxuWb2j4
         m/viwiWNVmZBSt4Pp4QBSFf7Hlt9QnWZOeu809HoCdJ2WWms4r4OVosWCpFj8GA9Eq5a
         VYPsph9dRaCS9zlD6tFNMQZSCrI+LFeqvOlGSKD/ShQqLu/YLLlkxJ8cLaF74ggGvbEx
         N+zA==
X-Gm-Message-State: AOAM532lSVi228eQRbvMhH73hgK3qE3pmYQDc9shNkRohywyUcEEKwzA
        gg0uWcU2mgJRWDXipo9/r5x6jWLbocw=
X-Google-Smtp-Source: ABdhPJwZKx4D7kzrspklHAF8lxEzQ+kshIU/F3nuenjwlxH5rXy4UcnweF6e+p34dDBD1gflHWhE7A==
X-Received: by 2002:a2e:91d9:: with SMTP id u25mr32214089ljg.79.1609666681043;
        Sun, 03 Jan 2021 01:38:01 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id h13sm7025202lfj.110.2021.01.03.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 01:38:00 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t1300: don't needlessly work with `core.foo` configs
Date:   Sun,  3 Jan 2021 10:36:48 +0100
Message-Id: <20210103093649.2221-4-martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103093649.2221-1-martin.agren@gmail.com>
References: <20210103093649.2221-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use various made-up config keys in the "core" section for no real
reason. Change them to work in the "section" section instead and be
careful to also change "cores" to "sections". Make sure to also catch
"Core", "CoReS" and similar.

There are a few instances that actually want to work with a real "core"
config such as `core.bare` or `core.editor`. After this, it's clearer
that they work with "core" for a reason.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1300-config.sh | 60 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 1439d870d6..1a4156c704 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -12,75 +12,75 @@ test_expect_success 'clear default config' '
 '
 
 cat > expect << EOF
-[core]
+[section]
 	penguin = little blue
 EOF
 test_expect_success 'initial' '
-	git config core.penguin "little blue" &&
+	git config section.penguin "little blue" &&
 	test_cmp expect .git/config
 '
 
 cat > expect << EOF
-[core]
+[section]
 	penguin = little blue
 	Movie = BadPhysics
 EOF
 test_expect_success 'mixed case' '
-	git config Core.Movie BadPhysics &&
+	git config Section.Movie BadPhysics &&
 	test_cmp expect .git/config
 '
 
 cat > expect << EOF
-[core]
+[section]
 	penguin = little blue
 	Movie = BadPhysics
-[Cores]
+[Sections]
 	WhatEver = Second
 EOF
 test_expect_success 'similar section' '
-	git config Cores.WhatEver Second &&
+	git config Sections.WhatEver Second &&
 	test_cmp expect .git/config
 '
 
 cat > expect << EOF
-[core]
+[section]
 	penguin = little blue
 	Movie = BadPhysics
 	UPPERCASE = true
-[Cores]
+[Sections]
 	WhatEver = Second
 EOF
 test_expect_success 'uppercase section' '
-	git config CORE.UPPERCASE true &&
+	git config SECTION.UPPERCASE true &&
 	test_cmp expect .git/config
 '
 
 test_expect_success 'replace with non-match' '
-	git config core.penguin kingpin !blue
+	git config section.penguin kingpin !blue
 '
 
 test_expect_success 'replace with non-match (actually matching)' '
-	git config core.penguin "very blue" !kingpin
+	git config section.penguin "very blue" !kingpin
 '
 
 cat > expect << EOF
-[core]
+[section]
 	penguin = very blue
 	Movie = BadPhysics
 	UPPERCASE = true
 	penguin = kingpin
-[Cores]
+[Sections]
 	WhatEver = Second
 EOF
 
 test_expect_success 'non-match result' 'test_cmp expect .git/config'
 
 test_expect_success 'find mixed-case key by canonical name' '
-	test_cmp_config Second cores.whatever
+	test_cmp_config Second sections.whatever
 '
 
 test_expect_success 'find mixed-case key by non-canonical name' '
-	test_cmp_config Second CoReS.WhAtEvEr
+	test_cmp_config Second SeCtIoNs.WhAtEvEr
 '
 
 test_expect_success 'subsections are not canonicalized by git-config' '
@@ -1057,12 +1057,12 @@ test_expect_success 'git -c "key=value" support' '
 	true
 	EOF
 	{
-		git -c core.name=value config core.name &&
+		git -c section.name=value config section.name &&
 		git -c foo.CamelCase=value config foo.camelcase &&
 		git -c foo.flag config --bool foo.flag
 	} >actual &&
 	test_cmp expect actual &&
-	test_must_fail git -c name=value config core.name
+	test_must_fail git -c name=value config section.name
 '
 
 # We just need a type-specifier here that cares about the
@@ -1107,7 +1107,7 @@ test_expect_success 'aliases can be CamelCased' '
 
 test_expect_success 'git -c does not split values on equals' '
 	echo "value with = in it" >expect &&
-	git -c core.foo="value with = in it" config core.foo >actual &&
+	git -c section.foo="value with = in it" config section.foo >actual &&
 	test_cmp expect actual
 '
 
@@ -1838,53 +1838,53 @@ do
 done
 
 cat >.git/config <<-\EOF &&
-[core]
+[section]
 foo = true
 number = 10
 big = 1M
 EOF
 
 test_expect_success 'identical modern --type specifiers are allowed' '
-	test_cmp_config 1048576 --type=int --type=int core.big
+	test_cmp_config 1048576 --type=int --type=int section.big
 '
 
 test_expect_success 'identical legacy --type specifiers are allowed' '
-	test_cmp_config 1048576 --int --int core.big
+	test_cmp_config 1048576 --int --int section.big
 '
 
 test_expect_success 'identical mixed --type specifiers are allowed' '
-	test_cmp_config 1048576 --int --type=int core.big
+	test_cmp_config 1048576 --int --type=int section.big
 '
 
 test_expect_success 'non-identical modern --type specifiers are not allowed' '
-	test_must_fail git config --type=int --type=bool core.big 2>error &&
+	test_must_fail git config --type=int --type=bool section.big 2>error &&
 	test_i18ngrep "only one type at a time" error
 '
 
 test_expect_success 'non-identical legacy --type specifiers are not allowed' '
-	test_must_fail git config --int --bool core.big 2>error &&
+	test_must_fail git config --int --bool section.big 2>error &&
 	test_i18ngrep "only one type at a time" error
 '
 
 test_expect_success 'non-identical mixed --type specifiers are not allowed' '
-	test_must_fail git config --type=int --bool core.big 2>error &&
+	test_must_fail git config --type=int --bool section.big 2>error &&
 	test_i18ngrep "only one type at a time" error
 '
 
 test_expect_success '--type allows valid type specifiers' '
-	test_cmp_config true  --type=bool core.foo
+	test_cmp_config true  --type=bool section.foo
 '
 
 test_expect_success '--no-type unsets type specifiers' '
-	test_cmp_config 10 --type=bool --no-type core.number
+	test_cmp_config 10 --type=bool --no-type section.number
 '
 
 test_expect_success 'unset type specifiers may be reset to conflicting ones' '
-	test_cmp_config 1048576 --type=bool --no-type --type=int core.big
+	test_cmp_config 1048576 --type=bool --no-type --type=int section.big
 '
 
 test_expect_success '--type rejects unknown specifiers' '
-	test_must_fail git config --type=nonsense core.foo 2>error &&
+	test_must_fail git config --type=nonsense section.foo 2>error &&
 	test_i18ngrep "unrecognized --type argument" error
 '
 
-- 
2.30.0

