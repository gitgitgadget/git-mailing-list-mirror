Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CF51F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbeIUVrn (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39798 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390577AbeIUVrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so12117573lji.6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5hf/A7kWPpl7L3qxITnZiIJmea+wgGqPXNfV1UQmNY=;
        b=KrZ4WinN4ZmV7piq+NV9enF+OAN/ACUKOoqGqJBg1bbhNagnLBgabWdi4SF5tK3PkY
         5RMA67or+gPaV/4e18oax5P9WXGNCk2dAsWFxRXO9YwjQ5Dc8BK8oXgMh1ocmzEXslDp
         qgMwN7ZJZKuhV6vkrOfBdBHRGow2DmjNmQcACVbHwkS5WXLsYZADC7giVQe8iUAeD0ZF
         16TbZ5clSU8OM8Qv5uCCoXMlQMf68n4FNuVApxZWAx1QxWOkdMAG8hSxZdgRyBBktatQ
         GJcHbPC8Uuxbw6iOg6pialzZ207l/xeg2oM5YPoESGWbDiDpFWBpR4I73H2lp6PUUUNw
         Y6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5hf/A7kWPpl7L3qxITnZiIJmea+wgGqPXNfV1UQmNY=;
        b=oD2X61LbcmKxdGupFNPVNhVw4w3OpM3QeJzT/F4JKB4Omok2UD3hgZkjguI1GqkrIh
         UDwveekptHI6MNXoPF/P311qqhlaT/UrsIdbT21Tx/y5XW8NAt0UOGLIJ0h8orhpEzMm
         pZMOIVWCLX1FkTSIqol15WVwuxp6rl9ClmZv7IYOeLq0UU7Gfu2CfNCr1beZdswaxjWL
         3Rk8r+Q8mMhK7m3iI92QYl3CPe2coEgWNJ1ZIAf1y3BoqrcpwLOmvvtJLLOAoeVVw1cR
         yGeBZwZ+u9Wv7ztPlPfIpy1PsxUUhf0MCdIa5VdmlWWKVaOFQElu5XXrPXHoJDXsNFI7
         UXpg==
X-Gm-Message-State: ABuFfoiWkFixbTSvPr5J5gmPYOw2CRpHROoBjvHoiXjCuBohO+g8w3kT
        3xu0KgBzU5z3aFlq+1es63k=
X-Google-Smtp-Source: ANB0VdYyMHXcspfv9lucLdqVTSPwMW/+XePSRB4FF9ohri8/kWigeXrl2rCwTgPi7PVssh3qWaec4w==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr1370687ljc.148.1537545489523;
        Fri, 21 Sep 2018 08:58:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:58:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 19/23] submodule.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:35 +0200
Message-Id: <20180921155739.14407-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c |  2 +-
 submodule.c    | 28 +++++++++++++++++-----------
 submodule.h    |  9 ++++++---
 transport.c    |  9 ++++++---
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 33b7100837..9c455984d1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -944,7 +944,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
-		    submodule_touches_in_range(&rebase_fork_point, &curr_head))
+		    submodule_touches_in_range(&the_index, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
diff --git a/submodule.c b/submodule.c
index a2b266fbfa..58427b5dfc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -766,7 +766,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
  * have a corresponding 'struct oid_array' (in the 'util' field) which lists
  * what the submodule pointers were updated to during the change.
  */
-static void collect_changed_submodules(struct string_list *changed,
+static void collect_changed_submodules(struct index_state *istate,
+				       struct string_list *changed,
 				       struct argv_array *argv)
 {
 	struct rev_info rev;
@@ -930,8 +931,10 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 	return 0;
 }
 
-int find_unpushed_submodules(struct oid_array *commits,
-		const char *remotes_name, struct string_list *needs_pushing)
+int find_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
+			     const char *remotes_name,
+			     struct string_list *needs_pushing)
 {
 	struct string_list submodules = STRING_LIST_INIT_DUP;
 	struct string_list_item *name;
@@ -943,7 +946,7 @@ int find_unpushed_submodules(struct oid_array *commits,
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	collect_changed_submodules(&submodules, &argv);
+	collect_changed_submodules(istate, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
 		struct oid_array *commits = name->util;
@@ -1044,7 +1047,8 @@ static void submodule_push_check(const char *path, const char *head,
 		die("process for submodule '%s' failed", path);
 }
 
-int push_unpushed_submodules(struct oid_array *commits,
+int push_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
@@ -1053,7 +1057,8 @@ int push_unpushed_submodules(struct oid_array *commits,
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(commits, remote->name, &needs_pushing))
+	if (!find_unpushed_submodules(istate, commits,
+				      remote->name, &needs_pushing))
 		return 1;
 
 	/*
@@ -1110,7 +1115,7 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(void)
+static void calculate_changed_submodule_paths(struct index_state *istate)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1131,7 +1136,7 @@ static void calculate_changed_submodule_paths(void)
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(istate, &changed_submodules, &argv);
 
 	for_each_string_list_item(name, &changed_submodules) {
 		struct oid_array *commits = name->util;
@@ -1158,7 +1163,8 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
-int submodule_touches_in_range(struct object_id *excl_oid,
+int submodule_touches_in_range(struct index_state *istate,
+			       struct object_id *excl_oid,
 			       struct object_id *incl_oid)
 {
 	struct string_list subs = STRING_LIST_INIT_DUP;
@@ -1176,7 +1182,7 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 		argv_array_push(&args, oid_to_hex(excl_oid));
 	}
 
-	collect_changed_submodules(&subs, &args);
+	collect_changed_submodules(istate, &subs, &args);
 	ret = subs.nr;
 
 	argv_array_clear(&args);
@@ -1346,7 +1352,7 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
+	calculate_changed_submodule_paths(r->index);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
diff --git a/submodule.h b/submodule.h
index e452919aa4..4826601ff2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -102,13 +102,16 @@ int add_submodule_odb(const char *path);
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
  */
-int submodule_touches_in_range(struct object_id *a,
+int submodule_touches_in_range(struct index_state *istate,
+			       struct object_id *a,
 			       struct object_id *b);
-int find_unpushed_submodules(struct oid_array *commits,
+int find_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing);
 struct refspec;
-int push_unpushed_submodules(struct oid_array *commits,
+int push_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
diff --git a/transport.c b/transport.c
index 06ffea2774..cb40a23d45 100644
--- a/transport.c
+++ b/transport.c
@@ -1139,7 +1139,8 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(&commits,
+			if (!push_unpushed_submodules(&the_index,
+						      &commits,
 						      transport->remote,
 						      rs,
 						      transport->push_options,
@@ -1163,8 +1164,10 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(&commits, transport->remote->name,
-						&needs_pushing)) {
+			if (find_unpushed_submodules(&the_index,
+						     &commits,
+						     transport->remote->name,
+						     &needs_pushing)) {
 				oid_array_clear(&commits);
 				die_with_unpushed_submodules(&needs_pushing);
 			}
-- 
2.19.0.640.gcd3aa10a8a

