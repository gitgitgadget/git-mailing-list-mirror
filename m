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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB6C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8164061076
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhFPOSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhFPOSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816AC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c9so2890635wrt.5
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8W1wC6kB9+MgUxQnjMREBVFkhtrduzY/fVU4ybz4Lw8=;
        b=UqGp5zVzA8DtNEb6b4JxrQWy+p1HMxtZ8BgxZzVcAMvaun1FnrA8uo+y2SnhsszgAr
         x+tf3CruR5gJfrr6/7GsehskKNlsC8nGvgmJJVS2sJsiC2dFjf4+raUldYOUhllBXdZA
         JTbsGHKqVfBZtv/ny4zxGg7cl0eBfQpQXNC5GnymmDlgstQKeEIxm4Wyy3lzzThIzkQE
         /xl+B6banMKZG1Org7e/J7hBmP1wqGjS6TUr2TOHXER+BBwn6pRAoJfntJp4qQBPsuAy
         zbt1aCHdOJZaoYimbJJbVin3rqco9ooxbtAuxRNwQpr8WwcMbHGJeDCVmIHQL1kU6ZfR
         HJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8W1wC6kB9+MgUxQnjMREBVFkhtrduzY/fVU4ybz4Lw8=;
        b=GdQHubneQtWVk7x+z5I4KmvbzLFx9rEQhSsQHWYS8SWVdAA0qbVNMTRoCP9PEeHQBn
         XOFiFyLhUB5yVVbcbD53kX7TLnBDD87oIkQiI6CwHE4WYb+78afFwgUWU4KDhFQ3R+Ib
         1M45ILXGbqscHzYlK+13hLYrhNxuEmxxYi5RsJQaazYJtOuBVazoXPCqgJkD9HmaQpAw
         wQKceHzHXyMsKAo2kTWauOCvidSr4m2WKDOVgtpuFU09nY68gFQ3kIUAbqy8tk7tacU6
         lNOJr8H32iMtLHFj3lQ2MkwkpReNtbVoBujO3wauDRAJlESqdD4G6K4v+Gx75knZy9j+
         JKBQ==
X-Gm-Message-State: AOAM533si8uKS9fxX+p03xXCW++Ey8fmkEgqsJtxJuwRTKX35ccmJgUa
        h4roSpLE6QrRhLMyxLB2YkKYpWEqJtMNSQ==
X-Google-Smtp-Source: ABdhPJxUWMJqvuMnvp+WoHqCAQEdMgbJ9WaXvxEywK9BSdfBSidQq4uc3ROgLtPSgWSIwDV0B/zSPw==
X-Received: by 2002:adf:bd88:: with SMTP id l8mr5688771wrh.90.1623852990182;
        Wed, 16 Jun 2021 07:16:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm2258555wrv.37.2021.06.16.07.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:16:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] serve: mark has_capability() as static
Date:   Wed, 16 Jun 2021 16:16:17 +0200
Message-Id: <patch-1.5-4f74d7d34c4-20210616T141332Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The has_capability() function introduced in ed10cb952d3 (serve:
introduce git-serve, 2018-03-15) has never been used anywhere except
serve.c, so let's mark it as static.

It was later changed from "extern" in 554544276a6 (*.[ch]: remove
extern from function declarations using spatch, 2019-04-29), but we
could have simply marked it as "static" instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 4 ++--
 serve.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/serve.c b/serve.c
index aa8209f147e..6748c590b74 100644
--- a/serve.c
+++ b/serve.c
@@ -156,8 +156,8 @@ static int is_command(const char *key, struct protocol_capability **command)
 	return 0;
 }
 
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value)
+static int has_capability(const struct strvec *keys, const char *capability,
+			  const char **value)
 {
 	int i;
 	for (i = 0; i < keys->nr; i++) {
diff --git a/serve.h b/serve.h
index fc2683e24d3..b31dd69434b 100644
--- a/serve.h
+++ b/serve.h
@@ -2,9 +2,6 @@
 #define SERVE_H
 
 struct strvec;
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value);
-
 struct serve_options {
 	unsigned advertise_capabilities;
 	unsigned stateless_rpc;
-- 
2.32.0.576.g59759b6ca7d

