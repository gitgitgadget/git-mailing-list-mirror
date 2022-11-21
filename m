Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525F8C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 13:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKUNlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKUNko (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 08:40:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F13636C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:40:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p21so10607943plr.7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPb2YIxJsENoQ62seVPEnDOwS2Xf607+HYztSsI52M4=;
        b=YkCaY1onarV2FPxx2Gx9QS6dYoGUlUQvxowNO9W0wgEhriRHIl0zZjZ6wYIfbpuE8m
         hjuiio7KhIn8qIMFUl6x57v3l60yKQ6Lz1BsFkwkX3/79cQKQOkis9bRg6uz0ZvlRr8U
         v/Ym9Ph3I69xZNfEQO5MEd7xIFiOcu9hfcq5IaWrrvJJtmsXxpegv1kVTJVtvbRLUeHl
         ieN2zhCNFHVYCf30eZkLW4IPazYI6xsSbRPtyz/w4UXwCiJY2JwzobvoS+n+iuT/VTFc
         WXc8F8H/KO/AnTPNtKwFZE8rlxPKrodv8UsnzzwJh8RImLajJQl+TtFeo6TNYVIQo9gy
         gS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPb2YIxJsENoQ62seVPEnDOwS2Xf607+HYztSsI52M4=;
        b=VkkG+Ye4S7AF8ZTgxaCuBWb3ORTurK1nxoB7DWtRGjiSmBighaARcQuBRNrF+y+qVJ
         3Ph1vIfxX6iWaEKDOAHq/Jv19RS7E/HHRrgi2IkDilf0jO2ptEaYoDP4kYst7sihVg2f
         wuPCv3gJe0lyzf70ajTAx7IocooIuPpHsfKqqOyPuotx+N2MogP3zwjJnqGyI4Fw5R/Z
         SDmrriX2SYMniAFR8tTOreaOOBcj8ppPqYPczMN5t11xRY+eumO5eUm+kFvHdF7Feodx
         cWJ48i3wOoGjG5BthOcrN2XNkCjhRuwMr0BSNxavrQHinLBsFQpRkt2G2kNd3e0pemu4
         /3Mg==
X-Gm-Message-State: ANoB5pkW2UQHFZhVqJdajaMbNbpIguZYFHUj1UoHNDpJePXv+UyO84wR
        WScnpgV1jICzTK43eQEZnlhAyThSsgU=
X-Google-Smtp-Source: AA0mqf51IoeHTY6ruzHZHMT/1g95MmpM4yzGvKkPs4ucOruPoquTk0NHKcd/efsPZjc6R1pxvMlunA==
X-Received: by 2002:a17:903:130c:b0:186:85c3:98af with SMTP id iy12-20020a170903130c00b0018685c398afmr2227858plb.101.1669038043500;
        Mon, 21 Nov 2022 05:40:43 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q21-20020aa79615000000b0056c2a85c097sm8684428pfg.20.2022.11.21.05.40.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 05:40:42 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] t5516: fail to run in verbose mode
Date:   Mon, 21 Nov 2022 21:40:40 +0800
Message-Id: <20221121134040.12260-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The test case "push with config push.useBitmap" of t5516 was introduced
in commit 82f67ee13f (send-pack.c: add config push.useBitmaps,
2022-06-17). It won't work in verbose mode, e.g.:

    $ sh t5516-fetch-push.sh --run='1,115' -v

This is because "git-push" will run in a tty in this case, and the
subcommand "git pack-objects" will contain an argument "--progress"
instead of "-q". Adding a specific option "--quiet" to "git push" will
get a stable result for t5516.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5516-fetch-push.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4f2bfaf005..98a27a2948 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1858,19 +1858,19 @@ test_expect_success 'push with config push.useBitmaps' '
 	git checkout main &&
 	test_unconfig push.useBitmaps &&
 	GIT_TRACE2_EVENT="$PWD/default" \
-	git push testrepo main:test &&
+	git push --quiet testrepo main:test &&
 	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
 		--thin --delta-base-offset -q <default &&
 
 	test_config push.useBitmaps true &&
 	GIT_TRACE2_EVENT="$PWD/true" \
-	git push testrepo main:test2 &&
+	git push --quiet testrepo main:test2 &&
 	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
 		--thin --delta-base-offset -q <true &&
 
 	test_config push.useBitmaps false &&
 	GIT_TRACE2_EVENT="$PWD/false" \
-	git push testrepo main:test3 &&
+	git push --quiet testrepo main:test3 &&
 	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
 		--thin --delta-base-offset -q --no-use-bitmap-index <false
 '
-- 
2.38.1.420.g319605f8f0

