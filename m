Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACA5207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046160AbdDWVgE (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37432 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046102AbdDWVfi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9D2E5280BB;
        Sun, 23 Apr 2017 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983332;
        bh=DEalbvUfEv9wR64g4yn6ao9f8h3PmvYLwd/JEo9p9wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDQ3UMslU7ZSaE3+QbxlUOt1W22e47Vmk7L4KBWHDrM8OhySZFGE080p1TJigameK
         sLtDMpslAJpkgslJqbbynnAZtW0joc+GomL3pIaVFE273TESYwV1cYJUgHs38JgsrX
         NqQYvWgSzk5MhM/N1WtMmOYW+DFPfEJl+OR2rvxehCrB4WvdpDQZ+OrV8YOB/k/SCL
         PkNJ9wEaJ9HSA+Xj5YZSr6NdkdqO2jXWntYZabEutOFLHIs+mSwh/pjiASQx9QeyPy
         veM6xncIpIeBRdMgtuk9c7397K5ohGCCysVc3LppMsekJ+xoxdEmCH2guMHLpxLtIC
         E1PvePOJlbhQXbx+kOD03BF7df6xMGp+EeBp6DQz7vbzvpp9diaL273Wuxk1hBfxLV
         ckpx9KQ/BYsdWgsKrzXmSa0hlACn5OBULlseNLC5SeJowFAkOF+qLTDnf62B/X9Z1A
         u4kNW52WdWKokVciQDT+q2GjkPbxwgMd7DLP8Rsxp+wPYJgPSaS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/53] parse-options-cb: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:14 +0000
Message-Id: <20170423213453.253425-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
