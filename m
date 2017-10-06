Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8034A1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdJFNYe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:24:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34445 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdJFNYd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:24:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id u27so18260369pgn.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W1atywiDOpZQLp8mhjN155cQzp3a7iptx+SnBJRWACk=;
        b=afCVAxEkOSHSxXVUwx2nv8WHu2KEEPekrxYExOyOXIpfZhKlTDLoy6hHOySn5Q/9kA
         JFSoBkWHnulfWPZK2FQiu19UFL4SFuJATdP6rcNIgIvWdu54OPB9EljtlUCqnRPkPF+C
         pv/BNf6+nOBY98+w88ogyZsaUV0l0MqRNmR00lBdqD6HN+PXyZtntCkbQ8eTbGan/Kri
         nyCpqJJrjr2BuoGaYP/G3pwigc01ttQwhuJpX/oCzwIZCyEuIuzYiBE0kZRFA8ksCmI0
         LOt0G6cR56ohgeSWnFs1RhP/7m4k7rSah/e6z9rQbPU+joyvmbKmoER6ZURdgkuKrK1y
         L4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1atywiDOpZQLp8mhjN155cQzp3a7iptx+SnBJRWACk=;
        b=Uxz6ulRxTU6KvWWvkDN4pAmwzXogG6FJ0swVUINdD2NA6DzEPCd8wvRH5HfsOZDEFd
         Boias9dCW8r2Y5B0LYOFIQIObftmE+aiYPC0KTAugMjkMy3iIOt/1NFWwH8VV2TBMtuc
         3JeJgbNof9h1+E5N5ybxv7gZ/HeOQgCiV1UKweb9vm/WZdAjgbXjaMMaJvX4qcBACOaW
         WE9RYOLYne2OPMhaBhsh/2w3AJ6U6Qwpx8JK9rEBGTsMAFkU1tg1zHzqmO6UCIHkaflB
         CxPOCj4DGilrCHzcf4NjGT7I3whaaMDVfFKio//q++5r/uiwgL7pHX01pHr0YmLIUdAz
         cbAA==
X-Gm-Message-State: AMCzsaWuGC7uf3SFQ2noJXLfUikvTNfLXjoOOP0u+zHvowDUm41Q//vD
        qqBeXxIDRcS3jX7txOYtG9feiJt7S5Q=
X-Google-Smtp-Source: AOwi7QACIOQtF3tMNcgSyiQRRWdCVH/hz4iZKQ5obOAqxiCOpO6iCrYz/31ji16mtpIUxCqZq61ViQ==
X-Received: by 10.84.192.37 with SMTP id b34mr1940518pld.279.1507296273137;
        Fri, 06 Oct 2017 06:24:33 -0700 (PDT)
Received: from localhost.localdomain ([42.110.180.199])
        by smtp.gmail.com with ESMTPSA id b23sm3770939pfm.148.2017.10.06.06.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 06:24:32 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v7 2/3] submodule--helper: introduce for_each_listed_submodule()
Date:   Fri,  6 Oct 2017 18:54:14 +0530
Message-Id: <20171006132415.2876-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006132415.2876-1-pc44800@gmail.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
 <20171006132415.2876-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_listed_submodule() and replace a loop
in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 56c1c52e2..29e3fde16 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -14,6 +14,11 @@
 #include "refs.h"
 #include "connect.h"
 
+#define OPT_QUIET (1 << 0)
+
+typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
+				  void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -348,7 +353,23 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_listed_submodule(const struct module_list *list,
+				      each_submodule_fn fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		fn(list->entries[i], cb_data);
+}
+
+struct init_cb {
+	const char *prefix;
+	unsigned int flags;
+};
+
+#define INIT_CB_INIT { NULL, 0 }
+
+static void init_submodule(const char *path, const char *prefix,
+			   unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
@@ -410,7 +431,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!(flags & OPT_QUIET))
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -437,12 +458,18 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	free(upd);
 }
 
+static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
+{
+	struct init_cb *info = cb_data;
+	init_submodule(list_item->name, info->prefix, info->flags);
+}
+
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -467,8 +494,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	if (quiet)
+		info.flags |= OPT_QUIET;
+
+	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
 	return 0;
 }
-- 
2.14.2

