Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D247E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjJBClt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjJBClQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C67CD3
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:01 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a25040faffso218163039f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214461; x=1696819261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trUwtva8DMZBzugwmwLMA6mftWeVdjTvb5jeyEQmyuY=;
        b=WxoVLWjh4e/PjtSkvyvPbomK32TDMUjCk7EOuKSdMq/DoQ01iIDk5/NeO9SnvXR7ZU
         Xa3J4aPlX4UE6+Sd3JrExlPkmwel1MesrMq0OP8t8aXx8OS3GtdvnOfE4IECyS8JXg0R
         FnEEzH2Kw9MDrCNR9TxPpelawGsySJPct7PTH/2fv5+GV0F7I5p2R6GC9yU7oL3M609D
         jWj2P8g/sb/g2AZxsUy58IL5/vQf0CCU6rS4O3uXc+ikpP5Zw2TqLqlbYF0jy7CgLwx0
         v5aVN6C6QgQXCmuH7d8C3CKddmbvyO0vGxG8URU1VKAkD6J+vvgH8au7NjD3bnH30B72
         Jx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214461; x=1696819261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trUwtva8DMZBzugwmwLMA6mftWeVdjTvb5jeyEQmyuY=;
        b=WvAr8wyCtzJJFW87Fd2uKBuIpwWzMoZy+VV3BfBuEmhiD+W5lPdRE9LLIZBxMyUW2f
         0rCe5zGO3+CuUF3aepFXG1qdKrOnwr0vdIPFh3DrnipW8b1Z6aFbapGFQyYXppPzg1QE
         U47QIxIs7K7xKdEnq3nkCEYxCNRZ0JJFILp6uRyhBucIjEjWC7xOgy8dJdiiBynuANGn
         w4sQuBA1TvRmVhYoj12rEVwlGbJJscHYuYzfJRiqkOA1GasJ/iX+RT6yFhSNPZcHtWgN
         taLqdxiTRTH36ExGG0Md+d9xv2HZ0S0dZOyDlyo6EvwDB38wyt51rcyPlh08NJPk7lID
         ujqA==
X-Gm-Message-State: AOJu0YwfEp3Kyu8I+hJsg5yifXL26JfQBK34N+FWA1rTsfSXRgzrpQX+
        0XSP0DesY0n+XdXutNKyX/U=
X-Google-Smtp-Source: AGHT+IHwfAdZdPXr5Nxxh6qNndh5pzsr+NItSFjxe4jDbO7IRY5c/Z8h2YQlV7ct4aKa0opan7r/VA==
X-Received: by 2002:a6b:610a:0:b0:79f:a0c2:4b85 with SMTP id v10-20020a6b610a000000b0079fa0c24b85mr10368357iob.20.1696214461195;
        Sun, 01 Oct 2023 19:41:01 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:41:00 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 25/30] object-file: handle compat objects in check_object_signature
Date:   Sun,  1 Oct 2023 21:40:29 -0500
Message-Id: <20231002024034.2611-25-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Update check_object_signature to find the hash algorithm the exising
signature uses, and to use the same hash algorithm when recomputing it
to check the signature is valid.

This will be useful when teaching git ls-tree to display objects
encoded with the compat hash algorithm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index b2d43d009898..5fa4b14baee0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1094,9 +1094,11 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size,
 			   enum object_type type)
 {
+	const struct git_hash_algo *algo =
+		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
 	struct object_id real_oid;
 
-	hash_object_file(r->hash_algo, buf, size, type, &real_oid);
+	hash_object_file(algo, buf, size, type, &real_oid);
 
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
-- 
2.41.0

