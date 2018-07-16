Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D5A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeGPBxU (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58962 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbeGPBxT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 531F06077C;
        Mon, 16 Jul 2018 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704503;
        bh=4MC5CteoJK4k1/NCPq7kXOwTpZKIc1gIvrAAsjBodAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mmCHNZLRfKBtfbkS/j5f5pIOf/COxjwgx/IbERoxUuhnhWHLTRSdF8IBdRN/l7rjI
         rjTyzDGuU4wRKDRS10DL1eiJmKIufDmR5HjQu7rzkd0wSlUiHjsTzZeSWEf/GfdaVm
         XY3huxH/EgyOmTqJbnE3cWRvELQVdVQsW+zaSRVEKU/MWryM9Y8aAoYe/NPw1FvOmb
         h4/iUbCclii9BTj/IUzNs8vpDhjmLlpYjcgRX+T1+W+qi39j4tJOo2k1e7LJQ5c+Ke
         fNZ3I168Q0QL7hocmRFxt8gBEhMsj9pw6iXBKqO/K8mxSQQ5w61womLSZ9o3QVIfg4
         wzMB5oD7BvegGgxsa73pg/GWu8lDjH5vzmM+DM/3nQlTkjGLEWfx+v2f8FEAamGFu5
         gk4w7OgAT1it8S4V5GtarxqHmLI1JhXskTvDRvf6XncjgnjQEXybNB/Xt3hdHnDyyb
         Aikxfccdb/LXVYBQlbIlQw+dZIKkh5oN73Kc9S3QxqpCBp+r+gH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 05/16] strbuf: allocate space with GIT_MAX_HEXSZ
Date:   Mon, 16 Jul 2018 01:27:57 +0000
Message-Id: <20180716012808.961328-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be sure we have enough space to use with any hash algorithm,
use GIT_MAX_HEXSZ to allocate space.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index b0716ac585..030556111d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -921,7 +921,7 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len)
 {
 	int r;
-	strbuf_grow(sb, GIT_SHA1_HEXSZ + 1);
+	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
 	r = find_unique_abbrev_r(sb->buf + sb->len, oid, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
 }
