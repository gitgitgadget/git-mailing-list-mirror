Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB4D1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642371AbdEACai (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35794 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642325AbdEACaL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C3065280B5;
        Mon,  1 May 2017 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605804;
        bh=2NSpD/LyhkhM4CA1zbv1XExfrT+1NOxf8jIFQ2ob+cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5KkIqg2X/m+rTL3qfyHJLm9A/Xjb4TBEhSkLpYJGYwqmzwI9QCs4IU6Y7k2XKz41
         5GVqns02uv16N9+xA0mBLjXMG5btn2QDePGJGI3jK8BZpNCjDJjSV18/2ve4MnKH60
         Qdm/Zp7g+2qrB8fCI9Ii76CDv0L9/yI9EXZoWHNJlLWL0oDXjZOAQH4+52N1kuk8fv
         1SfYss0zrXqPYz3sd+qG98EU3Vs69nlHU3pR0BEf3n1KD13Bmw49NHDWS6BrFMw41Q
         5mrLM/2W5uhESY9SpB9kxhlPnvwYqGks9oD92mVE4Yt/Uq6bPo5to92q8SmZrMAz3L
         pd2mS80LrIkgbBWNMCC+VskHXJrgg8hHc0f/q+IXLRzMGk+Rhpcn4WS5tWe265MOCU
         bmDC3+l2ZzfPkuw/W8jm6HuOhe3FzkH5sP+atjJoZTfH2UEXqgwUGdN/OCVSgJRcIz
         LIMJH+ATLd71JCXKBTNVcUUVOa71QkxYHBl/1Aeqx/3vcHcSP6W
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/53] builtin/blame: convert static function to struct object_id
Date:   Mon,  1 May 2017 02:29:01 +0000
Message-Id: <20170501022946.258735-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is a caller of lookup_commit_reference_gently, which we
will convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e4..7d644d092 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2461,7 +2461,7 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	 */
 	struct object *obj;
 	struct commit *head_commit;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 
 	if (sb->revs->pending.nr != 1)
 		return NULL;
@@ -2473,9 +2473,9 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 		return NULL;
 
 	/* Do we have HEAD? */
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(head_sha1, 1);
+	head_commit = lookup_commit_reference_gently(head_oid.hash, 1);
 	if (!head_commit)
 		return NULL;
 
