Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCABE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjI0T4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjI0T4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:07 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3B199
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fa425855cso347633639f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844560; x=1696449360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjIQESPk0o8Npu7i1ELfD9lAS93ZgVT64m2daSkMins=;
        b=S3fviLbHS8Xj0RKNxXdcSlTtS+s/jJ4R0eOkGgxUqStW685LkBBCOJ7JVXqVrlOH0B
         7lLs4jrSppJ0BOpexY+xapreOGjRKtfl8rTQZUFw+RInQfRbl2Hy6tYzigEoNxf5orxC
         KarAylT6uWNn/4oHo+B0IJN3yv6l5hBrlpHXYdZKELvEpxq97wwSd62UHPCFBENQdRcG
         HZzALBS39cFFnbPvAKRBT3cvQpC6dNjpxs6nDMpDxg9aJe7l8vBkyA4CFnA61q46vwOu
         A8+bvUVQ09y/Kvt/DZslRdZApeMfSgBmv5bVPZvi7GUrqq7oNX9AEIvszMVsjtuTcB0k
         BT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844560; x=1696449360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjIQESPk0o8Npu7i1ELfD9lAS93ZgVT64m2daSkMins=;
        b=XOTdPA60D622Xu8bDe2pbbliV3yjSNY4ksx5bpzOH6VE7LUAmekLmiyf7+btja7NIO
         AdA2xHz/6jB79tP0NZiXnwHvAo9MACHwJtRF4szFo6CGCAqZEzb5YCJoh+LBYMWPE1Iz
         qBn4awt55enQYuyqk/n2FJWmf1XoY42xyj3O00XJsMixGGSXLrR+UbhsA/nPNhaPj178
         qPWv+WnxAK2pouuA4SjkStU8NKXdAQbfu3OW7vvxiwauGn7oKm8uHHYJ5gmkQhkXwIRU
         A0Tf6UTIQkIob866mtC2n1bAxorc6PdK+Xnu5RugM4MmEkDgkFt0AWoCrnqJYIbANdWj
         vG/A==
X-Gm-Message-State: AOJu0YxLpFvQtJAg+kWsk5cdXEr9UlOeheHujz8+Z9xDTFVjwBa5x9P2
        6V/T8NTnb1pmDYOZ8QrhzUiiVsTbgf8=
X-Google-Smtp-Source: AGHT+IEcGoQmH5/VbnhNtAyFTHwh6d2WjynJFcWnLQc7IduD3KSAsvWNgSdLKxOEhgfzEgEQfJXgrQ==
X-Received: by 2002:a6b:fe14:0:b0:787:4b5f:b6cf with SMTP id x20-20020a6bfe14000000b007874b5fb6cfmr3115746ioh.5.1695844560517;
        Wed, 27 Sep 2023 12:56:00 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:00 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 13/30] cache: add a function to read an OID of a specific algorithm
Date:   Wed, 27 Sep 2023 14:55:20 -0500
Message-Id: <20230927195537.1682-13-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Currently, we always read a object ID of the current algorithm with
oidread.  However, once we start converting objects, we'll need to
consider what happens when we want to read an object ID of a specific
algorithm, such as the compatibility algorithm.  To make this easier,
let's define oidread_algop, which specifies which algorithm we should
use for our object ID, and define oidread in terms of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 hash.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hash.h b/hash.h
index 615ae0691d07..e064807c1733 100644
--- a/hash.h
+++ b/hash.h
@@ -73,10 +73,15 @@ static inline void oidclr(struct object_id *oid)
 	oid->algo = hash_algo_by_ptr(the_hash_algo);
 }
 
+static inline void oidread_algop(struct object_id *oid, const unsigned char *hash, const struct git_hash_algo *algop)
+{
+	memcpy(oid->hash, hash, algop->rawsz);
+	oid->algo = hash_algo_by_ptr(algop);
+}
+
 static inline void oidread(struct object_id *oid, const unsigned char *hash)
 {
-	memcpy(oid->hash, hash, the_hash_algo->rawsz);
-	oid->algo = hash_algo_by_ptr(the_hash_algo);
+	oidread_algop(oid, hash, the_hash_algo);
 }
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
-- 
2.41.0

