Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B1B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeGPBxb (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59040 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbeGPBxa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F1C5260780;
        Mon, 16 Jul 2018 01:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704513;
        bh=PhmtJjPV3BiFdxUT158dARGTTj2zSWVsO488SrMQCQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gKeS/hV0XZ9SQ73VZJV7nTSLOqTrEKd5obsJhEtvOkpPcrAUUl+Sv5kxKZhM082zI
         M//RhQJF4Sx9b6gU9D/wysEwk+H1GwitP0aB//LohX4F1XZuXT+5GHHb/aGSBv3rQ6
         sl3GmHW+A2Ej40TtwD2BKmCHJo1+KOIUIApvJLZmZ2yG+9Op/E79ZEebBH+tJkQMRw
         eczKcJ5sajJh2VCNJDRnfwRSUWi3d7OxJqUbuTVgbA5p/XFWBwIvnYOOVKf6j+7pdQ
         C+m1gkFjfR4gjyn0UEXNA8TIgeE0VD8Z/MJ+sxVYtuObs4MN25/4QfA/V06p4LCVVD
         HTSac88t2mPDNiu+kgOQxMElGbHMrDDUQZmmYIM5sh9M8U0YAM/aWlfna2hS+t0/N5
         MNSFdJs9OyjG85NQuAebzH7fa9Cw4Z6PM+4U2XYpM3/2xL+w72F1T+XsL7gi4AA2pa
         ljoZT9wFCjr8ybrZVEj+SfFSiLnHa+81Cu1CHgjRrBIuL2YavAm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 13/16] diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
Date:   Mon, 16 Jul 2018 01:28:05 +0000
Message-Id: <20180716012808.961328-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 639eb646b9..485ff6c264 100644
--- a/diff.c
+++ b/diff.c
@@ -3832,7 +3832,7 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 		char *hex = oid_to_hex(oid);
 		if (abbrev < 0)
 			abbrev = FALLBACK_DEFAULT_ABBREV;
-		if (abbrev > GIT_SHA1_HEXSZ)
+		if (abbrev > the_hash_algo->hexsz)
 			BUG("oid abbreviation out of range: %d", abbrev);
 		if (abbrev)
 			hex[abbrev] = '\0';
@@ -4947,7 +4947,7 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	const char *abbrev;
 
 	/* Do we want all 40 hex characters? */
-	if (len == GIT_SHA1_HEXSZ)
+	if (len == the_hash_algo->hexsz)
 		return oid_to_hex(oid);
 
 	/* An abbreviated value is fine, possibly followed by an ellipsis. */
@@ -4977,7 +4977,7 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	 * the automatic sizing is supposed to give abblen that ensures
 	 * uniqueness across all objects (statistically speaking).
 	 */
-	if (abblen < GIT_SHA1_HEXSZ - 3) {
+	if (abblen < the_hash_algo->hexsz - 3) {
 		static char hex[GIT_MAX_HEXSZ + 1];
 		if (len < abblen && abblen <= len + 2)
 			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
