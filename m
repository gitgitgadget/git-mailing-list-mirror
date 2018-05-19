Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBDE1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeESF3Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:29:16 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34198 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeESF2r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:47 -0400
Received: by mail-lf0-f66.google.com with SMTP id x145-v6so4862358lff.1
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k9IZpUizKvwYtOetAF8Uep13g9cfNHiutEfWUvMzaCc=;
        b=uHteLFD1nncm8wOHIIoPUL4Lh8zlzIxtTDlmqdPUniee6iJRUKqOOPIl4EyCF7Awwm
         cpWSi8PJQxdl9I+MvoguP8dYjvYr4+eJ7LnrGMDhlW0TuVb+cQPiaUMia1VK11ztk2HU
         C4XYzUUdUa+oCIsLOTGVEDhFGORPb5YbaYDWbzHEMKmxUxAgrx+WIOHfwMajWpHYC1yy
         rf/Foo0SDIJYfev82JyKH76My0UeLlqUmjoUe6VKzZjG5iigh6oA4QEtT6hdpWZaMr54
         hfYkeDssRpgG93J6Zk6JWfzuzZpauKyCb8RcbYeFGgeXpBD86GNUC3Xjj5szJrpxakOY
         1VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k9IZpUizKvwYtOetAF8Uep13g9cfNHiutEfWUvMzaCc=;
        b=C1RZVOj0drP0R/U9MI8j1RVCv7Jcgm1q1X32hbhCLkRiE3lSIFQ0EFJofTAmKNMZzV
         yzLy/b28s324b9C3fbZoS+iZOZ4M7kwulyEa9/hYsjr0Apgy1e6SFXgGDsHs03ehnD/a
         Yw3Cz7ZxZnBAYfskoDY6wq2CKim7h2yuxRlEqKbgRM1sE49R7d+E+bezFSM8WwcPDVVs
         dEmcNDcZg+OELEZ12Ikbu3X5cv4AEDE7VfpZJdfX9FSCVOOmPoQkA16pQlVHuoRT3Fj9
         gTmStkwoGtvAbMEyYcpXangToxJ/NMhXX/xJ5Jox419oy8mfcehM2X6AkG0JQsZ2UEnp
         NLQQ==
X-Gm-Message-State: ALKqPwc97VgcR/m6ukJ9gC6ico/UpL5AXB0IEIPQNb2yE337uLxmkdEt
        pXj5OVfKYGTghXxINBN05Ek=
X-Google-Smtp-Source: AB8JxZogZaJLQlIqhboaTpa9Z63gzfgpd/juLtrJn8TzbjnEyIRD3j/5X4kIF9h26cU27AemJv6PZA==
X-Received: by 2002:a2e:9158:: with SMTP id q24-v6mr7217865ljg.73.1526707726239;
        Fri, 18 May 2018 22:28:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 10/15] name-rev: use commit-slab for rev-name instead of commit->util
Date:   Sat, 19 May 2018 07:28:26 +0200
Message-Id: <20180519052831.12603-11-pclouds@gmail.com>
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

