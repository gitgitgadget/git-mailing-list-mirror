Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F96C43331
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FF22573
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgLWBjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgLWBjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252AC0611CC
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i9so16990528wrc.4
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j82JwUF4yIJ7Sfl4xAp7BXn2r+ww8FfG5DI7sGGD7nA=;
        b=eQuwBYDbA4k8VZHOKch2HXjpEC4JzDWNh4OsnGgeuTxI56ssJ93irEvNlZ6+PCgJ+N
         /66uQfP9JTK9bQqwxfJJLY40773bz4KWWl0nKW1SWsnkcdrvnS0xqzFo8+xUEzfpRJlU
         FoFbT7q9hKqrxB5sdIE+Ns0dt0bNWDJIwJHySns86tAJz04idwq50Ajcncj98iRK4Iso
         UbnA3hMzErIp3HG3oB1a2MOpAHgJ2MTBIgyD8ECRLAq6PJMpHIOKY+OouVP+TsfAEzjv
         p0mSHNGDLT68hROxsDCSoBazO2Gx6rAzNHrlHZhvvKVtzZPG9AT6YdrQsRN4a5USIsYh
         Baqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j82JwUF4yIJ7Sfl4xAp7BXn2r+ww8FfG5DI7sGGD7nA=;
        b=MYUBzNIZ5K9x9C3l2QygYE6DhotCeLybhmMFc3J5djhaUMgv0cJq2VwsQVFaXof8Vi
         UyULiQPykkECMscplf8BYZblPjGmQzwMDAzr16MLRHS6w+9GYPyT0JaTyCgRgAfoZeBs
         jC+gUmRMPNPXpHIDqnmSVQ7oYK2BI8C74NPbtwcB00rZz9HHK4RoiQTzasRIGSkAiW0K
         P7cr7yrwNdfoioc5GP6NOG2QuBfmlqmEccnCIVnLCqMk+Q6S7m/FlE/Mz4ZRQcacNzf6
         gDhXsF7Z8LeM9jWw2x3bfls/uye9C54N23nb0iq5nJwjCZHHqszMApW+AVKdh/d60ih8
         1bgQ==
X-Gm-Message-State: AOAM531C35IAzV5HF7BXUMa6XSDyF6zc19nwJ5foDc4K+HWaEjPBBMfg
        2hBh4uvPybyL56nBMhQHcO7CzX3B/tDGFA==
X-Google-Smtp-Source: ABdhPJzMgt7VIJkfj7CRWPVL5ZSESZhmP+UuFLutGUaXawd+PzTcKeYtJLsH8aQU9eh4tYmOPx0kkA==
X-Received: by 2002:adf:e410:: with SMTP id g16mr27039427wrm.364.1608687474317;
        Tue, 22 Dec 2020 17:37:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/20] mktag: remove redundant braces in one-line body "if"
Date:   Wed, 23 Dec 2020 02:35:57 +0100
Message-Id: <20201223013606.7972-13-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This minor stylistic churn is usually something we'd avoid, but if we
don't do this then the file after changes in subsequent commits will
only have this minor style inconsistency, so let's change this while
we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index ff7ac8e0e5..97ca5f28b1 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,9 +161,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 0) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
-	}
 
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
-- 
2.29.2.222.g5d2a92d10f8

