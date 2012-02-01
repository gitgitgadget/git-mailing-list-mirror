From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] pack-objects: remove bogus comment
Date: Wed,  1 Feb 2012 22:17:19 +0700
Message-ID: <1328109440-9510-2-git-send-email-pclouds@gmail.com>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
 <1328109440-9510-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 16:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsbsu-0006nB-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 16:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab2BAPOD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 10:14:03 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63338 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab2BAPOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 10:14:01 -0500
Received: by pbdu11 with SMTP id u11so1154333pbd.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p1vxECOdpvgSTwVfi+m8fshLrtEf2AUwpptFquZ62/s=;
        b=C8FEZj8YJBWLpEknXL5uRa+Apy4QlFuFIIkzDK1UE1lwEy9BhLRHdqbaTrXH5+STuM
         HLeoPLtQaZiGdH7lY+2Q8WVnjDEfeQxTUDsw2u0k9kBtGSbeXGNGaLSHZ+u5SFtSPhFv
         D0YqAFDYoyIgK01IaWfBk8INfKf5rJan1UNbY=
Received: by 10.68.195.73 with SMTP id ic9mr60858475pbc.72.1328109240938;
        Wed, 01 Feb 2012 07:14:00 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id kx17sm16643747pbb.19.2012.02.01.07.13.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 07:14:00 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 01 Feb 2012 22:17:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328109440-9510-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189515>

The comment was introduced in b5d97e6 (pack-objects: run rev-list
equivalent internally. - 2006-09-04), stating that

git pack-objects [options] base-name <refs...>

is acceptable and refs should be passed into rev-list. But that's not
true. All arguments after base-name are ignored.

Remove the comment and reject this syntax (i.e. no more arguments after
base name)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |   15 +--------------
 t/t5300-pack-object.sh |    4 ++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 297f792..80e3114 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2484,23 +2484,10 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
 		usage(pack_usage);
 	}
=20
-	/* Traditionally "pack-objects [options] base extra" failed;
-	 * we would however want to take refs parameter that would
-	 * have been given to upstream rev-list ourselves, which means
-	 * we somehow want to say what the base name is.  So the
-	 * syntax would be:
-	 *
-	 * pack-objects [options] base <refs...>
-	 *
-	 * in other words, we would treat the first non-option as the
-	 * base_name and send everything else to the internal revision
-	 * walker.
-	 */
-
 	if (!pack_to_stdout)
 		base_name =3D argv[i++];
=20
-	if (pack_to_stdout !=3D !base_name)
+	if (pack_to_stdout !=3D !base_name || argv[i])
 		usage(pack_usage);
=20
 	if (!pack_to_stdout && !pack_size_limit)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 602806d..d9d856b 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -38,6 +38,10 @@ test_expect_success \
     'pack without delta' \
     'packname_1=3D$(git pack-objects --window=3D0 test-1 <obj-list)'
=20
+test_expect_success \
+    'pack-objects with bogus arguments' \
+    'test_must_fail git pack-objects --window=3D0 test-1 blah blah <ob=
j-list'
+
 rm -fr .git2
 mkdir .git2
=20
--=20
1.7.8.36.g69ee2
