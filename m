Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275201F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfD3SZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:25:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41376 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfD3SZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7220939pgs.8
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tVOoScEQ6gBy1+cOusF/o3XZxMgCvYnqy4sXoGqZXY=;
        b=lJC//kujoccB+ouSrXIx3WGtnMiPbRTmoPNjdXaOhtIx9IxjJf5SfFeGDcdVPBy+Qf
         9dgIPiNub8Aa5GUqprCLljtco+WoVncipeugp8S8MiOmFOVqWAC85jK4XnGVfMVTyVkb
         UVYyHPHZjBsdhmW4tiKcMe0MXFX7dGonvAen2/AmUl8qPrO6+GnU19MyBtHE1wYhxWWZ
         VuNATn44A7gDmvbphBQ3hr+aeKqw2kZjjEpPBxUAF/e9RCkbxzATQuQNtLdz0jrZVsnl
         b95h2N67NjOKIrKFxuHfLxUFx8p5u95ll4SHcAU8jaW4IC+9otb8pe8X2BJ8KQKfCh0j
         WbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tVOoScEQ6gBy1+cOusF/o3XZxMgCvYnqy4sXoGqZXY=;
        b=BZvF5BxqG4BcUZ0lvjBuKf5TsbOY5Uddw1F7ri0WGvRaqABfiilxLRmF96qVhsTV4C
         az7nAYroFLPRhFlMC6ZHjSWqd5RGjj8HhlDHBIIbM+xXh5KixKubvuCrO6ZyYAPCrUOv
         6kcWW34mu2UkHIDq5pf3YU5OTiNoam4fEU7fLEf7Hlifm18Gi/d024fYrzffxq4ChiLk
         Tw+aE6pHpCFV/fwMgtzwAE6cDjbIEQjJ2F+U9RPG6hCcTuVSGnMQlPSWTvdRpYpY8MDA
         ljnQ2JO3BMOaFsdJAzp2192BE3SiUdD0WgEiQNknU9uQbqm6Or1ORA5cPamYoWO84dK/
         czgg==
X-Gm-Message-State: APjAAAXn6WRCNdA80sVXwD2Nqzq9GYUfvMbFJvDIJWQLH583soKyBH9u
        EhfJfwI8gpG+ezoGfwYOw3k=
X-Google-Smtp-Source: APXvYqz1NhsleuZjFq6A3rGGEYVrmRuj7mCyKYpzLAnGKxBF+L3GX86FwV958jSghItzZF//Qig8Vg==
X-Received: by 2002:a62:5f84:: with SMTP id t126mr72800229pfb.185.1556648734756;
        Tue, 30 Apr 2019 11:25:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p2sm111217508pfi.73.2019.04.30.11.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 11:25:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/5] fast-export: differentiate between explicitly utf-8 and implicitly utf-8
Date:   Tue, 30 Apr 2019 11:25:22 -0700
Message-Id: <20190430182523.3339-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g44aacb1a0b
In-Reply-To: <20190430182523.3339-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The find_encoding() function returned the encoding used by a commit
message, returning a default of git_commit_encoding (usually utf-8).
Although the current code does not differentiate between a commit which
explicitly requested utf-8 and one where we just assume utf-8 because no
encoding is set, it will become important when we try to preserve the
encoding header.  Since is_encoding_utf8() returns true when passed
NULL, we can just return NULL from find_encoding() instead of returning
git_commit_encoding.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7734a9f5a5..66331fa401 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -453,7 +453,7 @@ static const char *find_encoding(const char *begin, const char *end)
 	bol = memmem(begin, end ? end - begin : strlen(begin),
 		     needle, strlen(needle));
 	if (!bol)
-		return git_commit_encoding;
+		return NULL;
 	bol += strlen(needle);
 	eol = strchrnul(bol, '\n');
 	*eol = '\0';
-- 
2.21.0.782.g44aacb1a0b

