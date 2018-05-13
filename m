Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688E71F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeEMCZ6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45380 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752061AbeEMCZ5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8387F60741;
        Sun, 13 May 2018 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178356;
        bh=tNmE6YX8OIp3qF4zgyIdkeJH75tkcyLNAr3nE8efhx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hFqJ/WDYRvT5URe5qskLAyOzPKvLtkxaCR5XB4huyBD72++voQPgxMgH3nD/D5f/b
         hdrHyTqAdjvtHzcRUkXsn9ULd34ZvFPxjTuH3Joz0PIQdcd+SgZl+2mxwW817DQfz0
         4jD4xYeRiD0ndH3kHf/lVpWhnJlKuzu0EzkGAKzKnW4L1gLer9F90lqtA5zaU0+Q2E
         GHMu5T20rK9oGQxeZyeLsv4l+BNLuNBaA4ZxNCrdhI6YdQdderJM09w4is4lUpOrDZ
         nPH7uwol8dgil/3ZOGI4Rh5bW3/uym+1BG952FEA4NmGCr3fi2wtSWgTSpur8B/0tn
         5QpwKhfO73TtthD9F63BI7Y+G82KN+evoeKd16g+iAmv95XAdAblb7+8RrK/RIqu9B
         xcjpX2p3xi7VJIHC29UcQInWSA108mgxyz9ha/6GvTZdHgVWjHy5PbFy8O1gsYktl4
         knSFdfd2Dd8jbT5yVQ5juGAvodWyd+2tviumHcoAy+P9GUQ3iHU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 24/28] t4205: sort log output in a hash-independent way
Date:   Sun, 13 May 2018 02:24:34 +0000
Message-Id: <20180513022438.60003-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test enumerates log entries and then sorts them.  For SHA-1, this
produces results that happen to sort in the order specified in the test,
but for other hash algorithms they sort differently.  Ensure we sort the
log entries in a hash-independent way by sorting on the ref name instead
of the object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4205-log-pretty-formats.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 591f35daaf..2052cadb11 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -516,22 +516,22 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
 	cat <<-EOF >expected &&
-	$head1  (tag: refs/tags/tag2)
 	$head2  (tag: refs/tags/message-one)
 	$old_head1  (tag: refs/tags/message-two)
+	$head1  (tag: refs/tags/tag2)
 	EOF
-	sort actual >actual1 &&
+	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 
 test_expect_success 'clean log decoration' '
 	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
 	cat >expected <<-EOF &&
-	$head1 tag: refs/tags/tag2
 	$head2 tag: refs/tags/message-one
 	$old_head1 tag: refs/tags/message-two
+	$head1 tag: refs/tags/tag2
 	EOF
-	sort actual >actual1 &&
+	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 
