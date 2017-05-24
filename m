Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FB820281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969195AbdEXFRd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35502 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969114AbdEXFQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id m17so31048240oik.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/IqZguUwx/ZgWyW4DZR6Bl9JSpz7+2boNH97f5PAQqk=;
        b=TGbD82OffBS+n8d1yZD4XIeq4bCMdYKxRirZ/BKSBhhqjjb324iE02jMQeSb8p222U
         sSxlIk+gyODLeZr3BFj9dwHmzILtFynovV7KtWRjaDgm9muCM76R0kpBjKYpWu+N8xJ6
         F494mClQyCfdbDx+5HbCA2V5049RHcEH4lBaF71lwigaIlHBtky2VVHNHajVErcCGXaq
         9AcJ61Q4pgILepxSX1Bsz5nNThiPrkGuAZZIUqcb30dUJKwaKwARnRKoT+zdLU9Aj5Oq
         ISgQVLPz0NPJAMYpSx2LCYxNn8j+BTpMeVSxeCIQk13a3EMjZcqvdIF2CxAv3M8WSfYX
         8REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/IqZguUwx/ZgWyW4DZR6Bl9JSpz7+2boNH97f5PAQqk=;
        b=F8N/13UV/pi9U1O8Mp6aORbGcb3U1Uu/lKdA3BWQK+9JaFKaS1iUdl9jGum/Wvvznw
         V7Fg8WxVZA7voLXe7/30lgKnTq11SNEswdRg6xSI6skXQtqri+nCSTjVdFKsP2nycOov
         Ts39JReKFmf4kGgGtEbEA3sKftHbIU7ez5AxjZUQnBzeXgc/C4b800UL9PDA8VaDV3d6
         0AIfTyspEEO6I9kL+0oPak0oH5cc2wj5DOSz4xhwL47yOBS1JF6rmPWniGs4+GU/6IsT
         5pv1IKeIvWAVdzeaDQzDk12+CI7sXNBE1dpvYtq9+ldmweDkprukqGADbDVyslrXbSpf
         cwxw==
X-Gm-Message-State: AODbwcAc9Vxsz9F89LZIuBJGfNzquCQYQuNgnxczRAM7Oiw2zMZ+hXUV
        DV68+ssX5a6/fA==
X-Received: by 10.202.245.194 with SMTP id t185mr16862493oih.102.1495603005272;
        Tue, 23 May 2017 22:16:45 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:44 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 20/29] blame: rework methods that determine 'final' commit
Date:   Wed, 24 May 2017 00:15:28 -0500
Message-Id: <20170524051537.29978-21-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Either prepare_initial or prepare_final is used to determine which
commit is marked as 'final'. Call the underlying methods directly to
make this more clear.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 61fd5b4..e343520 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2431,14 +2431,8 @@ static struct commit *find_single_final(struct rev_info *revs,
 	return found;
 }
 
-static char *prepare_final(struct blame_scoreboard *sb)
-{
-	const char *name;
-	sb->final = find_single_final(sb->revs, &name);
-	return xstrdup_or_null(name);
-}
-
-static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
+static struct commit *dwim_reverse_initial(struct rev_info *revs,
+					   const char **name_p)
 {
 	/*
 	 * DWIM "git blame --reverse ONE -- PATH" as
@@ -2449,11 +2443,11 @@ static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
 	struct commit *head_commit;
 	unsigned char head_sha1[20];
 
-	if (sb->revs->pending.nr != 1)
+	if (revs->pending.nr != 1)
 		return NULL;
 
 	/* Is that sole rev a committish? */
-	obj = sb->revs->pending.objects[0].item;
+	obj = revs->pending.objects[0].item;
 	obj = deref_tag(obj, NULL, 0);
 	if (obj->type != OBJ_COMMIT)
 		return NULL;
@@ -2467,17 +2461,19 @@ static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
 
 	/* Turn "ONE" into "ONE..HEAD" then */
 	obj->flags |= UNINTERESTING;
-	add_pending_object(sb->revs, &head_commit->object, "HEAD");
+	add_pending_object(revs, &head_commit->object, "HEAD");
 
-	sb->final = (struct commit *)obj;
-	return sb->revs->pending.objects[0].name;
+	if (name_p)
+		*name_p = revs->pending.objects[0].name;
+	return (struct commit *)obj;
 }
 
-static char *prepare_initial(struct blame_scoreboard *sb)
+static struct commit *find_single_initial(struct rev_info *revs,
+					  const char **name_p)
 {
 	int i;
 	const char *final_commit_name = NULL;
-	struct rev_info *revs = sb->revs;
+	struct commit *found = NULL;
 
 	/*
 	 * There must be one and only one negative commit, and it must be
@@ -2490,19 +2486,22 @@ static char *prepare_initial(struct blame_scoreboard *sb)
 		obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
-		if (sb->final)
+		if (found)
 			die("More than one commit to dig up from, %s and %s?",
 			    revs->pending.objects[i].name,
 			    final_commit_name);
-		sb->final = (struct commit *) obj;
+		found = (struct commit *) obj;
 		final_commit_name = revs->pending.objects[i].name;
 	}
 
 	if (!final_commit_name)
-		final_commit_name = dwim_reverse_initial(sb);
+		found = dwim_reverse_initial(revs, &final_commit_name);
 	if (!final_commit_name)
 		die("No commit to dig up from?");
-	return xstrdup(final_commit_name);
+
+	if (name_p)
+		*name_p = final_commit_name;
+	return found;
 }
 
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
@@ -2546,7 +2545,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-	char *final_commit_name = NULL;
+	const char *final_commit_name = NULL;
 	enum object_type type;
 	struct commit *final_commit = NULL;
 	struct progress_info pi = { NULL, 0 };
@@ -2755,14 +2754,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
+
 	if (!reverse) {
-		final_commit_name = prepare_final(&sb);
+		sb.final = find_single_final(&revs, &final_commit_name);
 		sb.commits.compare = compare_commits_by_commit_date;
 	}
 	else if (contents_from)
 		die(_("--contents and --reverse do not blend well."));
 	else {
-		final_commit_name = prepare_initial(&sb);
+		sb.final = find_single_initial(&revs, &final_commit_name);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
 		if (revs.first_parent_only)
 			revs.children.name = NULL;
@@ -2917,10 +2917,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	if (!incremental)
 		setup_pager();
-
-	free(final_commit_name);
-
-	if (incremental)
+	else
 		return 0;
 
 	blame_sort_final(&sb);
-- 
2.9.3

