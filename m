From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/2] object.h: centralize object flag allocation
Date: Tue, 25 Mar 2014 20:23:26 +0700
Message-ID: <1395753807-23228-1-git-send-email-pclouds@gmail.com>
References: <1395294254-941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 14:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRJR-0001e1-De
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 14:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaCYNWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 09:22:37 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48070 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaCYNWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 09:22:36 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so435087pab.22
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Hm9qDlQwXAg1BjKhT90SuVCubl8sZ3F2EImYes9PO9g=;
        b=fPAo59SRXXEhShEo9rX4BHca44M3Vbi7LBszd1059ol+VBCuxRWZBlFytTfE0MypG7
         PqHuEF7juDHaZg7ZFVBywsifcNjx3dqoCLA++FjfzmcgU8DpXUnoflPv4TA1t6jI78Mu
         AADDxkvzPVqQSDm1JJsgiiqXWUFD4gGJGUsouQRZBjmg/N/LS75lbfj1TufWZsJmyD2c
         xll6LcHOOyFTmCx4wjZ89BdLu6SLlbLIEydxG0r2XrVv8DF0lJ1TwT05+UNlW39VWkab
         U0Txb0xmDXo01V4fW4Fdlc08nk8GFWkb5xERUN5/icdxUMEArcqxv+a/yvFbWBHCOcS/
         8q7A==
X-Received: by 10.68.136.2 with SMTP id pw2mr9578475pbb.167.1395753756171;
        Tue, 25 Mar 2014 06:22:36 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id hc4sm44681838pbc.29.2014.03.25.06.22.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 06:22:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Mar 2014 20:23:28 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395294254-941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245031>

While the field "flags" is mainly used by the revision walker, it is
also used in many other places. Centralize the whole flag allocation to
one place for a better overview (and easier to move flags if we have
too).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.c        |  3 +--
 builtin/blame.c |  2 +-
 bundle.c        |  1 +
 commit.c        |  2 +-
 fetch-pack.c    |  1 +
 http-push.c     |  3 +--
 object.h        | 13 +++++++++++++
 revision.h      |  1 +
 sha1_name.c     |  2 ++
 upload-pack.c   |  2 +-
 walker.c        |  1 +
 11 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index 8448d27..d6e851d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -21,8 +21,7 @@ static const char *argv_checkout[] =3D {"checkout", "=
-q", NULL, "--", NULL};
 static const char *argv_show_branch[] =3D {"show-branch", NULL, NULL};
 static const char *argv_update_ref[] =3D {"update-ref", "--no-deref", =
"BISECT_HEAD", NULL, NULL};
=20
-/* bits #0-15 in revision.h */
-
+/* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
=20
 /*
diff --git a/builtin/blame.c b/builtin/blame.c
index e5b5d71..88cb799 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -74,7 +74,7 @@ static unsigned blame_copy_score;
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40
=20
-/* bits #0..7 in revision.h, #8..11 used for merge_bases() in commit.c=
 */
+/* Remember to update object flag allocation in object.h */
 #define METAINFO_SHOWN		(1u<<12)
 #define MORE_THAN_ONE_PATH	(1u<<13)
=20
diff --git a/bundle.c b/bundle.c
index a85e0e4..1222952 100644
--- a/bundle.c
+++ b/bundle.c
@@ -120,6 +120,7 @@ static int list_refs(struct ref_list *r, int argc, =
const char **argv)
 	return 0;
 }
=20
+/* Remember to update object flag allocation in object.h */
 #define PREREQ_MARK (1u<<16)
=20
 int verify_bundle(struct bundle_header *header, int verbose)
diff --git a/commit.c b/commit.c
index 0f28902..f479331 100644
--- a/commit.c
+++ b/commit.c
@@ -721,7 +721,7 @@ void sort_in_topological_order(struct commit_list *=
*list, enum rev_sort_order so
=20
 /* merge-base stuff */
=20
-/* bits #0..15 in revision.h */
+/* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
 #define PARENT2		(1u<<17)
 #define STALE		(1u<<18)
diff --git a/fetch-pack.c b/fetch-pack.c
index 90d47da..eeee2bb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -26,6 +26,7 @@ static int agent_supported;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
=20
+/* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
 #define COMMON_REF	(1U << 2)
diff --git a/http-push.c b/http-push.c
index d4b40c9..f2c56c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -64,8 +64,7 @@ enum XML_Status {
 #define LOCK_TIME 600
 #define LOCK_REFRESH 30
=20
-/* bits #0-15 in revision.h */
-
+/* Remember to update object flag allocation in object.h */
 #define LOCAL    (1u<<16)
 #define REMOTE   (1u<<17)
 #define FETCHING (1u<<18)
diff --git a/object.h b/object.h
index 732bf4d..9918777 100644
--- a/object.h
+++ b/object.h
@@ -26,6 +26,19 @@ struct object_array {
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
=20
 #define TYPE_BITS   3
+/*
+ * object flag allocation:
+ * revision.h:      0---------10
+ * fetch-pack.c:    0---4
+ * walker.c:        0-2
+ * upload-pack.c:               11----------------19
+ * builtin/blame.c:               12-13
+ * bisect.c:                               16
+ * bundle.c:                               16
+ * http-push.c:                            16-----19
+ * commit.c:                               16-----19
+ * sha1_name.c:                                     20
+ */
 #define FLAG_BITS  27
=20
 /*
diff --git a/revision.h b/revision.h
index 1eb94c1..0262bbd 100644
--- a/revision.h
+++ b/revision.h
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "diff.h"
=20
+/* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREESAME	(1u<<2)
diff --git a/sha1_name.c b/sha1_name.c
index 6fca869..2b6322f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -819,6 +819,8 @@ static int get_sha1_1(const char *name, int len, un=
signed char *sha1, unsigned l
  * For future extension, ':/!' is reserved. If you want to match a mes=
sage
  * beginning with a '!', you have to repeat the exclamation mark.
  */
+
+/* Remember to update object flag allocation in object.h */
 #define ONELINE_SEEN (1u<<20)
=20
 static int handle_one_ref(const char *path,
diff --git a/upload-pack.c b/upload-pack.c
index 286a9ed..01de944 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -17,7 +17,7 @@
=20
 static const char upload_pack_usage[] =3D "git upload-pack [--strict] =
[--timeout=3D<n>] <dir>";
=20
-/* bits #0..7 in revision.h, #8..10 in commit.c */
+/* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
 #define OUR_REF		(1u << 12)
 #define WANTED		(1u << 13)
diff --git a/walker.c b/walker.c
index 633596e..1dd86b8 100644
--- a/walker.c
+++ b/walker.c
@@ -60,6 +60,7 @@ static int process_tree(struct walker *walker, struct=
 tree *tree)
 	return 0;
 }
=20
+/* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
 #define SEEN		(1U << 1)
 #define TO_SCAN		(1U << 2)
--=20
1.9.1.345.ga1a145c
