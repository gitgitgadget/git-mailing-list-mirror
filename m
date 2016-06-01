From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] reachable.c: mark reachable objects in index from all worktrees
Date: Wed,  1 Jun 2016 17:45:17 +0700
Message-ID: <20160601104519.16563-3-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jun 01 12:45:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b83ek-0001lL-8v
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 12:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbcFAKpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 06:45:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36084 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcFAKpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 06:45:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so3158193pfd.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHmUJSexmK2o8RVPwueGlEugCT4mZBsLgdYLuRfWeFE=;
        b=JNKrdZhKmfZJsi4vUx86c9F2bCorJPiLsjU9dO/M+duxfi5xVoicL5YjrD3dVNnDfa
         tt8jqAein+40ncOlw0BDKbwriFLa3SpwvIs+mOeBCkWek4ch+SElufYjEhWsU0ax2x8/
         cusO4omDDIdatBoHB6/jMZkk10pJmjv995dtA7TqItD1Y4T/F0yFdwQCVXYVRERirbaQ
         MKWEvgUa5WF5yAjjFtTTLqTs4VHFgNpQ67mXrsnkHSDqb/h4jKTKQ0mZEwyEF8Y38VZW
         r3dMkarjrF1IKCNlnTBoIBqtyzbKutfr4Or6KDzOmMT36q0ZGo+xBhUK6wuDfwiD1/jQ
         OW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHmUJSexmK2o8RVPwueGlEugCT4mZBsLgdYLuRfWeFE=;
        b=Ut/2HM2SAz+Eb+TSilu8FsyN9ZkSF/yzJ2baGZaBgSCv7tHJgNK8AVzyCKrafVQnQ6
         Mro4ANOtJ8SRif4xIIg4VlY4OI7CSgHh5/ioXFSJD/GliT52qm5FVk/uSjNQMYOxYpjE
         muvZtlRj60bzSLh61GiwmzfZdy+R7LR4L74ANOlOMMCkFPh8zlKugMpmQBKhaKfmLzbx
         BzQ1KstgFvUUWu2SuWvgnIU8T+aCbCIpdc2WaroK1VYlPGddBa19cfzesLOKQc3+Gp+n
         cPAeYZUr6t1b/E/SI4rjPv1JY238m01uv64lV3R6+7spcPiOHYm2cnXFxyc0XI6qWP8s
         UC1w==
X-Gm-Message-State: ALyK8tKrvL9LM/mm67CrcB2gsP6iZ//GBO3LxEx+7AjIRtuT56bcbLtehizWMuO2y96P/g==
X-Received: by 10.98.28.74 with SMTP id c71mr7276553pfc.131.1464777939910;
        Wed, 01 Jun 2016 03:45:39 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 8sm47143625pfq.11.2016.06.01.03.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 03:45:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:45:35 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160601104519.16563-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296077>

Current mark_reachable_objects() only marks objects from index from
_current_ worktree as reachable instead of all worktrees. Because this
function is used for pruning, there is a chance that objects referenced
by other worktrees may be deleted. Fix that.

Small behavior change in "one worktree" case, the index is read again
from file. In the current implementation, if the_index is already
loaded, the index file will not be read from file again. This adds some
more cost to this operation, hopefully insignificant because
reachability test is usually very expensive already.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c      | 33 +++++++++++++++++++++++++++++----
 t/t5304-prune.sh |  9 +++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/reachable.c b/reachable.c
index 15dbe60..8f67242 100644
--- a/reachable.c
+++ b/reachable.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "progress.h"
 #include "list-objects.h"
+#include "worktree.h"
=20
 struct connectivity_progress {
 	struct progress *progress;
@@ -155,6 +156,32 @@ int add_unseen_recent_objects_to_traversal(struct =
rev_info *revs,
 				      FOR_EACH_OBJECT_LOCAL_ONLY);
 }
=20
+static void add_objects_from_worktree(struct rev_info *revs)
+{
+	struct worktree **worktrees, **p;
+
+	worktrees =3D get_worktrees();
+	for (p =3D worktrees; *p; p++) {
+		struct worktree *wt =3D *p;
+		struct index_state istate;
+
+		memset(&istate, 0, sizeof(istate));
+		if (read_index_from(&istate,
+				    worktree_git_path(wt, "index")) > 0)
+			add_index_objects_to_pending(revs, 0, &istate);
+		discard_index(&istate);
+	}
+	free_worktrees(worktrees);
+
+	/*
+	 * this is in case the index is already updated but not
+	 * written down in file yet, then add_index_... in the above
+	 * loop will miss new objects that are just created or
+	 * referenced.
+	 */
+	add_index_objects_to_pending(revs, 0, &the_index);
+}
+
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    unsigned long mark_recent,
 			    struct progress *progress)
@@ -169,10 +196,6 @@ void mark_reachable_objects(struct rev_info *revs,=
 int mark_reflog,
 	revs->blob_objects =3D 1;
 	revs->tree_objects =3D 1;
=20
-	/* Add all refs from the index file */
-	read_cache();
-	add_index_objects_to_pending(revs, 0, &the_index);
-
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
=20
@@ -183,6 +206,8 @@ void mark_reachable_objects(struct rev_info *revs, =
int mark_reflog,
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
=20
+	add_objects_from_worktree(revs);
+
 	cp.progress =3D progress;
 	cp.count =3D 0;
=20
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 133b584..cba45c7 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -283,4 +283,13 @@ test_expect_success 'prune: handle alternate objec=
t database' '
 	git -C B prune
 '
=20
+test_expect_success 'prune: handle index in multiple worktrees' '
+	git worktree add second-worktree &&
+	echo "new blob for second-worktree" >second-worktree/blob &&
+	git -C second-worktree add blob &&
+	git prune --expire=3Dnow &&
+	git -C second-worktree show :blob >actual &&
+	test_cmp second-worktree/blob actual
+'
+
 test_done
--=20
2.8.2.524.g6ff3d78
