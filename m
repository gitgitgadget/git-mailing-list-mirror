Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990D11F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755934AbdLVX1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:27:37 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46132 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbdLVX1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:27:35 -0500
Received: by mail-pl0-f65.google.com with SMTP id i6so13695775plt.13
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 15:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW3BFJDlqie7fwuPVykPXDpcMuExgaDaV7v7XZ+PaiY=;
        b=ilddkSJuj8fRTg4NmewQ5/BhVtUJJaEs7moSMvzYlkJEQfM9RBX/c982QpgHCTjUue
         JXCXfFgKRlZMbJXETATj25DSgXZwkg9PPCijQhJx/HDENbQ6GW9Xyx3MIWCyJLhoePRS
         X/tSmH+CoIvG98/JYXZmG3OxnpCmv13FyqL1T4gXMDxOq6SHF+9r312WPW5fznVeH3k7
         /x1LPOT+p6UDkFVDQPew5QGqNclDlB1qNPaZqIGgpep8Hv2acrkU5EiyLrOQhZl1fhS+
         om0wHUviP9f2qQ1Oh09N1q+KRuMgZtGrVMLVvafNo0ADNn9moxejQg3cSH3HqxOf0f6p
         hzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GW3BFJDlqie7fwuPVykPXDpcMuExgaDaV7v7XZ+PaiY=;
        b=mCDfEd+HvFMsCl/IzHxRJd+yr+zd26YVIOCd0gMIZ33XQcfN9g5uCVHyBCkaYWG+im
         VlhSD6wYsfPQtGCYSxBie3efcd1yez7zXBBHW4LwQOxcAbm2AugzpWvBoeXyRD39+Mkc
         2N4sy9/U/gVb6zszEfFIWfibZ7GcqyJERGMlIjPN4bhCb1lmrfVeV6KhtzxSDwbABCqA
         nlqqWbi0cMLf4eSM1mLukWNLYxDO1+NhqvqSa9hFXdzC3XnRVNqwCgHMs9yLxBdCPd+C
         Hq6MUh2YXItL8WDBBL+LUaWLiy4ICOpxjXUE9aQSfLl0zImcv+X2AgYaquwjHn67GFlD
         gpXQ==
X-Gm-Message-State: AKGB3mIBJRyxDHDRIZIhR67gfVEuoR6/C93vLtnwwUwGMBM5WZjgYbyK
        bDhXKQLvMY2VGpYuL6jMxnpXBnM2Z2M=
X-Google-Smtp-Source: ACJfBosJtWGJx9Q7U3GPkvWkYdgslg1+imzDgAXBqsoXVRYAAWqyX3imqYk6yMuvpA64CQBQaDADJA==
X-Received: by 10.124.22.132 with SMTP id v4mr15729551ply.158.1513985254093;
        Fri, 22 Dec 2017 15:27:34 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 13sm47502275pfs.112.2017.12.22.15.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Dec 2017 15:27:33 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] oidmap: ensure map is initialized
Date:   Fri, 22 Dec 2017 15:27:29 -0800
Message-Id: <20171222232729.253936-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <xmqqlghur08f.fsf@gitster.mtv.corp.google.com>
References: <xmqqlghur08f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure that an oidmap is initialized before attempting to add, remove,
or retrieve an entry by simply performing the initialization step
before accessing the underlying hashmap.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 oidmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/oidmap.c b/oidmap.c
index 6db4fffcd..d9fb19ba6 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -33,12 +33,19 @@ void oidmap_free(struct oidmap *map, int free_entries)
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
 {
+	if (!map->map.cmpfn)
+		return NULL;
+
 	return hashmap_get_from_hash(&map->map, hash(key), key);
 }
 
 void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 {
 	struct hashmap_entry entry;
+
+	if (!map->map.cmpfn)
+		oidmap_init(map, 0);
+
 	hashmap_entry_init(&entry, hash(key));
 	return hashmap_remove(&map->map, &entry, key);
 }
@@ -46,6 +53,10 @@ void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 void *oidmap_put(struct oidmap *map, void *entry)
 {
 	struct oidmap_entry *to_put = entry;
+
+	if (!map->map.cmpfn)
+		oidmap_init(map, 0);
+
 	hashmap_entry_init(&to_put->internal_entry, hash(&to_put->oid));
 	return hashmap_put(&map->map, to_put);
 }
-- 
2.15.1.620.gb9897f4670-goog

