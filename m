Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FBC71F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeDIWpx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37848 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbeDIWpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:47 -0400
Received: by mail-pl0-f66.google.com with SMTP id v5-v6so6081504plo.4
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Nd/T4XOrenJa34WGOktQz52YdZWJoKgQ08HEtzoK6Y=;
        b=lwE2tFI0T71+UaqIi//ZET3xrVAHICK9GiDWzFUeq9BLgoBiVgnvweOHE4dudPB5Im
         SMuQ57recwIUMFvkXTJ7m/gkmY+mWTj1pjiCToJptQm8nt0Ma97FrRvLEJOwi+1Ar4a4
         HwaLi+RqwNulLl1tHIc+0eON/d+ajJTEv13B3epMvGwbZjp06H3rvmIht8k/FTwUJjfg
         nuz0meVYEjnk1htSqdYhRuko4HjPp/os+xH4SHbRigErev+Qd1iEWna05v/oPfXuhPiQ
         yaJH0OlP+fHjNL8Ihy2ghQnsseCD2sfXfI0r33CmrT5SfyT+xl5tJ8nqDoo4VodGi/oH
         LX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Nd/T4XOrenJa34WGOktQz52YdZWJoKgQ08HEtzoK6Y=;
        b=WJeOftXcaPt+Fv3iQq1JEpF7QdLoumaOHDKQzdgYTYBOnkD2s/1paMTiazL7T6UWAe
         Im+0OJz573NFcL5w1ZSUTBqYJEp4k7n2hic5PuTXedV42M86a9pGbCnFoROCVKx2nWBb
         0dyo2GK3oJdhagt/PLm2w+uZiKemC26mHmSSYDa6c110GvfnC/zX0PmWRJfEJ4CFcuLN
         CdjkjRoaHZJfowm3J6sp17eAFfOzJhZMNfzpOzumBe+TSHrtA5CWxRqDJrzFOMn1ZxN+
         i2scO+9GXWzKIDQzVpTScjZSta8WXCt8NtZ5B9DhBKN/OW8ZNgvzo6HzZCuJRUe2LK3i
         UoNw==
X-Gm-Message-State: AElRT7GhJeCZSuTyZOw4KUcKmbzn7WfA9+T2NWFEL8Tg17mTzWzqeXsW
        PhyEkWNRpQswqmeAq89qAVvP8j3kUBg=
X-Google-Smtp-Source: AIpwx4/idb21S7lLsyK+zwtZdPFeikJJ2pnAohwRg1//XXae4Vgx4cjUU4nJ83xyjj+uWaG8nuAdIw==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr41658237pll.396.1523313946480;
        Mon, 09 Apr 2018 15:45:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r70sm2617693pfe.22.2018.04.09.15.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 06/16] replace-object: check_replace_refs is safe in multi repo environment
Date:   Mon,  9 Apr 2018 15:45:23 -0700
Message-Id: <20180409224533.17764-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
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
 replace-object.c | 3 ---
 replace-object.h | 5 ++++-
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
diff --git a/replace-object.c b/replace-object.c
index 953fa9cc40..b2405f6027 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -41,9 +41,6 @@ static void prepare_replace_object(void)
 	oidmap_init(the_repository->objects->replace_map, 0);
 
 	for_each_replace_ref(register_replace_ref, NULL);
-
-	if (!the_repository->objects->replace_map->map.tablesize)
-		check_replace_refs = 0;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
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
-- 
2.17.0.484.g0c8726318c-goog

