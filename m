From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/14] Prevent diff machinery from examining worktree outside sparse checkout
Date: Sat, 20 Sep 2008 17:01:46 +0700
Message-ID: <1221904913-25887-8-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzJy-0001Fq-Ar
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYITKDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYITKDE
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbYITKDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=phFapAsAbk17g69qWnAox/s9GhWeG7ORfo6WMQaZDYY=;
        b=ZpZeAf3iarwhDVGpTKoHNvxkHZhPc+xzvKVUVUe78OKz8J6ZEVutM/lf+R/z1kw6R7
         Us/PjKhsCsT55gATWQ5EaCnnkPNOnURtm8u1el12OYyO/w082XW5wB5UpMaWsUhL09Je
         5eBROBvtRtLERdwNDdTIayq/B3eE1xOVMjjUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Hn6RE6E1Lzja8rKk7Aywioi3KmNN5Vyatl3XETS9iy7yWt29/tlYIgrA+2JkVQ5y9/
         R+IkqLjcmlqdEHbrKAYS7J63uTpV3GGsPsmTr2Viwd9qAuf1Oy9OD4KzVJpYsUEBqWvc
         0YLWkBMw2Xg85s+tAC6W+ky9r1dJ+0NqRNBtg=
Received: by 10.142.222.4 with SMTP id u4mr444011wfg.250.1221904981733;
        Sat, 20 Sep 2008 03:03:01 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 27sm3600388wff.3.2008.09.20.03.02.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:02:51 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96345>


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
index a2dd931..b5b7249 100644
--- a/diff.c
+++ b/diff.c
@@ -1793,8 +1793,10 @@ static int reuse_worktree_file(const char *name,=
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
1.6.0.96.g2fad1.dirty
