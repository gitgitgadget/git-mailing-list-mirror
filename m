Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABA31F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeELIA7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36511 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeELIAn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id t129-v6so11047682lff.3
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijiPJk1elyL5yuv0Biyo86OqMEXCZDdGl3I1Y3qcdNs=;
        b=N8YR/g32yg6RsGypfx5maF7ylUoxzR37Qp3/8WQ4CjRSdDalhg+30+Ua042pw82mlb
         Zo3wVwy+A9zI4KKXFvcTnc+T0vWtS7fI7E3TdWz7qcQkXMPrRlVMeZN0dr+mzmJGV4gR
         REH7aHhCWeKroymRbKlWiv4g550T/L3Ay9bEtRyRne01DDMY1Z1w+rufEArfbBgNckG4
         KCqI++ntXWzqhZ/u10VYyhg3nEdBKoXo1cJBevBkTjBxpM6oWGVWRbGU407zlmE0La6p
         XnPk5BcIs6C56bGoCw/73jod/m38cq68rshmphKRdDlCZg8axQ/kJOnWl+EGEu+MrE8Q
         4atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijiPJk1elyL5yuv0Biyo86OqMEXCZDdGl3I1Y3qcdNs=;
        b=Qx/hzq97ov+uGeNzcqWlAjxkdDqrZkuz91CXXA+9eYfdA8iK2L4K4nOXLCnKW6Gc1Y
         3RfhgBH0P7RxBm566OxF9LaASaD6TqSTg0/wTAaxHni0cT/rs3XuE4s5PICVszv1Rjav
         L2VLGh0SoPdDVK7tmGx7So2m+Y1qVvsL2EBpMFD4IpO6PZ2H8drKkDcxAIgQ72FvSsuB
         MJOIR8/Iw8xe1su/4WJaAx7pQxsl5d81qtsKAOMsjxGzlRhUhJVslZ5+puCMYzp3Wll3
         JdJFlyVFI5iZoQ0MBZCjYOh4dQ+x9n9TUE7+OnetQLwm0tbN+p0XZhptNqbf0cjYyyp5
         9Puw==
X-Gm-Message-State: ALKqPwfKyomp+XRxeFVSULOohdb6Q31Dp9u99Qa/RM2B9RCbKv8qLfab
        sabduWcV+/2oLDT86CEqguef4A==
X-Google-Smtp-Source: AB8JxZoRhnmPHa8/l4RK7rNXRhUcEHIZjG7ORg8+TAWZpAGaYNeuk8yITtMHp4GkA3J4+Nxoazcq3A==
X-Received: by 2002:a19:1760:: with SMTP id n93-v6mr3045432lfi.113.1526112041173;
        Sat, 12 May 2018 01:00:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/12] show-branch: use commit-slab for commit-name instead of commit->util
Date:   Sat, 12 May 2018 10:00:25 +0200
Message-Id: <20180512080028.29611-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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

