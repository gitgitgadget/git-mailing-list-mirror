Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E98C1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeESF3L (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:29:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45173 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeESF2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id w202-v6so16838726lff.12
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C6KiMUAGz7wi/MERK2bRJ0c6Iso094xJ4Ig4ECMPvLI=;
        b=JWhBWqfPQe0B/8jQkC+aS0K2V5n5xMmwipEg7il52rj2DuJLLURbuvoBQR6qtyPtVl
         ltWCtReYyQI6OCA0xBmEtdPOLeEybZ5O5ilFOI/s44Os0yCYoWBownc/MLqdK//VyXw+
         KKvU1jc1Hw/matf3tEP80wExDO6tDagZDRCnLmeFgSIVvVLiMYWqtllCQdSMgQcIz+7z
         m1PEgpPx/GDcxO02XPVzZKUN5eneJXkUvnj8S0yAaOAKZnjqOsIH84z6J5ZcDCVUSMSl
         swOakPEuOODNmzQOCDTHw4mRKf8vK3bgueL4W4BMhB9cIrNOayo14DuGVe0+sSMUUFiF
         mIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C6KiMUAGz7wi/MERK2bRJ0c6Iso094xJ4Ig4ECMPvLI=;
        b=QNbDhT0lmP0r+xkglOo04gd4yyikcC2IpJE3qhSoBdmOi3exI4kesXCDNb9IGgeev9
         69s4lHHozkJ10R1/Ii2RjqkDpVFuMJ/W6ZhfSECsEn+mvfbfihxxfI8bulGATvFD4kTk
         uA2EZPqUgPLhIJVs7SdrCsTyX3RjMS2oRMpTTTAS3kt9wahODFxg8uBwafRB2MHMVj+2
         crjZztN/gr1Oful7IprcMaVqoEva3aohkkI+IkVYK+3N++jgW9/DiyXvtuXJI4OWZLcu
         ZAL54Y0ugklu8Kz82nKpg+mzVem5ImXZSlO7gaUG1SdhHrc8f3w6XaOZaK4uFPF8aQ92
         +vaw==
X-Gm-Message-State: ALKqPwfQz0zD6iy2g+vdM1ak3MhyBbuJGTUr08POxCmxKMRtxTL28SBP
        0aEDqtef93SBefZozfZbczQ=
X-Google-Smtp-Source: AB8JxZoZJA2RBscWwc2UrCTDx37AhaUMyd8FXpiFyrPR4mtauKpYFlbj4kSDYEStUzasL1+K7y397Q==
X-Received: by 2002:a2e:8993:: with SMTP id c19-v6mr7534053lji.123.1526707727383;
        Fri, 18 May 2018 22:28:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 11/15] show-branch: use commit-slab for commit-name instead of commit->util
Date:   Sat, 19 May 2018 07:28:27 +0200
Message-Id: <20180519052831.12603-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.
---
 builtin/show-branch.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 6c2148b71d..29d15d16d2 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -7,6 +7,7 @@
 #include "argv-array.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "commit-slab.h"
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
@@ -59,15 +60,27 @@ struct commit_name {
 	int generation; /* how many parents away from head_name */
 };
 
+define_commit_slab(commit_name_slab, struct commit_name *);
+static struct commit_name_slab name_slab;
+
+static struct commit_name *commit_to_name(struct commit *commit)
+{
+	return *commit_name_slab_at(&name_slab, commit);
+}
+
+
 /* Name the commit as nth generation ancestor of head_name;
  * we count only the first-parent relationship for naming purposes.
  */
 static void name_commit(struct commit *commit, const char *head_name, int nth)
 {
 	struct commit_name *name;
-	if (!commit->util)
-		commit->util = xmalloc(sizeof(struct commit_name));
-	name = commit->util;
+
+	name = *commit_name_slab_at(&name_slab, commit);
+	if (!name) {
+		name = xmalloc(sizeof(*name));
+		*commit_name_slab_at(&name_slab, commit) = name;
+	}
 	name->head_name = head_name;
 	name->generation = nth;
 }
@@ -79,8 +92,8 @@ static void name_commit(struct commit *commit, const char *head_name, int nth)
  */
 static void name_parent(struct commit *commit, struct commit *parent)
 {
-	struct commit_name *commit_name = commit->util;
-	struct commit_name *parent_name = parent->util;
+	struct commit_name *commit_name = commit_to_name(commit);
+	struct commit_name *parent_name = commit_to_name(parent);
 	if (!commit_name)
 		return;
 	if (!parent_name ||
@@ -94,12 +107,12 @@ static int name_first_parent_chain(struct commit *c)
 	int i = 0;
 	while (c) {
 		struct commit *p;
-		if (!c->util)
+		if (!commit_to_name(c))
 			break;
 		if (!c->parents)
 			break;
 		p = c->parents->item;
-		if (!p->util) {
+		if (!commit_to_name(p)) {
 			name_parent(c, p);
 			i++;
 		}
@@ -122,7 +135,7 @@ static void name_commits(struct commit_list *list,
 	/* First give names to the given heads */
 	for (cl = list; cl; cl = cl->next) {
 		c = cl->item;
-		if (c->util)
+		if (commit_to_name(c))
 			continue;
 		for (i = 0; i < num_rev; i++) {
 			if (rev[i] == c) {
@@ -148,9 +161,9 @@ static void name_commits(struct commit_list *list,
 			struct commit_name *n;
 			int nth;
 			c = cl->item;
-			if (!c->util)
+			if (!commit_to_name(c))
 				continue;
-			n = c->util;
+			n = commit_to_name(c);
 			parents = c->parents;
 			nth = 0;
 			while (parents) {
@@ -158,7 +171,7 @@ static void name_commits(struct commit_list *list,
 				struct strbuf newname = STRBUF_INIT;
 				parents = parents->next;
 				nth++;
-				if (p->util)
+				if (commit_to_name(p))
 					continue;
 				switch (n->generation) {
 				case 0:
@@ -271,7 +284,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 {
 	struct strbuf pretty = STRBUF_INIT;
 	const char *pretty_str = "(unavailable)";
-	struct commit_name *name = commit->util;
+	struct commit_name *name = commit_to_name(commit);
 
 	if (commit->object.parsed) {
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
@@ -660,6 +673,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
+	init_commit_name_slab(&name_slab);
+
 	git_config(git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
-- 
2.17.0.705.g3525833791

