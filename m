From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] Add tests for diff.color-words configuration option.
Date: Mon, 19 Jan 2009 20:17:53 -0600
Message-ID: <200901192017.54163.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <adf1fd3d0901191447n7fc39dect9cf5afd88a02015b@mail.gmail.com> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 03:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP6D7-0003DW-Fe
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 03:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbZATCR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 21:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbZATCR6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 21:17:58 -0500
Received: from eastrmmtao106.cox.net ([68.230.240.48]:63184 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbZATCR5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 21:17:57 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090120021757.GSQX29613.eastrmmtao106.cox.net@eastrmimpo02.cox.net>;
          Mon, 19 Jan 2009 21:17:57 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id 5eHu1b00H2i4SyG02eHvvq; Mon, 19 Jan 2009 21:17:56 -0500
X-Authority-Analysis: v=1.0 c=1 a=FE7b1J5VVWEA:10 a=LD0FNtuhpLgA:10
 a=Fq1VQ0LPAAAA:8 a=UFrrqm8G_6aEkDTnu5QA:9 a=Thzqw39GSF-ZMo5yzpbrgEEbxk0A:4
 a=T3brmoaXcPoA:10 a=_RhRFcbxBZMA:10 a=JcB9aHnUDh0A:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LP6Be-0004Lk-9X; Mon, 19 Jan 2009 20:17:54 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106426>

Signed-Off-By: Boyd Stephen Smith Jr. <bss@iguanasuicide.net>
---
On Monday 19 January 2009, Johannes Schindelin <Johannes.Schindelin@gmx=
=2Ede> wrote about 'Re: [PATCH v4=20
0/7] customizable --color-words':
>On Mon, 19 Jan 2009, Santi B=C3=A9jar wrote:
>> Also, having a config (diff.color-words?) to set the default regexp
>> would be great. Thanks.
>
>From "git log --author=3D=3DSanti --stat" it seems that you are quite =
capable
>of providing that patch.
>
>A few pointers:
>
>- Add a test to t4034 that tests that the config sets a default, and t=
hat
>  the command line can override it.

Here's a couple tests to get someone started, adds one "known breakage"=
 to
the results of the test suite.  This is to be applied on top of
the existing patches.

Yes, I also think I'll work on the actual implementation, but I'd be gl=
ad
to have someone beat me to it.  I'm not sure why the diff is crazy long=
=2E

 t/t4034-diff-words.sh |   50 +++++++++++++++++++++++++++++++++++------=
-------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 744221b..6ebce9d 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -63,7 +63,7 @@ test_expect_success 'word diff with runs of whitespac=
e' '
=20
 '
=20
-cat > expect <<\EOF
+cat > expect.letter-runs-are-words <<\EOF
 <WHITE>diff --git a/pre b/post<RESET>
 <WHITE>index 330b04f..5ed8eff 100644<RESET>
 <WHITE>--- a/pre<RESET>
@@ -77,6 +77,7 @@ a =3D b + c<RESET>
=20
 <GREEN>aeff =3D aeff * ( aaa<RESET> )
 EOF
+cp expect.letter-runs-are-words expect
=20
 test_expect_success 'word diff with a regular expression' '
=20
@@ -84,21 +85,11 @@ test_expect_success 'word diff with a regular expre=
ssion' '
=20
 '
=20
-test_expect_success 'set a diff driver' '
-	git config diff.testdriver.wordregex "[^[:space:]]" &&
-	cat <<EOF > .gitattributes
-pre diff=3Dtestdriver
-post diff=3Dtestdriver
-EOF
-'
-
-test_expect_success 'option overrides default' '
-
-	word_diff --color-words=3D"[a-z]+"
-
+test_expect_success 'add configuration for default regex' '
+	git config diff.color-words "[^[:space:]]"
 '
=20
-cat > expect <<\EOF
+cat > expect.non-whitespace-is-word <<\EOF
 <WHITE>diff --git a/pre b/post<RESET>
 <WHITE>index 330b04f..5ed8eff 100644<RESET>
 <WHITE>--- a/pre<RESET>
@@ -112,6 +103,37 @@ a =3D b + c<RESET>
=20
 <GREEN>aeff =3D aeff * ( aaa )<RESET>
 EOF
+cp expect.non-whitespace-is-word expect
+
+test_expect_failure 'use default supplied by config' '
+
+	word_diff --color-words
+
+'
+
+cp expect.letter-runs-are-words expect
+
+test_expect_success 'option overrides config-default' '
+
+	word_diff --color-words=3D"[a-z]+"
+
+'
+
+test_expect_success 'set a diff driver' '
+	git config diff.testdriver.wordregex "[^[:space:]]" &&
+	cat <<EOF > .gitattributes
+pre diff=3Dtestdriver
+post diff=3Dtestdriver
+EOF
+'
+
+test_expect_success 'option overrides default' '
+
+	word_diff --color-words=3D"[a-z]+"
+
+'
+
+cp expect.non-whitespace-is-word expect
=20
 test_expect_success 'use default supplied by driver' '
=20
--=20
1.5.6.5
--=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20
