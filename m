Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8D7207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046120AbdDWVfo (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37312 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046088AbdDWVfa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4FAE0280B2;
        Sun, 23 Apr 2017 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983329;
        bh=A1alHSyYkN5ApLa4F3ObQpBeLHYtW/uPWw3C5MCRZbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2sfjrP4v8mfsDDlOBbvVhX5ZSfrUgyZA9Xper6NiIph+Z3CL0vd22vNpOEznKiuN
         cPsPYe/m06TC6WgQGdurd5AlypS5oynHLc6qR8PxmmVIudHsf7mX4IZqs4FsOYjNeL
         3zgYfoZ9en2NP06i9lJzrn7b31v6UBc6lMLsf+G/LdGoRC8Do5rcGIPwgqbrdqGzQf
         M5ZJGmP+ptFtx5HsYw68G26ldNG9Or6pV0E/hau2SKxEjuwLUyjoz16q6k+N9MGeX7
         m9rbSIHkj4L6ZAEf1mtbHvaixrsnxvenF3fJ82PgQC6MqbLnaGmE6EVVDow++IuLO6
         J9hNay4KZhRgYTGf5piALeTcnbpmfnBbHCAwN6iPC1s1YIyVF9tCMaKAJgkzJYUJJf
         B81SqVxGjxkp2C9KgZ7JbKiDVnihDf+cLRvm/BQ57UsHBXmP/i3vCS6SZm0qLz7iYB
         5HHghKgqcejnALU0m8cJqBKfM0kA7qU6ZEI/xrrYk/xDVK+CtV3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/53] builtin/prune: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:05 +0000
Message-Id: <20170423213453.253425-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the sole instance of unsigned char [20] to struct object_id.
cmd_prune is a caller of parse_object, which we will convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/prune.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 42633e0c6..96dca7d58 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -123,11 +123,11 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!get_sha1(name, sha1)) {
-			struct object *object = parse_object_or_die(sha1, name);
+		if (!get_oid(name, &oid)) {
+			struct object *object = parse_object_or_die(oid.hash, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
