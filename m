From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] read_tree(): pass "int stage" as context to read_tree_recursive()
Date: Sat, 18 Apr 2009 10:29:28 +1000
Message-ID: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 02:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuySf-0008FV-W3
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 02:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZDRA3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZDRA3k
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 20:29:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:21767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbZDRA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 20:29:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1128263rvb.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=IbXUVbljNnwVWGPYzsh2s2YteKIdN3ZTjwccTWkIkUU=;
        b=IpQoKmA2TqK4dEplII22w+698U29NjMYOjb7Z+lWZRCpIaTuKpsWaQxClNZHoX2Wmp
         1vjJghOodPP9yr32sHHqSglJxsnjzDHvVgcjbs98XJ9ULr84a3W1EeJV8szz6kk+r6j9
         9Xwpu/UK5OxgmEgNklXmXUHRiE+VcvL3AfkTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ZHJVPiz6qK4o151VkXPBx2wh1wDP7I3k3aBMuqYdAXtLEaEk7DuSlvVUU1d6IQHsko
         GrqP41xjPtycZ0Baj38P7WXxJbHOSh6VCj5e6QfhY+uiK+Ad5dsetxC+ZrhRbZ7Qynrc
         Q1XMD+KCPneP1dwJw7Hul9GDuRHWC0igFi72A=
Received: by 10.141.113.3 with SMTP id q3mr1400854rvm.82.1240014579249;
        Fri, 17 Apr 2009 17:29:39 -0700 (PDT)
Received: from dektop ([121.91.179.56])
        by mx.google.com with ESMTPS id k2sm2203925rvb.36.2009.04.17.17.29.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Apr 2009 17:29:38 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 18 Apr 2009 10:29:29 +1000
X-Mailer: git-send-email 1.6.2.2.693.g5a1be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116806>

Back in history, read_tree_recursive() did not have context argument to
pass custom parameters through. To support read_tree(), it took "stage"
from read_tree() and pass it to read_tree_fn_t function.  Then context
argument was added but "stage" remains as a read_tree_fn_t argument.

This patch converts read_tree() to pass stage as a context instead,
thus remove the last usage of "stage" argument in
read_tree_recursive() and read_tree_fn_t. When the opportunity comes,
"stage" should be removed from read_tree_fn_t and read_tree_recursive()=
=2E

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree.c |    6 +++---
 tree.h |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 0d703a0..02f2ca0 100644
--- a/tree.c
+++ b/tree.c
@@ -31,7 +31,7 @@ static int read_one_entry_opt(const unsigned char *sh=
a1, const char *base, int b
=20
 static int read_one_entry(const unsigned char *sha1, const char *base,=
 int baselen, const char *pathname, unsigned mode, int stage, void *con=
text)
 {
-	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
+	return read_one_entry_opt(sha1, base, baselen, pathname, mode, *(int =
*)context,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
=20
@@ -41,7 +41,7 @@ static int read_one_entry(const unsigned char *sha1, =
const char *base, int basel
  */
 static int read_one_entry_quick(const unsigned char *sha1, const char =
*base, int baselen, const char *pathname, unsigned mode, int stage, voi=
d *context)
 {
-	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
+	return read_one_entry_opt(sha1, base, baselen, pathname, mode, *(int =
*)context,
 				  ADD_CACHE_JUST_APPEND);
 }
=20
@@ -206,7 +206,7 @@ int read_tree(struct tree *tree, int stage, const c=
har **match)
=20
 	if (!fn)
 		fn =3D read_one_entry_quick;
-	err =3D read_tree_recursive(tree, "", 0, stage, match, fn, NULL);
+	err =3D read_tree_recursive(tree, "", 0, 0, match, fn, &stage);
 	if (fn =3D=3D read_one_entry || err)
 		return err;
=20
diff --git a/tree.h b/tree.h
index 2ff01a4..d0f4c9b 100644
--- a/tree.h
+++ b/tree.h
@@ -21,6 +21,7 @@ int parse_tree(struct tree *tree);
 struct tree *parse_tree_indirect(const unsigned char *sha1);
=20
 #define READ_TREE_RECURSIVE 1
+/* FIXME: remove "int stage" argument from read_tree_fn_t */
 typedef int (*read_tree_fn_t)(const unsigned char *, const char *, int=
, const char *, unsigned int, int, void *);
=20
 extern int read_tree_recursive(struct tree *tree,
--=20
1.6.2.2.693.g5a1be
