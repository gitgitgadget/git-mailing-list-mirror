Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC5C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B78615A2
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351530AbhJABjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351503AbhJABju (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 21:39:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76CBC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so5251967plz.13
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aixAOXBJJ5fKizWpV+Cy+SxgD/6vyTKaWdagEmFZu8=;
        b=dO5Ky8Srrfw3OZ0CtQJI4cVRqfAga/ZeqL3eOdXaQN6Jrf3Yf2fh0shYDn8hqxfIQs
         8/odfLZgjSXwx2+wCjky2NXATzes28QitCuMX++LWH9LpBn9QPgTAIATDNbXspsQxkl+
         rvnypIQ44EdKH/cZ+6Im7n9FCwlGRolUhlbnHE1dgm282yVJnoBR2RKhz70b6Eh5ipwR
         hq1P9EJ9teqE4NH8efbA+8pHUF9x924S01JKOqBEVVKLLCzmdFprpqII7QN4tAPW5Xzc
         J4mLVw2PCg87ZJvVvoOS1orQKN56CmifiGjMTp24LAUMaElXN+VOW+5UbsEpzrvtZLHw
         mI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aixAOXBJJ5fKizWpV+Cy+SxgD/6vyTKaWdagEmFZu8=;
        b=BdtowqHQ0yEfi2SZ8LfnZDPbM16povtJbjkzI2UvwEQYN0OuhH4xqNYT0cg1gRlJ85
         aqDM9XboqDVL1tlTJ1V0ddEtdLKVc/hunTT02Nlztl+Fr+rpvkwvJdQBenqp18RwUMby
         dEli/ymfOB0igeD7xMDwiOpp7X/1b31i0HWaN0N8KY4wU3odYzHShss5slBPTUX+gSuD
         SQcvAhnWN7xZuuAeGrGBwzj3VOQrCIkfej4PqkZKZAHfb2a+uJaoTpPlbH3xCvqOKNYY
         ohFv45jshRcyy33CRTJfIqr36b5EV3sY6Qoe3tLP85odkh62SvIT2WnYPCFjJDHc4iUa
         SX0w==
X-Gm-Message-State: AOAM532NeM4S+up7jEt9Lcuz7k2sIyPnKkFWwFIzbM+j3yXx84NgMn0J
        mEdz3wtyklZfTy/wKzKXEPfVeKEwzP8=
X-Google-Smtp-Source: ABdhPJwzOqVQM4RSSBEjMVI6vTHqn8sp8V99i7sX6gBLEIEBa37Tu0UCFukVgngi35ZIPVFTiU5+xg==
X-Received: by 2002:a17:902:ab43:b0:13e:6f69:d34d with SMTP id ij3-20020a170902ab4300b0013e6f69d34dmr5482424plb.33.1633052286948;
        Thu, 30 Sep 2021 18:38:06 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id c25sm4268199pfn.159.2021.09.30.18.38.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 18:38:06 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 4/4] difftool: add a missing space to the run_dir_diff() comments
Date:   Thu, 30 Sep 2021 18:37:56 -0700
Message-Id: <20211001013756.37586-5-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.886.g5b6dfe5e5c
In-Reply-To: <20211001013756.37586-1-davvid@gmail.com>
References: <20211001013756.37586-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 437474fea0..4931c10845 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -558,7 +558,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	/*
-	 * Symbolic links require special treatment.The standard "git diff"
+	 * Symbolic links require special treatment. The standard "git diff"
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-- 
2.33.0.886.g5b6dfe5e5c

