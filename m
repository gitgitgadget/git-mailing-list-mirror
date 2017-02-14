Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036B52013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdBNLdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:33:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:62449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdBNLcP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:32:15 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIdTM-1cfnCC1ncO-002Gax; Tue, 14
 Feb 2017 12:32:08 +0100
Date:   Tue, 14 Feb 2017 12:32:07 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] hashmap: allow memihash computation to be continued
In-Reply-To: <cover.1487071883.git.johannes.schindelin@gmx.de>
Message-ID: <bd4893f86c4484fc36480848bf2d0905d961e022.1487071883.git.johannes.schindelin@gmx.de>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B2AGTPNezBK/7PB3cj7XpC5hA5BFTqrTRKphJM/2+bYTV8yva7X
 SwJAk7hA78Oln7TaxtsB8rCKp31S2EFKPQeciAeNtSxQAS81SN3cQ0O0B/7uvUfYhcHZ8rf
 TS0xDW41h29EfTVaiXL2au2izB5mtksrGsQY52GfLK+bgHzYFt1/Sun0GmPcUcONEo6fnc7
 s7qb+elpVwDSdo8LTaYlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dl7FAqSz/n8=:enN9+ufTS6tjUaQLZgTphK
 rCJrkVhnWhe6Yg+fdxEGWe6pSJOsNR6AFCa0fXiVBo37/j3wexOGmWJA5g/C5qAFEQlCAuwU1
 1KLdY63rT5ln28lzRGaYdlM4y8rlBLBnkI0o/Da9UBaeX9+6+RV1KBeQatzSmetT7oueEAub1
 oxuiKujE3LycrRLLMWzf6BSv3FexJdiSGVJCIZl0T8XCeVd78d17Bm+9qan4S3BR8iwu8A9G1
 ZHD8SKvss3+DQRQDX0JsMvTaOM+Axcw9RZcwkv/Q4PyOqnNE4IRWA40sA80vdzFsj56Ai8rwr
 JiPCx5rwrKReIeAvScrzWJ6YZ0rOheau1+xamk9qOW077TfA8sNu5KirDiJYQvnBOdxXZSx1l
 q+3stUzr8m7MoGC0oz+lKleznsK5rgsAZ0+tqb+TTm16+M80S8a1fGfjQWqtC8rCHgcz4VeBk
 RIPgeYLLFCNC5BTxryI2pOOJ4sh8CY2MkU5e3ta/gIVgEIMZb63S4eadYaJBnTs5IQcjRUxse
 hSet7hvdgnY6WYlWUeDAWdjGil+ZARf2DykI3cSnh1ZLEdWbXBvJc9oAsLVELzZWHM9YqJxMJ
 xhVoaiwLUmbfsTVt/I5/UbOcWhWt70p8XTw6mkEUHuZm/He0NT6yQh6OOmCKMd9W2TFWZm32u
 ab00rMFQkA4C3lt/XZFwVVQDA/kPZMXykqPIEFPOTxiZbsF5EUlIBIzU/jXL+HNeMyiD8vWcm
 LA0KwYQQ0FWVlrAEoc3H3Q44cuD6cc5U3nwweWB4MBqUTew3LKr4dCQ/AylSlccFd34WaonjG
 8+bb+G+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

There are times when we compute the hash on
a full path and then the hash on just the path to the parent
directory. This can be expensive on large repositories.

With the new memihash_continue() function, we can hash the parent
directory first, and reuse that computed hash for all directory
entries.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hashmap.c | 14 ++++++++++++++
 hashmap.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hashmap.c b/hashmap.c
index b10b642229c..061b7d61da6 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -50,6 +50,20 @@ unsigned int memihash(const void *buf, size_t len)
 	return hash;
 }
 
+/* Incoporate another chunk of data into a memihash computation. */
+unsigned int memihash_continue(unsigned int hash,
+			       const void *buf, size_t len)
+{
+	const unsigned char *p = buf;
+	while (len--) {
+		unsigned int c = *p++;
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
 #define HASHMAP_INITIAL_SIZE 64
 /* grow / shrink by 2^2 */
 #define HASHMAP_RESIZE_BITS 2
diff --git a/hashmap.h b/hashmap.h
index ab7958ae333..78e14dfde71 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -12,6 +12,8 @@ extern unsigned int strhash(const char *buf);
 extern unsigned int strihash(const char *buf);
 extern unsigned int memhash(const void *buf, size_t len);
 extern unsigned int memihash(const void *buf, size_t len);
+extern unsigned int memihash_continue(unsigned int hash_seed,
+				      const void *buf, size_t len);
 
 static inline unsigned int sha1hash(const unsigned char *sha1)
 {
-- 
2.11.1.windows.1


