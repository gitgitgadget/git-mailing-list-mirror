Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139251F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfBSAFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732166AbfBSAFr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2CD7961091;
        Tue, 19 Feb 2019 00:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534745;
        bh=xY01/f579AhsVZN/bnBj89/b9ShunR77xSLUR7h63b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oY9kI+GJQWX4x3MzkuRrRMQ4aX3+eq+ZSRAcjbC7uM8aivXsdMyS6qjjxqJaHXxsl
         mQF7HeMBm/GXPYFBT7eyk3WFqs9rsBFCR8uc7fMd1wvysF2W8i3+zyUZHfCQCsrDjv
         isgO8YbM+6MFVmdsDuDMHGqS+mAYix/qa54JZ5hhNx6GhEiK2yjdg7d3ucaWU5WeET
         uKg6qbV4RkArvFANdbSd2PLLDOdtH208DMzVV/UeGGtYwc0zRaVCetZghbZe6L1t/R
         ujUjnzHJ6xzv+q7GbC9y5e9wnjj6DYVJxM5DjnPfAMoosqHuFgYKd/VSADSCRsi1WU
         EovfAJV0AG8NmeSmw4VvCsAW9UtmIJLONFd8M3K4nyBg5H/C1AXd47+oBR1qc+MYdi
         XLdRE1N2XUXULHTZOhSp3DWFppmgpOngSMJPShWrQkiqbsHn7vfltjfy70nzaW4Mgc
         wxxgOjfk4auIpDSO0jUi/KKBOPMCa7SmwhJj6s2/KRmoRoUZBAh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 08/35] submodule: avoid hard-coded constants
Date:   Tue, 19 Feb 2019 00:04:59 +0000
Message-Id: <20190219000526.476553-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded 40-based constants, express these values in
terms of the_hash_algo and GIT_MAX_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge-recursive.c | 2 +-
 submodule.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4851825aeb..b8bd5d4f8d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1122,7 +1122,7 @@ static int find_first_merges(struct repository *repo,
 	struct commit *commit;
 	int contains_another;
 
-	char merged_revision[42];
+	char merged_revision[GIT_MAX_HEXSZ + 2];
 	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
 				   "--all", merged_revision, NULL };
 	struct rev_info revs;
diff --git a/submodule.c b/submodule.c
index 934ecfa294..0e2faaa41b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -990,7 +990,7 @@ static int submodule_needs_pushing(struct repository *r,
 		if (start_command(&cp))
 			die("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s",
 					path);
-		if (strbuf_read(&buf, cp.out, 41))
+		if (strbuf_read(&buf, cp.out, the_hash_algo->hexsz + 1))
 			needs_pushing = 1;
 		finish_command(&cp);
 		close(cp.out);
