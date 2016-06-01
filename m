From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] reachable.c: make reachable reflogs for all per-worktree reflogs
Date: Wed,  1 Jun 2016 17:45:19 +0700
Message-ID: <20160601104519.16563-5-pclouds@gmail.com>
References: <574D382A.8030809@kdbg.org>
 <20160601104519.16563-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	mhagger@alum.mit.edu, dturner@twopensource.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 12:45:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b83eu-0001sL-JD
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 12:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcFAKpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 06:45:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36173 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbcFAKpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 06:45:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id 62so3159062pfd.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SN89hnV75n3ugkkGJ3ZRhxSeCXijbmvoE/ABQMuCdEk=;
        b=gzOOdSGY1kYQ8KZQIXx/hTEw2LmzU5Uvjn5G6y3X6zmSSpC1K6JlagByLs5sCsdt63
         0zldBqGJnNr9UAN1MC9U4mA1qY0KnwScX1oLnfCcHcHw0DSPPrOghT5rQhd0ejzYh56F
         a0Cix9Nohlzd/fKJs7S4/Y5RZEaXShWDlbxZ24UEl6GiRcqh466ri943Z+y8kpC1pWz/
         oqwEgNlDJ/On8VKRjuPs2VuKVjavm/N28bod/+LrH+XX5BfwQApj1S5DhrariBN+8fLk
         TgV2Xz0pWMkaK/trAeiwG8gJFhzIUHSAf9EfjKD6Q86e1feQH9ONqFZnvnmvWF7GzXcS
         PrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SN89hnV75n3ugkkGJ3ZRhxSeCXijbmvoE/ABQMuCdEk=;
        b=c7okyUSsGikWSrqAi1dTJ+woAdIt2DyYy0RmvM29bchlUj1wQldZoYcQvlQb9Z3NNu
         Hc+4S/x1gXyBEsRXpyE29xsFOqzuqQ06WY0O/2Tmi9nBWtsIjDglYxuiIKgI/rWBlhx/
         WFZFin8QpmRcMyQq8cvPydocaqpMkMhVfxhWDdXplfYDbqQHKqRslArrUnhHQrsoQPt1
         2oTtwuv1I64IDbAOgkdxDh1uqAsNdZjp3C/s+JWF1TZfJ6OfiPGQcSTlfD+Y9+lROLwE
         Y5KVemxxL+lF64Faup7/cp81xVjBEXkLIo2eK1lMPFp2UjgDX2RSyFLRrvIFrntMFUs8
         JT+w==
X-Gm-Message-State: ALyK8tJVh4LbpDHO2gMPi3O1Ivuu9w8V4+L65rX9T9CDtHozita9+CANysgxNuG9JbH3EA==
X-Received: by 10.98.5.133 with SMTP id 127mr7360125pff.110.1464777950786;
        Wed, 01 Jun 2016 03:45:50 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id ry2sm61725560pac.9.2016.06.01.03.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 03:45:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:45:45 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160601104519.16563-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296078>

Same reason as the previous commit, this is to avoid deleting objects
being referenced by per-worktree reflogs from other worktrees.
"logs/HEAD" is most important. "logs/refs/bisect" should not live long
enough to matter, but let's add it too for safety.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c      |  7 ++++---
 revision.c       | 19 +++++++++++++++++++
 revision.h       |  3 +++
 t/t5304-prune.sh | 19 +++++++++++++++++++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/reachable.c b/reachable.c
index e5f9170..73915e0 100644
--- a/reachable.c
+++ b/reachable.c
@@ -156,7 +156,7 @@ int add_unseen_recent_objects_to_traversal(struct r=
ev_info *revs,
 				      FOR_EACH_OBJECT_LOCAL_ONLY);
 }
=20
-static void add_objects_from_worktree(struct rev_info *revs)
+static void add_objects_from_worktree(struct rev_info *revs, int mark_=
reflog)
 {
 	struct worktree **worktrees, **p;
=20
@@ -176,7 +176,8 @@ static void add_objects_from_worktree(struct rev_in=
fo *revs)
 			o =3D parse_object_or_die(wt->head_sha1, "HEAD");
 			add_pending_object(revs, o, "");
 		}
-
+		if (mark_reflog)
+			add_worktree_reflogs_to_pending(revs, 0, wt);
 	}
 	free_worktrees(worktrees);
=20
@@ -214,7 +215,7 @@ void mark_reachable_objects(struct rev_info *revs, =
int mark_reflog,
 	 * Add all objects from the in-core index file and detached
 	 * HEAD which is not included in the list above
 	 */
-	add_objects_from_worktree(revs);
+	add_objects_from_worktree(revs, mark_reflog);
=20
 	cp.progress =3D progress;
 	cp.count =3D 0;
diff --git a/revision.c b/revision.c
index bbb6ff1..6a197a4 100644
--- a/revision.c
+++ b/revision.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
+#include "worktree.h"
=20
 volatile show_early_output_fn_t show_early_output;
=20
@@ -1245,6 +1246,24 @@ static int handle_one_reflog(const char *path, c=
onst struct object_id *oid,
 	return 0;
 }
=20
+void add_worktree_reflogs_to_pending(struct rev_info *revs, unsigned f=
lags,
+				     struct worktree *wt)
+{
+	struct all_refs_cb cb;
+	char *path;
+
+	cb.all_revs =3D revs;
+	cb.all_flags =3D flags;
+	path =3D xstrdup(worktree_git_path(wt, "logs/HEAD"));
+	if (file_exists(path))
+		handle_one_reflog(path, NULL, 0, &cb);
+	free(path);
+	path =3D xstrdup(worktree_git_path(wt, "logs/refs/bisect"));
+	if (file_exists(path))
+		handle_one_reflog(path, NULL, 0, &cb);
+	free(path);
+}
+
 void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
diff --git a/revision.h b/revision.h
index d06d098..9f3f148 100644
--- a/revision.h
+++ b/revision.h
@@ -30,6 +30,7 @@ struct log_info;
 struct string_list;
 struct saved_parents;
 struct index_state;
+struct worktree;
=20
 struct rev_cmdline_info {
 	unsigned int nr;
@@ -272,6 +273,8 @@ extern void add_pending_sha1(struct rev_info *revs,
=20
 extern void add_head_to_pending(struct rev_info *);
 extern void add_reflogs_to_pending(struct rev_info *, unsigned int fla=
gs);
+extern void add_worktree_reflogs_to_pending(struct rev_info *, unsigne=
d int flags,
+					    struct worktree *);
 extern void add_index_objects_to_pending(struct rev_info *, unsigned i=
nt flags,
 					 const struct index_state *);
=20
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 683bdb0..6b1c456 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -304,4 +304,23 @@ test_expect_success 'prune: handle HEAD in multipl=
e worktrees' '
 	test_cmp third-worktree/blob actual
 '
=20
+test_expect_success 'prune: handle HEAD reflog in multiple worktrees' =
'
+	(
+		cd third-worktree &&
+		git config core.logAllRefUpdates true &&
+		echo "HEAD{1} blob for third-worktree" >blob &&
+		git add blob &&
+		git commit -m "second commit in third" &&
+		cp blob expected &&
+		echo "HEAD{0} blob for third-worktree" >blob &&
+		git add blob &&
+		git commit -m "third commit in third" &&
+		git show HEAD@{1}:blob >actual &&
+		test_cmp expected actual
+	) &&
+	git prune --expire=3Dnow &&
+	git -C third-worktree show HEAD@{1}:blob >actual &&
+	test_cmp third-worktree/expected actual
+'
+
 test_done
--=20
2.8.2.524.g6ff3d78
