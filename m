Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63234C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396C5610C7
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhHZDTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 23:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZDTO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 23:19:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5DC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:18:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m21so1802255qkm.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQLZBL0TmYc9ZKmCmgHKMtDCl0sSYs9HeZhdIOUM9GM=;
        b=EZ8ZWd7ZqtZ+88NLjSZlSOkuolZ40EzNQhfI1EvLEHX2d6/czWsVLBGeyRIsS4l9mI
         7APYyq0E+HErkeZqCJwZJDEF43yWLftebvYJ8XzybQ+UbE4tYBrFbVHAM89akFv61y/Y
         vD0yZHrdXc/OWSdd1WJ/txoqgfP2oO/0YElyYsY3o4JGDQbhpHEOfxtcoRt7lrYZwUtk
         6zPl+yOxZ5NgG7ydKgUoR+0d/7SsVzGei48qC5RYCU5EBxAgB29sS/BRYzNQZlXSiIGP
         TRWiRLX8s1v9KN3W+BWQ1J81+MD9D7JBNTrcZGCBCGEDjxOK+ykSYli/AzYpDjeMKs7k
         Ifkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQLZBL0TmYc9ZKmCmgHKMtDCl0sSYs9HeZhdIOUM9GM=;
        b=gTGxefMSWiRlKTg+3XjKigMZdfHmmPm9RFZgG9RzKMuUIeee8W2CGO0OLIici4Epxs
         8eJWcbN2u3768H9tDSKZ9AC9U2N81+5rthl/JvJIkrUMndHTa0i0OBlleptjFlFxh2Sb
         9tV0m3p+thjgMRHjZnRTOU/vJ61Cn6R+1GcgC8SbmYkuG9w7Mmaq7H9doSKdU6FyOg0R
         KmGM5svX+9c2XnxwGZpCgfDl+kY6CNy6bw/b+cGsWqGY+xGZnso3Ae+XTqD70a8I7UNT
         RBfiN1Vaad23vsp4J5oJvD8TcLuuRefHM89gNlWUE11nGWJ8vNOkcIMMd+Ls6eywS0ji
         5glg==
X-Gm-Message-State: AOAM5321kdPrSKqEJWwTO0h+GcqDYA0EctJek6LpRuws3736HWV8Sw/O
        Z+XDD58QzRYefCNmSnwXLWumkrkKY6E=
X-Google-Smtp-Source: ABdhPJxnSV6/qx+KH7JuDa/KWGGkQcA3uNmj6JWauSfMfNIeg7w55k3VWBBbbAyH9C0CHKbFgDRNQQ==
X-Received: by 2002:a37:453:: with SMTP id 80mr1712112qke.397.1629947906605;
        Wed, 25 Aug 2021 20:18:26 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v10sm1475978qkj.79.2021.08.25.20.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Aug 2021 20:18:26 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Jens.Lehmann@web.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] test-lib-functions: avoid non POSIX ERE in test_dir_is_empty()
Date:   Wed, 25 Aug 2021 20:17:10 -0700
Message-Id: <20210826031710.32980-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

0be7d9b73d (test-lib: add test_dir_is_empty(), 2014-06-19) uses an
ERE through the egrep tool (which is not POSIX) using an ? operator
that isn't either.

replace invocation with two equivalent simpler BRE instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75..2803c97df3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -790,7 +790,7 @@ test_path_exists () {
 test_dir_is_empty () {
 	test "$#" -ne 1 && BUG "1 param"
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test -n "$(ls -a1 "$1" | grep -v '^\.$' | grep -v '^\.\.$')"
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.33.0.481.g26d3bed244

