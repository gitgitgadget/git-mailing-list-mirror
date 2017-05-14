Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962BA20188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758827AbdENDQd (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:33 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36699 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbdENDQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:18 -0400
Received: by mail-oi0-f65.google.com with SMTP id w138so14313547oiw.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BPFtTd6RQYscxQ0fQMf9Ao+ClKlP+5IQLT6ynk/ooMU=;
        b=jU33ryoit1ro2Lxky0Mf3QpsGB7dfZeMgUnJz4SxFYKpTPy0Vim3F1lMQVsLvatfVt
         TtFA5wBTQEZdjKuZZZmlnL5+PJd6K5JE+An1MxNbYBiv7R+96OBPOssxE4+25xTXI0U9
         HiHJsBfDc+IyB5zexf++UWH7pRnS/m90PVsOy+0kjZuECnugx84AJ8wCGOi32pQdhO7H
         fR8GFXM3bwKCFLqTxemUJFR5DKf7oMAXs2CO6oap/LuJLlGqCbcQ1hyaYtzpSLEDyyAL
         X9Qm66GhE6CguyTfFWQ14O2Mp+WoSAdgPKb8cdmdmTWHk9yeCN2a/6vrPrCO/Ey3Dhkh
         XSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BPFtTd6RQYscxQ0fQMf9Ao+ClKlP+5IQLT6ynk/ooMU=;
        b=Hv0IUnIy7THZdTl2hBHJDCUjDwdP7MpqXE9MK35q0TCCW3Y2UeytT6ea4BRMXwqxF2
         C4sBCbkyzJ/FCkbHeFWPD16vh/GotfsGGHo1E6WI33lnNJL5p2hfGnDu9+RQTUYR+oPn
         lVZ7s733yninYRSF9m3JzSP5leWYTVJKWpx5P8fejmwZHmUTXg3WUSE0n6sRG3Hhu/ZY
         rdV/raiMthwTomVLYEPkCb2jS33/GXCzvJIE/gvgv/ujwmfncf+IEOu0pJIS9uMV89i+
         y3V71dziCr4b5DHHwUWH5APQaJcfOQ3EhIeqB7KU/Kcm5EImajIGfmf3Qvvf3soZTRj+
         eXKQ==
X-Gm-Message-State: AODbwcD86TZ2IjsLtXkPscnKkA/uH38PtG9+pwuWNehHzHclW9vkIhHV
        AmKO9aZHPx7QNg==
X-Received: by 10.202.245.213 with SMTP id t204mr5791110oih.144.1494731778006;
        Sat, 13 May 2017 20:16:18 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:16 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 09/22] blame: move reverse flag to scoreboard
Date:   Sat, 13 May 2017 22:15:00 -0500
Message-Id: <20170514031513.9042-10-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reverse flag is used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         |  3 +++
 builtin/blame.c | 20 +++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/blame.h b/blame.h
index 388309d..85703dd 100644
--- a/blame.h
+++ b/blame.h
@@ -128,6 +128,9 @@ struct blame_scoreboard {
 
 	/* use this file's contents as the final image */
 	const char *contents_from;
+
+	/* flags */
+	int reverse;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 032fd15..ed50eda 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1218,7 +1218,8 @@ static void pass_whole_blame(struct blame_scoreboard *sb,
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
  */
-static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
+static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit,
+					   int reverse)
 {
 	if (!reverse) {
 		if (revs->first_parent_only &&
@@ -1232,9 +1233,9 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
-static int num_scapegoats(struct rev_info *revs, struct commit *commit)
+static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reverse)
 {
-	struct commit_list *l = first_scapegoat(revs, commit);
+	struct commit_list *l = first_scapegoat(revs, commit, reverse);
 	return commit_list_count(l);
 }
 
@@ -1272,7 +1273,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	struct blame_entry *toosmall = NULL;
 	struct blame_entry *blames, **blametail = &blames;
 
-	num_sg = num_scapegoats(revs, commit);
+	num_sg = num_scapegoats(revs, commit, sb->reverse);
 	if (!num_sg)
 		goto finish;
 	else if (num_sg < ARRAY_SIZE(sg_buf))
@@ -1288,7 +1289,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct commit *p = sg->item;
@@ -1320,7 +1321,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	}
 
 	sb->num_commits++;
-	for (i = 0, sg = first_scapegoat(revs, commit);
+	for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
 		struct blame_origin *porigin = sg_origin[i];
@@ -1341,7 +1342,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	if (opt & PICKAXE_BLAME_MOVE) {
 		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
 		if (origin->suspects) {
-			for (i = 0, sg = first_scapegoat(revs, commit);
+			for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 			     i < num_sg && sg;
 			     sg = sg->next, i++) {
 				struct blame_origin *porigin = sg_origin[i];
@@ -1368,7 +1369,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		if (!origin->suspects)
 			goto finish;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct blame_origin *porigin = sg_origin[i];
@@ -1649,7 +1650,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		 */
 		origin_incref(suspect);
 		parse_commit(commit);
-		if (reverse ||
+		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
@@ -2618,6 +2619,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
+	sb.reverse = reverse;
 	if (!reverse) {
 		final_commit_name = prepare_final(&sb);
 		sb.commits.compare = compare_commits_by_commit_date;
-- 
2.9.3

