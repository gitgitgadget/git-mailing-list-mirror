Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0FF21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeEBA1O (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37878 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753470AbeEBA1C (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:27:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8363A60D54;
        Wed,  2 May 2018 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220821;
        bh=0suzklJG0d1MNG2nlWN/45tMrCsFv4BO4ihcXECL36Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cWUfPa6768hZd7XNAeX2waJIurxfJfCls0dz9I/4cKHP394FcFzbn4LvsvFzL2AEA
         QUFiHSSy/MaQ1jIErg7cgb6LMxyVh/MY8VEW1dlOLvlNfg0s4ufadr60qnsYV8sDVa
         fPJBCEgVGuJUUZfVi7PfX5xFKgFDQcmbQHKDuQgpBA47C6LzodaxPmBFT+i1N2uvRb
         9MJgZCbSI+d3lcOK/2oxkJw1kHgWYg7N0gbtg/BNw11uB2T9w87ZZQbs1iID7MCzhb
         51CO9NlKDwOJLMMhZ+wHpJbHlRTppr1l/l0wSxBXbAs56tIIS2LKAusYdd0f+4T6tV
         DdYB3IqWqdHo+I8mjqL8WloNG/QOThUDCewUa+DN2J1FpYc99onvGsexWusFT10lSP
         +Sk/f8IB52g/JAkBt/8hxUI0m+KSunwzUPaUeqRGLp8Yy3kBzVFXvO88wR7R9nD+HX
         x/+zjxVY48KclVWhkO13aBKjhiGB42pz1zwlP5vNmUhn2vuhDh3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 38/42] dir: use the_hash_algo for empty blob object ID
Date:   Wed,  2 May 2018 00:26:06 +0000
Message-Id: <20180502002610.915892-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ensure that we are hash algorithm agnostic, use the_hash_algo to look
up the object ID for the empty blob instead of using the empty_tree_oid
variable.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 06f4c4a8bf..e879c34c2e 100644
--- a/dir.c
+++ b/dir.c
@@ -828,7 +828,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (size == 0) {
 			if (oid_stat) {
 				fill_stat_data(&oid_stat->stat, &st);
-				oidcpy(&oid_stat->oid, &empty_blob_oid);
+				oidcpy(&oid_stat->oid, the_hash_algo->empty_blob);
 				oid_stat->valid = 1;
 			}
 			close(fd);
