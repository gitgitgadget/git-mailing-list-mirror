From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 02/28] Replace struct extra_have_objects with struct sha1_array
Date: Thu,  5 Dec 2013 20:02:29 +0700
Message-ID: <1386248575-10206-3-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYVm-0001IJ-KS
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab3LEM6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:30 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40771 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab3LEM62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:28 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so24790891pdi.10
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7dtxnnVP/wlbzW3864SpOvqZOmgrOyfGxvHoHUNtfjc=;
        b=yNN6AUsMFLO/ubdhzwun9gW5ymdypvX+4vrxKmW7bBeRrfx/yBvoyUhOnrS6T2k3i5
         qK0k+Hwagy+RzDoj4wrJYzTserQ1M8mnPDvmWf/MCsWb7WgiZuS1VNgRZ4fhu/hRbH3P
         QVu42/SBSEpH1fRQYg/4fUYfxvLEZYQXj2BFUzYSjnDOQ281hSb7l1ZROcz0Ybnr8Hmz
         NdlH1KuI47i+dYhhM7TiLCn+rh0fd1T+4PXt8bFw2k6410MNMnmU8+c0hcq6tlh//XiQ
         Cldu6j7kL4fYflMKCobQ06sh/RwsbykqYvgSnIQfzmeSovPPoAKH6Kg9K+4zGbxdmkyn
         dzKA==
X-Received: by 10.66.123.5 with SMTP id lw5mr87640841pab.83.1386248308311;
        Thu, 05 Dec 2013 04:58:28 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id vh3sm111396119pbc.8.2013.12.05.04.58.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:12 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238857>

The latter can do everything the former can and is used in many more
places.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c |  5 ++---
 connect.c           | 12 +++---------
 remote.h            |  7 ++-----
 send-pack.c         |  7 ++++---
 send-pack.h         |  2 +-
 transport.c         |  3 ++-
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4482f16..faaa603 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
+#include "sha1-array.h"
=20
 static const char send_pack_usage[] =3D
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pac=
k=3D<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref=
>...]\n"
@@ -99,7 +100,7 @@ int cmd_send_pack(int argc, const char **argv, const=
 char *prefix)
 	const char *dest =3D NULL;
 	int fd[2];
 	struct child_process *conn;
-	struct extra_have_objects extra_have;
+	struct sha1_array extra_have =3D SHA1_ARRAY_INIT;
 	struct ref *remote_refs, *local_refs;
 	int ret;
 	int helper_status =3D 0;
@@ -228,8 +229,6 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
-	memset(&extra_have, 0, sizeof(extra_have));
-
 	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e);
=20
 	transport_verify_remote_names(nr_refspecs, refspecs);
diff --git a/connect.c b/connect.c
index 06e88b0..48eec41 100644
--- a/connect.c
+++ b/connect.c
@@ -8,6 +8,7 @@
 #include "connect.h"
 #include "url.h"
 #include "string-list.h"
+#include "sha1-array.h"
=20
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int=
 *);
@@ -45,13 +46,6 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, strlen(ref->name), flags);
 }
=20
-static void add_extra_have(struct extra_have_objects *extra, unsigned =
char *sha1)
-{
-	ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
-	hashcpy(&(extra->array[extra->nr][0]), sha1);
-	extra->nr++;
-}
-
 static void die_initial_contact(int got_at_least_one_head)
 {
 	if (got_at_least_one_head)
@@ -122,7 +116,7 @@ static void annotate_refs_with_symref_info(struct r=
ef *ref)
  */
 struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
-			      struct extra_have_objects *extra_have)
+			      struct sha1_array *extra_have)
 {
 	struct ref **orig_list =3D list;
 	int got_at_least_one_head =3D 0;
@@ -160,7 +154,7 @@ struct ref **get_remote_heads(int in, char *src_buf=
, size_t src_len,
=20
 		if (extra_have &&
 		    name_len =3D=3D 5 && !memcmp(".have", name, 5)) {
-			add_extra_have(extra_have, old_sha1);
+			sha1_array_append(extra_have, old_sha1);
 			continue;
 		}
=20
diff --git a/remote.h b/remote.h
index 131130a..984519b 100644
--- a/remote.h
+++ b/remote.h
@@ -137,13 +137,10 @@ int check_ref_type(const struct ref *ref, int fla=
gs);
  */
 void free_refs(struct ref *ref);
=20
-struct extra_have_objects {
-	int nr, alloc;
-	unsigned char (*array)[20];
-};
+struct sha1_array;
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src=
_len,
 				     struct ref **list, unsigned int flags,
-				     struct extra_have_objects *);
+				     struct sha1_array *extra_have);
=20
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_=
sha1);
diff --git a/send-pack.c b/send-pack.c
index fab62e3..14005fa 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
+#include "sha1-array.h"
=20
 static int feed_object(const unsigned char *sha1, int fd, int negative=
)
 {
@@ -28,7 +29,7 @@ static int feed_object(const unsigned char *sha1, int=
 fd, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct extra_have_ob=
jects *extra, struct send_pack_args *args)
+static int pack_objects(int fd, struct ref *refs, struct sha1_array *e=
xtra, struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -71,7 +72,7 @@ static int pack_objects(int fd, struct ref *refs, str=
uct extra_have_objects *ext
 	 * parameters by writing to the pipe.
 	 */
 	for (i =3D 0; i < extra->nr; i++)
-		if (!feed_object(extra->array[i], po.in, 1))
+		if (!feed_object(extra->sha1[i], po.in, 1))
 			break;
=20
 	while (refs) {
@@ -177,7 +178,7 @@ static int sideband_demux(int in, int out, void *da=
ta)
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
-	      struct extra_have_objects *extra_have)
+	      struct sha1_array *extra_have)
 {
 	int in =3D fd[0];
 	int out =3D fd[1];
diff --git a/send-pack.h b/send-pack.h
index 05d7ab1..8e84392 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -16,6 +16,6 @@ struct send_pack_args {
=20
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
-	      struct ref *remote_refs, struct extra_have_objects *extra_have)=
;
+	      struct ref *remote_refs, struct sha1_array *extra_have);
=20
 #endif
diff --git a/transport.c b/transport.c
index 7202b77..12e46ad 100644
--- a/transport.c
+++ b/transport.c
@@ -14,6 +14,7 @@
 #include "url.h"
 #include "submodule.h"
 #include "string-list.h"
+#include "sha1-array.h"
=20
 /* rsync support */
=20
@@ -454,7 +455,7 @@ struct git_transport_data {
 	struct child_process *conn;
 	int fd[2];
 	unsigned got_remote_heads : 1;
-	struct extra_have_objects extra_have;
+	struct sha1_array extra_have;
 };
=20
 static int set_git_option(struct git_transport_options *opts,
--=20
1.8.5.1.25.g8667982
