Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0BA1F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbeELIAh (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36496 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeELIAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:34 -0400
Received: by mail-lf0-f66.google.com with SMTP id t129-v6so11047384lff.3
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9q1Vcyo/klVwxvDuug07mBndb/zI6LwlT8ut6iCL0hM=;
        b=vFpwZJqNRMfU8+IIOQLZu0RAI851/9+m3MnNC1zEv6NSFctLi1iFFIR0CIvZRb9+Jr
         ibxhKSUDVSHpw+FprNpaRqsg1U7KTsjI0hMo33dOnipdLyztEuXtXpmRZtSMlNkTUKuV
         B2Ht/ZiaSe/ohj0+JSDO3VTzN2KhCvTxa+SYJRAg5V8cC/GyoWZ0PfmdjJ1Fieco4inr
         +vOt0ZjlIlzt8i6Pi//n53irIQjNt2atSHW4c0BQl8/5hjEjWUNLvyfFJqKxbGQbOR2N
         DUPh+hPJX27l0V5XFaWXRUqJyCN97xNTvsqIC5G22G4zK2mL8q9YKzo0a7y6BaqoVDjx
         rFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9q1Vcyo/klVwxvDuug07mBndb/zI6LwlT8ut6iCL0hM=;
        b=ir8dYnm6yn3YGvK5Z1LUKk7QypTx02U7JlUgsdFk4SSI2NlTt7yAGfmy0wFi4gfq4E
         E21GogxQb2xtaN4JqiXto4XsG7WXDGE8W/JGqsdTMitXPrW6qDKVHYA1xAFeDnmA65TU
         76xv8a+h6Pcz1EW31XO1zkq7mq72zcS8rCjd16k5i5PQzI9ZrS7dMcz6uPCT5FBSCdry
         9WY5vpPCn3PyIuF2mE+lpvBzWX92tTp+0QDiq9WqSZgdC3AcI7xuq3m275S305QF7c4O
         GkXRKKxouxZSJ7ISG96707uf1HE6GM9ZJUxleSQlNfvCEqn8ybsR3IbLCDgq6ZdXKFkr
         beWw==
X-Gm-Message-State: ALKqPwdsGWrm0V7pPBNMv60grS4/KSvW7ax3nkeOg+GSn7CooFG2d3Ii
        MaPsK73+oqBv8lOM1EMkhD1zLw==
X-Google-Smtp-Source: AB8JxZpw5qg+rWojn3g0aPLni+3H3j0J8S2G1he4IbrNemDDzvVi/vH5BCI6zwBaT1F1g140ddmDnQ==
X-Received: by 2002:a2e:5559:: with SMTP id j86-v6mr548520ljb.147.1526112033010;
        Sat, 12 May 2018 01:00:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/12] blame: use commit-slab for blame suspects instead of commit->util
Date:   Sat, 12 May 2018 10:00:17 +0200
Message-Id: <20180512080028.29611-2-pclouds@gmail.com>
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
 blame.c         | 42 +++++++++++++++++++++++++++++++-----------
 blame.h         |  2 ++
 builtin/blame.c |  2 +-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/blame.c b/blame.c
index 78c9808bd1..18e8bd996a 100644
--- a/blame.c
+++ b/blame.c
@@ -6,6 +6,24 @@
 #include "diffcore.h"
 #include "tag.h"
 #include "blame.h"
+#include "commit-slab.h"
+
+define_commit_slab(blame_suspects, struct blame_origin *);
+static struct blame_suspects blame_suspects;
+
+struct blame_origin *get_blame_suspects(struct commit *commit)
+{
+	struct blame_origin **result;
+
+	result = blame_suspects_peek(&blame_suspects, commit);
+
+	return result ? *result : NULL;
+}
+
+static void set_blame_suspects(struct commit *commit, struct blame_origin *origin)
+{
+	*blame_suspects_at(&blame_suspects, commit) = origin;
+}
 
 void blame_origin_decref(struct blame_origin *o)
 {
@@ -15,12 +33,12 @@ void blame_origin_decref(struct blame_origin *o)
 			blame_origin_decref(o->previous);
 		free(o->file.ptr);
 		/* Should be present exactly once in commit chain */
-		for (p = o->commit->util; p; l = p, p = p->next) {
+		for (p = get_blame_suspects(o->commit); p; l = p, p = p->next) {
 			if (p == o) {
 				if (l)
 					l->next = p->next;
 				else
-					o->commit->util = p->next;
+					set_blame_suspects(o->commit, p->next);
 				free(o);
 				return;
 			}
@@ -41,8 +59,8 @@ static struct blame_origin *make_origin(struct commit *commit, const char *path)
 	FLEX_ALLOC_STR(o, path, path);
 	o->commit = commit;
 	o->refcnt = 1;
-	o->next = commit->util;
-	commit->util = o;
+	o->next = get_blame_suspects(commit);
+	set_blame_suspects(commit, o);
 	return o;
 }
 
@@ -54,13 +72,13 @@ static struct blame_origin *get_origin(struct commit *commit, const char *path)
 {
 	struct blame_origin *o, *l;
 
-	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
+	for (o = get_blame_suspects(commit), l = NULL; o; l = o, o = o->next) {
 		if (!strcmp(o->path, path)) {
 			/* bump to front */
 			if (l) {
 				l->next = o->next;
-				o->next = commit->util;
-				commit->util = o;
+				o->next = get_blame_suspects(commit);
+				set_blame_suspects(commit, o);
 			}
 			return blame_origin_incref(o);
 		}
@@ -478,7 +496,7 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
 		porigin->suspects = blame_merge(porigin->suspects, sorted);
 	else {
 		struct blame_origin *o;
-		for (o = porigin->commit->util; o; o = o->next) {
+		for (o = get_blame_suspects(porigin->commit); o; o = o->next) {
 			if (o->suspects) {
 				porigin->suspects = sorted;
 				return;
@@ -525,7 +543,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 	const char *paths[2];
 
 	/* First check any existing origins */
-	for (porigin = parent->util; porigin; porigin = porigin->next)
+	for (porigin = get_blame_suspects(parent); porigin; porigin = porigin->next)
 		if (!strcmp(porigin->path, origin->path)) {
 			/*
 			 * The same path between origin and its parent
@@ -1550,7 +1568,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 
 	while (commit) {
 		struct blame_entry *ent;
-		struct blame_origin *suspect = commit->util;
+		struct blame_origin *suspect = get_blame_suspects(commit);
 
 		/* find one suspect to break down */
 		while (suspect && !suspect->suspects)
@@ -1752,6 +1770,8 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	struct commit *final_commit = NULL;
 	enum object_type type;
 
+	init_blame_suspects(&blame_suspects);
+
 	if (sb->reverse && sb->contents_from)
 		die(_("--contents and --reverse do not blend well."));
 
@@ -1815,7 +1835,7 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	}
 
 	if (is_null_oid(&sb->final->object.oid)) {
-		o = sb->final->util;
+		o = get_blame_suspects(sb->final);
 		sb->final_buf = xmemdupz(o->file.ptr, o->file.size);
 		sb->final_buf_size = o->file.size;
 	}
diff --git a/blame.h b/blame.h
index a6c915c277..2092f9529c 100644
--- a/blame.h
+++ b/blame.h
@@ -172,4 +172,6 @@ extern void setup_scoreboard(struct blame_scoreboard *sb, const char *path, stru
 
 extern struct blame_entry *blame_entry_prepend(struct blame_entry *head, long start, long end, struct blame_origin *o);
 
+extern struct blame_origin *get_blame_suspects(struct commit *commit);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index db38c0b307..969572810d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -457,7 +457,7 @@ static void output(struct blame_scoreboard *sb, int option)
 			struct commit *commit = ent->suspect->commit;
 			if (commit->object.flags & MORE_THAN_ONE_PATH)
 				continue;
-			for (suspect = commit->util; suspect; suspect = suspect->next) {
+			for (suspect = get_blame_suspects(commit); suspect; suspect = suspect->next) {
 				if (suspect->guilty && count++) {
 					commit->object.flags |= MORE_THAN_ONE_PATH;
 					break;
-- 
2.17.0.705.g3525833791

