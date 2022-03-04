Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF521C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiCDSd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiCDSdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558004667A
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u10so12285168wra.9
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zz2plPmu9z3ZtfTSGWVRImn5drZm2LyDPSizi5t8cwY=;
        b=njOk8MUkNKJY5EJ0piw8VTpUqLMno5EHhiJWF3n0PVN3HYslupd4scm+pC29eraAB9
         3TGscO9diO2lbzJOIq+FHM0RjgWonUuRwiyVavracSGvEhyOZypU7CaS+E3jD9gKKl46
         kEnzEAJ82dAgq0ix6ynxa3RU4BC8gNZMMySHljLh1jWre3k7GMpbPqAe7nAip8FIqllc
         qus2cSTqv/achg0Boo1FAIfHdFxdb7D2M29laSOf2X1AOkxlqDZ/T0XnOuTrMzpuKfeD
         +uLGl3UyF11FikTuSK4RCX3Fix9C1ySHwGwuWpaFWnMLNszG0LH65r1xOhx1WqBilo0O
         ThGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zz2plPmu9z3ZtfTSGWVRImn5drZm2LyDPSizi5t8cwY=;
        b=PjX2ac0rBAKB97wmG4WPsOeN0vmfJsVzCfg/QuB5d1+uxS6IPeTdjGa4f9OQwmO/jh
         J55db8vCqjwO5TQemqKKpsgm5Ivc0n3l38SKIAn/ppUgJaXLaN/41aX7EVUSjC/eXAB3
         ZiVxEf5vpWeVuNFW47TTI6FtxP/3qe1JvQLlZKm2oGHhPmXVrWe4Zwfh96mhmHnH0Nbx
         uZ7qQdgORW25b5WRT8dojPWvAWg2VTcuoTR7yVKj0kFn/xAk+fQzvAVvduQ3kBvGoQSS
         zFvmUi0Ra55NgNx90UjSIMY4scDEtGUligGeTPET8kbXJDCEIHcsVBowRBUam7JThN78
         n5Nw==
X-Gm-Message-State: AOAM533WXn/3HLOJKbaA+3VI3L/oCYPf0d6aoljvX9PfH6FGgrSfjh8k
        sisU9WyJlIgYkk9Jo35KrO2fW/p1mGWDcQ==
X-Google-Smtp-Source: ABdhPJxXEwbyC3ez08J9Xu39mIJ7eLwXQ4zm+b/ZVvDjsEZr/wSnyXW2F563g4BWZPzDhdiOg0D2pg==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr14395wrr.323.1646418745454;
        Fri, 04 Mar 2022 10:32:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/14] remote-curl.c: free memory in cmd_main()
Date:   Fri,  4 Mar 2022 19:32:08 +0100
Message-Id: <patch-v2-05.14-f0a26db8a87-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a trivial memory leak in code added in a2d725b7bdf (Use an
external program to implement fetching with curl, 2009-08-05).

To do this have the cmd_main() use a "goto cleanup" pattern, and to
return an error of 1 unless we can fall through to the http_cleanup()
at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote-curl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0dabef2dd7c..ff44f41011e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1472,11 +1472,12 @@ int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
+	int ret = 1;
 
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
-		return 1;
+		goto cleanup;
 	}
 
 	options.verbosity = 1;
@@ -1508,7 +1509,7 @@ int cmd_main(int argc, const char **argv)
 		if (strbuf_getline_lf(&buf, stdin) == EOF) {
 			if (ferror(stdin))
 				error(_("remote-curl: error reading command stream from git"));
-			return 1;
+			goto cleanup;
 		}
 		if (buf.len == 0)
 			break;
@@ -1556,12 +1557,15 @@ int cmd_main(int argc, const char **argv)
 				break;
 		} else {
 			error(_("remote-curl: unknown command '%s' from git"), buf.buf);
-			return 1;
+			goto cleanup;
 		}
 		strbuf_reset(&buf);
 	} while (1);
 
 	http_cleanup();
+	ret = 0;
+cleanup:
+	strbuf_release(&buf);
 
-	return 0;
+	return ret;
 }
-- 
2.35.1.1248.gb68c9165ad8

