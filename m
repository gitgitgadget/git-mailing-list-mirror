From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 6/8] unpack-trees.c: generalize verify_* functions
Date: Tue, 11 Aug 2009 22:44:04 +0700
Message-ID: <1250005446-12047-7-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatXG-0007BD-Tv
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbZHKPou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbZHKPot
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbZHKPos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:48 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=M5v45+tP+k77ijZJYlSN7mxOoGDzFbIETI28Mei4MzU=;
        b=w7efJ3+xcghMR1coWZFntVRf9/E874LQpg/KMm9BrdtB5kLXDVIo1138R2Dd5Zz3k5
         4sFl8tABGvS/NmwBA113pZuzT2qyYt1v6lC/XDGVVbKiVqGrAT2ZcHcxh9LG4W7ivC7h
         i57gSEF+Mp0cN4tsfdhv6pU4i/aMGTM0Uwbeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PVa0Z/ZHzhgP+GMeGRcndoJ88+581zq7mGLi0ufGGZqIBvtsRVHmw6FXY7Ibt3RXSs
         m0U8H9Hghx38iTNeGE23FvvNam6hx8KspLrdqI5NpTU2jM41xRGu4Y4bvRw3V22HKYxq
         zv9geFkUAELMlM09blYdJEAgzIfyCSj78kAD8=
Received: by 10.141.41.18 with SMTP id t18mr2257613rvj.264.1250005489984;
        Tue, 11 Aug 2009 08:44:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id g14sm32826309rvb.30.2009.08.11.08.44.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:44 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125583>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..02ea236 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -445,8 +445,9 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
+static int verify_uptodate_1(struct cache_entry *ce,
+				   struct unpack_trees_options *o,
+				   const char *error_msg)
 {
 	struct stat st;
=20
@@ -471,7 +472,13 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno =3D=3D ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, not_uptodate_file), ce->name);
+		error(error_msg, ce->name);
+}
+
+static int verify_uptodate(struct cache_entry *ce,
+			   struct unpack_trees_options *o)
+{
+	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -579,8 +586,9 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent(struct cache_entry *ce, const char *action,
-			 struct unpack_trees_options *o)
+static int verify_absent_1(struct cache_entry *ce, const char *action,
+				 struct unpack_trees_options *o,
+				 const char *error_msg)
 {
 	struct stat st;
=20
@@ -660,6 +668,11 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	}
 	return 0;
 }
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
+}
=20
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
--=20
1.6.3.GIT
