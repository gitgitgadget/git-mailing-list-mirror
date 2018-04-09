Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE141F404
	for <e@80x24.org>; Mon,  9 Apr 2018 01:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeDIBmt (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 21:42:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38120 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbeDIBmn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 21:42:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id i3so12959646wmf.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8YoKxMRjxPUNYvAckl51qp3Zpnob1shYxxfJiEG3iQ=;
        b=DdVtOme1n0a0wl0JwnkeBJZ/YkK2ft6r2r1pY95nYUr+vvctA80UNQGS37AA10neRl
         X6aNUkG517Dc36PK+Le5ajRRdqVzmW3Id9GXKahfvRZdn4QqZAHJCiM3Hn4TWtWNwc8b
         VcKg2BjuSvyAnpffTtWrzF5Yc8Whi+XyPeN1Asf5RAk5+QDDD5zLaPFsNkR8ElH/LsaB
         x2mdHY0C1GNEO7zOEU4u9nHh2qv1ZHDYPT7hD9lV9aFRqfSHoz3UtrtQ6Q8Aj+5sFQm7
         bG89EKLdCFFJbQG+Apt9ysxqMBzquEHTDz9Gp/Vwgy/Duka/1vNnT0J0YhiXAWjiW3sv
         6nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8YoKxMRjxPUNYvAckl51qp3Zpnob1shYxxfJiEG3iQ=;
        b=Hqi1XwbcFg4S19q0XGZNxiZKDb2DtjaP94RTMuUrkadeODx8Bq/W3L82ZsXu2BM0EH
         UQui5j34wl/NZEBZEEjA62h65ZEyNTC4hVZyGat4tY9rF5idoCHLVvPBZ7cdIuhGphuP
         7doD1ww+SBvCayrNX1LoW1Siy3aV3ZoFWJqaQ4BE7Etyony5szmGSCuZ8lMlh//VHooT
         KqM0mGQyHvTbyY/+anc87gQGtTbZ2yveNlCJcFuvMhAjZHGDbA9c+8ccT1+tpUSqqn72
         vW8UQPS2KHeTtnPlJjYzPafK7/nQ9xp6ksB6zh78m73sR5hpdr/X2shaOqjxRzJ3MdGc
         +5RA==
X-Gm-Message-State: AElRT7EXHT/uBdTtJDUBtp5So0OMWVceKbW0idXsp3eXeRpIhX0hu44D
        z6x0LF70WQmExktflOcYAb4XoEgCc50=
X-Google-Smtp-Source: AIpwx4+TynliSu/PlchbjCz8elDytLv8ay+jmjgAEJByKZA5HV0JVRyCH7G/2HrfQbQYbujN0p9Q1w==
X-Received: by 10.46.64.26 with SMTP id n26mr20929831lja.50.1523238161540;
        Sun, 08 Apr 2018 18:42:41 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id n62-v6sm3197231lfi.4.2018.04.08.18.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 18:42:40 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v14 1/4] ref-filter: use "struct object_id" consistently
Date:   Mon,  9 Apr 2018 03:42:23 +0200
Message-Id: <20180409014226.2647-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180402005248.52418-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Internally we store a "struct object_id", and all of our
callers have one to pass us. But we insist that they peel it
to its bare-sha1 hash, which we then hashcpy() into place.
Let's pass it around as an object_id, which future-proofs us
for a post-sha1 world.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 ref-filter.c         | 10 +++++-----
 ref-filter.h         |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index da186691e..42278f516 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -117,7 +117,7 @@ static int verify_tag(const char *name, const char *ref,
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid->hash, format);
+		pretty_print_ref(name, oid, format);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ad7b79fa5..6fa04b751 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -72,7 +72,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		}
 
 		if (format.format)
-			pretty_print_ref(name, oid.hash, &format);
+			pretty_print_ref(name, &oid, &format);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216..ade97a848 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1826,12 +1826,12 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const unsigned char *objectname,
+						 const struct object_id *oid,
 						 int flag)
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname.hash, objectname);
+	oidcpy(&ref->objectname, oid);
 	ref->flag = flag;
 
 	return ref;
@@ -1927,7 +1927,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid->hash, flag);
+	ref = new_ref_array_item(refname, oid, flag);
 	ref->commit = commit;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
@@ -2165,11 +2165,11 @@ void show_ref_array_item(struct ref_array_item *info,
 	putchar('\n');
 }
 
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
-	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item = new_ref_array_item(name, oid, 0);
 	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b3..68268f9eb 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -132,7 +132,7 @@ void setup_ref_filter_porcelain_msg(void);
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
  */
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format);
 
 #endif /*  REF_FILTER_H  */
-- 
2.14.3 (Apple Git-98)

