Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253721F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeFDXxE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:53:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751290AbeFDXxC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:53:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4973A60749;
        Mon,  4 Jun 2018 23:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156380;
        bh=O8G2TknhGB20+Eg0MVuhjhEd8j2HtADkxm5OMfazT0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=STX5BJcv5KEwkHPmLA0Z2yWRVPoCvgABKn6BgZpK+OVhPZefrIpzaBdOnYKlb9i24
         pq1hFrBkfjuXLdzhk0zIQcOgNLGrDsFt3MM5DsTbe2wX4rTvlMEw9TjM0NVyjmKJLA
         2dm9VybqsxlGrhi2qOJHbdHCcfs5LiwIr5mIJ8pZ3NoSCVfxy4CERavdu0PKMPlPNj
         t2KHkphRFe84LvDVu1tGk7/lbWKV96gihnAEdR+O9lOmO9DRHHEuO7vK1KS0h6S47o
         8qOXXGbIGB8V8zhU6ifVfwus+Ndw7SFtz6gx8iGKl7BM00YyMg0r3IyB0Ey+NydqBX
         bWXIT2dMJyXiCSvLoBCtL0knmsORTXvKFfiLE5OrT20dk0vtdPJBjIs4ZoRq3aIiaw
         yXLUsjpQY5RXLXRjSoYYkHAvKcpaPk7DwmAWyWFmN3s8ntL8cFg2YiY0exzfvUAwQb
         dhuYx0B516qy3Gs13s5lHNn062xm6UOI/yXEdFaMnNT9ejwFqD6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 10/10] t1407: make hash size independent
Date:   Mon,  4 Jun 2018 23:52:29 +0000
Message-Id: <20180604235229.279814-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a 40-based constant, split the output of
for-each-ref and for-each-reflog by field.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1407-worktree-ref-store.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 4623ae15c4..9a84858118 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -58,7 +58,7 @@ test_expect_success 'for_each_reflog()' '
 	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
 	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
 
-	$RWT for-each-reflog | cut -c 42- | sort >actual &&
+	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	PSEUDO-WT 0x0
@@ -68,7 +68,7 @@ test_expect_success 'for_each_reflog()' '
 	EOF
 	test_cmp expected actual &&
 
-	$RMAIN for-each-reflog | cut -c 42- | sort >actual &&
+	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	PSEUDO-MAIN 0x0
