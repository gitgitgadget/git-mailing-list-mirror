Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84A41F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeGRU2f (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:35 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:35011 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGRU2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:35 -0400
Received: by mail-qk0-f202.google.com with SMTP id w14-v6so4593678qkw.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=elxVfvCjNtwoUEMHc6YoZgpXosywtL06eiz5cem8GgM=;
        b=pslmr6N/h37ajVgoOiD5QITtxoq06e+qU6opjy0l0MNtS4ZYmZ3w3D1clKpUA9byew
         rjZBImzlzkdSii6ekF21H96HjFc5J644UL6MflGLwA0+/PB1wFobz7g0WeovCqNtBhQR
         ZRWnIrUe0AGMRcc9Loo+XOrbnwRk8B0AXycu1GOJR1dPlcHiiHKgYDTbwZtmDaKXaa+V
         H1qTYg3CuUF7lXPzE27XuPiT2gbgWHhxzTpsdPlVQUi8d0VWqCouJB+p8I2tD7MlO+y1
         DVKdcrWCY8n/4qvrp/H0wBbAEUppD5R6XSeLlwZ5y8dKN4MGQjeN3EnlE/gmb+fnY1MH
         5hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=elxVfvCjNtwoUEMHc6YoZgpXosywtL06eiz5cem8GgM=;
        b=dDXlb6D0VDayZdUYr2EUvMUgk8G2cwOEzd2hpw4w7YVaSC1GrQz85j5PCLDR0j/rD6
         x1PpySpcHKrCAf9eiQcT6EhiOyz1bx9/ziL5WYyoXWDlRIQtTiYCD3NUFy8UnVXUi7Lo
         OKVdKjw0SmzQYw1Tw7TldyaSrJwo3kuZwTa8yEgIVIisCbmhGOgkois9rYtcuv8gtx8G
         wuQ/RmxH3KazdOKrXIz5fOhMisgk0jlgCOI6ijwLcDiMA4xCRCJi9FT8y2QA6UCiHYBm
         0wfM1zt446PiH3k/n670b5G1SquHP+fsWrMt9eg9byJkz5SCirasT2D1q48lppYE/G/a
         g4SA==
X-Gm-Message-State: AOUpUlGg/TMJ0wqOXHaiGbfPCS0cpcA9tS5/0BeBjUICf4pgbZXVt92X
        wjSarX1tsSNHCw4SKaa1CMp2TlJmNf7sY0l68hS3EDW8Vn6BnqmeQt1RSxIbWXSL81c7rK5/La3
        mcckyTBTqQyC8rb8voZ7sPbggfJgspvhe3LdcDek3wdkYHbPcLxD13Lzkc0vY
X-Google-Smtp-Source: AAOMgpdDXhQU+OD8hz6HT0DlBn8EPnz0vIkUBFMjGhHaGaSCnrXiFrmHDE90ncAyXSvUwK5xtkQSAORWCjiA
MIME-Version: 1.0
X-Received: by 2002:a37:d603:: with SMTP id t3-v6mr3754610qki.26.1531943350854;
 Wed, 18 Jul 2018 12:49:10 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:51 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com>
Message-Id: <20180718194853.57994-5-sbeller@google.com>
References: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 4/6] builtin/submodule--helper: store update_clone information
 in a struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
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
index 96929ba1096..fb54936efc7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1444,6 +1444,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
@@ -1463,8 +1469,9 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 
-	/* Machine-readable status lines to be consumed by git-submodule.sh */
-	struct string_list projectlines;
+	/* to be consumed by git-submodule.sh */
+	struct update_clone_data *update_clone;
+	int update_clone_nr; int update_clone_alloc;
 
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
+	ALLOC_GROW(suc->update_clone, suc->update_clone_nr + 1,
+		   suc->update_clone_alloc);
+	oidcpy(&suc->update_clone[suc->update_clone_nr].oid, &ce->oid);
+	suc->update_clone[suc->update_clone_nr].just_cloned = needs_cloning;
+	suc->update_clone[suc->update_clone_nr].sub = sub;
+	suc->update_clone_nr++;
 
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
2.18.0.233.g985f88cf7e-goog

