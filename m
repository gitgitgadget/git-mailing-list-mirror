Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DEC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DC62082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJYnVLb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfK0Txc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35161 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfK0Txa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so2985863pgk.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZjQuhshmUTYkNjRds66IUkGFQ5n+5vfrrW8eCRBASk=;
        b=iJYnVLb96Y21h7oyfsJWf0PC+0e+D95bIoPYTKcu7usV+nctcL0XbOE4uuNUDE6ngd
         rwDKS6sT6z4BMVUjQwBEiC4//epuO2j75yW7HeyqDcTeDDY4GqF/vAvT2fPSfhew5EqE
         5mGygSyTUP2GEegzlbPvGHpGB5yKIQoRXYg22P998oplxzq1sRYzJA4PkODS3lzp1Jx+
         jbeKJIUf1Yi4G2zS86VYxy+47hmD4wqlZMshgsDymdHpLT7p+gz463cIc8ToeQHKvOmu
         sfUvigDZE18NdYatKuKmmNX+Of5DUqPcANGyv8kZwasoFlVulgFnpVl188+CBBJsikpk
         QICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZjQuhshmUTYkNjRds66IUkGFQ5n+5vfrrW8eCRBASk=;
        b=g2ILGHRdJ9jXHn3vkP6f9GSYUK+LFuJjxklczdqgnzAsV8zYFrO8WUzNpja2ZsprEU
         laLjvT9xKTroHFQkhD4qQmYh1gpkQBJPoR+P3AeeWazmoK3hNJgcED69BeO31SlbsWao
         jsqWKThDVlHgW6ND7vLm2aHBBrrg32y9Ne/aMHSzGZ8xx8xHwY/QOEIm1u3EqqyJwVeH
         R/m6bYturYg7/mc4i7jGEMKgo0i+1uTTWeTPlGPoqDtRmJe7T5NnoVFDRiVLObCZW5Yu
         hfyHzGYBWoGcyW9lfz6hNj7Uir9PfxF1CySrtMhLTyad2LJxEqeLtEgAlPZASrikCcUO
         6SyA==
X-Gm-Message-State: APjAAAVpyx5CUyGuv04NHPCBQt6uXIThD3J6lRaMo9wzewhg1qxao/dW
        y3NGnLVaYy0twS3rDHRQLyQW1M43
X-Google-Smtp-Source: APXvYqxM3B4NhuZfXvMSAS6vbRvxmYS1XGHGZUjg/3tmUa8FR/s9TKtBFVlMzs/6eEgHKPZ+q4d+EQ==
X-Received: by 2002:a63:a452:: with SMTP id c18mr6992080pgp.188.1574884408940;
        Wed, 27 Nov 2019 11:53:28 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e7sm17772561pfe.173.2019.11.27.11.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:28 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 10/26] t4015: use test_write_lines()
Message-ID: <a44dd28b4d22cf9dfbb9344d3184d5d0bd4ac1da.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of rolling our own method to write out some lines into a file,
use the existing test_write_lines().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 7fb83c8eff..4c540b1d70 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -771,9 +771,9 @@ test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
-	{ echo a; echo b; echo; echo; } >x &&
+	test_write_lines a b "" "" >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo; } >x &&
+	test_write_lines a "" "" "" "" >x &&
 	test_must_fail git diff --check >check &&
 	grep "new blank line" check
 '
-- 
2.24.0.504.g3cd56eb17d

