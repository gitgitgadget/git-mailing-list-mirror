From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/23] sparse checkout: inhibit empty worktree
Date: Mon, 14 Dec 2009 17:31:06 +0700
Message-ID: <1260786666-8405-24-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gn-0008VO-51
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbZLNKd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbZLNKdz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:55 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:39386 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313AbZLNKdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:44 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691452pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ct05QMEVpW/T4Gc9P2NXMv4p7mV/QmZV3oYHgqsCzBA=;
        b=mg4LMQmyzNk/WjOdmYnjMiMqXol6z8QvmbPFv5ZW78wxfSX9Aegf/11EPgXcS1f/Nt
         DjZKFO4rgF4+mhGc7RwIwQ2hBLTGSJ4K1ieT7rOn30SOrIPXHEFTF8SUk+Bn8hXHsZM/
         9TNgnEE5BnTISeJqJZWlplGM43hwiIHKQu94A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DO65CpEk5jsG3u03yrqzPGS7oFYl2rGGs7iX6srv7OdkrypsJXFQjSDHQMaKphOYQx
         R/sskeDlJTWISBKnpqdL6FzrLTWgX/u6fgync41+7LZOh03hoNvFzMPHcw/UnyspP0gk
         QBKnzORFzBzcbgLa9SGVJii1DF72ZJjyt2+1o=
Received: by 10.114.214.17 with SMTP id m17mr3049457wag.197.1260786824587;
        Mon, 14 Dec 2009 02:33:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4915543pzk.4.2009.12.14.02.33.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:33:02 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135188>

The way sparse checkout works, users may empty their worktree
completely, because of non-matching sparse-checkout spec, or empty
spec. I believe this is not desired. This patch makes Git refuse to
produce such worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1011-read-tree-sparse-checkout.sh |   10 +++-------
 unpack-trees.c                       |    7 +++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 2192f5a..62246db 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -55,20 +55,16 @@ test_expect_success 'read-tree --no-sparse-checkout=
 with empty .git/info/sparse-
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-S init.t
-S sub/added
-EOF
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	git config core.sparsecheckout true &&
 	echo > .git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	test_must_fail git read-tree -m -u HEAD &&
 	git ls-files --stage > result &&
 	test_cmp expected result &&
 	git ls-files -t > result &&
 	test_cmp expected.swt result &&
-	test ! -f init.t &&
-	test ! -f sub/added
+	test -f init.t &&
+	test -f sub/added
 '
=20
 cat >expected.swt <<EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index aac9922..d33b39e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -498,6 +498,7 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	}
=20
 	if (!o->skip_sparse_checkout) {
+		int empty_worktree =3D 1;
 		for (i =3D 0;i < o->result.cache_nr;i++) {
 			struct cache_entry *ce =3D o->result.cache[i];
=20
@@ -512,8 +513,14 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 			 */
 			if (ce_skip_worktree(ce))
 				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
+			else
+				empty_worktree =3D 0;
=20
 		}
+		if (o->result.cache_nr && empty_worktree) {
+			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g directory");
+			goto done;
+		}
 	}
=20
 	o->src_index =3D NULL;
--=20
1.6.5.2.216.g9c1ec
