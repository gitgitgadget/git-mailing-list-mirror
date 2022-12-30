Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F8C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiL3CTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiL3CSv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06617422
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so48641504eji.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr1Rsly295TTDRzmr/4QKVtou++xrIda0Uwrmqg/FnI=;
        b=qY6V58ZRZ15jOqMVwfOU5M2TKzm/oynKl2lRUwBE84AeLY2lxaLOPk6bd6aMJXj6aK
         CBbdkJiCK9BCQ8HX0L0ZjE2XLoHmQ/9icezqIgKHr8RbqJiQCubOq6irM3Ei7KlHr0OP
         xFNICAn35FeUkhNqn49MdxS1uBS7HHjqq5YXVsP6wqWx/T4W4qQezktRMKFMzcPCiJjk
         5lINMNhWTR9OsxHUCW1kqVaTITn9//2sKQPJQftnG+ZDrkw5HgZr5mVSDGfKFA5wnpR9
         IxEFg1EfmhHmtB5X03nj6pzH3CggtsMWwNJJ0lBdpejD89aoz4OG71AqLYXMtXBAl9vV
         EnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr1Rsly295TTDRzmr/4QKVtou++xrIda0Uwrmqg/FnI=;
        b=x0n/fCKU8DY4HhEGKXH4PU68N3EKLu0qXe4UNiNjs99O7bP3aVAebeHwWhrMTJo7lZ
         DfvrmH71JTF9CYnyTkwNXaBH75HIDwMyOXy0yYLnMCWITo8nRW3EZVdF9XyQawxhqluN
         8StKGQ6zp2a+b85CAlMvvYMowVJbsGcIZ+TZ3NiXnBCV0pSYkSvc3iujF2BGsAbVMOFn
         VGG2CVi2qD0ywFrsccVsfvHOu0N07Y26D13i4lpOWLG8oLanmQq5cIiMvuv3Hvxue3jh
         it6hddGgjPGaGEz6Pn6c71L11W8xAWvjY9bMjlT9n25zZVHznd4UbQ+CGQnhqYxUNzdW
         6Zjw==
X-Gm-Message-State: AFqh2kqKdTv1EFt/6vIyRLSVB6wLhabBbJxi+sc9pWsSkLlLvxSb9X7Y
        6I6ntVEG4u/ummZO0aC4GCs704MKQc7G4g==
X-Google-Smtp-Source: AMrXdXv1odsR3jWtxGCOB9mZLFGGTisbhTFxQuzOTpftlCP+szT7FLd0sJ9BEMZxG3vP7SnDvzULSw==
X-Received: by 2002:a17:907:d109:b0:818:3f54:8df7 with SMTP id uy9-20020a170907d10900b008183f548df7mr34278708ejc.2.1672366728411;
        Thu, 29 Dec 2022 18:18:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/20] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Fri, 30 Dec 2022 03:18:25 +0100
Message-Id: <patch-v2-10.20-fd34c4817f4-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc

