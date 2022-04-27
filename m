Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A8C4332F
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 08:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359267AbiD0IHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359260AbiD0IHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99C15611A
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 01:04:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id o18so604465qtk.7
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pUZHfzEvuC9rP78GDVqEVs3oq27X6PyI/+BDWRZNt4=;
        b=NMg2ZuOvBTMA393Mv8cpILA0wcPwMsW/0RZUI7OnJVocTcIUmue+OAWjqd5XUGT+np
         Nge+0OlCFvHMZ4cFndOps1/71jGE/oIs2BaKUnbQSrbKNLp0xlbKqn2nZnlW6fFpY2Zf
         rjoSm9OpQkOhguj5Zic+DzRWkl0NEUc9y4VaXtjGCuW+r/yW+LHuqLf3zpehbRGHDA+D
         /cujYzme4GuV2l/y/aHaTEINVPiQtOqp1STfknQX1+W/qG7Xf4sOG/DuKxRMzR46Q6r3
         80sDHsCi6FdO/HbgJCH+8Zzg0Aa5QHTX6PM7FJp1yLuLzZBqrWWsUSaiEaUiMda0NCBP
         4Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pUZHfzEvuC9rP78GDVqEVs3oq27X6PyI/+BDWRZNt4=;
        b=Y8p2SNedo2YqQXsUnGYaIU+kxSVcZpjxRphtEIeouczeEdQHIK4MwIMS090/agqyMB
         ojV4Ewe+QXlPWPC8iWSmcGQ4U/xIk6oBwHhuVG2RF1TdShxIMkM5DF6G6GOhzEHR4vv6
         khTRaCnV12lrK8e/gSxmyAqP8XOBI0DJQkvYYYoZ7cUiM5oWlCwltmMPgRlu9j6H/28i
         JSZmNiLfGxYikepBJwd1/kXmHEmXQz3nPXbUAOOhEwgv2+G9HLBIMHlEHFcZIaepxyD7
         G8ASrFRqyI4tWp6fnV7grQ756LBH2rVfw0IY4D3wxRfvkjDtU6PmY958HmLZwE1iiDkS
         KRAA==
X-Gm-Message-State: AOAM531K9AadhScdwZco9ygD2KRbZ6h5L37Kj1Af36HVH+Pcutfnwlp2
        A5Fi31JuFgqSh/mG4T30XnJJDVmgcZnl1Q==
X-Google-Smtp-Source: ABdhPJxnKwDp8losOxAC4cRhsrt8ew/U6LvCNHebsQlvukHX/wa8i1s+vd5jTEHohiu2R6sPPSY2pA==
X-Received: by 2002:ac8:7f53:0:b0:2e0:77a0:1d35 with SMTP id g19-20020ac87f53000000b002e077a01d35mr17763644qtk.496.1651046666253;
        Wed, 27 Apr 2022 01:04:26 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h23-20020ac87777000000b002f3604761desm7419682qtu.35.2022.04.27.01.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2022 01:04:25 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     me@m28.io, derrickstolee@github.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] setup: avoid uninitialized use of is_safe in ensure_valid_ownership
Date:   Wed, 27 Apr 2022 01:04:12 -0700
Message-Id: <20220427080412.37766-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

8959555cee7 (setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02) adds this member as part of a newly created
structure that then gets initialized during the callback, but bb50ec3cc30
(setup: fix safe.directory key not being checked, 2022-04-13) add a
quick exit from the callback that avoids this initialization unless the
callback is called with the relevant key.

This leads to this variable not being initialized UNLESS the global config
has at least one key for safe.directory, so instead initialize it in the
caller.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index a7b36f3ffbf..17c7f5fc1dc 100644
--- a/setup.c
+++ b/setup.c
@@ -1122,7 +1122,7 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
 
 static int ensure_valid_ownership(const char *path)
 {
-	struct safe_directory_data data = { .path = path };
+	struct safe_directory_data data = { .path = path, .is_safe = 0 };
 
 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
 	    is_path_owned_by_current_user(path))
-- 
2.36.0.266.g59f845bde02

