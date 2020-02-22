Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E4C35674
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3D2206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uelK4TFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBVUSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgBVUSH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 210A0609D3
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402687;
        bh=4gheojD2MuO/Sj5dLmd6kr3aAsmGkuPA6l7A0+gClak=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=uelK4TFNkcmb345BZY82emcShWf7537TYVOfEoDez9w3kDKlAY8VjcIlkzLoWR1GI
         oSvN+T2giJwe5Flhaqq0MsGjxyd7HPAtIEpujmR+jZXwGpunHiisYcybNtK9rk6TOS
         qQQ8YAcQohwlhkgbJ4F7IFkogmPCgizShMXf+pSav5RvJbzSIoy17qkINUuqcGzUyu
         G703j2KDP9UXNNbzYFr+rjEKlik/oO5lzrdqu1lyciEpq0OyDT7EDmBqrl44DJtsfW
         HdagzSxWDmlEve4DaiwqnUTJpxFWTC6wkUyziYuPMsMXd2KAx6ecxNfTAm5hJdw7Nf
         OjaJ+eEHHjlCtsM2TVMmML6HDFTONWygcnMpVcMYB/0vhSNvibhNJwVDtE+B0mEwH+
         IVzXr7BYXRyR4X8H4SXUgEVKsRwynqNSJ5RlD3cVBjccB+e9veksiNOZDWmnxGeWbg
         pz2O8Q9x7/rGRbqja+RTXkpD2QF+0WeY9AnyEtmPRm38Tk8g0nz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 09/24] t/helper/test-dump-split-index: initialize git repository
Date:   Sat, 22 Feb 2020 20:17:34 +0000
Message-Id: <20200222201749.937983-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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
