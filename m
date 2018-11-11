Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F25B1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeKKQLI (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34917 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQLI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id v198-v6so4772140oif.2
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfH2+6YabaYG35LhvEhVXMJWWsSW3LIBAQR1xqoWPYA=;
        b=LUn5AOq2ruHO8QhkH+rLh6qv2VDU5R0JA9HJLlqlG6N+l5v46HdIEPukV9TrG+E2sw
         yX8oHar0pfUNPPDCVCPu9xKYWrWm+TYJu24Ybmp65zVBuKbqPzxLgaSrow6NPmCePyV3
         5kLzNNcK5Suf10SdTEo30ZVjdRHlQrvK22EHk13vYFSsQPuuN9uFJ3goTxM3b4YGUJYt
         pIehvSa4TiPOg1yr7sZ0R209yw/xktFZGAbi31eX+zeIJ+CmpHj+gupQD/SVCCqVI79z
         pSlsI4s7bJbXqkl0CT+Eya7ERJc1db7BMgnvqjwvuSirV9zsa5Hmw4EPg5jCX3IbX7F9
         +WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfH2+6YabaYG35LhvEhVXMJWWsSW3LIBAQR1xqoWPYA=;
        b=ATctXdgTKQeBUXgQ7gi/GsGpyFOm7tJtcqXpXyDkgP1WW0SeHITEr9Nqm18gHhWQn2
         088WtF1nVvaKJSIVGE0uU2j6KUvpznk2OPBQHnChw5+6roiLr8Kxtf/iKNUExxvBDNWe
         x35Xx7KMWjFSCCVtxid1a65jSWf/5q60JqO4Qbadw9gsX+ZFe+Juecj28nAPfb/wCJ6X
         s04GXM7vC/+HOe7apcHNALl2r9yjNTKVd6jiAIWJUtR7G/Si9BG64LuXnlN0N2nzhpHA
         r3c10m/JFSB2XRko3I/u9o2L5zPXtylDrn3Ol4fWEMKO2OqEvyBzELj7WcsmJp4Vz5u4
         A9Ug==
X-Gm-Message-State: AGRZ1gJK9rPKmO48MajP8hho90UVfehD4DpSf2vISGpqnRzbcHpYNkeb
        79e3XLtSeEDh+lDZPaGSW+mMz8y6
X-Google-Smtp-Source: AJdET5eWhsFr40Kd25ZxXg6eajJDBmK5eZO0mYkN3ndEDZx+msGrB2toJuMHXB0Z6o90PmfFm5+byg==
X-Received: by 2002:aca:5204:: with SMTP id g4-v6mr8961382oib.149.1541917409016;
        Sat, 10 Nov 2018 22:23:29 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:28 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/10] fast-export: add --reference-excluded-parents option
Date:   Sat, 10 Nov 2018 22:23:10 -0800
Message-Id: <20181111062312.16342-9-newren@gmail.com>
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

git filter-branch has a nifty feature allowing you to rewrite, e.g. just
the last 8 commits of a linear history
  git filter-branch $OPTIONS HEAD~8..HEAD

If you try the same with git fast-export, you instead get a history of
only 8 commits, with HEAD~7 being rewritten into a root commit.  There
are two alternatives:

  1) Don't use the negative revision specification, and when you're
     filtering the output to make modifications to the last 8 commits,
     just be careful to not modify any earlier commits somehow.

  2) First run 'git fast-export --export-marks=somefile HEAD~8', then
     run 'git fast-export --import-marks=somefile HEAD~8..HEAD'.

Both are more error prone than I'd like (the first for obvious reasons;
with the second option I have sometimes accidentally included too many
revisions in the first command and then found that the corresponding
extra revisions were not exported by the second command and thus were
not modified as I expected).  Also, both are poor from a performance
perspective.

Add a new --reference-excluded-parents option which will cause
fast-export to refer to commits outside the specified rev-list-args
range by their sha1sum.  Such a stream will only be useful in a
repository which already contains the necessary commits (much like the
restriction imposed when using --no-data).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt | 16 ++++++++++--
 builtin/fast-export.c             | 42 +++++++++++++++++++++++--------
 t/t9350-fast-export.sh            | 11 ++++++++
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 677510b7f7..2916096bdd 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -110,6 +110,17 @@ marks the same across runs.
 	the shape of the history and stored tree.  See the section on
 	`ANONYMIZING` below.
 
+--reference-excluded-parents::
+	By default, running a command such as `git fast-export
+	master~5..master` will not include the commit master\~5 and
+	will make master\~4 no longer have master\~5 as a parent (though
+	both the old master\~4 and new master~4 will have all the same
+	files).  Use --reference-excluded-parents to instead have the
+	the stream refer to commits in the excluded range of history
+	by their sha1sum.  Note that the resulting stream can only be
+	used by a repository which already contains the necessary
+	parent commits.
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
@@ -119,8 +130,9 @@ marks the same across runs.
 	'git rev-list', that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
 	current master reference to be exported along with all objects
-	added since its 10th ancestor commit and all files common to
-	master\~9 and master~10.
+	added since its 10th ancestor commit and (unless the
+	--reference-excluded-parents option is specified) all files
+	common to master\~9 and master~10.
 
 EXAMPLES
 --------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0d0bbd9445..ea9c5b1c00 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -37,6 +37,7 @@ static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
 static int full_tree;
+static int reference_excluded_commits;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
@@ -596,7 +597,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		message += 2;
 
 	if (commit->parents &&
-	    get_object_mark(&commit->parents->item->object) != 0 &&
+	    (get_object_mark(&commit->parents->item->object) != 0 ||
+	     reference_excluded_commits) &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
 		diff_tree_oid(get_commit_tree_oid(commit->parents->item),
@@ -638,13 +640,21 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	unuse_commit_buffer(commit, commit_buffer);
 
 	for (i = 0, p = commit->parents; p; p = p->next) {
-		int mark = get_object_mark(&p->item->object);
-		if (!mark)
+		struct object *obj = &p->item->object;
+		int mark = get_object_mark(obj);
+
+		if (!mark && !reference_excluded_commits)
 			continue;
 		if (i == 0)
-			printf("from :%d\n", mark);
+			printf("from ");
+		else
+			printf("merge ");
+		if (mark)
+			printf(":%d\n", mark);
 		else
-			printf("merge :%d\n", mark);
+			printf("%s\n", sha1_to_hex(anonymize ?
+						   anonymize_sha1(&obj->oid) :
+						   obj->oid.hash));
 		i++;
 	}
 
@@ -925,13 +935,22 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				/*
 				 * Getting here means we have a commit which
 				 * was excluded by a negative refspec (e.g.
-				 * fast-export ^master master).  If the user
+				 * fast-export ^master master).  If we are
+				 * referencing excluded commits, set the ref
+				 * to the exact commit.  Otherwise, the user
 				 * wants the branch exported but every commit
-				 * in its history to be deleted, that sounds
-				 * like a ref deletion to me.
+				 * in its history to be deleted, which basically
+				 * just means deletion of the ref.
 				 */
-				printf("reset %s\nfrom %s\n\n",
-				       name, sha1_to_hex(null_sha1));
+				if (!reference_excluded_commits) {
+					/* delete the ref */
+					printf("reset %s\nfrom %s\n\n",
+					       name, sha1_to_hex(null_sha1));
+					continue;
+				}
+				/* set ref to commit using oid, not mark */
+				printf("reset %s\nfrom %s\n\n", name,
+				       sha1_to_hex(commit->object.oid.hash));
 				continue;
 			}
 
@@ -1068,6 +1087,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
+		OPT_BOOL(0, "reference-excluded-parents",
+			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by sha1sum")),
+
 		OPT_END()
 	};
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index a0c93f2212..c2f40d6a40 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -66,6 +66,17 @@ test_expect_success 'fast-export master~2..master' '
 
 '
 
+test_expect_success 'fast-export --reference-excluded-parents master~2..master' '
+
+	git fast-export --reference-excluded-parents master~2..master >actual &&
+	grep commit.refs/heads/master actual >commit-count &&
+	test_line_count = 2 commit-count &&
+	sed "s/master/rewrite/" actual |
+		(cd new &&
+		 git fast-import &&
+		 test $MASTER = $(git rev-parse --verify refs/heads/rewrite))
+'
+
 test_expect_success 'iso-8859-1' '
 
 	git config i18n.commitencoding ISO8859-1 &&
-- 
2.19.1.866.g82735bcbde

