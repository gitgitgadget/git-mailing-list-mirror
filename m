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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EBAC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A85220835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE+HKBkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfK0TxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41143 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfK0TxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id l26so1315310pgb.8
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8wt0iElzEdlUVR3u3fJA/vaW3ImQKr4auWa7LRPo7c=;
        b=YE+HKBkzB93REg5U3doRq1ynKzvjVNRQiTPrh2XIjcYjnm5L6/8x/Yf9thmz2VLpCY
         IOZMzrkMI1iRq972z4r9M6kgN/YM3WjffkTX3Vg6kmNwOtvKcrqu8D/T5M5GsX/edkdq
         ZJ5lc9Oycfwa/RLvcZXg0MdIPhSvaw3dNFRs8RGNDjPTf/HgbsxAz58GybktLNOF9Xot
         7kQX5xfQ81PPWhFGbRvP8U+KxwUhqFHOQ9DagDAjAU15RwQ1HAUeRhfRJ623RrneADN1
         QJ3LVdsdURaNIn0hMAuJrdBixM+BYUI4Nllg46OimRp6r0uBIO70Jm04Cp4J6JGN9wsw
         s8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8wt0iElzEdlUVR3u3fJA/vaW3ImQKr4auWa7LRPo7c=;
        b=X8vmlpbK6Xret8e8/kzOYGmxy8Z1QdbGfh0RWh4Kh+xCTB/vTIA6G8X3LOUZF4hn3o
         svi7aomXYiUeRwvYpzK+qYcqX4g44PKF6sO6r8KGFoOnrL8PQOdlKRH8yo5GM7i7rUva
         +dhu2fcmYezFMIemf37cK3h0Rmit5VodVkj/2sEL0Tc6rEy2yv1T5Tj/POvK29v4cYTf
         BGYIdOTDj0gk8pw/i2JdobNr3Zm0qVCzaWFKi3luInIJEBjmtilVao8GIG2wV32GrX1B
         klN48RjBNU44smvlZU+QuodLjmEKnwBHOt7PDbALF4pPDYcaFX6VQ4a/2nF94uyBMun0
         NvHA==
X-Gm-Message-State: APjAAAWfEsdiuegZfyc8rMD64MRB9pc8prfk6UsLDdEP/u8msgXTDSsI
        SfB0keEJgLKwx2axlsP6KNZYqOgu
X-Google-Smtp-Source: APXvYqxHsTBB9WzvWy5CuW8Hmlu8YcFOG6QvDHe3U/jtgl57YeJt1TJXxJ8ngjf2bMrExCvC9+dVvw==
X-Received: by 2002:a63:e647:: with SMTP id p7mr7098902pgj.47.1574884390985;
        Wed, 27 Nov 2019 11:53:10 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e8sm17519161pga.17.2019.11.27.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:10 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 03/26] t0014: remove git command upstream of pipe
Message-ID: <3844e00367de57ec09b1e3282280fd20dd807c0b.1574884302.git.liu.denton@gmail.com>
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

Before, the `git frotz` command would fail but its return code was
hidden since it was in the upstream of a pipe. Break the pipeline into
two commands so that the return code is no longer lost. Also, mark
`git frotz` with test_must_fail since it's supposed to fail.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0014-alias.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2694c81afd..8d3d9144c0 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -38,8 +38,8 @@ test_expect_success 'looping aliases - internal execution' '
 #'
 
 test_expect_success 'run-command formats empty args properly' '
-    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
-    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
+    test_must_fail env GIT_TRACE=1 git frotz a "" b " " c 2>actual.raw &&
+    sed -ne "/run_command:/s/.*trace: run_command: //p" actual.raw >actual &&
     echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
     test_cmp expect actual
 '
-- 
2.24.0.504.g3cd56eb17d

