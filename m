From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/15] add: mark "The following paths are ignored" for
 translation
Date: Mon, 21 Feb 2011 04:25:30 -0600
Message-ID: <20110221102530.GL32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSxZ-0005i2-U7
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab1BUKZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:25:37 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47979 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BUKZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:25:36 -0500
Received: by iwn8 with SMTP id 8so1734490iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9+TiEEfVM06kq1BmjiU3SBVDPa4zOaDeq5R/zvXr/pI=;
        b=CT8a5i4PpJuHin59MUm+vffKJSmbCoS2WnJ4Av3B1yPfR28+wf+kJsWvFM/WIeKrTr
         r+uWoBIDorhxrlw3ND3V81oEJUK28ZsSZjiFl9eTtlvem99EibrUhl/BOiajp4DmPjO3
         6HUlFGtDguggeG+Tcw8AcFrCLkOBvKYRov+Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uI1wUPReCRRQKJ/4/Nt+hmHST4Awgsv1m2hVLQSb/bsPlieFWRCeDR3stSL0EUH4z6
         kBCzFxYNFvNAd5C+HT4HM4E6dj1aE2nqNDxjSXoEeZa7KULuIH2pF8z3wVS+uDe/0dO2
         cnVtJb8dGm9nuagFXlcePxF5D4jyXZem87NKo=
Received: by 10.42.220.199 with SMTP id hz7mr1757801icb.238.1298283936275;
        Mon, 21 Feb 2011 02:25:36 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u9sm5047271ibe.8.2011.02.21.02.25.34
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:25:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167467>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Wed, 22 Sep 2010 19:20:25 +0000

t2204 (.gitignore) and t3700 (add) explicitly check this sequence of
messages, so while at it, split each relevant test into a part that
just checks "git add"'s exit status and a part that checks porcelain
output.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c          |    8 ++++----
 t/t2204-add-ignored.sh |   37 +++++++++++++++++++++++++------------
 t/t3700-add.sh         |    5 ++++-
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a9a78f4..21776ac 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -307,7 +307,7 @@ static int edit_patch(int argc, const char **argv, =
const char *prefix)
 static struct lock_file lock_file;
=20
 static const char ignore_error[] =3D
-"The following paths are ignored by one of your .gitignore files:\n";
+N_("The following paths are ignored by one of your .gitignore files:\n=
");
=20
 static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing=
 =3D 0;
@@ -344,11 +344,11 @@ static int add_files(struct dir_struct *dir, int =
flags)
 	int i, exit_status =3D 0;
=20
 	if (dir->ignored_nr) {
-		fprintf(stderr, ignore_error);
+		fprintf(stderr, _(ignore_error));
 		for (i =3D 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, "Use -f if you really want to add them.\n");
-		die("no files added");
+		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		die(_("no files added"));
 	}
=20
 	for (i =3D 0; i < dir->nr; i++)
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 24afdab..4975336 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -31,18 +31,21 @@ do
 		rm -f .git/index &&
 		test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out &&
-		grep -e "Use -f if" err &&
-		cat err
+		! test -s out
+	'
+
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i output=
" '
+		grep -e "Use -f if" err
 	'
=20
 	test_expect_success "complaints for ignored $i with unignored file" '
 		rm -f .git/index &&
 		test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out &&
-		grep -e "Use -f if" err &&
-		cat err
+		! test -s out
+	'
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i with u=
nignored file output" '
+		grep -e "Use -f if" err
 	'
 done
=20
@@ -54,9 +57,14 @@ do
 			cd dir &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out &&
-			grep -e "Use -f if" err &&
-			cat err
+			! test -s out
+		)
+	'
+
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i in dir=
 output" '
+		(
+			cd dir &&
+			grep -e "Use -f if" err
 		)
 	'
 done
@@ -69,9 +77,14 @@ do
 			cd sub &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out &&
-			grep -e "Use -f if" err &&
-			cat err
+			! test -s out
+		)
+	'
+
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i in sub=
 output" '
+		(
+			cd sub &&
+			grep -e "Use -f if" err
 		)
 	'
 done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ec71083..ac115ed 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -283,7 +283,10 @@ add 'track-this'
 EOF
=20
 test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file' '
-	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err &&
+	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err
+'
+
+test_expect_success C_LOCALE_OUTPUT 'git add --dry-run --ignore-missin=
g of non-existing file output' '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
--=20
1.7.4.1
