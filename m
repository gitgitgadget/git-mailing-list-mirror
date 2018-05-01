Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D0D1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEAVeg (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45908 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeEAVeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id i29-v6so9075025pgn.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtOXK+FWnagJv6o5GihewJ+sGNcs0fZf57YYOiDkE+U=;
        b=kc6Ngo2FsRCeCfv84+jSi1+ch4nykOy3KgpDNtip+cAJx8nCYGDnP5pHisWKzzzSxd
         ffO0R6qbj0WVVptz0d4uvY9piON19/VtLs+SLQPPNTYDMstL5mv3DF56xKJOXog6IVOz
         NFWBtjV5Wm7EP3pMuNlYmMaSqhjh5JTNwdmuG8NaJPqfeWSU6Fgw9okQfujHKH15Pchb
         ahcYpqJiOoloo9RB03jRbPR9i+Mc5KqAd4gXZ/1mCVqiclteC1/CgaIgonvH3U6FcYbw
         niitMMKKVR4/aj4/2H+FVt86nzhUToAmjE9x1zPL9S3SXL17VCjSl828cpOrcrvZESxW
         qHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DtOXK+FWnagJv6o5GihewJ+sGNcs0fZf57YYOiDkE+U=;
        b=PBq9NCxv13Rvb2UY4rFwWw9KAge8suC9RETH4fs83Pgvd0hOC2cE8ZEWhPdkpuhelJ
         ncv3az1H1C8AI5J4MtOuOMPc9tOoQrQeaal2VlC2Eu4gz/MsbjhFEnKOqYsBVgozDH6k
         0Ohsccmc5ib4gB89mFQ1hpEcKY4RJeCMg51JHWVtMrNS40JlzgTpUSMUXkd/qt2cCpEm
         oe0wCWyN03LN/AbMLKrk/+8OuJFlxqidBX4kmeMO5tQuDwMUtextwdrakFD56FZ11aB+
         a/XvaY0eeEAlutsYgszXSYN1R3zG+qv9tE2fZ/jo5CA1JB20UfeB6Gh8lqFGXQ39wOPC
         B6+w==
X-Gm-Message-State: ALQs6tAyG+Wta9qeHbkx3RT+pVKmJ0hoPoxZyBNU6iZr3iehsvJ0lY43
        +8IJmQHnP9Pm4KzPiBIVNb2H6H35B/M=
X-Google-Smtp-Source: AB8JxZpQSfTrztkVgKpabmWFBbGYOA092RGO64By7oSd6nivHY8OP7fZYef2qM7JlCoijAAAVri/eA==
X-Received: by 2002:a63:7208:: with SMTP id n8-v6mr12031580pgc.420.1525210463503;
        Tue, 01 May 2018 14:34:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v15sm20670056pfa.116.2018.05.01.14.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/13] object: allow grow_object_hash to handle arbitrary repositories
Date:   Tue,  1 May 2018 14:34:01 -0700
Message-Id: <20180501213403.14643-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index ddf4b7b196e..43954fadf93 100644
--- a/object.c
+++ b/object.c
@@ -116,27 +116,27 @@ struct object *lookup_object(const unsigned char *sha1)
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-#define grow_object_hash(r) grow_object_hash_##r()
-static void grow_object_hash_the_repository(void)
+static void grow_object_hash(struct repository *r)
 {
 	int i;
 	/*
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
 	 */
-	int new_hash_size = the_repository->parsed_objects->obj_hash_size < 32 ? 32 : 2 * the_repository->parsed_objects->obj_hash_size;
+	int new_hash_size = r->parsed_objects->obj_hash_size < 32 ? 32 : 2 * r->parsed_objects->obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj = the_repository->parsed_objects->obj_hash[i];
+	for (i = 0; i < r->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = r->parsed_objects->obj_hash[i];
+
 		if (!obj)
 			continue;
 		insert_obj_hash(obj, new_hash, new_hash_size);
 	}
-	free(the_repository->parsed_objects->obj_hash);
-	the_repository->parsed_objects->obj_hash = new_hash;
-	the_repository->parsed_objects->obj_hash_size = new_hash_size;
+	free(r->parsed_objects->obj_hash);
+	r->parsed_objects->obj_hash = new_hash;
+	r->parsed_objects->obj_hash_size = new_hash_size;
 }
 
 void *create_object_the_repository(const unsigned char *sha1, void *o)
-- 
2.17.0.441.gb46fe60e1d-goog

