Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A5E1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeGPBxg (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59070 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbeGPBxe (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 78C1460783;
        Mon, 16 Jul 2018 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704518;
        bh=NlGf3VybX9bV3HFHY8hgPzR6yd0wnlt8MmRfi2O5WdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YSTJXSSeR6PSMCgZr4iEcjIoZPywrjHJLMln4JXMxKXzhC3/IvYOGp0AVgO8tv9x/
         fFMp5TKvXxtWuN4Lrvtxb0DHKvqKys7+gzeXQ3K3aAx4w7GacXvR7QU71DaSf1u0+D
         YbPvyO0jQkxgdHSAt7jloIacqZ+ReFOCuSBm4vfAbDp5p043chAC5ZL4WyNfFhqEqz
         xdFr1h0Skvy7yuL4a7A/Al2y3wEbPO1xdJXog+5+kiud6CHS5IGMUTQuOWTnpgGU3D
         Xx+1cLo03Gt6NUWVmRPJi9yY7bxeZLFQHjCtJNtFVISItHwBmSkpRX/zjxE6WHtYG2
         vBIYnLEYbS2nvdSD2CkTE1QZHkS2hMp7ggFEFMLuU/x0PIUgIR7z1+iKrJmbPA5BIS
         JOKyGuRb+4wMIGqmahFDoX+qCPpY4Ky8qFKx5BaitsQR1SyO5zS8KQe1f/Sx19P9c7
         Oi5dhEXbQ429uWfVbSzeVw8BjNfMVKFdksBMIx1iQneR72tMvT3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 16/16] pretty: switch hard-coded constants to the_hash_algo
Date:   Mon, 16 Jul 2018 01:28:08 +0000
Message-Id: <20180716012808.961328-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch several hard-coded constants into expressions based either on
GIT_MAX_HEXSZ or the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 703fa6ff7b..b0e653ff25 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1575,7 +1575,7 @@ static void pp_header(struct pretty_print_context *pp,
 		}
 
 		if (starts_with(line, "parent ")) {
-			if (linelen != 48)
+			if (linelen != the_hash_algo->hexsz + 8)
 				die("bad parent line in commit");
 			continue;
 		}
@@ -1583,7 +1583,7 @@ static void pp_header(struct pretty_print_context *pp,
 		if (!parents_shown) {
 			unsigned num = commit_list_count(commit->parents);
 			/* with enough slop */
-			strbuf_grow(sb, num * 50 + 20);
+			strbuf_grow(sb, num * (GIT_MAX_HEXSZ + 10) + 20);
 			add_merge_info(pp, sb, commit);
 			parents_shown = 1;
 		}
