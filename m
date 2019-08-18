Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095991F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfHRUFt (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58006 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbfHRUFr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C065F6075D;
        Sun, 18 Aug 2019 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158746;
        bh=qN/7ECw+72Orb66ukmrchlssQkO9KrF1FPFx3xGnVw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jxjHg73WbjVIvHWXF3D8P03jpIoqZXNAb5mF4nxxIU/Omdm4chQn6jj4CWtqOEd6a
         3uyMBrMBmtWIBQo7ciFopP2pSBR7G9kXpgE8UZZlpYnpXNf8B/uWl1jlKm8GCA9/k+
         cTsyDFTmst6kSMhSFe9Uixh5xKP/D49+OJwnE8RB9yutPWOdSau8qjPGxd2+SsPIoA
         dIA1wq1V2iugG8Fw+3SyJ8uFLMNee89P1JQl0SlG+SjZOLtQATyBQ12lHN6bXYDM4V
         epEGLrIQ/LLIkLQDSBVUUX4WB8aeVk1zbGz1f1vsQaf+3B5CsJiA+D1LHXMVfb7smt
         JOcLKBUpI9Ugeo86FBR31mnPXSv/nJcfwqmdBLF/fveTmIwxeNK9thNp+FYxZzfXk5
         CQOX5mdHBU8w71l2MvkXePEaW5sb300zjIc1iOR7EagfRhKPFFqW29T2OGgusjEJr7
         WTMKT2pva0hmKDZ6Eg0H0DQu0jaU3hNyCpVsKkk2QPZbWMZC3+q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 17/26] builtin/repack: write object IDs of the proper length
Date:   Sun, 18 Aug 2019 20:04:18 +0000
Message-Id: <20190818200427.870753-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the_hash_algo when calling xwrite with a hex object ID so that the
proper amount of data is written.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 632c0c0a79..5830f796e0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -190,7 +190,7 @@ static int write_oid(const struct object_id *oid, struct packed_git *pack,
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
-	xwrite(cmd->in, oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
 	xwrite(cmd->in, "\n", 1);
 	return 0;
 }
