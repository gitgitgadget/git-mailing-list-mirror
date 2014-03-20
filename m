From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/2] object.h: centralize object flag allocation
Date: Thu, 20 Mar 2014 12:44:13 +0700
Message-ID: <1395294254-941-1-git-send-email-pclouds@gmail.com>
References: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 06:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQVmH-00037S-T8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 06:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaCTFoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 01:44:24 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58532 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbaCTFoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 01:44:22 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so427569pdb.14
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 22:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qk25rB02snyho7b7GCIuVkw8DWqX3yHmOvpmz0GMJOk=;
        b=b76JoiR/kH+JUVt4J2eQEmjoHZmrUGFyRs+aVaC5YtI+jE/6HUytz7di0xqXed0XHY
         bLowFO6c47NOlLM/j7z4ML9e9cJsTOOCwmjnMNdD/PntOlgT96AD1pUQi1hGjuMOTDce
         P6eIe9ZnHhd2wdTRpt9LIfALsNaZjqYcdse61EvCcZU4oKf3fulQTwJcfRWl+X3tlj31
         QK+P1tdo1drgShiJGtYn+9RMahJCPQIc+kxDjiWj4nFb0HdkCuemSJDijrv88tRLnCGE
         iDGahjlNmip4BLa6wn2nsHVqkNh0me00n8MSE846rvXOdXnqR0mn2TMRsBidnVMQ3rHO
         wxwg==
X-Received: by 10.68.178.66 with SMTP id cw2mr44684111pbc.89.1395294262119;
        Wed, 19 Mar 2014 22:44:22 -0700 (PDT)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id un5sm4320788pab.3.2014.03.19.22.44.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 22:44:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Mar 2014 12:44:15 +0700
X-Mailer: git-send-email 1.9.0.201.g13d9d8b
In-Reply-To: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244518>

While the field "flags" is mainly used by the revision walker, it is
also used in many other places. Centralize the whole flag allocation to
one place for a better overview (and easier to move flags if we have
too).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The next step could be define (instead of document) all of them in
 a single place. But that may result in naming conflicts and stuff
 for little gain.

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
index f061f1f..fd470e7 100644
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
index 732bf4d..768490b 100644
--- a/object.h
+++ b/object.h
@@ -26,6 +26,19 @@ struct object_array {
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
=20
 #define TYPE_BITS   3
+/*
+ * object flag allocation:
+ * revision.h:      0------10
+ * fetch-pack.c:    0---4
+ * walker.c:        0-2
+ * upload-pack.c:             11---------19
+ * builtin/blame.c:              12-13
+ * bisect.c:                          16
+ * bundle.c:                          16
+ * http-push.c:                       16-19
+ * commit.c:                          16-19
+ * sha1_name.c:                            20
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
index 9314c25..27df12f 100644
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
1.9.0.201.g13d9d8b
