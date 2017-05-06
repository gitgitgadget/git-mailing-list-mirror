Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AF3207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754758AbdEFWME (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37858 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754248AbdEFWLR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C97A5280C1;
        Sat,  6 May 2017 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108670;
        bh=PIZ3gx1aHRaCQtcuwuk6Ye15UOP7JE01YzTgp9gB5XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEBGIsMk0Rkh76SlfzeawS2Yo+dnhBJntcMd8P4XLFylIdh3gB+YDD6aWdkluxeDl
         qfyqmu3DZuBCskvSHlwmSW0j9bW1pHwkt8nx/3lC8YMUh8ywNjCGYlrR+yOFlQgccK
         WNhsxIYwmNQ+CQl8rjVe6peIZy5/YOzvA652aWAR1RqWbPm3z+aDE0QUtfry4Lboju
         N4lobueJs/RqzeVOjVEpj1zoQWT39C4L/paBFUETbcswaZOZFflzG716ernPIPPZjm
         gp11rPETQ++/FSfbthzIFcYaYg3+YnMYXNU2jWtOo/ZLYF0sleidC9Jir2h8I6ebKk
         kjyXPOw1200xf+/DRayudrxxgJ6vwUkl8vRygx7CRtFpwjoAlp6qiSIyPanE9XJT5+
         9xQGfxl4ktm9pkL5Hh5jU8aDtlKCEszJTWZuuLFuXe1pbwzkME+DY/7BUx935Mt7d/
         e9fvUWoDl6+u/jsXHaYRPFLEMtCpTmIInHfECj6OSX/HI3iaQDx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 20/53] revision: convert prepare_show_merge to struct object_id
Date:   Sat,  6 May 2017 22:10:05 +0000
Message-Id: <20170506221038.296722-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a caller of lookup_commit_or_die, which we will convert later
on.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 2b56c3baf..945367034 100644
--- a/revision.c
+++ b/revision.c
@@ -1389,16 +1389,16 @@ static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 
-	if (get_sha1("HEAD", sha1))
+	if (get_oid("HEAD", &oid))
 		die("--merge without HEAD?");
-	head = lookup_commit_or_die(sha1, "HEAD");
-	if (get_sha1("MERGE_HEAD", sha1))
+	head = lookup_commit_or_die(oid.hash, "HEAD");
+	if (get_oid("MERGE_HEAD", &oid))
 		die("--merge without MERGE_HEAD?");
-	other = lookup_commit_or_die(sha1, "MERGE_HEAD");
+	other = lookup_commit_or_die(oid.hash, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other);
