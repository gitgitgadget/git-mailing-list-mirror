Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D64F21847
	for <e@80x24.org>; Wed,  2 May 2018 00:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeEBA15 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753423AbeEBA0o (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 023D360B3C;
        Wed,  2 May 2018 00:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220803;
        bh=lbrjuRNp+Vxx6jdPrBW9KZBqW1TXM9mCmQpHC4oMdes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m1HEXIqGYwjn36DvYpKBzLZRaY9mgbHKRmvGmvJLP9Jfh/JZzLYKo+3hjfbl1Tyib
         LPdysXVgTK/g0mV8mCuiJ1ZgKv/XIux41Z5XP5stVfHBNH2aoGMt5yLJbKVaZHvyF2
         r8pQfHyGHEMPE9P8cZZA/9Bi+bL7EImbrJB3lkRh5h/AC+gdH1UIh2GzgJY4J2la2f
         P2+uoiE32AykjLuM28CU6Pe2uzbhl4DjiwPGrChcZNv1Jt6sHSpsSJixZoFDCI2y8s
         aW80A1WMdJsmcD9F5gBWbnCfzekGMd6sCArkxZjMbrBUK0n+TK7zmk9Y0Y0H9zBEnr
         hkX5EQUF1A4Zm9GIPVo/Njkl+KeC6umtj2SHuoUrhhFa0PoVf4h/442mEQFfn6R0Rr
         hICkOSvVfeOFmyOxy/y/DCU3mmb0ooSyRhs5Fd2n/ROdD46v+iHsOXyJbjT9Nxy7bI
         Rl2D4DIYi+bFY++M/mZNrURYo6X88Z+Sx24jXI9LoiE0DSV1B4z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 22/42] revision: replace use of hard-coded constants
Date:   Wed,  2 May 2018 00:25:50 +0000
Message-Id: <20180502002610.915892-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace two uses of the hard-coded constant 40 with references to
the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index ce0e7b71f2..daf7fe6ff4 100644
--- a/revision.c
+++ b/revision.c
@@ -1751,6 +1751,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	const char *arg = argv[0];
 	const char *optarg;
 	int argcount;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
@@ -2038,8 +2039,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = strtoul(optarg, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
-		else if (revs->abbrev > 40)
-			revs->abbrev = 40;
+		else if (revs->abbrev > hexsz)
+			revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
 		revs->abbrev_commit_given = 1;
