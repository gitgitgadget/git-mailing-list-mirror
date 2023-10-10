Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE89ECD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjJJUdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjJJUde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:34 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F594
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65b07651b97so37442076d6.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970011; x=1697574811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8raC1pwRNPDQkT90yACQAJIG2zJj06sfDjsWA9vqOU=;
        b=sJT0KNgHZyV1JglWBV/ah8JdjZLFtkui2F5mzG6Vmaa9twFrgZYeyGODly27YHz/15
         CG1ofPIyHvaz4DhIp4+wjsIUEyY6+mOrRJKSImtUO4R5NSOkPBSpaDT3AzxxUa6/rmjj
         kSzwHWu9/zFdjdjvr7lqcIK5+KI5zDlHPF6itxIPv6jEnustaRtdFLMOfKC8MQ7q0c10
         MaqrEKvTYvSO0ZD8zCPHwf94rwvN3Zah2KQFjvz3fUCYHjz1q5XH5qUTGHNYtQ+Q4wgE
         4QSjZYIXLdKUlOwTptjtO5vKX8wpGVIOPD/JZQ9kIyVTi+RqHcwRp7up8DNEjGf5IQ5d
         A7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970011; x=1697574811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8raC1pwRNPDQkT90yACQAJIG2zJj06sfDjsWA9vqOU=;
        b=GQRBhOsBVFfPQVhLf6M2sUrCDZ9SYsfor5MIDcLjYFog7toi/xSeHR+NUHF+GoHqRi
         7dHzCLZys3YEPDQLACSboXnrZdC8HZzM4EcQxvu9ThCnBNo/Ow5n3puDpPkGjSuwShxK
         aUTTg1Ijyxug6QwjJmzjNHy1Y8B5im3G9Myg8RyyIvgCyLuZzlyqpy3W3xG8ItJ2VntE
         gjTG1ueF+XWri9OKu6dkZfUkgJAlQMhgGZM7rLK9G59jdqARepKvrBNf6dIXOa0bZ4qV
         YWho8Rhm4gWJOUw5TxizqTi8YrXa+YMxg4+RowmTgzO9fExeZs+c7uLnxBzqcKTaLJk7
         6A5A==
X-Gm-Message-State: AOJu0YxqscSuqEsg0JdhuWuxifdry+pWL9vcz/qiX3o8pMWcyp52Lt8c
        BpmfkJKAGJ/UIBOBWjKbFZhoFa9EE9YSURQH5rmMNQ==
X-Google-Smtp-Source: AGHT+IH7Cifs0+Hq0a6X63OCrwl/LJQORO4UNZdn2RYGFul2FO3j+nPKqM43xJDPdbgLPTG7k0jh5g==
X-Received: by 2002:a05:6214:104d:b0:658:3a12:9949 with SMTP id l13-20020a056214104d00b006583a129949mr20366515qvr.53.1696970011429;
        Tue, 10 Oct 2023 13:33:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ct5-20020a056214178500b0066cf09f5ba9sm942231qvb.131.2023.10.10.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:31 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 04/17] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <17703ed89ae9a60a26161682ce1c5a468d4ab3e0.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.42.0.342.g8bb3a896ee

