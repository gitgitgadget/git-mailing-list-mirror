Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E1C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C43207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="j7MH6pxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgAMMsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728898AbgAMMsB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4AB1060426
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919680;
        bh=4gheojD2MuO/Sj5dLmd6kr3aAsmGkuPA6l7A0+gClak=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=j7MH6pxSdjQvx1NSBlPm+CCTIe6Pd1SaylPd/CmeGmcA5icIR7mmVV7Izn1tA4Z+g
         1o4uIEiI891DxjHYqkz4yTRFI790d2TjPwGXSZEiccyRFN/hQD5VXcLvoI3WXGVQAs
         1nouumFD9yV46gNvCb3soNS1lqZfSrXE55F9HKlUBrX9wOUZykYanjbgvc/vzV+fF7
         pwqSIUfgXfA1u6DsW4SGBxOX+MOG8eNDJLYBdVJabAYK5VFwm6lqbZlqvnGlqNC4ye
         C+tafqBrTRdU/SvmEEm1OuocOD+L0Gy4XzOlbfrSsnvqaoznGGNeyIRwYh5w7Lk+x8
         5vCAud2n0m4Xxq58uPAc20KKVl8xKd+FqhD6jc0TVDEHMEfnRPdkYnn5/OC7fV5owP
         wDwwLBgg5qHCZwLQ51mh5sYlLoHZgJUTyfvcR/5VUlJHbJmmou2v1bv66IA76nSXXs
         6YcnT4twxCEP9/gm41xDuEwSdlUKQBNfXRoBJMmlqwizxr5cQWE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 07/22] t/helper/test-dump-split-index: initialize git repository
Date:   Mon, 13 Jan 2020 12:47:14 +0000
Message-Id: <20200113124729.3684846-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this test helper, we read the index.  In order to have the proper
hash algorithm set up, we must call setup_git_directory.  Do so, so that
the test works when extensions.objectFormat is set.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-dump-split-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 63c689d6ee..a209880eb3 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -13,6 +13,8 @@ int cmd__dump_split_index(int ac, const char **av)
 	struct split_index *si;
 	int i;
 
+	setup_git_directory();
+
 	do_read_index(&the_index, av[1], 1);
 	printf("own %s\n", oid_to_hex(&the_index.oid));
 	si = the_index.split_index;
