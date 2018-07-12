Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17681F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGLT7J (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:09 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:49870 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbeGLT7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:09 -0400
Received: by mail-yw0-f202.google.com with SMTP id w190-v6so5875715ywg.16
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yYMqjsapfhI6lDYi7YbxuaRC4TK4Va0QFQTqO93EqiQ=;
        b=RbC3pUJHYIQWbIugbnuBQyCMamm28h88iaaCPe5FrKobXWvRZBjnJ9+RGsFwltyyTz
         PIAkm/qD4a9jHGzxut1XR0JEHJw+AREHP3aCrFfSEYn69/K9JgUGf0kafwg6f3Qtbm/3
         +QEptTbPTdZHjKNGYkXZBROU1oqwYB6+4ofOMDgq/GwkWSG3Xwa9oKYGM8ZHxBQ3vCfm
         6lrY4odqGxMKOR7VDq8DhRIxSZqCpnypXJhIrSzls7lzTUcTQwg9IJXUGfvhfi3nDU0e
         Bc3BTp90ZZOdGtQZgxg50wahx9pq575F/2OljDPUoXfbA9Q/6MekyHsmivZDy+Q6rmr2
         HOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yYMqjsapfhI6lDYi7YbxuaRC4TK4Va0QFQTqO93EqiQ=;
        b=Q5M7JCJnHCsmQQAcfmdmuQZhSsJ6+7Aw2kTmZt8ZOdjqj6uaEZMm4He3qR0Hy+ksU5
         HBHurVMjl6tOBZlsKOiJWhGOzMnWNkd1fNSM6X1v/K/RYXMdQV6TX9OPVIvE2Kwy71/F
         ZHKbULb5TeGBPdo1o5IlPoDyUrIBxZKi2iQMCS46/gtpmZ4+fNpR06eDbeMQdJYz4Uk9
         lUGPfWiGmFcDwejL4N7RkxSGLwt7ZKAb39k6d0ocpu3TgRJlM7MFNxmabJ3H4A3KUMIZ
         c39YLFQMvSdpfWIaJHTEOxTYopcL3gPFtke6kz8J6I+toVZJX+BmxF4y22fRwvZ0CyaK
         7+kw==
X-Gm-Message-State: AOUpUlGcAMifIDz4Eui22CxzQeOlKI+U8nxynUq4sJdHLE9TsgIWA303
        tfoo8qVUDAwg2d83EWlgWorCXtSzdCPWG1fvjis1FgZH6UwcK9kbeOTTCB1sHnDWHVpOwYz5X/b
        Y6jFHBEPpPXuXaiOms5EIwfcyNVY8U3qwwgJNlZp/T6dEIE+ZQ4ra/8w1tSTD
X-Google-Smtp-Source: AAOMgpc02E3jTpz0nS+dQAIxq+eFTcHJUMsq+7AvxkRPLOublok3qUWPveapfkAR0hnmfb5JR0ZZlvSYJHnS
MIME-Version: 1.0
X-Received: by 2002:a0d:c404:: with SMTP id g4-v6mr1160750ywd.1.1531424887442;
 Thu, 12 Jul 2018 12:48:07 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:52 -0700
In-Reply-To: <20180712194754.71979-1-sbeller@google.com>
Message-Id: <20180712194754.71979-5-sbeller@google.com>
References: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 4/6] builtin/submodule--helper: store update_clone information
 in a struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
---
 builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 96929ba1096..c9c3fe2bf28 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1444,6 +1444,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct submodule_update_clone_information {
+	const struct submodule *sub;
+	struct object_id oid;
+	unsigned just_cloned;
+};
+
 struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
@@ -1463,8 +1469,9 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 
-	/* Machine-readable status lines to be consumed by git-submodule.sh */
-	struct string_list projectlines;
+	/* to be consumed by git-submodule.sh */
+	struct submodule_update_clone_information *submodule_lines;
+	int submodule_lines_nr; int submodule_lines_alloc;
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
@@ -1478,7 +1485,7 @@ struct submodule_update_clone {
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
+	NULL, 0, 0, 0, NULL, 0, 0, 0}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -1572,10 +1579,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
 
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "dummy %s %d\t%s\n",
-		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
-	string_list_append(&suc->projectlines, sb.buf);
+	ALLOC_GROW(suc->submodule_lines, suc->submodule_lines_nr + 1,
+					 suc->submodule_lines_alloc);
+	oidcpy(&suc->submodule_lines[suc->submodule_lines_nr].oid, &ce->oid);
+	suc->submodule_lines[suc->submodule_lines_nr].just_cloned = needs_cloning;
+	suc->submodule_lines[suc->submodule_lines_nr].sub = sub;
+	suc->submodule_lines_nr++;
 
 	if (!needs_cloning)
 		goto cleanup;
@@ -1718,7 +1727,8 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 
 static int update_submodules(struct submodule_update_clone *suc)
 {
-	struct string_list_item *item;
+	int i;
+	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1737,9 +1747,16 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for_each_string_list_item(item, &suc->projectlines)
-		fprintf(stdout, "%s", item->string);
+	for (i = 0; i < suc->submodule_lines_nr; i++) {
+		strbuf_addf(&sb, "dummy %s %d\t%s\n",
+			oid_to_hex(&suc->submodule_lines[i].oid),
+			suc->submodule_lines[i].just_cloned,
+			suc->submodule_lines[i].sub->path);
+		fprintf(stdout, "%s", sb.buf);
+		strbuf_reset(&sb);
+	}
 
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.203.gfac676dfb9-goog

