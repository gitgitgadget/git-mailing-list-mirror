Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DDD1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeDIWqA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41820 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeDIWpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id a2so6608272pff.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZRYyXXYgVoWmwwNIYvGXq/7GuAH+dxFj2UFDvqRec0=;
        b=LIcvbjsTNcpYFWTg4uNOUuvb18RbMmiaXxQ+w+2YkWLO0GJ9Hc6d2VVfS1tepcY/n9
         HtZPjHKYiQXCkdartxWKg0+IzmqEwkka9IbDww3/Uh7PqLyuVcE9iWS/cGzi4gZ8oJmS
         x7ldzeKWvtywaEDpWCBHYP5wZvyrjrxGDnD8ZhV6FsOR1E8veDY3y4XCoeiadwh2Umh/
         G68SJj75WOzkw0e3vnZIGagL0xp5pVfJ8jvgLz9eJzpjuLGTxEStNZQhzGRS3cK9/xBP
         I4GsrlNFoIB0USAhnOMT/jpLAiRpteKpSLikR43nuEeW41+LH36TS5ps8egBjXb78/Bd
         ASgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iZRYyXXYgVoWmwwNIYvGXq/7GuAH+dxFj2UFDvqRec0=;
        b=LGmdevHjV5A0nN0ib0rHAKHLjJ2ipE2YSUoPAMWnXuj215RNDQnhe/A7WmtRfhpC+J
         bmhJq4WUDd5rMqIiKyVGJWPzDvI5BPqlt9Vy6CEd3VKJRRvlLlo6sPvP25ASWcViLIK1
         EgB9BP1DMx8uxRerLYG6iSkAGuKVGCZGhpl7onmb/YxYsOxw3xqeJ5jh1mIbpgyIJ2MQ
         2dexlr4CnAlqORYYGng3sfNoAt75DzUeIcC72FBmFUioTlz3Wvl/D9/J+FQ8df4pv33L
         uqHETsY4sHgtpc7n7GIF6AsHqCNWnpX1hRwLfaiQute+BcoIWIi61hsTyhuNuoan22EW
         GBRQ==
X-Gm-Message-State: AElRT7HRh/KolOKkGD6T0BP3GtnumGNY0TuxKAbcSWGGMuTUiLfmDCqr
        /JY9cVO/1ZbQ/EmduWqqKxBqdg==
X-Google-Smtp-Source: AIpwx4/VRSFEEgGXaOwRR/6m3mEuAoh76vzTC3Mj4pOUGu8Kn7PSEETrRRwdcm88mx9Nh3ltaU9JEw==
X-Received: by 10.99.96.19 with SMTP id u19mr25627658pgb.261.1523313949349;
        Mon, 09 Apr 2018 15:45:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z127sm2198177pfb.72.2018.04.09.15.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/16] refs: add repository argument to for_each_replace_ref
Date:   Mon,  9 Apr 2018 15:45:25 -0700
Message-Id: <20180409224533.17764-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
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
 replace-object.c  | 2 +-
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
diff --git a/replace-object.c b/replace-object.c
index b2405f6027..16a95ea416 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -40,7 +40,7 @@ static void prepare_replace_object(void)
 		xmalloc(sizeof(*the_repository->objects->replace_map));
 	oidmap_init(the_repository->objects->replace_map, 0);
 
-	for_each_replace_ref(register_replace_ref, NULL);
+	for_each_replace_ref(the_repository, register_replace_ref, NULL);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.17.0.484.g0c8726318c-goog

