Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9EC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiL3H2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiL3H21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E8718E02
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso11611317wms.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG4cljO9A+mkjB7FbMUFvgaidw60Uzkh3j9pfp/Ay9k=;
        b=BVugXgCnfp3o7lcq8EguVTbNtK4Jp3R+oQ0wZdzlbVI3lFIckhDJmDn0DGnAlDLPDz
         6cxt2Wev6FMCWw7C/UvC+qeAFUymWrafa/xbEMhchpnnsAAWIYFT10DKgv/5qFHeODAV
         3Gcopwz+Zc6+QIulAEvyagoAjA7ypWuJAIWVkftrBNjgpzBD1ucQUk6l8m1BEXf9lrO5
         WegaRrPHGTlkMSNPivWZQpUCxtQazAcbUB1RIXTZXwxv8nhea6xmt07b3/qJDdlsCwFL
         S3qHcPBhc0m8DxbCu9gDXYKrGk7VZLdkP1+u2TAe/cpPaMnALI1KkGuGnn9X7B2Kc+rP
         7wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG4cljO9A+mkjB7FbMUFvgaidw60Uzkh3j9pfp/Ay9k=;
        b=RHhnActJmDYWMkpOBXe4vG/V82J9oh+zsIvcfrRYKpZcw2EykNKqNQ3Zo0CYiE/qja
         Gr19tb0G/VDrA6r23UnPdBfUJ5J2LOQ+s5X6YERktRMyRyQwDCEPiRb4DI0JvKVV+Pn6
         4xHHpQyS6iQ9D4CGK0yyHhAoSCa36/CyR8E7qZwFKTQquZS5C0mrBDi+xebRQqp8reMI
         D9DUymyaOhOH6uRLjVnYiOYMkxxckeXGKfJroCyW4lXoFB/EVP/u6pbot/ijjCi/iEKb
         H6xr5lO9QKVvUWcFRQHIRfqVejhbllHPLZe8A2F2T4QX98BId1zHAxElE9BkIBZpUfSt
         4ukA==
X-Gm-Message-State: AFqh2krydMzuRnahlRHQi35lQstTaPK9XNItmMFb8HJHberGNA3Pc4aC
        43DqxISuwQ5/v184ci7X7o8Oy6kesKo6nA==
X-Google-Smtp-Source: AMrXdXuE6+AqZCDz8viY8dQfiptDtpeNxTBNsgq5c1XAt1sOvSLMHEEAmoF5p6+xUF0bDs0bMWRRIw==
X-Received: by 2002:a05:600c:a10:b0:3d2:2904:dfe9 with SMTP id z16-20020a05600c0a1000b003d22904dfe9mr25396787wmp.21.1672385305152;
        Thu, 29 Dec 2022 23:28:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] builtin/rebase.c: fix "options.onto_name" leak
Date:   Fri, 30 Dec 2022 08:28:12 +0100
Message-Id: <patch-07.10-484ebbfd6d1-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] we started saving away the earlier xstrdup()'d
"options.onto_name" assignment to free() it, but when [2] added this
"keep_base" branch it didn't free() the already assigned
"squash_onto_name" before re-assigning to "options.onto_name". Let's
do that, and fix the memory leak.

1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c                 | 3 ++-
 t/t3416-rebase-onto-threedots.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 91bf55be6e6..f7fd20d71c0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1658,7 +1658,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&buf, options.upstream_name);
 		strbuf_addstr(&buf, "...");
 		strbuf_addstr(&buf, branch_name);
-		options.onto_name = xstrdup(buf.buf);
+		free(squash_onto_name);
+		options.onto_name = squash_onto_name = xstrdup(buf.buf);
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index ea501f2b42b..f8c4ed78c9e 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -5,6 +5,7 @@ test_description='git rebase --onto A...B'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 
-- 
2.39.0.1153.g589e4efe9dc

