From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] reachable.c: mark reachable detached HEAD from all worktrees
Date: Wed,  1 Jun 2016 17:45:18 +0700
Message-ID: <20160601104519.16563-4-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jun 01 12:46:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b83ep-0001pE-3a
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 12:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcFAKpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 06:45:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34999 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcFAKpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 06:45:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id f144so3190462pfa.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eL5TPPFdYBzF27KSosZGjravl3E1l0MKLbvwpnjq4sY=;
        b=LWmHuuddJLlYcq4wQVf8yzX9H7RuMZlcck1wjKQ/CDwzKwb4i/psD8BsmFs9Tcoqv7
         SRLzd7XQLi+XF/I5ZK1Dw+ej8NxALIYpKYA8FkemN+Is0pL1dsWi/Xt1ujDHjV6Z1xv+
         q/ayoFCveD/9kUtwg1GhLaVLgkIRka72lcscM93Io5ZZqi/mCZ6liKalOFPBw8Qe4Peu
         yEliKpoWJSXNe/rw/O0BYIF+GBrt+noL5QXt5GBLL7wonKjDhQDYhT6WhlrAP81r5SxR
         BwHBKrFGb84p736/6+MQd3R3FKqGxMd9zackiFH1Ay82isyBggV7elEY2ZMAXSVWsi7c
         SH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eL5TPPFdYBzF27KSosZGjravl3E1l0MKLbvwpnjq4sY=;
        b=m28u+DB+dSQcHQ+qA5U0eJNcySY9b23e3dsgQx07gF3e01lXdXFGapTjtLb43doxPF
         l4k6CEtum1Z8nIk2ahYJTXWd0K3x7rPUL/5Otap1UH8POERfRb8ChfdWci9LgUJygvzO
         VIim/Otp+nG220/91FS6hvceOGKo4qazCG9MRyXK2bNSaz7ksdyGAXNjuiP0BQqnuKw9
         q1KWKqCGjviGKXcYR4ut1jOnqSRuBZpWlWZYTvYwo33yqYZ+cJXKr9ADY54DmujxfGAm
         crr3Pn1wv8l+57uCIPQiehzsHgmF8sdr/UGYbEnH2CRARFbZ4n9pEp9aCRSdAfdUOxru
         rouw==
X-Gm-Message-State: ALyK8tJGpQQTGujrmnH+A+noi+NhcRLihyOkZ5ybWdQ6XUJFfpy9Lkxip/urrBHUWr06SQ==
X-Received: by 10.98.152.66 with SMTP id q63mr7446329pfd.38.1464777945217;
        Wed, 01 Jun 2016 03:45:45 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id c82sm47114983pfd.42.2016.06.01.03.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 03:45:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:45:40 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160601104519.16563-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296079>

Same reason as the previous commit, this prevents potential object
deletion that other worktrees need.

There is a slight change in behavior. The current implementation always
adds HEAD. The new one only adds _detached_ HEAD. But that's fine becau=
se
all normal refs should be already covered by for_each_ref() in
mark_reachable_objects().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c      | 14 +++++++++++---
 t/t5304-prune.sh | 12 ++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/reachable.c b/reachable.c
index 8f67242..e5f9170 100644
--- a/reachable.c
+++ b/reachable.c
@@ -170,6 +170,13 @@ static void add_objects_from_worktree(struct rev_i=
nfo *revs)
 				    worktree_git_path(wt, "index")) > 0)
 			add_index_objects_to_pending(revs, 0, &istate);
 		discard_index(&istate);
+
+		if (wt->is_detached) {
+			struct object *o;
+			o =3D parse_object_or_die(wt->head_sha1, "HEAD");
+			add_pending_object(revs, o, "");
+		}
+
 	}
 	free_worktrees(worktrees);
=20
@@ -199,13 +206,14 @@ void mark_reachable_objects(struct rev_info *revs=
, int mark_reflog,
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
=20
-	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
-
 	/* Add all reflog info */
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
=20
+	/*
+	 * Add all objects from the in-core index file and detached
+	 * HEAD which is not included in the list above
+	 */
 	add_objects_from_worktree(revs);
=20
 	cp.progress =3D progress;
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index cba45c7..683bdb0 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -292,4 +292,16 @@ test_expect_success 'prune: handle index in multip=
le worktrees' '
 	test_cmp second-worktree/blob actual
 '
=20
+test_expect_success 'prune: handle HEAD in multiple worktrees' '
+	git worktree add --detach third-worktree &&
+	echo "new blob for third-worktree" >third-worktree/blob &&
+	git -C third-worktree add blob &&
+	git -C third-worktree commit -m "third" &&
+	rm .git/worktrees/third-worktree/index &&
+	test_must_fail git -C third-worktree show :blob &&
+	git prune --expire=3Dnow &&
+	git -C third-worktree show HEAD:blob >actual &&
+	test_cmp third-worktree/blob actual
+'
+
 test_done
--=20
2.8.2.524.g6ff3d78
