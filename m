From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/9] Prevent diff machinery from examining worktree outside sparse checkout
Date: Wed,  1 Oct 2008 11:04:07 +0700
Message-ID: <1222833849-22129-8-git-send-email-pclouds@gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
 <1222833849-22129-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:07:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkszh-0001Sc-LV
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbYJAEF5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 00:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYJAEF5
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:05:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbYJAEF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:05:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kmB8S5dajC55l4eUNX3nOIyGpIuMU5Xw4VxeKjFBEMA=;
        b=f5rdIGKTRXnpdksWh/boOWzW+0o2u4oFwJM4iIL6d3dieXg+0UyVuPrXwFH82sK89F
         VP5DuuPKXTuBq6jiZzMhBbsE0I9uhmrH+gv2XJQ7oETTBM4vSdKaCRibxBvtgE3nPmh/
         ECAsbLiv5EiMU72AqOe5EBnpHon835xGdJfOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ldFBh1qEYtPMk8ZN4ESfuBJtYsATJQ0lkMg3o22bCndhChQMYFkMF+PNdmCemfcfiT
         MTxy/SZsS3Hh2LPRY+MqC+3OMee1KJEFYRF8RVPTS5CK/aYz8i27v6KC6iyQDLh8EIOX
         p/jBbMDQNPHvtWEspCy5OZYGUFDmAUa5ap6Vw=
Received: by 10.141.74.17 with SMTP id b17mr4036502rvl.119.1222833956260;
        Tue, 30 Sep 2008 21:05:56 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id b8sm3947545rvf.4.2008.09.30.21.05.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:05:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:05:49 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
In-Reply-To: <1222833849-22129-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97198>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c |    5 +++--
 diff.c     |    4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae96c64..992280b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -161,7 +161,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || ce_no_checkout(ce))
 			continue;
=20
 		changed =3D check_removed(ce, &st);
@@ -348,6 +348,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	struct rev_info *revs =3D cbdata->revs;
 	int match_missing, cached;
=20
+	/* if the entry is not checked out, don't examine work tree */
+	cached =3D o->index_only || (idx && ce_no_checkout(idx));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -355,7 +357,6 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/diff.c b/diff.c
index b001d7b..c001e2c 100644
--- a/diff.c
+++ b/diff.c
@@ -1798,8 +1798,10 @@ static int reuse_worktree_file(const char *name,=
 const unsigned char *sha1, int
=20
 	/*
 	 * If ce matches the file in the work tree, we can reuse it.
+	 * For sparse checkout case, ce_uptodate() may be true although
+	 * the file may or may not exist in the work tree.
 	 */
-	if (ce_uptodate(ce) ||
+	if ((ce_uptodate(ce) && ce_checkout(ce)) ||
 	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
=20
--=20
1.6.0.2.488.gf604a
