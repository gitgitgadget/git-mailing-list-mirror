From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [RFC/PATCH 2/4] textconv: make diff_options accessible from blame
Date: Thu,  3 Jun 2010 12:47:16 +0200
Message-ID: <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 13:11:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK8L7-0006Qa-V7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 13:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362Ab0FCLLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 07:11:48 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mx1.imag.fr ([129.88.30.5]:35231 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228Ab0FCLLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 07:11:47 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o53AfJ4B028103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 3 Jun 2010 12:41:19 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o53Amh68023204;
	Thu, 3 Jun 2010 12:48:43 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o53AmhK1008474;
	Thu, 3 Jun 2010 12:48:43 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o53AmhrP008473;
	Thu, 3 Jun 2010 12:48:43 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Jun 2010 12:41:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o53AfJ4B028103
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148308>

Diff_options specify whether conversion is activated or not. Blame need=
s
to access these options in order to concert files with external drivers

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/blame.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..63b497c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -89,7 +89,8 @@ struct origin {
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
-static void fill_origin_blob(struct origin *o, mmfile_t *file)
+static void fill_origin_blob(struct diff_options opt,
+			     struct origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -741,8 +742,8 @@ static int pass_blame_to_parent(struct scoreboard *=
sb,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
=20
-	fill_origin_blob(parent, &file_p);
-	fill_origin_blob(target, &file_o);
+	fill_origin_blob(sb->revs->diffopt, parent, &file_p);
+	fill_origin_blob(sb->revs->diffopt, target, &file_o);
 	num_get_patch++;
=20
 	memset(&xpp, 0, sizeof(xpp));
@@ -922,7 +923,7 @@ static int find_move_in_parent(struct scoreboard *s=
b,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
=20
-	fill_origin_blob(parent, &file_p);
+	fill_origin_blob(sb->revs->diffopt, parent, &file_p);
 	if (!file_p.ptr)
 		return 0;
=20
@@ -1063,7 +1064,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
=20
 			norigin =3D get_origin(sb, parent, p->one->path);
 			hashcpy(norigin->blob_sha1, p->one->sha1);
-			fill_origin_blob(norigin, &file_p);
+			fill_origin_blob(sb->revs->diffopt, norigin, &file_p);
 			if (!file_p.ptr)
 				continue;
=20
@@ -1990,7 +1991,9 @@ static int git_blame_config(const char *var, cons=
t char *value, void *cb)
  * Prepare a dummy commit that represents the work tree (or staged) it=
em.
  * Note that annotating work tree item never works in the reverse.
  */
-static struct commit *fake_working_tree_commit(const char *path, const=
 char *contents_from)
+static struct commit *fake_working_tree_commit(struct diff_options opt=
,
+					       const char *path,
+					       const char *contents_from)
 {
 	struct commit *commit;
 	struct origin *origin;
@@ -2384,7 +2387,8 @@ parse_done:
 		 * or "--contents".
 		 */
 		setup_work_tree();
-		sb.final =3D fake_working_tree_commit(path, contents_from);
+		sb.final =3D fake_working_tree_commit(sb.revs->diffopt, path,
+						    contents_from);
 		add_pending_object(&revs, &(sb.final->object), ":");
 	}
 	else if (contents_from)
--=20
1.6.6.7.ga5fe3
