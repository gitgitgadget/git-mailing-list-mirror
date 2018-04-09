Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D951F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDIWpz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35792 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeDIWpp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so6095790plb.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvLFrMtrcsJ6FFrDLTiYF9ou0Wg9QO9CJ+nxKUfibi8=;
        b=SOeFcvj7RTFzXwA9L7VTBRFt8QEPphyFyAOm6YnVHV9sQc2+8W9a2LZzkcohZ80sxl
         f+lQoZQYpUnu+xWrwIf8cwpERheS9jjtVsESsEeej4LApAeU0W83iV0W7uKUCruJrOC+
         t8ONSJG1zncp0jhrRbXFP/b8XOzKx3QybEtGqKYK93aqEvxIgOcFZUIOMu3Df9Qg01E3
         RK3nwUPux7V0rN9tPHi/pcgyElTAGylZck4ufn/2cBigzTvEKsmEHCx5J4qqXK/FcY44
         P6SJ1Bf3MtTr/+mXyZ1/K7oK/LmxXpecZOC/nCiTp0PAzXHCveLo1Fk3rr4Fcz2/3t5K
         6pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvLFrMtrcsJ6FFrDLTiYF9ou0Wg9QO9CJ+nxKUfibi8=;
        b=i+gI06YCfKE+bQGiWjDWyfOVa7Qc2bYv/RHEx2caFJVGzkKXBeO6vJOlMNpHxpipHn
         m4XHyrOBbJ9F9KGWZsTF/RfyR8fgBwQjqB1dNfes/oGw3qou4ytweAtjVkXk6NevwVTP
         F2QJeEFPtHJufl/QrXdAadRi+Y/bSkDAIeTTRd2uqpSmAgfklRH5wbXuD7ski3d83EL0
         hJDXKRAaUFWk6W2L24dudD0CN2U7dBV+OIJCDqrjHsHHlcIvBOSwadB4vpR82YTzgCty
         1JgDzBiMEVHVhKuI+hFA3Kjt56vXNkTZh70MQ1S89dlkBRiTowzmqa1T//klg8HzclE/
         /LHA==
X-Gm-Message-State: AElRT7FuveDQd0rZJhhxJE6DUQIPa4tLBYPvSH0tJJE92OMbOq9W56gn
        7DVzitHFVepZExavxd43/ulT3Q==
X-Google-Smtp-Source: AIpwx4/5cuR3JEWWUvf1vUH9moezfFtA49mlTZe6loNbqzh22oDxeniF4qLo4Qe8ls7r/QhVwKQy8g==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3-v6mr35147245plt.257.1523313945140;
        Mon, 09 Apr 2018 15:45:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e87sm2388711pfd.136.2018.04.09.15.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 05/16] replace-object: eliminate replace objects prepared flag
Date:   Mon,  9 Apr 2018 15:45:22 -0700
Message-Id: <20180409224533.17764-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By making the oidmap a pointer, we eliminate the need for
the global boolean variable 'replace_object_prepared'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   |  2 +-
 replace-object.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/object-store.h b/object-store.h
index c04b4c95eb..1ff862c7f9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -99,7 +99,7 @@ struct raw_object_store {
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).
 	 */
-	struct oidmap replace_map;
+	struct oidmap *replace_map;
 
 	/*
 	 * private data
diff --git a/replace-object.c b/replace-object.c
index afbdf2df25..953fa9cc40 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -25,7 +25,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(&the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -33,14 +33,16 @@ static int register_replace_ref(const char *refname,
 
 static void prepare_replace_object(void)
 {
-	static int replace_object_prepared;
-
-	if (replace_object_prepared)
+	if (the_repository->objects->replace_map)
 		return;
 
+	the_repository->objects->replace_map =
+		xmalloc(sizeof(*the_repository->objects->replace_map));
+	oidmap_init(the_repository->objects->replace_map, 0);
+
 	for_each_replace_ref(register_replace_ref, NULL);
-	replace_object_prepared = 1;
-	if (!the_repository->objects->replace_map.map.tablesize)
+
+	if (!the_repository->objects->replace_map->map.tablesize)
 		check_replace_refs = 0;
 }
 
@@ -64,7 +66,7 @@ const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
 		struct replace_object *repl_obj =
-			oidmap_get(&the_repository->objects->replace_map, cur);
+			oidmap_get(the_repository->objects->replace_map, cur);
 		if (!repl_obj)
 			return cur;
 		cur = &repl_obj->replacement;
-- 
2.17.0.484.g0c8726318c-goog

