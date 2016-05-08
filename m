From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] rev-parse tests: add tests executed from a subdirectory
Date: Sun, 08 May 2016 11:05:54 -0700
Message-ID: <xmqqvb2ozapp.fsf@gitster.mtv.corp.google.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
	<1462541720-79553-2-git-send-email-rappazzo@gmail.com>
	<xmqqy47m25z4.fsf@gitster.mtv.corp.google.com>
	<CANoM8SVr1_G6KevbGSHifGyQS-ei57q+5D+GE_QmKvf_ysF2Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= 
	<pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:06:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azT5s-0000lH-I7
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbcEHSGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 14:06:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750913AbcEHSF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2016 14:05:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C66118CE0;
	Sun,  8 May 2016 14:05:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QNaHXDT83EUV
	SZ9qwATHLra+xu8=; b=rOKJQmEgQlitckNLF6+puFd6YTBwAHqPO7KID3FQIdjh
	idTGQHAusjdy8kxL06Pmk542MN9eSWOQKjh0yyM12CzNM6EoKc4BXjL4h8+PB3m7
	YVWAQNNCSif8TnyiWoBcYwOeVytq7E8HY85fxQhR/Xdg6GfFlvvhKy3UutULL2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a/Myoo
	16nHZ7CDskVqrbFah05TkLNr0O+mnc9FV02IwIgRbwJClyuS+dKYSwmadBCZiNuV
	a+ZJFBkH9+27j4QJQH+We12SzIBtS4jft4KeKk/ddxNYPBr4nQLxglFLvH0/tRMy
	Mim/Y2/GosZp+NNeGbBDyrEFSOYfGm7TJccns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81EB218CDF;
	Sun,  8 May 2016 14:05:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2C9F18CDD;
	Sun,  8 May 2016 14:05:55 -0400 (EDT)
In-Reply-To: <CANoM8SVr1_G6KevbGSHifGyQS-ei57q+5D+GE_QmKvf_ysF2Sg@mail.gmail.com>
	(Mike Rappazzo's message of "Sat, 7 May 2016 09:35:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82A44B8A-1547-11E6-8811-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293970>

Mike Rappazzo <rappazzo@gmail.com> writes:

>> Instead of cleaning things up like this, could you please please
>> please fix these existing tests that chdir around without being in a
>> subshell?  If the "previous tests" failed before going down as this
>> step expects, the "cd .. && rm -r" can make things worse.

> I originally copied the pattern from above this code:
> ...
> but G=C3=A1bor had an objection to it [2].  So I went with this simpl=
e cleanup test.

The "|| exit 1" you see everywhere is a sure sign that these tests
are not designed correctly.  These existing tests that do too many
things outside test_expect_success block needs to be redone, so that
each of them can do what it wants to test even when previous ones
failed.

What I had in mind was more a long the lines of this change. I only
did the first several just for illustration (I added an 'exit' to
mark where I stopped), but I think you get the idea.  The point is
that by doing things in subprocess inside test_expect_success you
can avoid disrupting the main test process even when a test fails as
much as possible, and this illustrates how you would deal with the
"cd" and "export".  What I didn't handle was the updates to
=2Egit/config whose effects by earlier tests are relied on later tests
in this illustration.

As to "table driven" vs "explicitly spelling out scripts, accepting
some code repetition", I tend to favor the latter slightly, unless
the table driven approach is done in such a way that each of its
tests are truly independent from one another, i.e. if a row of the
table represents one test, the tests would not be disrupted by
reordering the rows, inserting a new row in the middle, or removing
an existing row.  From my experience, "table-driven" sets of tests
whose rows have inter-dependency has been much harder to debug when
I had to hunt down a bug that manifests itself only in one test in
the middle.

Hope this helps clarify what I meant.

 t/t1500-rev-parse.sh | 82 ++++++++++++++++++++++++++++++--------------=
--------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..22b52c0 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -5,65 +5,79 @@ test_description=3D'test git rev-parse'
=20
 test_rev_parse() {
 	name=3D$1
-	shift
-
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' =3D \"\$(git rev-parse --is-bare-repository)\""
+	prep=3D$2
+	shift 2
+
+	test_expect_success "$name: is-bare-repository" "
+	(
+		$prep &&
+		test '$1' =3D \"\$(git rev-parse --is-bare-repository)\"
+	)"
 	shift
 	[ $# -eq 0 ] && return
=20
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' =3D \"\$(git rev-parse --is-inside-git-dir)\""
+	test_expect_success "$name: is-inside-git-dir" "
+	(
+		$prep &&
+		test '$1' =3D \"\$(git rev-parse --is-inside-git-dir)\"
+	)"
 	shift
 	[ $# -eq 0 ] && return
=20
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' =3D \"\$(git rev-parse --is-inside-work-tree)\""
+	test_expect_success "$name: is-inside-work-tree" "
+	(
+		$prep &&
+		test '$1' =3D \"\$(git rev-parse --is-inside-work-tree)\"
+	)"
 	shift
 	[ $# -eq 0 ] && return
=20
-	test_expect_success "$name: prefix" \
-	"test '$1' =3D \"\$(git rev-parse --show-prefix)\""
+	test_expect_success "$name: prefix" "
+	(
+		$prep &&
+		test '$1' =3D \"\$(git rev-parse --show-prefix)\"
+	)"
 	shift
 	[ $# -eq 0 ] && return
=20
-	test_expect_success "$name: git-dir" \
-	"test '$1' =3D \"\$(git rev-parse --git-dir)\""
+	test_expect_success "$name: git-dir" "
+	(
+		$prep &&
+		test '$1' =3D \"\$(git rev-parse --git-dir)\"
+	)"
 	shift
 	[ $# -eq 0 ] && return
 }
=20
-# label is-bare is-inside-git is-inside-work prefix git-dir
+# label prep is-bare is-inside-git is-inside-work prefix git-dir
=20
 ROOT=3D$(pwd)
+mkdir -p sub/dir work
=20
-test_rev_parse toplevel false false true '' .git
+test_rev_parse toplevel : false false true '' .git
=20
-cd .git || exit 1
-test_rev_parse .git/ false true false '' .
-cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
-cd ../.. || exit 1
+test_rev_parse .git 'cd .git' false true false '' .
=20
-mkdir -p sub/dir || exit 1
-cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
-cd ../.. || exit 1
+test_rev_parse .git/objects/ 'cd .git/objects' false true false '' "$R=
OOT/.git"
=20
-git config core.bare true
-test_rev_parse 'core.bare =3D true' true false false
+test_rev_parse subdirectory 'cd sub/dir' \
+	false false true sub/dir/ "$ROOT/.git"
=20
-git config --unset core.bare
-test_rev_parse 'core.bare undefined' false false true
+test_rev_parse 'core.bare =3D true' 'git config core.bare true' \
+	true false false
=20
-mkdir work || exit 1
-cd work || exit 1
-GIT_DIR=3D../.git
-GIT_CONFIG=3D"$(pwd)"/../.git/config
-export GIT_DIR GIT_CONFIG
+test_rev_parse 'core.bare undefined' 'git config --unset core.bare || =
:' \
+	false false true
=20
-git config core.bare false
-test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D false' false false tr=
ue ''
+test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D false' '
+	cd work &&=20
+	GIT_DIR=3D../.git &&
+	GIT_CONFIG=3D"$(pwd)"/../.git/config &&
+	export GIT_DIR GIT_CONFIG &&
+	git config core.bare false' \
+	false false true ''
+
+exit
=20
 git config core.bare true
 test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D true' true false fals=
e ''
