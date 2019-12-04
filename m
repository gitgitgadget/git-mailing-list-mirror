Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D3C0044D
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D743720637
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIBOgq2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLDHr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:47:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38780 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:47:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id o8so2817505pls.5
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mcvSIFKED6eEr6cLl9VnEAcgMfrYd6ySclhfRxTwBA4=;
        b=AIBOgq2lBrPYsrDTtTaiEQrfhLciwYSb+XNUIpi3tLcAIB70xVTWTxrzl2sHbCRX3u
         yXz0YXlnKUFoHdycv46fRlzZZXmPx/HmvrnMbR8cwYFCE33wT9cnbiFvT0RoDR+Jigfr
         dMfyjMUI9T+beEpj1TZKH1a2maQ+x1iMPACG5mykttvz+lBOpX5JxHTJ+CRInnLzp32o
         1ngRyushz5dENHW3bQZCI6I7/VVeLj3jrrieqpA5s9hQGt4prUYq7XHSUvZKjRIMiFHW
         4B2j//B7v671oLEYyctrJ3SDDdGMw7gic/vDeOp3a8RAy0GGOSJXhoIObphrhmpPYNp8
         NObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcvSIFKED6eEr6cLl9VnEAcgMfrYd6ySclhfRxTwBA4=;
        b=ed8ybOujRkInUDYd9iOL0FfrziWUgV9nR8su8stSSPbAyDasbkS8uvJ6kDYvbuKYBf
         y+N8bES0mMsIaXI0rBORbRSDQ6t4KqpJM8Q0UPsZwF96wG+0TCehRVly8yVgdcLFrqTI
         7ob9d4VOq5m954DN6rbn/+AYZhWhZth59NL+LZGcwj7ESiVrF8QNZ2wxlfnDrn3ws/5N
         aEJwKW9YcKUVwDVxIJVXDHD/kR3BDvoxoA0JGW17pRw97syqOrm4c3tEiENwr3XihVRW
         rJ5/qLF8dADWeCPIBs7YqKCjmhVmnpr/OQy2/83otxbvuQnYAjdT1GjnDETd1N8o/owh
         8j3g==
X-Gm-Message-State: APjAAAXOwxiCd2ibqGzKyl/v56JDGiMBLa7LEXW/gdsek7SuxreC7lBr
        MHVWRrqbqiHEPZNGkYc8mo2dTfZF
X-Google-Smtp-Source: APXvYqyyBU1jlUUkilpujWkSpWFcu9h2svVy5kFeasCnd84aZG65XO7SFkuHL89x/Fcpej4AeBKHmg==
X-Received: by 2002:a17:902:7c0c:: with SMTP id x12mr2121288pll.239.1575445678592;
        Tue, 03 Dec 2019 23:47:58 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id y144sm7240937pfb.188.2019.12.03.23.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:47:58 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:47:56 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/5] t4014: use test_config()
Message-ID: <638c4add00657daa9b7a4fa50882053335d5caef.1575445583.git.liu.denton@gmail.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
 <cover.1575445582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575445582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually unsetting the config after the test case is done,
use test_config() to do it automatically. While we're at it, fix a typo
in a test case name.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 69267b16f0..c7cc643adf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1939,10 +1939,9 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	test_must_fail 	git format-patch --base=auto -1
 '
 
-test_expect_success 'format-patch format.useAutoBaseoption' '
-	test_when_finished "git config --unset format.useAutoBase" &&
+test_expect_success 'format-patch format.useAutoBase option' '
 	git checkout local &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse upstream >commit-id-base &&
@@ -1951,8 +1950,7 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 '
 
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
-	test_when_finished "git config --unset format.useAutoBase" &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse HEAD~1 >commit-id-base &&
-- 
2.24.0.578.g4820254054

