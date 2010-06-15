From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [PATCH 1/5 v2] merge-recursive: porcelain messages for checkout
Date: Tue, 15 Jun 2010 14:22:52 +0200
Message-ID: <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 14:23:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVAr-0006TW-LI
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab0FOMXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 08:23:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56983 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608Ab0FOMXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:23:12 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCF8PP002464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:15:08 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCN9Wx021124;
	Tue, 15 Jun 2010 14:23:09 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FCN90d028300;
	Tue, 15 Jun 2010 14:23:09 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FCN9aF028299;
	Tue, 15 Jun 2010 14:23:09 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:15:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCF8PP002464
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
MailScanner-NULL-Check: 1277208909.94064@S3YdVaGYMTXOWysN+tt2sQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149175>

A porcelain message was first added in checkout.c in the commit
8ccba008 (Junio C Hamano, Sat May 17 21:03:49 2008, unpack-trees:=20
allow Porcelain to give different error messages) so that it better fit=
=20
the situation.
This patch proposes other specific porcelain messages for checkout inst=
ead of
using merge plumbing error messages. This way, when having a checkout e=
rror,
"merge" no longer appears in the error message.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/checkout.c |    1 +
 builtin/merge.c    |    3 ++-
 merge-recursive.c  |   48 +++++++++++++++++++++++++++++++-------------=
----
 merge-recursive.h  |    6 ++++--
 4 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 88b1f43..6f34566 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -372,6 +372,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.src_index =3D &the_index;
 		topts.dst_index =3D &the_index;
=20
+		topts.msgs =3D get_porcelain_error_msgs("checkout");
 		topts.msgs.not_uptodate_file =3D "You have local changes to '%s'; ca=
nnot switch branches.";
=20
 		refresh_cache(REFRESH_QUIET);
diff --git a/builtin/merge.c b/builtin/merge.c
index 37d414b..501177f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -704,7 +704,8 @@ int checkout_fast_forward(const unsigned char *head=
, const unsigned char *remote
 	opts.verbose_update =3D 1;
 	opts.merge =3D 1;
 	opts.fn =3D twoway_merge;
-	opts.msgs =3D get_porcelain_error_msgs();
+
+	opts.msgs =3D get_porcelain_error_msgs("merge");
=20
 	trees[nr_trees] =3D parse_tree_indirect(head);
 	if (!trees[nr_trees++])
diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..80c9744 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -185,7 +185,7 @@ static int git_merge_trees(int index_only,
 	opts.fn =3D threeway_merge;
 	opts.src_index =3D &the_index;
 	opts.dst_index =3D &the_index;
-	opts.msgs =3D get_porcelain_error_msgs();
+	opts.msgs =3D get_porcelain_error_msgs("merge");
=20
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
@@ -1178,24 +1178,38 @@ static int process_entry(struct merge_options *=
o,
 	return clean_merge;
 }
=20
-struct unpack_trees_error_msgs get_porcelain_error_msgs(void)
+struct unpack_trees_error_msgs get_porcelain_error_msgs(const char *cm=
d)
 {
-	struct unpack_trees_error_msgs msgs =3D {
-		/* would_overwrite */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting=
=2E",
-		/* not_uptodate_file */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting=
=2E",
-		/* not_uptodate_dir */
-		"Updating '%s' would lose untracked files in it.  Aborting.",
-		/* would_lose_untracked */
-		"Untracked working tree file '%s' would be %s by merge.  Aborting",
-		/* bind_overlap -- will not happen here */
-		NULL,
-	};
+	struct unpack_trees_error_msgs msgs;
+
+	/* would_overwrite */
+	msgs.would_overwrite =3D malloc(sizeof(char) * 72);
+	sprintf((char *)msgs.would_overwrite,
+		"Your local changes to '%%s' would be overwritten by %s.  Aborting."=
,
+		cmd);
+	/* not_uptodate_file */
+	msgs.not_uptodate_file =3D msgs.would_overwrite;
+	/* not_uptodate_dir */
+	msgs.not_uptodate_dir =3D
+		"Updating '%s' would lose untracked files in it.  Aborting.";
+	/* would_lose_untracked */
+	msgs.would_lose_untracked =3D malloc(sizeof(char) * 72);
+	sprintf((char *)msgs.would_lose_untracked,
+		"Untracked working tree file '%%s' would be %%s by %s.  Aborting.",
+		cmd);
+
 	if (advice_commit_before_merge) {
-		msgs.would_overwrite =3D msgs.not_uptodate_file =3D
-			"Your local changes to '%s' would be overwritten by merge.  Abortin=
g.\n"
-			"Please, commit your changes or stash them before you can merge.";
+		msgs.would_overwrite =3D malloc(sizeof(char) * 140);
+		sprintf((char *)msgs.would_overwrite,
+			"Your local changes to '%%s' would be overwritten by %s.  Aborting.=
\n"
+			"Please, commit your changes or stash them before you can %s.",
+			cmd, strcmp(cmd,"checkout") ? cmd : "swicth branches");
+		msgs.not_uptodate_file =3D msgs.would_overwrite;
+		msgs.would_lose_untracked =3D malloc (sizeof(char) * 135);
+		sprintf((char *)msgs.would_lose_untracked,
+			"Untracked working tree file '%%s' would be %%s by %s.  Aborting.\n=
"
+			"Please move or remove them before you can %s.",
+			cmd, strcmp(cmd,"checkout") ? cmd : "swicth branches");
 	}
 	return msgs;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 0cc465e..d910ae6 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -23,8 +23,10 @@ struct merge_options {
 	struct string_list current_directory_set;
 };
=20
-/* Return a list of user-friendly error messages to be used by merge *=
/
-struct unpack_trees_error_msgs get_porcelain_error_msgs(void);
+/* Return a list of user-friendly error messages to be used by
+ * the command cmd which would be either merge or checkout
+ */
+struct unpack_trees_error_msgs get_porcelain_error_msgs(const char *cm=
d);
=20
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
--=20
1.6.6.7.ga5fe3
