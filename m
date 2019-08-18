Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98421F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfHRUFf (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbfHRUFe (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 885C36073E;
        Sun, 18 Aug 2019 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158733;
        bh=0O9hDoNy7NpmY7YUxFAQGwnA7qjnRaIxcWNwkK0iILA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Gu/2ZVYaWW2KKPEFjZN+sCb7qWRNzJhOWvqn9VFHb7Fi3+J0t5SuWcgke62CUW4L9
         AL3ALaFvdFYw9ejcOLjV51HC44ae6k14/Xk84h8/Hg+/99APUNwYQBFKFwxmFN89mH
         qHkzzfL9/HlqMUWc5Ur8qrK/kEDc1EaPC6u6fTlEv4kxrIy9ACGVntLAH8SWDN5n78
         ZD4PM/OWRkr7MjwnsZju//gPpkyqdHUAPBuRYJ756aDQtHD3yBjoJV8icbkvEGmkt6
         YdjdnzlpT6BemFeKPXTktGiI4p6et+r+VUNYCt/98ENqpeT5okUXwY1J7NB4U+hTO5
         vn+/qWhtTsaQGn/YOqZ81QcCeFanPWvsnr/t9dH/eZlGt3CavrHRnT3IQ0g/mIMigo
         P8Ly9d/GFZ/V7eMFXvghLxANWq61BbfnsiXPRUe83ZrNIMGfr35fyQaf30JyMyVyru
         Rt/RYT8UUF+ECBb0qIaw/aIhxbyFggqpnMTwDDX/NdDJdWSszrY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 05/26] builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:06 +0000
Message-Id: <20190818200427.870753-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch several uses of GIT_SHA1_HEXSZ to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index b6534d4dea..5a0c0c2312 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -460,7 +460,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
 
 		if (opt & OUTPUT_COLOR_LINE) {
 			if (cnt > 0) {
@@ -885,6 +885,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct range_set ranges;
 	unsigned int range_i;
 	long anchor;
+	const int hexsz = the_hash_algo->hexsz;
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
@@ -931,11 +932,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	} else if (show_progress < 0)
 		show_progress = isatty(2);
 
-	if (0 < abbrev && abbrev < GIT_SHA1_HEXSZ)
+	if (0 < abbrev && abbrev < hexsz)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
 	else if (!abbrev)
-		abbrev = GIT_SHA1_HEXSZ;
+		abbrev = hexsz;
 
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
