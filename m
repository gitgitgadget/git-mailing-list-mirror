Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9831F597
	for <e@80x24.org>; Fri, 27 Jul 2018 00:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeG0B4j (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 21:56:39 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:53050 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbeG0B4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 21:56:38 -0400
Received: by mail-qk0-f202.google.com with SMTP id b185-v6so2949054qkg.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 17:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ty/S5m1rjcc4vBnYwokcMwrEFF1B1wIy8v0pPgEMwDI=;
        b=hSNMuetbJkG44sgFixjEbYVzJGnAHnw9081HkwMpsN4qgdpwWGzCCbHF35bJeXJG/p
         x7RfF/2qgwci8dRylRONsivrDtbWa9EHXRVnCGp+BaJ2brdj6nn4ZL2kWd/LBXJ40QLk
         m0x5+/S3NDmwXOS0L/O/7xT+W1MqA0wTqk4pgxhZYORtMtUoH5ElynyeCTaR4RsHQ29D
         hms/188i0qLQ42zcpozB50wdRhvPY+aNph7nOJlLo0oUSox1X1zVBe25b/8Ltwner2m8
         QPrEprmJa0yLAcbT6GBvWznAT2dpAOUPsdwLg6SLihwewwW55afvKn9Aawo0NjMViFgh
         i0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ty/S5m1rjcc4vBnYwokcMwrEFF1B1wIy8v0pPgEMwDI=;
        b=dy6Kuhz0VPU2Ek3gJGG15Tvwctylzgq7S/cNDeYHmci1Q0eE0v/hlcq8Ou0RQQxQPJ
         9qCWaDX/N47GdNj82lVdfTOPvWzhJv8he3l3nyottgm0+pPDowHW0Zz77vYZCvhgb/Ch
         4ydbLX9kNfkm8gTfP7YK0KwTZ4xAc9Kk5TqPanWfGCDybT0qyIl6hXDwrQ3e0QjNRib2
         0ej6JeWkCeHVMb+pphXLlAkEP6pxXxQxiPAoqJi7c2bHHl+OM6COy6646TPJ8OC0oGPt
         z9L3mIBkbAGcCNSmfTjFZA9+A5l/RinFB8OPLCmx83ul8Tmv4owtZFoef01AKuemg6cb
         72mQ==
X-Gm-Message-State: AOUpUlEjcIyHjQGPEFL9ikCZLbqHrGyA+e9Tt3OHHCMq83xumm/U959E
        u/kSj/5a+28335JvCR5cW/Zuoo06X82gzUeVi7NXHsisJM3JtYooQW/wUHovo/JJueAWkK2L8fj
        m7zTXq9LnenuYaurjLnQHdl9PseT3NF5BqCHpRwphzT6PAV8b3LbETTqzpF3s
X-Google-Smtp-Source: AAOMgpeiDPmvMqjO60GIOgzbFwmvtJXGQqyJqPoBNhN6d9lFVEismjSyAYcqrxykdW7oir6oE/JKSyfSo4F7
X-Received: by 2002:ae9:c004:: with SMTP id u4-v6mr2260047qkk.40.1532651842359;
 Thu, 26 Jul 2018 17:37:22 -0700 (PDT)
Date:   Thu, 26 Jul 2018 17:36:40 -0700
In-Reply-To: <20180727003640.16659-1-sbeller@google.com>
Message-Id: <20180727003640.16659-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180727003640.16659-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 3/3] replace: migrate to for_each_replace_repo_ref
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By upgrading the replace mechanism works well for all repositories

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 9 +++++----
 replace-object.c  | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index ef22d724bbc..fd8a935eb77 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -39,7 +39,8 @@ struct show_data {
 	enum replace_format format;
 };
 
-static int show_reference(const char *refname, const struct object_id *oid,
+static int show_reference(struct repository *r, const char *refname,
+			  const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct show_data *data = cb_data;
@@ -56,9 +57,9 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = oid_object_info(the_repository, &object,
+			obj_type = oid_object_info(r, &object,
 						   NULL);
-			repl_type = oid_object_info(the_repository, oid, NULL);
+			repl_type = oid_object_info(r, oid, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
@@ -87,7 +88,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 			     "valid formats are 'short', 'medium' and 'long'\n",
 			     format);
 
-	for_each_replace_ref(the_repository, show_reference, (void *)&data);
+	for_each_replace_repo_ref(the_repository, show_reference, (void *)&data);
 
 	return 0;
 }
diff --git a/replace-object.c b/replace-object.c
index 801b5c16789..c0457b8048c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -6,7 +6,8 @@
 #include "repository.h"
 #include "commit.h"
 
-static int register_replace_ref(const char *refname,
+static int register_replace_ref(struct repository *r,
+				const char *refname,
 				const struct object_id *oid,
 				int flag, void *cb_data)
 {
@@ -25,7 +26,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(r->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -40,7 +41,7 @@ static void prepare_replace_object(struct repository *r)
 		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
-	for_each_replace_ref(r, register_replace_ref, NULL);
+	for_each_replace_repo_ref(r, register_replace_ref, NULL);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.18.0.345.g5c9ce644c3-goog

