Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677021F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933328AbeGHXh0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932799AbeGHXgz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4629060747;
        Sun,  8 Jul 2018 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093014;
        bh=CpuWu05rD2cXoKmTAygSUyhe2Wc1SJ4UOgn7oJMMAqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Sxq3l+9qVg4Ba0bqUpPpwSME7hNf2iViInhIdkn+OuuUpJmf8NLrGH0i2c/5p5aOj
         4q1bV3QT9pBYWcCyj/Ro5ncZg6Na/J3NeLk90xosswTm6UmDs6Nuvr/5/P+TAu42+L
         jgHfDEc5B1p3LIf4cpUn51QQDiiSNynimpgDD9DEYyIa54jLapy6PdvdE9tFvSEywr
         5PfSWOxyisQnA6WDv0M5MZ83pYL5S7jY8MQrZYPgFxKhD80HokrF7jJvS9BAMZcJE9
         RVjUg3rQacXJgu2f6CvkxR0PpGYnG8fmJDDemWzdKn4rZDNuItWJf5wRsCT2s+bsAq
         kz3L9/RuaBglyEtedGFQ2pRa5kQflzpGs9f94bzF00Ff2mTj17Ri0yy+RKgDT8BrD4
         S+CtA0WXKET6+dTwoeXuUkgH3Mo25eB8e95XfE1iDxX964t2aLNLRNC14jg1mgPZ1A
         2IfmFy2KmsZca0IvYubvpXJ5C3gud0Edct87cKy5x5o8BRJsWUa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/17] commit: increase commit message buffer size
Date:   Sun,  8 Jul 2018 23:36:28 +0000
Message-Id: <20180708233638.520172-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

100 bytes is not sufficient to ensure we can write a commit message
buffer when using a 32-byte hash algorithm.  Increase the buffer size to
ensure we have sufficient space.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a9a066dcfb..252f835bae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 	char *logrec;
 
 	msglen = msg ? strlen(msg) : 0;
-	maxlen = strlen(committer) + msglen + 100;
+	maxlen = strlen(committer) + msglen + 200;
 	logrec = xmalloc(maxlen);
 	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
 			oid_to_hex(old_oid),
