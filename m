Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034C71F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeKKQLH (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41156 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQLH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id g188-v6so4748673oif.8
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBpZPg6l7CxjS3NxuCNj92+0MdQSMXusdWB2zYFHEOY=;
        b=eoGL37fGPSa6cIKVP6vxANuOtVrwCzu54dLLlRZRwd9bRQVOJd2T6cibGQTyD1kqFf
         LlyrGRhWzXEXBbZgfY8UpJpWZbCv5wBdb4Qo9/SSNMGo2kHUCMagi9LnxHgOi2iI4pbH
         ITeY9EuSuhA2hdBe/Uou7lv0pFrPnSoQT30RlRXsVko1XayxYJAi19Q0dtGJxJjcXiNe
         +39JknmQ1CVhn2wDPUQXFN4bhE0I3LwxdJt6a55tyPzTV+Db+pccXYVgan9Zp2grcmrS
         lQkPiJX0UtjA21fOYO07kwvvlKcNUybMBR+UIK/koC4lpxR3+kVWdfeH4KPFbqda8V1K
         WXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBpZPg6l7CxjS3NxuCNj92+0MdQSMXusdWB2zYFHEOY=;
        b=EWb8KMsuB2XOv8jlCj+FRTfP8XptDeSqhD7klWGWvZ493RHnFPbtV4wKbSN9LKNylA
         2o+dnzyzc60ZR0cUX+u9/5hoD927xzZYRpQLkZqfTnjmp2WTvd/0P6nm2yvwj+v70Uwi
         AQhnjzQRXUr4OGwhBAvg6S6ui0RsVSpw7cuNgexs/AHK0gTVlqZU8ImgWwnontk/ck5C
         GNIz4TC1yxQabdPwpz8TWLyzu7ssof7OQvZzh3qi0is+Ewb3Ynw7FG2CZ7T4Lt+fSV6d
         S9VMEpPzdVhLfa8jpx8VnoJNz/a78eYDdXf4cycykmJ5cNUZZhoYCikfQMb9zPDTx3y0
         MJcQ==
X-Gm-Message-State: AGRZ1gJXnUEHLiOvB/F9/UigtWDhsD28OClkGgGBa0vDb55ShbWZQqOk
        xuaHv1URIAxEyZdaPCKnLBh/EKHG
X-Google-Smtp-Source: AJdET5fLBIdx1+O8NdL/Ahh50H0gaJvy0OS1Kh6gG66FbLQfUpok0ICG+TIqsMMawbwROG6AxNTsDg==
X-Received: by 2002:aca:ce47:: with SMTP id e68-v6mr8772718oig.83.1541917407754;
        Sat, 10 Nov 2018 22:23:27 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:27 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/10] fast-export: ensure we export requested refs
Date:   Sat, 10 Nov 2018 22:23:09 -0800
Message-Id: <20181111062312.16342-8-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If file paths are specified to fast-export and a ref points to a commit
that does not touch any of the relevant paths, then that ref would
sometimes fail to be exported.  (This depends on whether any ancestors
of the commit which do touch the relevant paths would be exported with
that same ref name or a different ref name.)  To avoid this problem,
put *all* specified refs into extra_refs to start, and then as we export
each commit, remove the refname used in the 'commit $REFNAME' directive
from extra_refs.  Then, in handle_tags_and_duplicates() we know which
refs actually do need a manual reset directive in order to be included.

This means that we do need some special handling for excluded refs; e.g.
if someone runs
   git fast-export ^master master
then they've asked for master to be exported, but they have also asked
for the commit which master points to and all of its history to be
excluded.  That logically means ref deletion.  Previously, such refs
were just silently omitted from being exported despite having been
explicitly requested for export.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
NOTE: I was hoping the strmap API proposal would materialize, but I either
missed it or it hasn't shown up.  The usage of string_list in this patch
would be better replaced by what Peff suggested.

 builtin/fast-export.c  | 48 +++++++++++++++++++++++++++++++-----------
 t/t9350-fast-export.sh | 16 +++++++++++---
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5648a8ce9c..0d0bbd9445 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -38,6 +38,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
+static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 static struct revision_sources revision_sources;
@@ -611,6 +612,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
 	refname = *revision_sources_at(&revision_sources, commit);
+	string_list_remove(&extra_refs, refname, 0);
 	if (anonymize) {
 		refname = anonymize_refname(refname);
 		anonymize_ident_line(&committer, &committer_end);
@@ -814,7 +816,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 		/* handle nested tags */
 		while (tag && tag->object.type == OBJ_TAG) {
 			parse_object(the_repository, &tag->object.oid);
-			string_list_append(&extra_refs, full_name)->util = tag;
+			string_list_append(&tag_refs, full_name)->util = tag;
 			tag = (struct tag *)tag->tagged;
 		}
 		if (!tag)
@@ -873,25 +875,30 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		}
 
 		/*
-		 * This ref will not be updated through a commit, lets make
-		 * sure it gets properly updated eventually.
+		 * Make sure this ref gets properly updated eventually, whether
+		 * through a commit or manually at the end.
 		 */
-		if (*revision_sources_at(&revision_sources, commit) ||
-		    commit->object.flags & SHOWN)
+		if (e->item->type != OBJ_TAG)
 			string_list_append(&extra_refs, full_name)->util = commit;
+
 		if (!*revision_sources_at(&revision_sources, commit))
 			*revision_sources_at(&revision_sources, commit) = full_name;
 	}
+
+	string_list_sort(&extra_refs);
+	string_list_remove_duplicates(&extra_refs, 0);
 }
 
-static void handle_tags_and_duplicates(void)
+static void handle_tags_and_duplicates(struct string_list *extras)
 {
 	struct commit *commit;
 	int i;
 
-	for (i = extra_refs.nr - 1; i >= 0; i--) {
-		const char *name = extra_refs.items[i].string;
-		struct object *object = extra_refs.items[i].util;
+	for (i = extras->nr - 1; i >= 0; i--) {
+		const char *name = extras->items[i].string;
+		struct object *object = extras->items[i].util;
+		int mark;
+
 		switch (object->type) {
 		case OBJ_TAG:
 			handle_tag(name, (struct tag *)object);
@@ -912,8 +919,24 @@ static void handle_tags_and_duplicates(void)
 				       name, sha1_to_hex(null_sha1));
 				continue;
 			}
-			printf("reset %s\nfrom :%d\n\n", name,
-			       get_object_mark(&commit->object));
+
+			mark = get_object_mark(&commit->object);
+			if (!mark) {
+				/*
+				 * Getting here means we have a commit which
+				 * was excluded by a negative refspec (e.g.
+				 * fast-export ^master master).  If the user
+				 * wants the branch exported but every commit
+				 * in its history to be deleted, that sounds
+				 * like a ref deletion to me.
+				 */
+				printf("reset %s\nfrom %s\n\n",
+				       name, sha1_to_hex(null_sha1));
+				continue;
+			}
+
+			printf("reset %s\nfrom :%d\n\n", name, mark
+			       );
 			show_progress();
 			break;
 		}
@@ -1101,7 +1124,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	handle_tags_and_duplicates();
+	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates(&tag_refs);
 	handle_deletes();
 
 	if (export_filename && lastimportid != last_idnum)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index dbb560c110..a0c93f2212 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -552,10 +552,20 @@ test_expect_success 'use refspec' '
 	test_cmp expected actual
 '
 
-test_expect_success 'delete refspec' '
+test_expect_success 'delete ref because entire history excluded' '
 	git branch to-delete &&
-	git fast-export --refspec :refs/heads/to-delete to-delete ^to-delete > actual &&
-	cat > expected <<-EOF &&
+	git fast-export to-delete ^to-delete >actual &&
+	cat >expected <<-EOF &&
+	reset refs/heads/to-delete
+	from 0000000000000000000000000000000000000000
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'delete refspec' '
+	git fast-export --refspec :refs/heads/to-delete >actual &&
+	cat >expected <<-EOF &&
 	reset refs/heads/to-delete
 	from 0000000000000000000000000000000000000000
 
-- 
2.19.1.866.g82735bcbde

