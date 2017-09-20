Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CCF20A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdITTsH (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:48:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34010 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdITTsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:48:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id k20so2036153wre.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9GKSkKn7P2WmRLAFhIwXdIbfQ7mG+ddlNOGQ4ixpBY=;
        b=NXZ3/Wud+Z+xLr8AirVY+DpcwIOBAFY4X3E3gvVZtSYQ/Xe7C2jWwTtNebere11MsG
         mC4lAsxoybBbjMgLP2IWx3Iz48A8HaxdCjaegsRGpieHwh1kBChBRx13wXwlprwZGjWF
         LXCxg/UK1ciXZedPWWJF/mvjachs025N6FAZiHui8ncuNCevY+wofrQhWTc6UYxBrlF9
         ES0MNnjCCfMsNtTEq411R5GwaHk7kgNkkgoHWhlD715ENd4VwHfrTbT2sYM/Mn58mVYh
         JwuPNjAPpfpSFv7LNTDBh2gBU/szX+EDj9xCOqpduJHFy2GEF472Appfd8yl97a7cIm8
         VrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9GKSkKn7P2WmRLAFhIwXdIbfQ7mG+ddlNOGQ4ixpBY=;
        b=WGWEgW67//fZ5tDoYFuEN6mFdR/wT15pBnz3PH0LCxdgKdAmUm2S6gvYbWONs71NO8
         i0wCj4MRewd1y2ewuWh03E1DnSbxMaL25o1BaGPg5TuhK5fbUhbqbTXlPEugEV9ypr7O
         qMJilg2m4Ud/PW3tnYcKC4Bq7Z/yvH/P/PaRjqfhn1cSYraatUi6/oj+kBsJfzQ8lEEq
         0bJ9+FG8ElCH+b/R0u3HnPnAnXiUOWHOUXGSt+YgtBsF1tryHfmaxlJiP6vCYU667wGd
         EkN9mc0IF0RsKxw+BZS3BapAM8QQn4IApSCVLM2Hz9PNEsa4RXgn60z+59TvAu9fP+qR
         CeTA==
X-Gm-Message-State: AHPjjUjhusEs0YfHRSiBTC3VGMCXSoBW4pbpzURYf/euESP21vQ1OYnm
        kCjmqXLKtIb4Ryd2/wL1KbGzfSpE
X-Google-Smtp-Source: AOwi7QAICSa0nN3eAGzQ8o2QTVCL43jm0cwJGgr2MgOcd8IlwgQv3V5TB4/IxHXSUPwrXOpesPufOw==
X-Received: by 10.223.142.82 with SMTP id n76mr6022063wrb.272.1505936885618;
        Wed, 20 Sep 2017 12:48:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t141sm2419652wme.33.2017.09.20.12.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 12:48:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] diff-lib: clear `pending` object-array in `index_differs_from()`
Date:   Wed, 20 Sep 2017 21:47:24 +0200
Message-Id: <1505936846-2195-2-git-send-email-martin.agren@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of conditionally freeing `rev.pending.objects`, just call
`object_array_clear()` on `rev.pending`. This means we don't poke as
much into the implementation, which is already a good thing, but also
that we free the individual entries as well, thereby fixing a
memory-leak.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 diff-lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 2a52b07..4e0980c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -549,7 +549,6 @@ int index_differs_from(const char *def, int diff_flags,
 	rev.diffopt.flags |= diff_flags;
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
-	if (rev.pending.alloc)
-		free(rev.pending.objects);
+	object_array_clear(&rev.pending);
 	return (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0);
 }
-- 
2.14.1

