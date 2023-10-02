Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22769E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjJBClO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjJBClA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5843E0
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:51 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fce245bf6so380643939f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214451; x=1696819251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjIQESPk0o8Npu7i1ELfD9lAS93ZgVT64m2daSkMins=;
        b=OReJxIyzCPNkjsRnMFNDqbVvEFlmLzenqwa+8yYCCzz8LbR/LXvmozOXn1+OMbHqsI
         851Vkug8tC/+y/TldwGynABbwRO5bqs1fwBGcKF39oE8/rk6aLrr5UQHmL34PK/c5+KO
         4E+4wR5gxwBUctu1qnE8giIBEHJH7TomsoLBztwy1lkUz/A1I85zdQtQlFKvswshNM7q
         Dx2KY0U0LkRB8ycoihh7uPds8I2lnVUO6MF6TbAKQnNOiqzbha45vkSPc1PKP+0CYosi
         MfRQvTLqDbYPrXXOo6AYjhk7AoQMaAyPTAlOmZszQkxpLGhJoy4rnTmEDnBTc3EFDQL5
         Z1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214451; x=1696819251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjIQESPk0o8Npu7i1ELfD9lAS93ZgVT64m2daSkMins=;
        b=kykPSYi6tM8ZoU8YfI1NmdSI5xcscv3KywyxGq5Cup5jwc8kq+fFlnDglSYHIFV6Bn
         O1XpRx+ufqMXJ/oMZSxqq0JcYGSuni9hEhr6cuH7GZbCQxSobMHSGxr3h/HwbcunDGyf
         PLChmHwQOLQ1kxQDeKz9p5fC/ks3lBAko6zdyKdFq7XINrN0T8/G61NRqYOMOwo3Xenn
         Hj6ShwVgSjVuwZipV7bEyPMXd3cC/aQgKkm2uxKLW6TUYZfDH6vMDABMu/d3tZHNitDH
         wdB67g7cCLrDhbgy1LlfLSGLiSl6JJxq9QlyNBblBQTdoo7kXHJHBMw5/q97GpnexU8A
         m3lg==
X-Gm-Message-State: AOJu0Yy+i//TKfNPYM52cM+Cy7L8fkVAUaXKWZWTQ7WTMOVZf1yAjQqO
        euMdGtQsFjy1LygszQezfWQ=
X-Google-Smtp-Source: AGHT+IGmpC38Orvr7CXdkRbi0sDovesiqpiQ826ihm/INmwugN84/5ZCO9as5zlvnjbObjXCwoLIEA==
X-Received: by 2002:a6b:5c02:0:b0:79a:b526:2f2a with SMTP id z2-20020a6b5c02000000b0079ab5262f2amr11175034ioh.5.1696214450919;
        Sun, 01 Oct 2023 19:40:50 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:50 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 13/30] cache: add a function to read an OID of a specific algorithm
Date:   Sun,  1 Oct 2023 21:40:17 -0500
Message-Id: <20231002024034.2611-13-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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

