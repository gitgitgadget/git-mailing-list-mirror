Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8704F1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDXV7e (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40247 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeDXV71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id f189so4287516pfa.7
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgmyI7EXLa/QggdEmZ5EjECxXb7xepgvxLY2N8Q7i0c=;
        b=B3DkfK/3SRhrwM6F5uwHJX7wZZ+WpveqH485gizr7tAJhgPUU+A8G3JB7HJTATub3m
         j6mSiPfLFAsVXLI7kK+NNRUYGUKptWV/WLkc45aDeLWXD7Kz4Pm1zdacUtjRewZ0o3o/
         tehlUhh57Zen9ndDrFckrvjJfPBEV1VR5fba9VL4ACpwwjRRxGbJ1GHl4EuylZwfPY8Y
         hT1y3qWzEMcUemMuhtJJOx0oXawszeSpxDVdy0KxtSwz7w7ZVh/p7mtuYTLanNkciY7P
         PzT6DaGKTLV3BBIdaGnLJzOL3BSA1fIZA2YmxOT/BfEItkq4AN02+WB5QPdFWlrlpV3P
         YDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgmyI7EXLa/QggdEmZ5EjECxXb7xepgvxLY2N8Q7i0c=;
        b=n2JZj3jknvZr0ynFcN/Pulo2SgxmFz5u+7b7LsM3QV8+wUSOL8FHq1jkMlw/eM8d9F
         /h0VrPUAWhnJOF7RfXlkpivjqDdQMktpjBidoQHrETQ+Vbd9x8TD31EA0aSKPWXDgiut
         Kl3YbGp/aRr8GkLCh4cFQFa0n2rO7wIERJGvIccL7lojwl8nmXnndeqbDFVx3DDSKad0
         G7szIwDee+VMlajeLxOPbGmNnrYvjJ71GjvUHEW80ezyn/3+3viU6WNvBRvssVaMF7A5
         0q1mEgv9VwQpeuK3E8XAFSHiMahEjJ27gOHb5fYHyCpnabs9CMNYS8hZl/aDO3qwAnYj
         gDLA==
X-Gm-Message-State: ALQs6tDkdra16UGiuo29tjsKtA0F8SHWBOBRBc1JtgFdmoOddgW6TS8c
        3P859He0PSEmRD8KNGlF/tEZz4WavSA=
X-Google-Smtp-Source: AIpwx4/fKHqsnOU6AO25O1YWW8dR5R5sTMBg8zEMnzSaktYc74WdVxz8xe0659Ib2MzWKI/Es5T/2g==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12-v6mr27083926plr.178.1524607166094;
        Tue, 24 Apr 2018 14:59:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l8sm26547336pff.126.2018.04.24.14.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv2 8/9] packfile: add repository argument to cache_or_unpack_entry
Date:   Tue, 24 Apr 2018 14:59:08 -0700
Message-Id: <20180424215910.22201-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of cache_or_unpack_entry
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index d5ac48ef18..8de87f904b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1272,7 +1272,8 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
+#define cache_or_unpack_entry(r, p, bo, bs, t) cache_or_unpack_entry_##r(p, bo, bs, t)
+static void *cache_or_unpack_entry_the_repository(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1346,7 +1347,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(the_repository, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-- 
2.17.0.441.gb46fe60e1d-goog

