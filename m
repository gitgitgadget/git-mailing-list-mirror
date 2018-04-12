Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E98F1F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDLAVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33684 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeDLAVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:35 -0400
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so1694170plp.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WOURTMOm6f29NU63Z04k1yLJ89rlki5PnOYiSfxNbBM=;
        b=GyN2tGWw+HZoL66w8vMXKbeRJ5dcmb1NUsNvHaJYzOVGUamoOxAQnDuR1xorhKkalk
         j+o9EHuwjod2lki57IpqG9MFDkCdCIYfhAFfS8jDtUQm63hMq0tPHlNLC5GEuObwey4X
         vO8812cZN/drNx57lnY5GGGKfKuf52Ii0YDz0H+pQjseCjJOG94yL/X4xCNPk652Fuem
         dA7yZmWBLU0ir+jAF9C16NXz1eSi+a1oD2ZDMF8Giyf+mZosBzsnLuLkqekFZNIEVA2s
         AbhGNlUneGBRCdQ5nX9S1H7ECKFvoWhwManP4Eyn3egC878H8rtwyxSxriAWDot8NSmv
         vAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WOURTMOm6f29NU63Z04k1yLJ89rlki5PnOYiSfxNbBM=;
        b=JZBo2x+NE8ubGBOTh/1xuVFaNZDva8J69hmvNiHUMTOlqamvzokVcsnYXg4UXRMYym
         urBUM6ZrvQvUdUQERzS/FLmE9OfkbZrfLpDGZ7lHBjSv3fjRUYkJrwzeY0MQWDtUI0+s
         taAxRZhGfxCLQfaXZMJwtkujS19LUWegcNMhaGRg9gKM1yxY79a9qYJWrM8NAZRr39zk
         l+4lnVviEMAva4VG2WWfwN1OFkhmcoaSWCLAKXEhzXa74HWtOXO8Dezq69tjhSii6not
         3DbhJrcAggoyx0NkiPVDMruVlCGLtVAy7VgDHuB4CVk+yV5Q0LucQLOtUq3obxxaoBEc
         J85A==
X-Gm-Message-State: ALQs6tDg/jQ3ef4TkDD9699bPYJOsE0LnhoPHIcsRrIzlgXuNbi1Ov2L
        XtGwFakbH0TzJnO/ZycGgYLoAg==
X-Google-Smtp-Source: AIpwx4/XNiNKDVx4QCPBzedahFKkSYenDh4FaYSzpbvZ6ZhaU26tMj/2PGd/FGZkvUUBxQFoESG2RA==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr7389542pli.62.1523492494394;
        Wed, 11 Apr 2018 17:21:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 125sm4289472pff.158.2018.04.11.17.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/15] refs: add repository argument to for_each_replace_ref
Date:   Wed, 11 Apr 2018 17:21:10 -0700
Message-Id: <20180412002118.102976-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow for_each_replace_ref callers to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 4 +++-
 refs.c            | 2 +-
 refs.h            | 4 +++-
 replace_object.c  | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 19006e52bc..ef8145e556 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -14,6 +14,8 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "object-store.h"
+#include "repository.h"
 #include "tag.h"
 
 static const char * const git_replace_usage[] = {
@@ -83,7 +85,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 		    "valid formats are 'short', 'medium' and 'long'\n",
 		    format);
 
-	for_each_replace_ref(show_reference, (void *)&data);
+	for_each_replace_ref(the_repository, show_reference, (void *)&data);
 
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 74d4ed97cb..f58b9fb7df 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,7 +1415,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(the_repository),
 			       git_replace_ref_base, fn,
diff --git a/refs.h b/refs.h
index 0d013377ce..ab3d2bec2f 100644
--- a/refs.h
+++ b/refs.h
@@ -300,7 +300,9 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(each_ref_fn fn, void *cb_data);
+#define for_each_replace_ref(r, fn, cb) \
+	for_each_replace_ref_##r(fn, cb)
+int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
diff --git a/replace_object.c b/replace_object.c
index b2405f6027..16a95ea416 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -40,7 +40,7 @@ static void prepare_replace_object(void)
 		xmalloc(sizeof(*the_repository->objects->replace_map));
 	oidmap_init(the_repository->objects->replace_map, 0);
 
-	for_each_replace_ref(register_replace_ref, NULL);
+	for_each_replace_ref(the_repository, register_replace_ref, NULL);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.17.0.484.g0c8726318c-goog

