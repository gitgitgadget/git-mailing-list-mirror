Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76652201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbdGCS4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:56:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53010 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753254AbdGCSzu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 59F90280B6;
        Mon,  3 Jul 2017 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108148;
        bh=X6Uty+9qUjlcmrHY62dA19ga9aRw8AvfJKzKAG+2j74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAVBiT8zZfDYumEXqpBtG8Bs2kOSDNWAqD8lv7ZH8UlMXZ2Iev4Sw6HAoh6TM7VcA
         bqFjXwm4B7NbzKO4zf0vRtvOD/9COsAMJu0azIDKKhqsHTsLOIcJhdO0wEJhYzNEhM
         sjm4BDWFaTG5/w/0grxdx9UvEx3YnAZINhAoYQvwjb5iKBjekMdpv+5kr16cR6nGaA
         mwfgfjcH6OS1S7dJDwGv7uOuYj2jsPA7I7BEJ1/HLCd7tMY4o2LKjAYH+HjF7U+iSh
         5h6mZIxL9yNodDaYpY+rsfvWUrXnDc5aExAmQHylKel44lYs0CenL+hHtMRJKVTsoC
         bZmbC0t64D0qYxD0P78S2HHju8kylzCojD9VCJApO9MP2ybEjkz/mkjl5PWU9mPDaD
         XAsaSQbNxFbnbiq3Y4NXfw/AkXgwqfQPDvQCMcO19FwMFij8j3+kbhlq7YkS33eMP3
         zZKy28akh1LEcsMEW6oAHox+SGlFrUzSiwa/SiHJTHjKimSduk3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 09/12] builtin/verify-tag: convert to struct object_id
Date:   Mon,  3 Jul 2017 18:55:30 +0000
Message-Id: <20170703185533.51530-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f9a5f7535..30e4c826e 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -56,20 +56,20 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	}
 
 	while (i < argc) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name = argv[i++];
-		if (get_sha1(name, sha1)) {
+		if (get_oid(name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
 
-		if (gpg_verify_tag(sha1, name, flags)) {
+		if (gpg_verify_tag(oid.hash, name, flags)) {
 			had_error = 1;
 			continue;
 		}
 
 		if (fmt_pretty)
-			pretty_print_ref(name, sha1, fmt_pretty);
+			pretty_print_ref(name, oid.hash, fmt_pretty);
 	}
 	return had_error;
 }
