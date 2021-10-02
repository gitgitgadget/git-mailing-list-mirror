Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC69C433FE
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDB5619F7
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhJBUSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhJBUSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:18:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83557C0613EF
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:16:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w29so21522545wra.8
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnjDEpbhuQSrK/YsfFxBWyqnlniN9eCd0dxaLQWRTKc=;
        b=kS8JqspZEtcql4AJ2KxTgmG8U68NrSxjd6EB/MlFv2fPbRN6hWUWpiASdu3esGTwJE
         EnO4Zp7PLVgtuJoqrimtadLUGKlDcbgIzrTjwiwcoU3YgtTmlbsWtRtr38xdVOpRvQYP
         R4KlhpwIcelb2+Cj1quHFa63iVHHP1UsGP1hhTvOn2pl7siZExuOs46XXRVOl7huRqsz
         GkKZ3SNX3ZzRqlC54FclTXazUlixF3DYX99plMlWBLb0b+RhFQxvojyCKkFH7GNHZIEq
         OGeoJWA7Roa4A4BjFxJdZwGPDBx7A8qN1cQBxsDAOvq+dqZRuaDuFWZPJ5ILTxPdofTh
         sFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnjDEpbhuQSrK/YsfFxBWyqnlniN9eCd0dxaLQWRTKc=;
        b=oE4xdYK+wXnSzcpgD6i6yotxff0x+M+uwbZen9NXNxyY3hOv5to8mnHNtPZKL+PSMp
         sYHBdX8vWZPv9tOvmiGme4DuOI53hBAtKDzKRqQ8cmmjFEiuxZe78IWgujn2pfcKTkT2
         JfbQR/yunx9JfcOoset7HdnH7jx93ST/F4CSZTG3C7kDSU8v9vdZjf1k0vip3jOs3n0p
         xZkj4WrWwFGUxpzELJq49RJWpcfEJartapzf79hciVDcMdWYXSPVVO/pyPofVyN/v0WD
         xkTs7ikc01kGvGaoyEUBOky8ekZRl7uORIiug9F83fe1288sgZgqa4fpKBw+u7gIpqLw
         5FUg==
X-Gm-Message-State: AOAM532bzEJ4UZzIDMeAr2hpKKU56XBWwGJYHd4eF8u9KNsfpvxTjg1A
        azpMWQeM1LY4kiDlZHG9KRorczI4nOq0rw==
X-Google-Smtp-Source: ABdhPJzJJOr+l0j91OY9k9tIbf6xgaHHmwsLTBvqYGmFdz+9S9zM2aDwT1HupIZ0iWHzOlkCm+Dctg==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr4944198wri.300.1633205783874;
        Sat, 02 Oct 2021 13:16:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g2sm9946009wrb.20.2021.10.02.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:16:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/5] builtin/remote.c: add and use SHOW_INFO_INIT
Date:   Sat,  2 Oct 2021 22:16:17 +0200
Message-Id: <patch-v4-5.5-25fec54877b-20211002T201434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we introduced REF_STATES_INIT, but did not
change the "struct show_info" to have a corresponding
initializer. Let's do that, and make it use "REF_STATES_INIT" and
"STRING_LIST_INIT_DUP", doing that requires changing "list" and
"states" away from being pointers.

The resulting end-state is simpler since we omit the local "info_list"
and "states" variables in show() as well as the memset().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/remote.c | 90 ++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 160dd954f74..deb48772ac5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -972,26 +972,31 @@ static int get_remote_ref_states(const char *name,
 }
 
 struct show_info {
-	struct string_list *list;
-	struct ref_states *states;
+	struct string_list list;
+	struct ref_states states;
 	int width, width2;
 	int any_rebase;
 };
 
+#define SHOW_INFO_INIT { \
+	.list = STRING_LIST_INIT_DUP, \
+	.states = REF_STATES_INIT, \
+}
+
 static int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *info = cb_data;
 	int n = strlen(item->string);
 	if (n > info->width)
 		info->width = n;
-	string_list_insert(info->list, item->string);
+	string_list_insert(&info->list, item->string);
 	return 0;
 }
 
 static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *info = cb_data;
-	struct ref_states *states = info->states;
+	struct ref_states *states = &info->states;
 	const char *name = item->string;
 
 	if (states->queried) {
@@ -1018,7 +1023,7 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 static int add_local_to_show_info(struct string_list_item *branch_item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
-	struct ref_states *states = show_info->states;
+	struct ref_states *states = &show_info->states;
 	struct branch_info *branch_info = branch_item->util;
 	struct string_list_item *item;
 	int n;
@@ -1031,7 +1036,7 @@ static int add_local_to_show_info(struct string_list_item *branch_item, void *cb
 	if (branch_info->rebase >= REBASE_TRUE)
 		show_info->any_rebase = 1;
 
-	item = string_list_insert(show_info->list, branch_item->string);
+	item = string_list_insert(&show_info->list, branch_item->string);
 	item->util = branch_info;
 
 	return 0;
@@ -1086,7 +1091,7 @@ static int add_push_to_show_info(struct string_list_item *push_item, void *cb_da
 		show_info->width = n;
 	if ((n = strlen(push_info->dest)) > show_info->width2)
 		show_info->width2 = n;
-	item = string_list_append(show_info->list, push_item->string);
+	item = string_list_append(&show_info->list, push_item->string);
 	item->util = push_item->util;
 	return 0;
 }
@@ -1214,9 +1219,7 @@ static int show(int argc, const char **argv)
 		OPT_BOOL('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
 	};
-	struct ref_states states = REF_STATES_INIT;
-	struct string_list info_list = STRING_LIST_INIT_NODUP;
-	struct show_info info;
+	struct show_info info = SHOW_INFO_INIT;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
 			     0);
@@ -1227,25 +1230,22 @@ static int show(int argc, const char **argv)
 	if (!no_query)
 		query_flag = (GET_REF_STATES | GET_HEAD_NAMES | GET_PUSH_REF_STATES);
 
-	memset(&info, 0, sizeof(info));
-	info.states = &states;
-	info.list = &info_list;
 	for (; argc; argc--, argv++) {
 		int i;
 		const char **url;
 		int url_nr;
 
-		get_remote_ref_states(*argv, &states, query_flag);
+		get_remote_ref_states(*argv, &info.states, query_flag);
 
 		printf_ln(_("* remote %s"), *argv);
-		printf_ln(_("  Fetch URL: %s"), states.remote->url_nr > 0 ?
-		       states.remote->url[0] : _("(no URL)"));
-		if (states.remote->pushurl_nr) {
-			url = states.remote->pushurl;
-			url_nr = states.remote->pushurl_nr;
+		printf_ln(_("  Fetch URL: %s"), info.states.remote->url_nr > 0 ?
+		       info.states.remote->url[0] : _("(no URL)"));
+		if (info.states.remote->pushurl_nr) {
+			url = info.states.remote->pushurl;
+			url_nr = info.states.remote->pushurl_nr;
 		} else {
-			url = states.remote->url;
-			url_nr = states.remote->url_nr;
+			url = info.states.remote->url;
+			url_nr = info.states.remote->url_nr;
 		}
 		for (i = 0; i < url_nr; i++)
 			/*
@@ -1258,57 +1258,57 @@ static int show(int argc, const char **argv)
 			printf_ln(_("  Push  URL: %s"), _("(no URL)"));
 		if (no_query)
 			printf_ln(_("  HEAD branch: %s"), _("(not queried)"));
-		else if (!states.heads.nr)
+		else if (!info.states.heads.nr)
 			printf_ln(_("  HEAD branch: %s"), _("(unknown)"));
-		else if (states.heads.nr == 1)
-			printf_ln(_("  HEAD branch: %s"), states.heads.items[0].string);
+		else if (info.states.heads.nr == 1)
+			printf_ln(_("  HEAD branch: %s"), info.states.heads.items[0].string);
 		else {
 			printf(_("  HEAD branch (remote HEAD is ambiguous,"
 				 " may be one of the following):\n"));
-			for (i = 0; i < states.heads.nr; i++)
-				printf("    %s\n", states.heads.items[i].string);
+			for (i = 0; i < info.states.heads.nr; i++)
+				printf("    %s\n", info.states.heads.items[i].string);
 		}
 
 		/* remote branch info */
 		info.width = 0;
-		for_each_string_list(&states.new_refs, add_remote_to_show_info, &info);
-		for_each_string_list(&states.tracked, add_remote_to_show_info, &info);
-		for_each_string_list(&states.stale, add_remote_to_show_info, &info);
-		if (info.list->nr)
+		for_each_string_list(&info.states.new_refs, add_remote_to_show_info, &info);
+		for_each_string_list(&info.states.tracked, add_remote_to_show_info, &info);
+		for_each_string_list(&info.states.stale, add_remote_to_show_info, &info);
+		if (info.list.nr)
 			printf_ln(Q_("  Remote branch:%s",
 				     "  Remote branches:%s",
-				     info.list->nr),
+				     info.list.nr),
 				  no_query ? _(" (status not queried)") : "");
-		for_each_string_list(info.list, show_remote_info_item, &info);
-		string_list_clear(info.list, 0);
+		for_each_string_list(&info.list, show_remote_info_item, &info);
+		string_list_clear(&info.list, 0);
 
 		/* git pull info */
 		info.width = 0;
 		info.any_rebase = 0;
 		for_each_string_list(&branch_list, add_local_to_show_info, &info);
-		if (info.list->nr)
+		if (info.list.nr)
 			printf_ln(Q_("  Local branch configured for 'git pull':",
 				     "  Local branches configured for 'git pull':",
-				     info.list->nr));
-		for_each_string_list(info.list, show_local_info_item, &info);
-		string_list_clear(info.list, 0);
+				     info.list.nr));
+		for_each_string_list(&info.list, show_local_info_item, &info);
+		string_list_clear(&info.list, 0);
 
 		/* git push info */
-		if (states.remote->mirror)
+		if (info.states.remote->mirror)
 			printf_ln(_("  Local refs will be mirrored by 'git push'"));
 
 		info.width = info.width2 = 0;
-		for_each_string_list(&states.push, add_push_to_show_info, &info);
-		QSORT(info.list->items, info.list->nr, cmp_string_with_push);
-		if (info.list->nr)
+		for_each_string_list(&info.states.push, add_push_to_show_info, &info);
+		QSORT(info.list.items, info.list.nr, cmp_string_with_push);
+		if (info.list.nr)
 			printf_ln(Q_("  Local ref configured for 'git push'%s:",
 				     "  Local refs configured for 'git push'%s:",
-				     info.list->nr),
+				     info.list.nr),
 				  no_query ? _(" (status not queried)") : "");
-		for_each_string_list(info.list, show_push_info_item, &info);
-		string_list_clear(info.list, 0);
+		for_each_string_list(&info.list, show_push_info_item, &info);
+		string_list_clear(&info.list, 0);
 
-		free_remote_ref_states(&states);
+		free_remote_ref_states(&info.states);
 	}
 
 	return result;
-- 
2.33.0.1380.g193143c62ce

