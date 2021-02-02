Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB5C4332B
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459BD64E4D
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhBBT1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhBBTZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 14:25:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065DC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 11:24:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lg21so4417205ejb.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 11:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnYD00KmQFAVYx5NSKppzIvLUt5sd58U/u6HgdNb8xE=;
        b=N4snJpvonBf1w9fCxGWqa9p8VH+3T9uSuvbhbcQsLlJ0K7LnLHhzhk9aDCKm2rsEEL
         sB/BIj/ucH9c2jwYKRn5YTw0HEmsIuVLyIDZvxlEZykQ6pdG+Zv0KZ/UpjO0O3LcXyTh
         TZluP/9ryI2dRY5IGL2ybn7euBGDdjQOdfGjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnYD00KmQFAVYx5NSKppzIvLUt5sd58U/u6HgdNb8xE=;
        b=YzPjbO7ZF72rGY3qG+25oqTfVbriQWiQ+pOXGxQeH+eTj9hWF63qtv0R+7u0SS07Fj
         Rt3O4hapE8dcb0VlMK7MLgitPLeVrxuw+aumEQSgQSAptkdEkk4XZpCg++WiZFqMpP70
         NwyaVF100LTV06I5A68KlgaeIz2doW9me5GUNtV1PErJ0X2NyaXr8r5cIW6gDDMBcAct
         DK5W9M731nVZ5eum9X9VgLEA2729ArMmQUyHzyqhCc6dZBmgBwBb8sMq+Y3I6NeBU2wQ
         GiwbUG4GR5klxRDZpRcZWJsl1Uzdyq9dVtjTvdqesBEGmy22HHQkscDPa0OFS4rd//Ve
         3dbQ==
X-Gm-Message-State: AOAM531jYmcrx5sCip37qg6kwpXn2+aqxdYRJ0MYoiQPRbURAl7Mv9KD
        cbCIdG3yWhSYP9dEl47xEBoLhMmgQI1POZpR2yw=
X-Google-Smtp-Source: ABdhPJyE/TwU9L8LN7ZhlAzaxy1qlwWi6M4DBHsjID2xB8IECsNOoqwG+801J+4zyEtGRSfysKOglQ==
X-Received: by 2002:a17:906:7cb:: with SMTP id m11mr12940024ejc.332.1612293881171;
        Tue, 02 Feb 2021 11:24:41 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id m22sm1193530edp.63.2021.02.02.11.24.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 11:24:40 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, avarab@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v2] t5544: clarify 'hook works with partial clone' test
Date:   Tue,  2 Feb 2021 20:24:17 +0100
Message-Id: <20210202192417.68663-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CAPig+cQoTpsYS+2pccHmzx=Xoc34u166cYoC=GAcEndofN4gcA@mail.gmail.com>
References: <CAPig+cQoTpsYS+2pccHmzx=Xoc34u166cYoC=GAcEndofN4gcA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply a few leftover improvements from the review of ad5df6b782
(upload-pack.c: fix filter spec quoting bug).

1. Instead of enumerating objects reachable from HEAD, enumerate all
reachable objects, because HEAD has not special significance in this
test.

2. Instead of relying on the knowledge that "? in rev-list output
means partial clone", explicitly verify that there are no blobs with
cat-file.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 t/t5544-pack-objects-hook.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index f5ba663d64..dd5f44d986 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -64,8 +64,9 @@ test_expect_success 'hook works with partial clone' '
 	test_config_global uploadpack.packObjectsHook ./hook &&
 	test_config_global uploadpack.allowFilter true &&
 	git clone --bare --no-local --filter=blob:none . dst.git &&
-	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
-	grep "^?" objects
+	git -C dst.git rev-list --objects --missing=allow-any --no-object-names --all >objects &&
+	git -C dst.git cat-file --batch-check="%(objecttype)" <objects >types &&
+	! grep blob types
 '
 
 test_done
-- 
2.30.0

