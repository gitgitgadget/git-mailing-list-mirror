Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512EFC61DB3
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjAJFpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjAJFoK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:10 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DA4102C
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ss4so18531230ejb.11
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwl1zo1cOqA+tv66p0BTwdfcbsxGzdoucTAVbabRV7k=;
        b=h7+g0N6cuAXuZA7lOKS1fRdH7+/ObD39teEvWRTp9nMllYqyh8nRBhju7RtuZaQju1
         9PHK7FfDH6wBKtCqov0SJV/OeAeL+An7BE7Iy+Dcz/QM39JI1ZTfWu2G3XaRqhOzhqGX
         e0oCzrwSfEIRiXrdWDCTvIKwxrj6sz0K+r2DLkdx1/Kq2gmuSv+JHf5yF8FS2hXvl7dZ
         bC+0T4o1phWvpJ5CFz3+qaUNM3zrJ8eMls0ZOvswGb0pbD5xCyRoq7HYm5HR+gnKtXp1
         gnSxCMaUeTXwm9L/ooC8yMP/qmKX7m6S46f+CXu5bIg/czpp9vK83M5KnDfxOaQGlHhA
         JtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwl1zo1cOqA+tv66p0BTwdfcbsxGzdoucTAVbabRV7k=;
        b=E0MGdEI/YxOiOD+JnOnlapka4AiJeUGWpI26t84I27EIJ+vYwsu+UTSQvW+F2CyUu1
         6pWwVtgiE8D/tSQPkdzK8gkCnIO4TzxUxT8MjWfOLShmzQye8+JUt+FOJOEhD4YLWbla
         wQbuTDEl2F5KhMObLdngpy7zLxAOBBzWYsXNiGuDZ5Y8qDq4k0WuCaREB529mBZLKrX9
         V2dg9Wwh7DkFZRiIqeH9V01PWhHxxxiMR6B32utC0wfXVR9+MubFrUmKFxxmgY18EdD0
         Mwelh00l9Q7rhWfgJDzOuXYRRe4MxP6Z1F+x9s0GqcLdymvLyUKBTnJF1MPblT8Km4mU
         KJPw==
X-Gm-Message-State: AFqh2koJ4KwpjVwMIKIkYdmVfIvabqa1oMWUClIOV1HYhLGQJn1dxmEl
        vR7KVC+ozRhNbu95aBPx8WqK/1afTAWsSw==
X-Google-Smtp-Source: AMrXdXvW5MjF7zn17RHEvDjPqBdRzKmY7YRGpJP5RvWR/G9G4oVImx2TXH+BZjoCPL4zh3JwpVH2MA==
X-Received: by 2002:a17:907:d387:b0:7c1:6fd3:1ef3 with SMTP id vh7-20020a170907d38700b007c16fd31ef3mr58066943ejc.33.1673329439732;
        Mon, 09 Jan 2023 21:43:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/19] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Tue, 10 Jan 2023 06:43:30 +0100
Message-Id: <patch-v3-10.19-5355e0fc60b-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since
2f4038ab337 (Git-aware CGI to provide dumb HTTP transport,
2009-10-30). In this case we're not calling regerror() after a failed
regexec(), and don't otherwise use "re" afterwards.

We can therefore simplify this code by calling regfree() right after
the regexec(). An alternative fix would be to add a regfree() to both
the "return" and "break" path in this for-loop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 67819d931ce..8ab58e55f85 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
 		struct service_cmd *c = &services[i];
 		regex_t re;
 		regmatch_t out[1];
+		int ret;
 
 		if (regcomp(&re, c->pattern, REG_EXTENDED))
 			die("Bogus regex in service table: %s", c->pattern);
-		if (!regexec(&re, dir, 1, out, 0)) {
+		ret = regexec(&re, dir, 1, out, 0);
+		regfree(&re);
+
+		if (!ret) {
 			size_t n;
 
 			if (strcmp(method, c->method))
@@ -774,7 +778,6 @@ int cmd_main(int argc, const char **argv)
 			dir[out[0].rm_so] = 0;
 			break;
 		}
-		regfree(&re);
 	}
 
 	if (!cmd)
-- 
2.39.0.1195.gabc92c078c4

