Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3FC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCHJG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCHJGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:06:25 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F12CC40
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:05:40 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bk32so11629533oib.10
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GpzPz0w6EpCmi+izawBk7foJ8eQpkuXT8BzzRKit8sQ=;
        b=l82+xNWIXzNP1eDx3Tel+YQ01Zw9t+cJljF8kZoNYVKaWmQ9KlJbg3hs4t8yZpmleq
         /FT6Cbzf6PTBth7LauRRmSvujF96SKWqRxbmcwjQJRQM3818h8ahd5E5YUNEHtRvYP7r
         xCTe8DyvtIozGZW5xcof8dN8yQyWr6CXy/eUHCX2M/bUac0e8e2p9tK4I0LGfAbETzrd
         TW8BlYqjtg+VuvJtxd2ZqKm+ZsZ5xtxlMeg/NKOYzHd6WAntquAypYnDJ6mf+8WSThLM
         qy/sIAmQoNFO/a0+jvoPDKI/JQQve6hlcgmh5vr3auiUc/bZkuLIkU1aLon6x8MghQ1O
         o39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpzPz0w6EpCmi+izawBk7foJ8eQpkuXT8BzzRKit8sQ=;
        b=KpO6t+HkvyxmWlnzxEKeJeKlWMSlk0xkoRDqAvo/f/2Vl+lHES7QoEKgzp6vBMucMQ
         Mi3JKzI0Jp2Lc0NCknlNeNPYnTbNOKm97ChD9w9Qx0K0TABgqO7F3t5biso+LfQKckH/
         ZMOOjNtDJsdjHCiZZV8pHUs8l1t5XenXSuCQ2i3Lq60iEljvYVoqlliTTH1RlGTIpHJz
         CqP1wJq9jNWDHW1nKs3I/SQAAS4oLvU+e9eleDTVZMwHlcXVUoBHGc+xD8FZr2CswQef
         HIAn6fjp8n2Teo0K84A0l0Maj4bGb7z3mogfwAPcL9O1N5C3B+wP5VNiEImC/lZdv6BZ
         IZ2A==
X-Gm-Message-State: AO0yUKVjX9b4RZ/t5jPQTSTOtrf9x4bSakCKawZLCEZHiIPb1QSLcO+V
        rpcivlwu7+tEBazRr7yutlajEht3x4I=
X-Google-Smtp-Source: AK7set8+kyBVw5APShd6+CNTNEGoNtAGDpNByzkS9GM3iybZVtENA1PvEpSOTFyrpXaUwBLlwPPxNg==
X-Received: by 2002:a54:450d:0:b0:35a:d192:9a53 with SMTP id l13-20020a54450d000000b0035ad1929a53mr7323653oil.41.1678266337808;
        Wed, 08 Mar 2023 01:05:37 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f15-20020a056830204f00b00690e7b0f9e3sm3506403otp.34.2023.03.08.01.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:05:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: simplify counts aggregation
Date:   Wed,  8 Mar 2023 03:05:36 -0600
Message-Id: <20230308090536.2562917-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the list of files as input was implemented in 6508eedf67
(t/aggregate-results: accomodate systems with small max argument list
length, 2010-06-01), a much simpler solution wasn't considered.

Let's just pass the pattern as an argument.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/Makefile             | 4 +---
 t/aggregate-results.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 2c2b252240..6bc878558f 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -140,9 +140,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
+	'$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)/t*-*.counts'
 
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index 7f2b83bdc8..2efc2c37cd 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -8,7 +8,7 @@ broken=0
 total=0
 missing_prereq=
 
-while read file
+for file in $1
 do
 	while read type value
 	do
-- 
2.39.2

