Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6323B1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeHSVGz (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55110 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbeHSVGz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 064776081D;
        Sun, 19 Aug 2018 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701277;
        bh=O8G2TknhGB20+Eg0MVuhjhEd8j2HtADkxm5OMfazT0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ma8xT/99M7Fsi4c3YJSmTbnBtyz1TKllkccq8TtYlyeobCVvEkgAty5UthOoZmo3W
         RQoOLtFi1XXv0Kaik6DbOMOcbGOcpTCrfOg8GcFyOzLkOeOHYsZ7FTV8kpEWGudbA8
         HJYG7pGJZ5D+LGTZRztJPhbTCK2cAyIBBYPOdDnWO5xiX6wHwgl7MNXijSpQUK6WqU
         7ymYYarXP65XyKwxqZMxV52rnK5hetgFbOll5NHjbJ4ct+yOF13wcWXW0iO7fLkJPc
         SJvcj+wV/cbdgXwCOodp+AFFOZcYf5e758nDP1fVWcQ4QQgVYJ5IJQ2ckYFB9IH3et
         CEPTwtL/sgv29syJ7HO6SKEG2GiGf5q69vRheTmpLL6Oak97GWmB3JVsRsLAzbqSzo
         aAH7fTx2z/wlpsPuuQ1A48G8zSU8BUEDZhWawh8Tf0GzBj2Jh6TMWUUSEf+3FoqJOp
         p2UGJRcEAW4XGGhYBZ7kn9OcI8MqiaCxH2cMonoPeNx0Avri7iq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 11/11] t1407: make hash size independent
Date:   Sun, 19 Aug 2018 17:53:51 +0000
Message-Id: <20180819175351.449973-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
