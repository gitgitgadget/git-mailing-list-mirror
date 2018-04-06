Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF521F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeDFXWj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46558 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeDFXWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id h69so1788253pfe.13
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rRcqdRT/XA3NgpARH10pD7JU7hp5bdhFttW7LevEWz4=;
        b=NixhzbPu1viM5K6doBMrC8VsUX5iTgkdwwdAinwnisztjQFX7gqh29Mn0FiqE/lV1E
         BatQKI73GDsX1gjR79Rx4Z5u5cmB9NTMb0q1DdTVUp6Vk8gk7j4xAT0seB3bHkNtUDkS
         GIvZonjqtMVESmpkde8cjjZb5+YQfDyAOPp8sK/ejyQ8oFf0kiIxbIlCVGk9Z90rAjEb
         J8En2VmoWZRHHV3FYlvnT6p3RWLCCPsFHAYa2N3C8mD5TWAfuq/WJuOvqNtKyw+WDtS5
         8ZCDYL6n5PiP0hpY7MTQVftZmwygoPNskn4N33qcEbk/zzbb9JPs/TnLgr37QCGbnyWJ
         DOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rRcqdRT/XA3NgpARH10pD7JU7hp5bdhFttW7LevEWz4=;
        b=ED4PimSV3HI6oD/GJQhzH1GZcg513sbllFx1TVHHuQncky81XLK98eIUb8vR07+IEs
         GoY28hnVwbPxoLV9dt+lIsOPdAZ1HXcFdPynu5Pxa2gUNgho/gAvfZyQtMRtu+Hso7y3
         ruAosky1wsh++s33MA6s/xrJ1igQHkQIzEF8HyAJ1eAWU6g8bh2EuiUq0Ngt8tRrPVBY
         klGArpUhyd9forqAzEMaoGKKUQsHNCwpB70LpttnRJZZmhXCwb0YnDenJoym8FYguOtO
         NOlCoYq7KJvUy1qUfRLge778BNlnC21tfk1foyq8FVLdccBnyq44REqwFUs4XcmShbdL
         j7uQ==
X-Gm-Message-State: ALQs6tAC/cAACT9Fi2dVDvspWr8O5+z4Kla0VU8olSgc3IdEsNK6q02v
        lt3TEMtBuRxLHvC0wH5wbIHM8g==
X-Google-Smtp-Source: AIpwx4+fd/dbX7UsvKH9/5qdstYYvQChd1ZQJ7iMDyN/SRimTPWfTFNtqc6TZJIZRNKW0zkRyWqpEw==
X-Received: by 10.101.68.129 with SMTP id l1mr1006995pgq.58.1523056920166;
        Fri, 06 Apr 2018 16:22:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f64sm21222342pfa.154.2018.04.06.16.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/19] refs: add repository argument to for_each_replace_ref
Date:   Fri,  6 Apr 2018 16:21:24 -0700
Message-Id: <20180406232136.253950-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
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
index 10078ae371..6d27dd73f0 100644
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
index addc9d4934..0352cbdcc1 100644
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
index c6d08c2e17..a31e930cfe 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -76,7 +76,7 @@ static void prepare_replace_object(void)
 	if (the_repository->objects->replacements.prepared)
 		return;
 
-	for_each_replace_ref(register_replace_ref, NULL);
+	for_each_replace_ref(the_repository, register_replace_ref, NULL);
 	the_repository->objects->replacements.prepared = 1;
 }
 
-- 
2.17.0.484.g0c8726318c-goog

