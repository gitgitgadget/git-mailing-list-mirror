Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A861F516
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDLAVf (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:35 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44075 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeDLAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id b6-v6so2597426pla.11
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CL1LCkYcsz73X0CF6vsIi+1/w7sK8RYFOnFsDx/XW/E=;
        b=tGd0p1NbvOOtUt1XXC+7oGrjOnV/WwsaSPgOwKONnO4T0OGME6yHvEcb+p26ctMqLy
         QzF4ExrxV9hsT1+YSOq7FKYdBEvr4aBrbU2gjiitvb+tDQjsKos+hjRVfL/XIm9QIv4C
         OTXNOi1H4nDjaIaEo+CSARayy8VQlWb6xILRfSW9Fh63gZPpt54NS1qFgQOCk5BmrxyG
         r+csBG6iEX5bazsUYp5dxNQiBYSUJXdc5Ic21gzgKHqX5VLu8WMHEDtRyjbFx5Iod044
         iApPtgxqtKqOQCquhymL0xITHN2dgLXfOAZRo7PeQyNji7KaoduGjOtzQWfBLmOLm8Hd
         v8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CL1LCkYcsz73X0CF6vsIi+1/w7sK8RYFOnFsDx/XW/E=;
        b=d1z4CxO7LdFnPKD8eyn+nPVcE4izxnVEcK38IRGinM0Qesph+m1JzpSwgJfUu5SYXY
         9fRgDthmypABN1z8OZQ7kP9Ob5RWwRICAD8tTAu//IUBjscInV1ACzP5PgXWBtm3sR67
         FYSoH/sZb22PXUjAV+4pvWRifF4abl/KcgXszCTfjHbqSkDrKf/1AOaoCVvQTj2jkhb3
         PaiOwUBbA4EelUhh0HWctoCiGUgbQquj0ZinwB+sE4lydCW9Qdn85tWtuNaHlbyMobpB
         w4N/KkOWMJ7C0U7A1cybI8rrRA8eAbT4AkNq8kOoGZY2LIgHAeQ/hVhgrap6rQqyri/D
         WtyA==
X-Gm-Message-State: ALQs6tAx4TaG5Ba6pR4Hx1RY3gC0ybtJItJMCvMDtoIeNDH8kQT644bA
        TNU2rWmAijIk9MIks9IIfUkraQ==
X-Google-Smtp-Source: AIpwx4/2FYZsx8y+0BdAMjqLjRBvb298eY6g6TYfHMpmVmxBXFGo8BWcrf2ktjwpLNaldCjXUKHm0A==
X-Received: by 2002:a17:902:529:: with SMTP id 38-v6mr7393470plf.64.1523492491591;
        Wed, 11 Apr 2018 17:21:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p6sm4915217pfk.104.2018.04.11.17.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 05/15] replace-object: check_replace_refs is safe in multi repo environment
Date:   Wed, 11 Apr 2018 17:21:08 -0700
Message-Id: <20180412002118.102976-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e1111cef23 (inline lookup_replace_object() calls, 2011-05-15) a shortcut
for checking the object replacement was added by setting check_replace_refs
to 0 once the replacements were evaluated to not exist. This works fine in
with the assumption of only one repository in existence.

The assumption won't hold true any more when we work on multiple instances
of a repository structs (e.g. one struct per submodule), as the first
repository to be inspected may have no replacements and would set the
global variable. Other repositories would then completely omit their
evaluation of replacements.

This reverts back the meaning of the flag `check_replace_refs` of
"Do we need to check with the lookup table?" to "Do we need to read
the replacement definition?", adding the bypassing logic to
lookup_replace_object after the replacement definition was read.
As with the original patch, delay the renaming of the global variable

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 environment.c    | 2 +-
 replace-object.h | 5 ++++-
 replace_object.c | 3 ---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index 39b3d906c8..b991fc0a87 100644
--- a/environment.c
+++ b/environment.c
@@ -50,7 +50,7 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int check_replace_refs = 1;
+int check_replace_refs = 1; /* NEEDSWORK: rename to read_replace_refs */
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
diff --git a/replace-object.h b/replace-object.h
index 15315311fb..dbc51265ec 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -3,6 +3,7 @@
 
 #include "oidmap.h"
 #include "repository.h"
+#include "object-store.h"
 
 struct replace_object {
 	struct oidmap_entry original;
@@ -23,7 +24,9 @@ extern const struct object_id *do_lookup_replace_object(const struct object_id *
  */
 static inline const struct object_id *lookup_replace_object(const struct object_id *oid)
 {
-	if (!check_replace_refs)
+	if (!check_replace_refs ||
+	    (the_repository->objects->replace_map &&
+	     the_repository->objects->replace_map->map.tablesize == 0))
 		return oid;
 	return do_lookup_replace_object(oid);
 }
diff --git a/replace_object.c b/replace_object.c
index 953fa9cc40..b2405f6027 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -41,9 +41,6 @@ static void prepare_replace_object(void)
 	oidmap_init(the_repository->objects->replace_map, 0);
 
 	for_each_replace_ref(register_replace_ref, NULL);
-
-	if (!the_repository->objects->replace_map->map.tablesize)
-		check_replace_refs = 0;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.17.0.484.g0c8726318c-goog

