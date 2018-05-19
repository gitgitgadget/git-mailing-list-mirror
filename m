Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7081F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeESF2z (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32923 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeESF2o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id h9-v6so16908195lfi.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qNuXRkqLpR6qVL2zQqiSq9OOvzcM+3FgKD6yP4d3wrU=;
        b=uYnaEj/KY397ZNsWsnNJcIatVgcffBBCHK3cLbRhDVs689P6yeljrnNAbKC7FaiQfR
         FcOgUUfZgg4gWAOAJVZpKzVriLhigJVqVFSvrWL9xNTrleXOdpHkwJLGlAxENZOrrpX1
         dNkkHiW/J3mPk6hFNsfh/3vH2YMTZMHpZypzrCViFQ1Fc9Xq3ma2/t2APmXA9XkYmTt4
         fEIZr6Vk5eUKK3gg66WfvVQJ6GDz0TmQq0jypPVo0fJzpQwZXXXb14UEJ5dyXjW8VpiQ
         W9tNcDwjiT3i68nZCqfzlyzm0U+2NxEK0W/fNE91g+B6wFgjbGqRB2iVAlbBGV6wnufG
         h9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qNuXRkqLpR6qVL2zQqiSq9OOvzcM+3FgKD6yP4d3wrU=;
        b=XAB6q7+EgwUsyNjUfHFyn3/Zqug+vQjYt2JJshHAzzgUG9VppmhezAn5PzKuz9hh51
         lYJQqMNQZVrVVt3Lm3aJ30XaDUqnRdUVIjIQKrq4ltljXC0vxg2wCiYu82nbC7h+FhLU
         pyyxLX3ZqNZ89GR2EsgSlKPEN4E3mr/E/2uPWgE7C6m+/LLwieci3vrpwyOx6H18mj40
         fdKGnD3cn+d7Glw8jaymGoB/Oi54wsekelUSMQCgHNjJK1yQTl4WBlCRDWJrEg4yS8sp
         iVq0QtZ8rpTu8CzRh0xu7/eMj53gtDCCG9rYmIzfv3hifsOVNtIX3h9WZt/ZDdXTmjAK
         iZBg==
X-Gm-Message-State: ALKqPweb6ZbeqnSyeM01RcIug/yanPqxhZnSjcpb2bx1paJd/7F+LTjW
        6eSuLgl8cep7/rcKvcZeiaM=
X-Google-Smtp-Source: AB8JxZoiQ51fVyXUlKVjEcHLg8IvYSBRd8pw0stO2De4Fu7Iocf8wULEWmbnkk9k05ZhPZ6RfLVXoA==
X-Received: by 2002:a2e:9797:: with SMTP id y23-v6mr7640023lji.52.1526707723173;
        Fri, 18 May 2018 22:28:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 07/15] sequencer.c: use commit-slab to associate todo items to commits
Date:   Sat, 19 May 2018 07:28:23 +0200
Message-Id: <20180519052831.12603-8-pclouds@gmail.com>
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
 sequencer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3af296db3b..3b6d56d085 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3362,6 +3362,8 @@ static int subject2item_cmp(const void *fndata,
 	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
 }
 
+define_commit_slab(commit_todo_item, struct todo_item *);
+
 /*
  * Rearrange the todo list that has both "pick commit-id msg" and "pick
  * commit-id fixup!/squash! msg" in it so that the latter is put immediately
@@ -3378,6 +3380,7 @@ int rearrange_squash(void)
 	struct hashmap subject2item;
 	int res = 0, rearranged = 0, *next, *tail, i;
 	char **subjects;
+	struct commit_todo_item commit_todo;
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
@@ -3386,6 +3389,7 @@ int rearrange_squash(void)
 		return -1;
 	}
 
+	init_commit_todo_item(&commit_todo);
 	/*
 	 * The hashmap maps onelines to the respective todo list index.
 	 *
@@ -3416,10 +3420,11 @@ int rearrange_squash(void)
 
 		if (is_fixup(item->command)) {
 			todo_list_release(&todo_list);
+			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
 
-		item->commit->util = item;
+		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
 		parse_commit(item->commit);
 		commit_buffer = get_commit_buffer(item->commit, NULL);
@@ -3446,9 +3451,9 @@ int rearrange_squash(void)
 			else if (!strchr(p, ' ') &&
 				 (commit2 =
 				  lookup_commit_reference_by_name(p)) &&
-				 commit2->util)
+				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
-				i2 = (struct todo_item *)commit2->util
+				i2 = *commit_todo_item_at(&commit_todo, commit2)
 					- todo_list.items;
 			else {
 				/* copy can be a prefix of the commit subject */
@@ -3527,5 +3532,6 @@ int rearrange_squash(void)
 	hashmap_free(&subject2item, 1);
 	todo_list_release(&todo_list);
 
+	clear_commit_todo_item(&commit_todo);
 	return res;
 }
-- 
2.17.0.705.g3525833791

