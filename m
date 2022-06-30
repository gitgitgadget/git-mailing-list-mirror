Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C8C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiF3SAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiF3SAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678829813
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f190so11539090wma.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSjgEpJpS1hCTwXFyzvEJZom7E1w/0RxXe0G9lCTwEs=;
        b=b0C4vr5z4Vb3k0oDmEpbYZCL4wx9rCc6KnCOQFa/wfIjIWT0nDeNRO3yc62hUaqp3y
         kHxuhX2HkZy1y2/0p4gBE3mbMV+ETKLAkhJRL/skMJ5B7fdDzPTvSW+usInUplPFdtxt
         Wc0u2zWD4ZVtHaZGshtsP5w5CdTpPt0IUpAJj+c3uSh2jsvugfJQKVZ6HletTyGWbxJP
         g75mdmbHOSXQyDxGCJyYCKWXRV7qZI+thBZOcFfXqIjp9ewlF3SW8JksUqBbKhtxNwVX
         EUbo3PUiI6xbMuyWYLMSwT9+0xSBY9yXCd/ejzIlIP28vBHWAP0hthlMR8WcuCUI3ibT
         Og0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSjgEpJpS1hCTwXFyzvEJZom7E1w/0RxXe0G9lCTwEs=;
        b=qQHMrvY3F5JDxyesftnCHOE6mC8VCrsqF+e4pKrWW5CfMMRRD+0OoAXwJT13OFY7wJ
         bI0jvl29NAwUbgzFL2fCUg7v+/s+IHrGxkTrUrBbRdTdoFyPHxN2T6RkmXjqinOzpbeQ
         tAOieOSi4kj3Rb/JEhvzhwO6RcgKv8BirzT6mOZyI+Z20IulDT2jGBp6ZIvodciaUChi
         p/IVObpE4lnqm0W5y4hkPWcnJogXyEi8X2JjPeQ7ip9yGPjqn8f+nVoGP6Y/HRv78MTY
         RJ8TRL+KyBn1qQycKsamZM48GfydEMjlVd6IPlZR9KIcspff3u4+a/eYewBDs/7gP1+y
         DIIQ==
X-Gm-Message-State: AJIora+jvLaUuVNN1dk1bfNfsYC/MBIjjaJ6v0pJFlO+TQC9c/TNkOg6
        XRDxbA4GaXjQGTzNqjcLjMkCD5/Erbt7aQ==
X-Google-Smtp-Source: AGRyM1spUFQ6jDr02rE54Gytz9Mjho5+BJ1BTVdf67CtORdB2UzFZJWotOMUB1d2KldRS5auT9lszA==
X-Received: by 2002:a05:600c:1d0b:b0:3a0:3ab8:924 with SMTP id l11-20020a05600c1d0b00b003a03ab80924mr11294182wms.137.1656612027441;
        Thu, 30 Jun 2022 11:00:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/11] submodule.c: free() memory from xgetcwd()
Date:   Thu, 30 Jun 2022 20:00:13 +0200
Message-Id: <patch-03.11-a687d1281f8-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in bf0231c6614 (rev-parse: add
--show-superproject-working-tree, 2017-03-08), we should never have
made the result of xgetcwd() a "const char *", as we return a
strbuf_detach()'d value. Let's fix that and free() it when we're done
with it.

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
e.g. "t/t1500-rev-parse.sh" now gets closer to passing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 4e299f578f9..06073b2e7be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2388,7 +2388,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
-	const char *cwd = xgetcwd();
+	char *cwd = xgetcwd();
 	int ret = 0;
 	const char *subpath;
 	int code;
@@ -2451,6 +2451,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 		ret = 1;
 		free(super_wt);
 	}
+	free(cwd);
 	strbuf_release(&sb);
 
 	code = finish_command(&cp);
-- 
2.37.0.874.g7d3439f13c4

