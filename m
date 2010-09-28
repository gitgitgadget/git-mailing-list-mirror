From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] diff-no-index: use diff_tree_setup_paths()
Date: Tue, 28 Sep 2010 22:00:25 +1000
Message-ID: <1285675229-28019-3-git-send-email-pclouds@gmail.com>
References: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ijY-00036b-3U
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab0I1WdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:33:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55020 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0I1WdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:33:00 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so35176pvg.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WvrY/+970G2bakEd3we5MjBNSe5I0GuABuJOI2VYPfE=;
        b=qn7LOtXEWAR8Tu+UcUVi/ta4HquhoRtaOzhV+sOrcy9Ge0HXWlsbnrUIcEmC0oih3Q
         maF9WpWfwB21kH8SNwnpTl8eO12+0jqWQN4S3XsBR8nTWZiCXWDYo186Qx+o5brxqzrz
         z/Ytc9+2CO93Fl4FB+i+MMtipjU9ZxJVW7mmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LE0efsGf3apz37AFaZYyY6aZ5K4I71CC8uKOPiH/CtyfCYuoaMQ4XRAtbsjrrim/4l
         k0BrzBmYJrBvvCg61cKtfIQTy+mw7H2d076TBMgBiyNgVsVFO99EYdaskA1wh1vNdRLF
         t2uJuJYgL2FE3fD82/bnWqGQdEs1aape0yZyQ=
Received: by 10.142.211.19 with SMTP id j19mr591594wfg.216.1285713179968;
        Tue, 28 Sep 2010 15:32:59 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id l42sm9364271wfa.9.2010.09.28.15.32.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 15:32:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 28 Sep 2010 22:00:43 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157487>

diff_options.{paths,nr_paths} will be removed later. Do not
modify them directly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ce9e783..e48ab92 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -231,8 +231,9 @@ void diff_no_index(struct rev_info *revs,
=20
 	if (prefix) {
 		int len =3D strlen(prefix);
+		const char *paths[3];
+		memset(paths, 0, sizeof(paths));
=20
-		revs->diffopt.paths =3D xcalloc(2, sizeof(char *));
 		for (i =3D 0; i < 2; i++) {
 			const char *p =3D argv[argc - 2 + i];
 			/*
@@ -242,12 +243,12 @@ void diff_no_index(struct rev_info *revs,
 			p =3D (strcmp(p, "-")
 			     ? xstrdup(prefix_filename(prefix, len, p))
 			     : p);
-			revs->diffopt.paths[i] =3D p;
+			paths[i] =3D p;
 		}
+		diff_tree_setup_paths(paths, &revs->diffopt);
 	}
 	else
-		revs->diffopt.paths =3D argv + argc - 2;
-	revs->diffopt.nr_paths =3D 2;
+		diff_tree_setup_paths(argv + argc - 2, &revs->diffopt);
 	revs->diffopt.skip_stat_unmatch =3D 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format =3D DIFF_FORMAT_PATCH;
--=20
1.7.1.rc1.70.g788ca
