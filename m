Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8918C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBFXIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBFXI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849BA31E3F
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mc11so38696552ejb.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KNedtb+kcuqOHdIPhSqYUKAnp7PxCIkOe7K81k0HZg=;
        b=W3DZoXJGDgOyAQDuzUREQfP+Q5WObKmyG2AsA/gLf9tmKYpaDeci8tL0+a703EgT+L
         alDMcwlZTEFFjnyvrzDi5I+zF/eg4NC045i5unBoaE9lv/Fm2BgOlVGmt4JJkS0WaW0n
         f5KZEjMarCHv4oQ6RoC6A2nDXkSp8APZZW471OMXOV6287qMK1nmWUB+qxUajmXqC+VX
         zCCpQuqLSh1T8ynwk0lq9N72D+p7wjO66KW0tqT92a8Htm9oBLblFyvtiTmmIB4AWzCk
         KeEpE4jJTuZKmeIC82oCW0sevVspcxHkYzlLrt9vwy017zCkgU1YDPgXJwKrLmg1l5DY
         bpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KNedtb+kcuqOHdIPhSqYUKAnp7PxCIkOe7K81k0HZg=;
        b=bi21Y3f48M7F5gl+omIAW+vGaASAjJAJ9Ph5WrQP5ajrR68Vwu1DsLVZzB/e+aSfud
         OJFx3EuaPAwiTow/3o3I3e0ovW9MVX/WaCIC5ZEnoquNLaLbqgwSijbKwAnvBR9+SW5O
         81E+PIRPqt5yvEob7k6+0o/w01BZ9vmZF4+O7vWvV9+T+MlxAKMiWrntKQg0F16EDW7m
         JvcaGa82JWMQDgtgwVbpYPnqs8J+kewjTWkp8/JyCPNXQiYq7S6AXyrNZq1M37Khfjx3
         BaUGb1CRb7/l/B4LLATZCIfni0GjUp6q/qZ2/zWd/XOVTWSRX8lzk5BQJ0FUcy1v7znV
         86/Q==
X-Gm-Message-State: AO0yUKXmUV7AddrnuDADDc0YP7WQWmSZk3PLXjbisI/XEtZ8xylhg19d
        KKdLHIepSCyGpWIskU2w40/I/Rn2/ozpDAwm
X-Google-Smtp-Source: AK7set+GGbWDMmbgU7gWze7M18Rx5kjQDUdILCqgyIQQi47fvpi432/j62y1zyBER42Zbex0VXdK9g==
X-Received: by 2002:a17:906:2898:b0:886:9b85:ac5d with SMTP id o24-20020a170906289800b008869b85ac5dmr937635ejd.44.1675724899384;
        Mon, 06 Feb 2023 15:08:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 10/19] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Tue,  7 Feb 2023 00:07:45 +0100
Message-Id: <patch-v7-10.19-1d8088dec84-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

