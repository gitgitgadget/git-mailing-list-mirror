Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6327C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351136AbhK2Sbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378913AbhK2S3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:29:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A4C12B687
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso11094230wmh.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omNVKaLZbdtJh0YrwT3wapl+ckatKnbGSElTpWE9CBw=;
        b=AV3SH4b28NJdjCFQ0PmcbKfLd5vbkXL/hSJq2BIkYUaZNbJBvIspLJiDYSW05zw4FT
         ePuEgCUFiTtG5FDgTVE56OO9yh3hRbz939jyACQmMgrfu64pZh0aEKciGTnP2hatldJQ
         m7RIT4NJIWSHGwwwtuDKy4yfXnqRfvtIJ+jTWYArK2BcE8iUstx+MDCVpw7NlGacmYlA
         kC/wAvceMjsSTSzMkrdeH9tprXQ4rQz0PuJ3igOzqzHa+nvS4MZn4s13W6qj8lipjrNF
         532GW4uSr4uclxaVQSZdypmS2lDs/qpjBBIPk8lK2Bchd3sJQHCA1fVnN8TK/Cc5fcLT
         U9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omNVKaLZbdtJh0YrwT3wapl+ckatKnbGSElTpWE9CBw=;
        b=NGy/N+jpOgYTougYKmbOPpZ3twmjgza/fh8MmVnRsuu5cv2ge+kGkpSC6zlFfXfcPl
         Uki/D3ISTdwQYHu9ntq+Ey1y7Ynzudy8fmeYbuvT8FFgTQjFHIAg9rdZO9KvLuNiiv8h
         SProZN8y8TUYl3iPiMKfQWdjs+zNdV7weQYlkBXIiTvrUimAyTA81VWXx1epP1H0Uj3l
         c4to3fxrwU5MnRn/dwSU3iaUkIX4Y+d/ou30B/fb+GAPAnt/hDMmchQx0JNZ6l/LdOLx
         d6Has29h150zviXP6XXhHajq4JgsJtUTlfPpQdddfzgyeOft1ytgSw5rwa6ZwOqkHwkA
         9MBQ==
X-Gm-Message-State: AOAM530PGaBdtIuggtcdVqsSfijbbRPOcfnBevsi05oXRliit8jRSXSI
        z+v7XZbYv9kkgvsTopBqGtwGBCfKi53EKQ==
X-Google-Smtp-Source: ABdhPJxyQuB5gFRtsyQSbkvGKvAAokZLlERuCluz2qjyilX4k7DwhCnXkAUI7DZlIEFMV1uVXQsooA==
X-Received: by 2002:a05:600c:3227:: with SMTP id r39mr38854472wmp.120.1638197461172;
        Mon, 29 Nov 2021 06:51:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:51:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/7] grep.c: don't pass along NULL callback value
Date:   Mon, 29 Nov 2021 15:50:51 +0100
Message-Id: <patch-v3-5.7-2536eae2c32-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.34.1.841.gf15fb7e6f34

