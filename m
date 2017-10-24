Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7325C1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbdJXS71 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:59:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:48005 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbdJXS7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:59:25 -0400
Received: by mail-it0-f67.google.com with SMTP id p138so11242088itp.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gUundsOxrd7m6Mw6PwQ0G82bx+eu1TJ0IckATD1woco=;
        b=ANAPij7hXpbp43IJohBlt7EqKx+CIcwjQG2GKd4aB6Lb9MVCTCA7xLTSeUwhaX2A0H
         ch1aayi0+L+DuD7J5GwmuxUy4oirA29kxDPFnq5yoj0BH1Gg2HhvCdq2AtVlhSiYLjqe
         Lu77liXYnFA4wqFYKa5aLYQF+8IZP8SO28mbcphJKHORlUTnfyUitZIRxCT9qKG2RYEh
         XZomgHdXb3HXw39lA8pMlMAEKHGrGm6Bp50x8JVc/YvHsnK1hxMKPKb5bXw4nI41xhja
         B3757gS+quVHrkUGBDgFQg75PsnstGpu1kO3vukH4JIZgiwR5MBqr41ian0bTSG5BT+u
         Hd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gUundsOxrd7m6Mw6PwQ0G82bx+eu1TJ0IckATD1woco=;
        b=Hr49TRPH1taniSYznk+8i6p3JYJ3c24QR5R7HF2eHNr4nyd+sAQelikyMPWBOu3vmj
         M8LE6W5bSUfKqgyCRHArpgpzZs4Zdo9wyCE1BZ336FW/zC7fbRZSfVWqWcPhTFUVm0xV
         lIyEbXgayyzqdB5s+Iw3DDqXf6pq3BLvXzPmzTKmlY93gPCr/Y4c8sfp+jzLj5yXnV5l
         2ccjMuf4o5q59SlueVaVQhVxR9TqhxSMahyP0enrFug5Fa9/dD3xQoZqra8cy/cSBQk7
         cqviQw56ssUJ3YQ1fdXRmgsjSEBvuchJxTqdBzQf1p27qC2OtOOU0fdwj939ADrktcdc
         Cj8g==
X-Gm-Message-State: AMCzsaUiFce8OgECbtQISD6kLc9EfggnPEjbSTF6zc4kiUOneK7cCBJb
        lUdntqsvrcl+xbl2l8XCeiPfA2PCQQI=
X-Google-Smtp-Source: ABhQp+R2zPCNJuXkDd7mSyOo1SiEZQQgz3VVxWW7RkRKY2e/E98w4jnthsz7QNX2xddU4gLOArElZg==
X-Received: by 10.36.33.23 with SMTP id e23mr47621ita.109.1508871563872;
        Tue, 24 Oct 2017 11:59:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id f184sm443427ith.2.2017.10.24.11.59.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:59:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] hashmap: introduce memhash_feed to access the internals of FNV-1 hash
Date:   Tue, 24 Oct 2017 11:59:14 -0700
Message-Id: <20171024185917.20515-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171024185917.20515-1-sbeller@google.com>
References: <20171024185917.20515-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be useful shortly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 hashmap.c | 7 ++++++-
 hashmap.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hashmap.c b/hashmap.c
index d42f01ff5a..d103eb1fd2 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -26,13 +26,18 @@ unsigned int strihash(const char *str)
 	return hash;
 }
 
+unsigned int memhash_feed(unsigned int hash_seed, const unsigned char next)
+{
+	return (hash_seed * FNV32_PRIME) ^ next;
+}
+
 unsigned int memhash(const void *buf, size_t len)
 {
 	unsigned int hash = FNV32_BASE;
 	unsigned char *ucbuf = (unsigned char *) buf;
 	while (len--) {
 		unsigned int c = *ucbuf++;
-		hash = (hash * FNV32_PRIME) ^ c;
+		hash = memhash_feed(hash, c);
 	}
 	return hash;
 }
diff --git a/hashmap.h b/hashmap.h
index 7cb29a6aed..c2464385ed 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -105,10 +105,13 @@
  * `strihash` and `memihash` are case insensitive versions.
  * `memihash_cont` is a variant of `memihash` that allows a computation to be
  * continued with another chunk of data.
+ * `memhash_feed` takes just one character and returns the hash based off
+ * a previous hash.
  */
 extern unsigned int strhash(const char *buf);
 extern unsigned int strihash(const char *buf);
 extern unsigned int memhash(const void *buf, size_t len);
+extern unsigned int memhash_feed(unsigned int hash_seed, const unsigned char next);
 extern unsigned int memihash(const void *buf, size_t len);
 extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
 
-- 
2.15.0.rc2.6.g953226eb5f

