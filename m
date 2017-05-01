Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BD61FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642344AbdEACaU (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:20 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35660 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642315AbdEACaG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9A36A280B2;
        Mon,  1 May 2017 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605803;
        bh=A1alHSyYkN5ApLa4F3ObQpBeLHYtW/uPWw3C5MCRZbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQm6yHfwwncTOnwud7NaT6Gz2IL/kgnMOR/QiqoC58jF5ubb6GNznqr9BePhAxBQJ
         XbQVfDAdkC5/ZRIRpKAU2UQKrypMaSIxg9EBfSxDJVhV5cnwH/SRZGxk5b/gv+xuSj
         6fSNMAoQsU84BzzEun/EmubhfMcZJ7OOUa/FUetdyVUK0jDRvt3rF7LyWp9/P6zED/
         jMMEDWFuQjdzwInPPtTezGEyY0/xsUhokLYKIFajBJ8EMcZo8DJPeH83uBKo+rlpz3
         3r/6hhWSB/KaBM4O6gJ17kpH/RhxcmC6HuNLJ6atxM8Jo4WAggxLzLqzIBGXJFLVX4
         mA42mrvINq0qRO8Oqsk8Uy1xWhge4qbpqcwOYU/y6UzHYQ1wxQiJwBvG2A3eqKaNXv
         TxqaWj5nTZZJ/9/Cfzko2ZTjdNic3Y+50oamo1ElvL5RFZY0Y4HowMVGC46aymcV6+
         xYXCDDf4UMwBEEqFpJAM1ujgFhcFCG2S2T1yHbNAu4Y93CWbPmp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/53] builtin/prune: convert to struct object_id
Date:   Mon,  1 May 2017 02:28:58 +0000
Message-Id: <20170501022946.258735-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
