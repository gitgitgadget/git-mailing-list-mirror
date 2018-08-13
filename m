Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292951F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbeHNB1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:27:09 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:55676 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:27:09 -0400
Received: by mail-qt0-f201.google.com with SMTP id j9-v6so14171495qtn.22
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6DcS6wFz0IzP6QVuXioLXV8OvZH/ScIfaycZTVVHexU=;
        b=bxFZR9P//jPRsjJ6jC3U3ygCwUDNGascB34sZM+QRdA8ik/+mE8eNpHN38bRrC/a3c
         D93aq8RE+ycUV59iF0f9GyvE1SK+5cRrZ5Xh/S9ctGmZoNdVBLXs0K5Lth/43iZdkHn2
         q8XhqsDVNrNtVXmaSZpBmInvu06AWPp3pzCiWMbXOFTLr0PVSGMCqJDk7ivNqKBUbMIR
         ebPXkO/EF2A+abYN3LC0eu4Pu5e62JsECn8Y+yeS0eis8cjp9gKMhG1nF0GN1qQqAwUB
         QYaaup4uptalQ/YT/LwDizA6+DcvmSqk9uRvwgvFv/ToyTo7WKAt6JBm4wSwYZHKPEaL
         63ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6DcS6wFz0IzP6QVuXioLXV8OvZH/ScIfaycZTVVHexU=;
        b=K6PCHmQwugGollGWl3Ijb25i2Lndy6KFGZfuh7OO+L1+d/dGZ8W2CdyD5xEIi3b1Os
         F1pQzkzRzJDcO61D0bJ6lDNuiZytBWO5AguymXZ96pkWyfR1mkrxJzWeBvEshIeacxlZ
         xYk+au7fGxbEPrvYg3RZVJXNNk9Wkz9W9o6+j2VDmqSH6yuKJFJNtZsqVUPaDX2b71Gl
         FiUqAaKgrd4b9TnsWdxdR6o9zN9ZE0ro+mCwGGhvwD+CYEQ9n7M4s81elkcQvOLsqUin
         HxfOfwJkrZ4R9yXV+ypTbwDKBxfik8c0lKxech1l+MBqv+OuOv1FN/r/ffUiEbbhdMIi
         LUWg==
X-Gm-Message-State: AOUpUlFngf1mOxGTPK1+wAGab2n6hd6RyDriaFI7REmjA9HTNNj18jlI
        DxqJv8aeufhblIAYF+2MWw7GJJPuM30Z
X-Google-Smtp-Source: AA+uWPw8Il1jdB0JsrmWv6YRDPcZtM3SSl7hq3sK7zoyEWSIdR9hhQIBwNL5Ap5SYrlIs7qtjzmG5dDm3AG/
X-Received: by 2002:a37:a9ca:: with SMTP id s193-v6mr12053970qke.36.1534200172657;
 Mon, 13 Aug 2018 15:42:52 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:32 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com>
Message-Id: <20180813224235.154580-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 4/7] builtin/submodule--helper: store update_clone information
 in a struct
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The information that is printed for update_submodules in
'submodule--helper update-clone' and consumed by 'git submodule update'
is stored as a string per submodule. This made sense at the time of
48308681b07 (git submodule update: have a dedicated helper for cloning,
2016-02-29), but as we want to migrate the rest of the submodule update
into C, we're better off having access to the raw information in a helper
struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 32f00ca6f87..40b94dd622e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1446,6 +1446,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct update_clone_data {
+	const struct submodule *sub;
+	struct object_id oid;
+	unsigned just_cloned;
+};
+
 struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
@@ -1465,8 +1471,9 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 
-	/* Machine-readable status lines to be consumed by git-submodule.sh */
-	struct string_list projectlines;
+	/* to be consumed by git-submodule.sh */
+	struct update_clone_data *update_clone;
+	int update_clone_nr; int update_clone_alloc;
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
@@ -1480,7 +1487,7 @@ struct submodule_update_clone {
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
+	NULL, 0, 0, 0, NULL, 0, 0, 0}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -1574,10 +1581,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
 
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "dummy %s %d\t%s\n",
-		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
-	string_list_append(&suc->projectlines, sb.buf);
+	ALLOC_GROW(suc->update_clone, suc->update_clone_nr + 1,
+		   suc->update_clone_alloc);
+	oidcpy(&suc->update_clone[suc->update_clone_nr].oid, &ce->oid);
+	suc->update_clone[suc->update_clone_nr].just_cloned = needs_cloning;
+	suc->update_clone[suc->update_clone_nr].sub = sub;
+	suc->update_clone_nr++;
 
 	if (!needs_cloning)
 		goto cleanup;
@@ -1720,7 +1729,8 @@ static int git_update_clone_config(const char *var, const char *value,
 
 static int update_submodules(struct submodule_update_clone *suc)
 {
-	struct string_list_item *item;
+	int i;
+	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1739,9 +1749,16 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for_each_string_list_item(item, &suc->projectlines)
-		fprintf(stdout, "%s", item->string);
+	for (i = 0; i < suc->update_clone_nr; i++) {
+		strbuf_addf(&sb, "dummy %s %d\t%s\n",
+			oid_to_hex(&suc->update_clone[i].oid),
+			suc->update_clone[i].just_cloned,
+			suc->update_clone[i].sub->path);
+		fprintf(stdout, "%s", sb.buf);
+		strbuf_reset(&sb);
+	}
 
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.865.gffc8e1a3cd6-goog

