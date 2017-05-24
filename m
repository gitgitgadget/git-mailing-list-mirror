Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0A520281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969150AbdEXFQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34480 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969114AbdEXFQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id w10so31062394oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KXCjbM714XbpOyBYK1K5A/kUIU6fXvAqN1HjM2zwz1s=;
        b=ZQAMa9DJKCswIfZN2RAQvIO2JzDPjoX+kjEgT5M3PGuMh0ctI6uM7sLxY8z11lVTbQ
         9U6oMBUl/63tAf8LcqVF65ZDetxZP/Z335LnPVBaV7uYw59ReCPw019ip/zHCD5ZuinR
         Ca9cv2Zemxg0cJ5sFMvmnPmHRdsPl8po9xSZfQ9Dx5qfjcxhCH8TPfWDrUKo6ifGv6V+
         9TFTbQIIfGsBN3KkcH+sP5sGNfgYT4FZwPJ8jWaNj6aPHgoHgMUSk4K8nHDRUuki5gVd
         52pWpEYfhMv16GelZBn/W+cxWaSMWYPTyY49SmQseD/AhP67avtN/5c+zbcEBeUXtNZV
         Jzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KXCjbM714XbpOyBYK1K5A/kUIU6fXvAqN1HjM2zwz1s=;
        b=Rdxsv58A04cEkutrRtNX7fR8pwStqbXMeQn6W8SkyE1ah0cUZDHUOkOYrgwrXhViuy
         Yf3x9dTzKOLEBOSe/tjqrmVQaF5sIDU2lhVZJEwoAU5dvZiwcaS2DQ43periigGs403p
         joQtDI5pT38ktUPw78FpefXlAQO4Zv0OZy8gIEov0tMxSVjatA4F6YsOa5meJZPv5zXf
         5NOCrTHjC87FgQYcRuGDh6fGraVFl5AJr7rKLbIvLbYANEYrfbYZyu34t+gLPwJNMAqQ
         iaKOkiUwgQmOMqlM3H1m7K6MXkpPD7T62MEs+A3vqAjCYJpELUA92mfArr7CjIvTIQ3q
         ozcA==
X-Gm-Message-State: AODbwcCx8sfuJtNsoUnd/WBTcEEN5IJEDZ2crw/rpvBGuoz2wwq9w8Ej
        ibeO2gGDKmJIxQ==
X-Received: by 10.202.4.79 with SMTP id 76mr16866918oie.60.1495602995043;
        Tue, 23 May 2017 22:16:35 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:33 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 13/29] blame: move reverse flag to scoreboard
Date:   Wed, 24 May 2017 00:15:21 -0500
Message-Id: <20170524051537.29978-14-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reverse flag is used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0955fc1..161d15c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -381,6 +381,9 @@ struct blame_scoreboard {
 
 	/* use this file's contents as the final image */
 	const char *contents_from;
+
+	/* flags */
+	int reverse;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -1339,7 +1342,8 @@ static void pass_whole_blame(struct blame_scoreboard *sb,
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
  */
-static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
+static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit,
+					   int reverse)
 {
 	if (!reverse) {
 		if (revs->first_parent_only &&
@@ -1353,9 +1357,9 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
-static int num_scapegoats(struct rev_info *revs, struct commit *commit)
+static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reverse)
 {
-	struct commit_list *l = first_scapegoat(revs, commit);
+	struct commit_list *l = first_scapegoat(revs, commit, reverse);
 	return commit_list_count(l);
 }
 
@@ -1393,7 +1397,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	struct blame_entry *toosmall = NULL;
 	struct blame_entry *blames, **blametail = &blames;
 
-	num_sg = num_scapegoats(revs, commit);
+	num_sg = num_scapegoats(revs, commit, sb->reverse);
 	if (!num_sg)
 		goto finish;
 	else if (num_sg < ARRAY_SIZE(sg_buf))
@@ -1409,7 +1413,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct commit *p = sg->item;
@@ -1441,7 +1445,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	}
 
 	sb->num_commits++;
-	for (i = 0, sg = first_scapegoat(revs, commit);
+	for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
 		struct blame_origin *porigin = sg_origin[i];
@@ -1462,7 +1466,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	if (opt & PICKAXE_BLAME_MOVE) {
 		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
 		if (origin->suspects) {
-			for (i = 0, sg = first_scapegoat(revs, commit);
+			for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 			     i < num_sg && sg;
 			     sg = sg->next, i++) {
 				struct blame_origin *porigin = sg_origin[i];
@@ -1489,7 +1493,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		if (!origin->suspects)
 			goto finish;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct blame_origin *porigin = sg_origin[i];
@@ -1770,7 +1774,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		 */
 		blame_origin_incref(suspect);
 		parse_commit(commit);
-		if (reverse ||
+		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
@@ -2739,6 +2743,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
+	sb.reverse = reverse;
 	if (!reverse) {
 		final_commit_name = prepare_final(&sb);
 		sb.commits.compare = compare_commits_by_commit_date;
-- 
2.9.3

