Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0A51F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeELIBD (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:01:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38985 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeELIAl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id j193-v6so11056009lfg.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNw60YK45KTxBb/ak8D55j1bp9aQb/W8Gr/+QJAdf6o=;
        b=Wnt2zoh0FPNhSxTAkUZvfY/0UdMKQohk9Hcv9UjpwTlvMOHXJHc5vfDklj8Pyuw1lN
         9ltFKw2norPvqe88+o+SrOyirYDS0DJbGHKzMI/KG2VgQkWJkpxxIX5bdXonOWaI9mB2
         rJqax7P1FnJSmKi4N+WH5kMTNAaq8b3QoPdHAeUWr6y+V8JWdSaSrt3UeWY3s2lsTRG+
         TbTL8TVMoIahz+/mgrlIGJnPQVUBz9IKgL35vulSYYDih+NoubueBNwuNrFg1W8QY/hT
         OzJqsalTQX2ngeDBBKFZVsuS2Nzdb8NGoiwluUa639eygz0RronIOYXVJrH9GFfoL4ai
         ZWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNw60YK45KTxBb/ak8D55j1bp9aQb/W8Gr/+QJAdf6o=;
        b=f58m4HXIrIS3MEzt/JWK8JIA7RDBDRtBrVn5R4O8sFpInLdnaWp41KsvHB71y1Suc4
         EEUlcnskE9QN5NMCxVZsHRmhOP+bJuOwtVbAZXmUeIoEmdPu+JjVdpkBv5Y4jV5vgunT
         KfdVyvOkNB51VqPtW6mxiLk8a/tNnnWrXZn8RnjRj+Bh8USTvPVRSMonY3/r5GKTcwsI
         V7OJNZsO/aBL8T4ZOXD8gMPAzCKY4roeiuCcrHj8CDqlHO2loFPq7fI+VlRakDN5LUrJ
         VS+PxCP2pW63E9xlihYX0sYMp/FtOFkUUzA1tRkSDIvnUJh3l0lZA9oEWFEGudQ58O4G
         rVoA==
X-Gm-Message-State: ALKqPwdN2BHgyxpetLhL/St69nBy94mgqF/fAtBATjJzkDkRp9TZjAzR
        JW42yNQ1rDM/6skSy0BJpZ1BmQ==
X-Google-Smtp-Source: AB8JxZrrRvg9zzj9If85jB5imhbABAzLCxjZ3FDeNa497+BFe1WXmIsZT+2iIpu6bZWQWFf5gJNy6A==
X-Received: by 2002:a19:18e9:: with SMTP id 102-v6mr743830lfy.10.1526112040152;
        Sat, 12 May 2018 01:00:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/12] name-rev: use commit-slab for rev-name instead of commit->util
Date:   Sat, 12 May 2018 10:00:24 +0200
Message-Id: <20180512080028.29611-9-pclouds@gmail.com>
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
 builtin/name-rev.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 387ddf85d2..0eb440359d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "sha1-lookup.h"
+#include "commit-slab.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -17,11 +18,26 @@ typedef struct rev_name {
 	int from_tag;
 } rev_name;
 
+define_commit_slab(commit_rev_name, struct rev_name *);
+
 static timestamp_t cutoff = TIME_MAX;
+static struct commit_rev_name rev_names;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
+static struct rev_name *get_commit_rev_name(struct commit *commit)
+{
+	struct rev_name **slot = commit_rev_name_peek(&rev_names, commit);
+
+	return slot ? *slot : NULL;
+}
+
+static void set_commit_rev_name(struct commit *commit, struct rev_name *name)
+{
+	*commit_rev_name_at(&rev_names, commit) = name;
+}
+
 static int is_better_name(struct rev_name *name,
 			  const char *tip_name,
 			  timestamp_t taggerdate,
@@ -65,7 +81,7 @@ static void name_rev(struct commit *commit,
 		int generation, int distance, int from_tag,
 		int deref)
 {
-	struct rev_name *name = (struct rev_name *)commit->util;
+	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 	char *to_free = NULL;
@@ -84,7 +100,7 @@ static void name_rev(struct commit *commit,
 
 	if (name == NULL) {
 		name = xmalloc(sizeof(rev_name));
-		commit->util = name;
+		set_commit_rev_name(commit, name);
 		goto copy_data;
 	} else if (is_better_name(name, tip_name, taggerdate,
 				  generation, distance, from_tag)) {
@@ -296,7 +312,7 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (o->type != OBJ_COMMIT)
 		return get_exact_ref_match(o);
 	c = (struct commit *) o;
-	n = c->util;
+	n = get_commit_rev_name(c);
 	if (!n)
 		return NULL;
 
@@ -413,6 +429,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	init_commit_rev_name(&rev_names);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (all + transform_stdin + !!argc > 1) {
-- 
2.17.0.705.g3525833791

