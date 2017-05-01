Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8519A207F4
	for <e@80x24.org>; Mon,  1 May 2017 02:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999429AbdEACax (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:53 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35912 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642334AbdEACaP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 78576280BD;
        Mon,  1 May 2017 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605806;
        bh=DEalbvUfEv9wR64g4yn6ao9f8h3PmvYLwd/JEo9p9wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOmK5twv/1bWL5E1wph0iZfBu2xP6FcEXos8ozu86/XmtIOqDPB+bGVs5Ndznt8yb
         0jrIT377jBvR98j3vxrjBMcIqC/yj1cZiZXgQVv46Ob36vsjRb+ZRhmjOSHKo89+hg
         9RsGN2A/bvMzCRKIDj4HGxq1gSaiTnXdghLVvecyIUgnBKyCnVTBnaYCObnbIRr/MG
         JCAUsiT7akhgFPSG8XKIUldcA0a1PIsrM2taP3TF+2rEhlsdCgRpfoYnR5UFgnyzBd
         KenSv4SrQidanrMwQ422Qm3aHA0PnC29qHVzeiZ9xb1d/YgzwcpzwWH4r3mVmYM2U6
         eaC0UWDvWz6NK2c0CrqMY6CVAH61UHQb36Zi6LUwH1w1aDA7RbKr/N9JT/9nb458Zy
         AW0ap48AGsRsYBlCbldX+dg2N9Sn8uegPrTxeXK2yyKkB7R/ef3efpGfmQJFBHl42H
         UgUDuHNnxM70jwwlPea6482Q+8SFWfCLFfaxhz9pcRytb2flMHt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/53] parse-options-cb: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:07 +0000
Message-Id: <20170501022946.258735-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a caller of lookup_commit_reference, which we will soon convert.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 parse-options-cb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 7419780a9..35a941fdd 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -80,14 +80,14 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 
 int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *commit;
 
 	if (!arg)
 		return -1;
-	if (get_sha1(arg, sha1))
+	if (get_oid(arg, &oid))
 		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference(oid.hash);
 	if (!commit)
 		return error("no such commit %s", arg);
 	commit_list_insert(commit, opt->value);
