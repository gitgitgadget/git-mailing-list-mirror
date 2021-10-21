Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC149C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936FF611CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhJUQAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhJUQAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:00:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C76C061348
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so197942wrd.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGWPxesBAkE7U2pSHWFVD7qJdDjOphqg3HmGJEDHKSs=;
        b=MfGKTZpf/k/DE53Fjv1ya/NvPzk3qWNM9H85Nd6TfdRYjMzoH2BVHbUlFLsveYBSd1
         MmZWV3uk7QqS+oPn8ts1m6By/kLEGtePc30d3a9UHwz6FuyZRPiLvxlbizeQivYYFiKr
         WsluZTLAIkJ4uj/AVXFpcPM9umnjkOts4CKCKd5MP5NWiOfdbWk8i9kceFvsWIV013TV
         fYUr1VN5HxGFDD4Lclv2qiKyT/TffJEAFvKOwqi4XCQQkEGmYyhv6NXhY5kFQiORCnJq
         WmFAkuaH8LlerFeHfqL3i9Fv1nfR3qh68b927UBTIwXVSAJg5Z0uFHZP6h43K8TG1zOK
         m7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGWPxesBAkE7U2pSHWFVD7qJdDjOphqg3HmGJEDHKSs=;
        b=7RLQZjcXpQigICPMO/Pn+o7jfCQSl1iO0CmjK6+cJbQYlb6HwxABKXssaWYusRvYef
         mI9CQD+aCwLOHA7t4k67lk8ogeI3hV1NoWctDZCohAXx6JgVpjVpmIcA2TG+JR+vLL6Q
         Dvhrm/OjJrkAt0RMal3UGGSSoOOSV0KwWDooTRa7DRKW4mip7hhmNbFYBdc4FJ7O//0G
         bL8pwDcO+ZTAXnmCb7R3+8qjOfKzF9A+mk/xYYN9i74XCqSW6QA86TIDyOERmGk6lgQS
         HrpDknUJtbeLZX55hcwiluY2ZKHlhknlAqkzW1s0x50x7WB8ETsgcejhmyMIj3JkhOZy
         3fSQ==
X-Gm-Message-State: AOAM533zmyECG1SxTqhOLB8PU9NxNR980FZIEzl4x70Vzvc5VgoUTHzP
        BKuhjwxNHWgtSl/4NS1r/xJvUfFIWLFayA==
X-Google-Smtp-Source: ABdhPJwVRTp5JWFgNGZ1LTY307Wr2dd4WO6980MBmIvxTBSAqxeoJe0QUk2qoiBf7KjCq6WTyknNUQ==
X-Received: by 2002:adf:80cd:: with SMTP id 71mr4042071wrl.429.1634831864731;
        Thu, 21 Oct 2021 08:57:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] repack: stop leaking a "struct child_process"
Date:   Thu, 21 Oct 2021 17:57:37 +0200
Message-Id: <patch-6.6-526d5649156-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/repack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82b..50730517c7b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -258,9 +258,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	for_each_packed_object(write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
-	if (cmd.in == -1)
+	if (cmd.in == -1) {
+		child_process_clear(&cmd);
 		/* No packed objects; cmd was never started */
 		return;
+	}
 
 	close(cmd.in);
 
-- 
2.33.1.1494.g88b39a443e1

