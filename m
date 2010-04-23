From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Fri, 23 Apr 2010 16:59:49 +0200
Message-ID: <4BD1B5E5.6030307@spacetec.no>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com> <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Apr 23 17:07:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5KTY-0006ni-9p
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 17:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192Ab0DWPHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 11:07:22 -0400
Received: from puck.spacetec.no ([192.51.5.29]:60002 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755476Ab0DWPHR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 11:07:17 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2010 11:07:16 EDT
Received: (qmail 23594 invoked from network); 23 Apr 2010 14:59:53 -0000
Received: from ringworld4.spacetec.no (HELO ?10.10.1.233?) (tor@10.10.1.233)
  by puck.spacetec.no with ESMTPA; 23 Apr 2010 14:59:53 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100411 Iceowl/1.0b1 Icedove/3.0.4
In-Reply-To: <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145622>

On 03/31/10 18:29, Brandon Casey wrote:

> Can you run the test suite with this ksh?  If it suffers from
> the same exit status behavior of ksh on IRIX and SunOS, then
> I have a patch which allows the test suite to run.

I've run a test (make test -k) on Tru64 V5.1 on today's version of Git =
(08641d02) plus=20
your  ksh test patch. I haven't done any analysis yet of the tests whic=
h failed, but I'll
start looking at some of them later (particularly the first one that fa=
iled, a 'tar'
test).

Below is a diff between the output from a run on Linux and the Tru64 on=
e
(instead of a full log), just to illustrate which ones failed.

(Is this log too much to post inline? If yes, then I'll use an attachme=
nt for any=20
future logs)

-Tor

(this is basically diff -u linux-x86-test-log tru64-test-log)

 *** t0000-basic.sh ***
 *   ok 1: .git/objects should be empty after git init in an empty repo=
=2E
 *   ok 2: .git/objects should have 3 subdirectories.
@@ -208,9 +204,17 @@
 * passed all 2 test(s)
 *** t0024-crlf-archive.sh ***
 *   ok 1: setup
-*   ok 2: tar archive
+* FAIL 2: tar archive
+=09
+=09
+		git archive --format=3Dtar HEAD |
+		( mkdir untarred && cd untarred && "$TAR" -xf - )
+=09
+		test_cmp sample untarred/sample
+=09
+=09
 *   ok 3: zip archive
-* passed all 3 test(s)
+* failed 1 among 3 test(s)
 *** t0030-stripspace.sh ***
 *   ok 1: long lines without spaces should be unchanged
 *   ok 2: lines with spaces at the beginning should be unchanged
@@ -909,14 +913,14 @@
 *   ok 11: ref name 'heads/foo.lock' is not valid
 *   ok 12: ref name 'heads/foo@bar' is valid
 *   ok 13: ref name 'heads/v@{ation' is not valid
-*   ok 14: ref name 'heads/foo\bar' is not valid
+*   ok 14: ref name 'heads/foo=08ar' is not valid
 *   ok 15: check-ref-format --branch @{-1}
 *   ok 16: ref name 'heads/foo' simplifies to 'heads/foo'
 *   ok 17: ref name 'refs///heads/foo' simplifies to 'refs/heads/foo'
 *   ok 18: check-ref-format --print rejects 'foo'
 *   ok 19: check-ref-format --print rejects 'heads/foo/../bar'
 *   ok 20: check-ref-format --print rejects 'heads/./foo'
-*   ok 21: check-ref-format --print rejects 'heads\foo'
+*   ok 21: check-ref-format --print rejects 'heads=0Coo'
 * passed all 21 test(s)
 *** t1410-reflog.sh ***
 *   ok 1: setup
@@ -1468,7 +1472,8 @@
 * passed all 6 test(s)
 *** t3001-ls-files-others-exclude.sh ***
 *   ok 1: git ls-files --others with various exclude options.
-*   ok 2: git ls-files --others with \r\n line endings.
+*   ok 2: git ls-files --others with=20

+ line endings.
 *   ok 3: setup skip-worktree gitignore
 *   ok 4: git ls-files --others with various exclude options.
 *   ok 5: restore gitignore
@@ -2260,7 +2265,10 @@
 *   ok 7: check encoding header for eucJP
 *   ok 8: check encoding header for ISO-2022-JP
 *   ok 9: config to remove customization
-*   ok 10: ISO8859-1 should be shown in UTF-8 now
+* FAIL 10: ISO8859-1 should be shown in UTF-8 now
+=09
+		compare_with ISO8859-1 "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
+=09
 *   ok 11: eucJP should be shown in UTF-8 now
 *   ok 12: ISO-2022-JP should be shown in UTF-8 now
 *   ok 13: config to add customization
@@ -2268,7 +2276,10 @@
 *   ok 15: eucJP should be shown in itself now
 *   ok 16: ISO-2022-JP should be shown in itself now
 *   ok 17: config to tweak customization
-*   ok 18: ISO8859-1 should be shown in UTF-8 now
+* FAIL 18: ISO8859-1 should be shown in UTF-8 now
+=09
+		compare_with ISO8859-1 "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
+=09
 *   ok 19: eucJP should be shown in UTF-8 now
 *   ok 20: ISO-2022-JP should be shown in UTF-8 now
 *   ok 21: eucJP should be shown in eucJP now
@@ -2278,24 +2289,195 @@
 *   ok 25: No conversion with ISO8859-1
 *   ok 26: No conversion with eucJP
 *   ok 27: No conversion with ISO-2022-JP
-* passed all 27 test(s)
+* failed 2 among 27 test(s)
 *** t3901-i18n-patch.sh ***
 *   ok 1: setup
-*   ok 2: format-patch output (ISO-8859-1)
-*   ok 3: format-patch output (UTF-8)
-*   ok 4: rebase (U/U)
-*   ok 5: rebase (U/L)
-*   ok 6: rebase (L/L)
-*   ok 7: rebase (L/U)
-*   ok 8: cherry-pick(U/U)
-*   ok 9: cherry-pick(L/L)
-*   ok 10: cherry-pick(U/L)
-*   ok 11: cherry-pick(L/U)
-*   ok 12: rebase --merge (U/U)
-*   ok 13: rebase --merge (U/L)
-*   ok 14: rebase --merge (L/L)
-*   ok 15: rebase --merge (L/U)
-* passed all 15 test(s)
+* FAIL 2: format-patch output (ISO-8859-1)
+=09
+		git config i18n.logoutputencoding ISO8859-1 &&
+=09
+		git format-patch --stdout master..HEAD^ >out-l1 &&
+		git format-patch --stdout HEAD^ >out-l2 &&
+		grep "^Content-Type: text/plain; charset=3DISO8859-1" out-l1 &&
+		grep "^From: =3D?ISO8859-1?q?=3DC1=3DE9=3DED=3D20=3DF3=3DFA?=3D" out=
-l1 &&
+		grep "^Content-Type: text/plain; charset=3DISO8859-1" out-l2 &&
+		grep "^From: =3D?ISO8859-1?q?=3DC1=3DE9=3DED=3D20=3DF3=3DFA?=3D" out=
-l2
+=09
+* FAIL 3: format-patch output (UTF-8)
+=09
+		git config i18n.logoutputencoding UTF-8 &&
+=09
+		git format-patch --stdout master..HEAD^ >out-u1 &&
+		git format-patch --stdout HEAD^ >out-u2 &&
+		grep "^Content-Type: text/plain; charset=3DUTF-8" out-u1 &&
+		grep "^From: =3D?UTF-8?q?=3DC3=3D81=3DC3=3DA9=3DC3=3DAD=3D20=3DC3=3D=
B3=3DC3=3DBA?=3D" out-u1 &&
+		grep "^Content-Type: text/plain; charset=3DUTF-8" out-u2 &&
+		grep "^From: =3D?UTF-8?q?=3DC3=3D81=3DC3=3DA9=3DC3=3DAD=3D20=3DC3=3D=
B3=3DC3=3DBA?=3D" out-u2
+=09
+* FAIL 4: rebase (U/U)
+=09
+		# We want the result of rebase in UTF-8
+		git config i18n.commitencoding UTF-8 &&
+=09
+		# The test is about logoutputencoding not affecting the
+		# final outcome -- it is used internally to generate the
+		# patch and the log.
+=09
+		git config i18n.logoutputencoding UTF-8 &&
+=09
+		# The result will be committed by GIT_COMMITTER_NAME --
+		# we want UTF-8 encoded name.
+		. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+		git checkout -b test &&
+		git rebase master &&
+=09
+		check_encoding 2
+=09
+* FAIL 5: rebase (U/L)
+=09
+		git config i18n.commitencoding UTF-8 &&
+		git config i18n.logoutputencoding ISO8859-1 &&
+		. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+=09
+		git reset --hard side &&
+		git rebase master &&
+=09
+		check_encoding 2
+=09
+* FAIL 6: rebase (L/L)
+=09
+		# In this test we want ISO-8859-1 encoded commits as the result
+		git config i18n.commitencoding ISO8859-1 &&
+		git config i18n.logoutputencoding ISO8859-1 &&
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+=09
+		git reset --hard side &&
+		git rebase master &&
+=09
+		check_encoding 2 8859
+=09
+* FAIL 7: rebase (L/U)
+=09
+		# This is pathological -- use UTF-8 as intermediate form
+		# to get ISO-8859-1 results.
+		git config i18n.commitencoding ISO8859-1 &&
+		git config i18n.logoutputencoding UTF-8 &&
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+=09
+		git reset --hard side &&
+		git rebase master &&
+=09
+		check_encoding 2 8859
+=09
+* FAIL 8: cherry-pick(U/U)
+=09
+		# Both the commitencoding and logoutputencoding is set to UTF-8.
+=09
+		git config i18n.commitencoding UTF-8 &&
+		git config i18n.logoutputencoding UTF-8 &&
+		. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+=09
+		git reset --hard master &&
+		git cherry-pick side^ &&
+		git cherry-pick side &&
+		git revert HEAD &&
+=09
+		check_encoding 3
+=09
+* FAIL 9: cherry-pick(L/L)
+=09
+		# Both the commitencoding and logoutputencoding is set to ISO-8859-1
+=09
+		git config i18n.commitencoding ISO8859-1 &&
+		git config i18n.logoutputencoding ISO8859-1 &&
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+=09
+		git reset --hard master &&
+		git cherry-pick side^ &&
+		git cherry-pick side &&
+		git revert HEAD &&
+=09
+		check_encoding 3 8859
+=09
+* FAIL 10: cherry-pick(U/L)
+=09
+		# Commitencoding is set to UTF-8 but logoutputencoding is ISO-8859-1
+=09
+		git config i18n.commitencoding UTF-8 &&
+		git config i18n.logoutputencoding ISO8859-1 &&
+		. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+=09
+		git reset --hard master &&
+		git cherry-pick side^ &&
+		git cherry-pick side &&
+		git revert HEAD &&
+=09
+		check_encoding 3
+=09
+* FAIL 11: cherry-pick(L/U)
+=09
+		# Again, the commitencoding is set to ISO-8859-1 but
+		# logoutputencoding is set to UTF-8.
+=09
+		git config i18n.commitencoding ISO8859-1 &&
+		git config i18n.logoutputencoding UTF-8 &&
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+=09
+		git reset --hard master &&
+		git cherry-pick side^ &&
+		git cherry-pick side &&
+		git revert HEAD &&
+=09
+		check_encoding 3 8859
+=09
+* FAIL 12: rebase --merge (U/U)
+=09
+		git config i18n.commitencoding UTF-8 &&
+		git config i18n.logoutputencoding UTF-8 &&
+		. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+=09
+		git reset --hard side &&
+		git rebase --merge master &&
+=09
+		check_encoding 2
+=09
+* FAIL 13: rebase --merge (U/L)
+=09
+		git config i18n.commitencoding UTF-8 &&
+		git config i18n.logoutputencoding ISO8859-1 &&
+		. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+=09
+		git reset --hard side &&
+		git rebase --merge master &&
+=09
+		check_encoding 2
+=09
+* FAIL 14: rebase --merge (L/L)
+=09
+		# In this test we want ISO-8859-1 encoded commits as the result
+		git config i18n.commitencoding ISO8859-1 &&
+		git config i18n.logoutputencoding ISO8859-1 &&
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+=09
+		git reset --hard side &&
+		git rebase --merge master &&
+=09
+		check_encoding 2 8859
+=09
+* FAIL 15: rebase --merge (L/U)
+=09
+		# This is pathological -- use UTF-8 as intermediate form
+		# to get ISO-8859-1 results.
+		git config i18n.commitencoding ISO8859-1 &&
+		git config i18n.logoutputencoding UTF-8 &&
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+=09
+		git reset --hard side &&
+		git rebase --merge master &&
+=09
+		check_encoding 2 8859
+=09
+* failed 14 among 15 test(s)
 *** t3902-quoted.sh ***
 *   ok 1: setup
 *   ok 2: check fully quoted output from ls-files
@@ -3204,11 +3386,44 @@
 *   ok 1: setup
 *   ok 2: apply in forward
 *   ok 3: apply in reverse
-*   ok 4: setup separate repository lacking postimage
-*   ok 5: apply in forward without postimage
-*   ok 6: apply in reverse without postimage
+* FAIL 4: setup separate repository lacking postimage
+=09
+=09
+		git tar-tree initial initial | $TAR xf - &&
+		(
+			cd initial && git init && git add .
+		) &&
+=09
+		git tar-tree second second | $TAR xf - &&
+		(
+			cd second && git init && git add .
+		)
+=09
+=09
+* FAIL 5: apply in forward without postimage
+=09
+=09
+		T0=3D`git rev-parse "second^{tree}"` &&
+		(
+			cd initial &&
+			git apply --index --binary ../patch &&
+			T1=3D`git write-tree` &&
+			test "$T0" =3D "$T1"
+		)
+=09
+* FAIL 6: apply in reverse without postimage
+=09
+=09
+		T0=3D`git rev-parse "initial^{tree}"` &&
+		(
+			cd second &&
+			git apply --index --binary --reverse ../patch &&
+			T1=3D`git write-tree` &&
+			test "$T0" =3D "$T1"
+		)
+=09
 *   ok 7: reversing a whitespace introduction
-* passed all 7 test(s)
+* failed 3 among 7 test(s)
 *** t4117-apply-reject.sh ***
 *   ok 1: setup
 *   ok 2: apply without --reject should fail
@@ -3435,8 +3650,20 @@
 *** t4201-shortlog.sh ***
 *   ok 1: shortlog wrapping
 *   ok 2: shortlog from non-git directory
-*   ok 3: shortlog encoding
-* passed all 3 test(s)
+* FAIL 3: shortlog encoding
+=09
+		git reset --hard "$commit" &&
+		git config --unset i18n.commitencoding &&
+		echo 2 > a1 &&
+		git commit --quiet -m "$MSG1" --author=3D"$DSCHOE" a1 &&
+		git config i18n.commitencoding "ISO8859-1" &&
+		echo 3 > a1 &&
+		git commit --quiet -m "$(iconvfromutf8toiso88591 "$MSG2")" \
+			--author=3D"$(iconvfromutf8toiso88591 "$DSCHOE")" a1 &&
+		git config --unset i18n.commitencoding &&
+		git shortlog HEAD~2.. > out &&
+	test_cmp expect out
+* failed 1 among 3 test(s)
 *** t4202-log.sh ***
 *   ok 1: setup
 *   ok 2: pretty
@@ -3515,20 +3742,45 @@
 *   ok 10: git archive vs. the same in a bare repo
 *   ok 11: git archive with --output
 *   ok 12: git archive --remote
-*   ok 13: validate file modification time
+* FAIL 13: validate file modification time
+	mkdir extract &&
+	     "$TAR" xf b.tar -C extract a/a &&
+	     test-chmtime -v +0 extract/a/a |cut -f 1 >b.mtime &&
+	     echo "1117231200" >expected.mtime &&
+	     test_cmp expected.mtime b.mtime
 *   ok 14: git get-tar-commit-id
-*   ok 15: extract tar archive
-*   ok 16: validate filenames
-*   ok 17: validate file contents
+* FAIL 15: extract tar archive
+	(cd b && "$TAR" xf -) <b.tar
+* FAIL 16: validate filenames
+	(cd b/a && find .) | sort >b.lst &&
+	     test_cmp a.lst b.lst
+* FAIL 17: validate file contents
+	diff -r a b/a
 *   ok 18: git tar-tree with prefix
-*   ok 19: extract tar archive with prefix
-*   ok 20: validate filenames with prefix
-*   ok 21: validate file contents with prefix
+* FAIL 19: extract tar archive with prefix
+	(cd c && "$TAR" xf -) <c.tar
+* FAIL 20: validate filenames with prefix
+	(cd c/prefix/a && find .) | sort >c.lst &&
+	     test_cmp a.lst c.lst
+* FAIL 21: validate file contents with prefix
+	diff -r a c/prefix/a
 *   ok 22: create archives with substfiles
-*   ok 23: extract substfiles
-*   ok 24: validate substfile contents
-*   ok 25: extract substfiles from archive with prefix
-*   ok 26: validate substfile contents from archive with prefix
+* FAIL 23: extract substfiles
+	(mkdir f && cd f && "$TAR" xf -) <f.tar
+* FAIL 24: validate substfile contents
+	git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEAD \
+	      >f/a/substfile1.expected &&
+	      test_cmp f/a/substfile1.expected f/a/substfile1 &&
+	      test_cmp a/substfile2 f/a/substfile2
+=09
+* FAIL 25: extract substfiles from archive with prefix
+	(mkdir g && cd g && "$TAR" xf -) <g.tar
+* FAIL 26: validate substfile contents from archive with prefix
+	git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEAD \
+	      >g/prefix/a/substfile1.expected &&
+	      test_cmp g/prefix/a/substfile1.expected g/prefix/a/substfile1 &=
&
+	      test_cmp a/substfile2 g/prefix/a/substfile2
+=09
 *   ok 27: git archive --format=3Dzip
 *   ok 28: git archive --format=3Dzip in a bare repo
 *   ok 29: git archive --format=3Dzip vs. the same in a bare repo
@@ -3543,61 +3795,215 @@
 *   ok 38: validate filenames with prefix
 *   ok 39: validate file contents with prefix
 *   ok 40: git archive --list outside of a git repo
-*   ok 41: git-archive --prefix=3Dolde-
-* passed all 41 test(s)
+* FAIL 41: git-archive --prefix=3Dolde-
+=09
+		git archive --prefix=3Dolde- >h.tar HEAD &&
+		(
+			mkdir h &&
+			cd h &&
+			"$TAR" xf - <../h.tar
+		) &&
+		test -d h/olde-a &&
+		test -d h/olde-a/bin &&
+		test -f h/olde-a/bin/sh
+=09
+* failed 12 among 41 test(s)
 *** t5001-archive-attr.sh ***
 *   ok 1: setup
-*   ok 2: git archive
+* FAIL 2: git archive
+=09
+		git archive HEAD >archive.tar &&
+		(mkdir archive && cd archive && "$TAR" xf -) <archive.tar
+=09
 *   ok 3:  archive/ignored does not exist
 *   ok 4:  archive/ignored-by-tree does not exist
-*   ok 5:  archive/ignored-by-worktree exists
-*   ok 6: git archive with worktree attributes
+* FAIL 5:  archive/ignored-by-worktree exists
+	test -e archive/ignored-by-worktree
+* FAIL 6: git archive with worktree attributes
+=09
+		git archive --worktree-attributes HEAD >worktree.tar &&
+		(mkdir worktree && cd worktree && "$TAR" xf -) <worktree.tar
+=09
 *   ok 7:  worktree/ignored does not exist
-*   ok 8:  worktree/ignored-by-tree exists
+* FAIL 8:  worktree/ignored-by-tree exists
+	test -e worktree/ignored-by-tree
 *   ok 9:  worktree/ignored-by-worktree does not exist
 *   ok 10: git archive vs. bare
-*   ok 11: git archive with worktree attributes, bare
+* FAIL 11: git archive with worktree attributes, bare
+=09
+		(cd bare && git archive --worktree-attributes HEAD) >bare-worktree.t=
ar &&
+		(mkdir bare-worktree && cd bare-worktree && "$TAR" xf -) <bare-workt=
ree.tar
+=09
 *   ok 12:  bare-worktree/ignored does not exist
-*   ok 13:  bare-worktree/ignored-by-tree exists
-*   ok 14:  bare-worktree/ignored-by-worktree exists
-*   ok 15: export-subst
+* FAIL 13:  bare-worktree/ignored-by-tree exists
+	test -e bare-worktree/ignored-by-tree
+* FAIL 14:  bare-worktree/ignored-by-worktree exists
+	test -e bare-worktree/ignored-by-worktree
+* FAIL 15: export-subst
+=09
+		git log "--pretty=3Dformat:A${SUBSTFORMAT}O" HEAD >substfile1.expect=
ed &&
+		test_cmp nosubstfile archive/nosubstfile &&
+		test_cmp substfile1.expected archive/substfile1 &&
+		test_cmp substfile2 archive/substfile2
+=09
 *   ok 16: git tar-tree vs. git archive with worktree attributes
 *   ok 17: git tar-tree vs. git archive with worktree attrs, bare
-* passed all 17 test(s)
+* failed 8 among 17 test(s)
 *** t5100-mailinfo.sh ***
 *   ok 1: split sample box
 *   ok 2: mailinfo 0001
 *   ok 3: mailinfo 0002
 *   ok 4: mailinfo 0003
 *   ok 5: mailinfo 0004
-*   ok 6: mailinfo 0005
+* FAIL 6: mailinfo 0005
+=09
+			check_mailinfo $mail "" &&
+			if test -f "$TEST_DIRECTORY"/t5100/msg$mail--scissors
+			then
+				check_mailinfo $mail --scissors
+			fi &&
+			if test -f "$TEST_DIRECTORY"/t5100/msg$mail--no-inbody-headers
+			then
+				check_mailinfo $mail --no-inbody-headers
+			fi
+	=09
 *   ok 7: mailinfo 0006
 *   ok 8: mailinfo 0007
 *   ok 9: mailinfo 0008
 *   ok 10: mailinfo 0009
 *   ok 11: mailinfo 0010
-*   ok 12: mailinfo 0011
+* FAIL 12: mailinfo 0011
+=09
+			check_mailinfo $mail "" &&
+			if test -f "$TEST_DIRECTORY"/t5100/msg$mail--scissors
+			then
+				check_mailinfo $mail --scissors
+			fi &&
+			if test -f "$TEST_DIRECTORY"/t5100/msg$mail--no-inbody-headers
+			then
+				check_mailinfo $mail --no-inbody-headers
+			fi
+	=09
 *   ok 13: mailinfo 0012
 *   ok 14: mailinfo 0013
 *   ok 15: mailinfo 0014
 *   ok 16: mailinfo 0015
 *   ok 17: mailinfo 0016
 *   ok 18: split box with rfc2047 samples
-*   ok 19: mailinfo rfc2047/0001
-*   ok 20: mailinfo rfc2047/0002
-*   ok 21: mailinfo rfc2047/0003
-*   ok 22: mailinfo rfc2047/0004
-*   ok 23: mailinfo rfc2047/0005
-*   ok 24: mailinfo rfc2047/0006
-*   ok 25: mailinfo rfc2047/0007
-*   ok 26: mailinfo rfc2047/0008
-*   ok 27: mailinfo rfc2047/0009
-*   ok 28: mailinfo rfc2047/0010
-*   ok 29: mailinfo rfc2047/0011
+* FAIL 19: mailinfo rfc2047/0001
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 20: mailinfo rfc2047/0002
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 21: mailinfo rfc2047/0003
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 22: mailinfo rfc2047/0004
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 23: mailinfo rfc2047/0005
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 24: mailinfo rfc2047/0006
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 25: mailinfo rfc2047/0007
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 26: mailinfo rfc2047/0008
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 27: mailinfo rfc2047/0009
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 28: mailinfo rfc2047/0010
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
+* FAIL 29: mailinfo rfc2047/0011
+=09
+			git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
+			echo msg &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
+			echo patch &&
+			test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-patch &&
+			echo info &&
+			test_cmp "$TEST_DIRECTORY"/t5100/rfc2047-info-$(basename $mail) $ma=
il-info
+	=09
 *   ok 30: respect NULs
 *   ok 31: Preserve NULs out of MIME encoded message
 *   ok 32: mailinfo on from header without name works
-* passed all 32 test(s)
+* failed 13 among 32 test(s)
 *** t5300-pack-object.sh ***
 *   ok 1: setup
 *   ok 2: pack without delta
@@ -3691,8 +4097,14 @@
 *   ok 21: ... but having a loose copy allows for full recovery
 *   ok 22: ... and then a repack "clears" the corruption
 *   ok 23: ... and a redundant pack allows for full recovery too
-*   ok 24: corrupting header to have too small output buffer fails unp=
ack
-* passed all 24 test(s)
+* FAIL 24: corrupting header to have too small output buffer fails unp=
ack
+	create_new_pack &&
+	     git prune-packed &&
+	     printf "\262=01" | do_corrupt_object $blob_1 0 &&
+	     test_must_fail git cat-file blob $blob_1 > /dev/null &&
+	     test_must_fail git cat-file blob $blob_2 > /dev/null &&
+	     test_must_fail git cat-file blob $blob_3 > /dev/null
+* failed 1 among 24 test(s)
 *** t5304-prune.sh ***
 *   ok 1: setup
 *   ok 2: prune stale packs
@@ -3932,22 +4344,20 @@
 *   ok 14: unbundle 2
 *   ok 15: bundle does not prerequisite objects
 *   ok 16: bundle should be able to create a full history
-*   ok 17: fetch via rsync
-*   ok 18: push via rsync
-*   ok 19: push via rsync
-*   ok 20: fetch with a non-applying branch.<name>.merge
-*   ok 21: quoting of a strangely named repo
-*   ok 22: bundle should record HEAD correctly
-*   ok 23: explicit fetch should not update tracking
-*   ok 24: explicit pull should not update tracking
-*   ok 25: configured fetch updates tracking
-*   ok 26: pushing nonexistent branch by mistake should not segv
-*   ok 27: auto tag following fetches minimum
-*   ok 28: refuse to fetch into the current branch
-*   ok 29: fetch into the current branch with --update-head-ok
-*   ok 30: fetch --dry-run
-*   ok 31: should be able to fetch with duplicate refspecs
-* passed all 31 test(s)
+* Skipping rsync tests because rsync was not found
+*   ok 17: fetch with a non-applying branch.<name>.merge
+*   ok 18: quoting of a strangely named repo
+*   ok 19: bundle should record HEAD correctly
+*   ok 20: explicit fetch should not update tracking
+*   ok 21: explicit pull should not update tracking
+*   ok 22: configured fetch updates tracking
+*   ok 23: pushing nonexistent branch by mistake should not segv
+*   ok 24: auto tag following fetches minimum
+*   ok 25: refuse to fetch into the current branch
+*   ok 26: fetch into the current branch with --update-head-ok
+*   ok 27: fetch --dry-run
+*   ok 28: should be able to fetch with duplicate refspecs
+* passed all 28 test(s)
 *** t5511-refspec.sh ***
 *   ok 1: push  (invalid)
 *   ok 2: push :
@@ -5191,40 +5601,41 @@
 *   ok 51: listing the one-line message of a non-signed tag should suc=
ceed
 *   ok 52: listing the zero-lines message of a non-signed tag should s=
ucceed
 *   ok 53: listing many message lines of a non-signed tag should succe=
ed
-*   ok 54: trying to verify an annotated non-signed tag should fail
-*   ok 55: trying to verify a file-annotated non-signed tag should fai=
l
-*   ok 56: trying to verify two annotated non-signed tags should fail
-*   ok 57: creating a signed tag with -m message should succeed
-*   ok 58: sign with a given key id
-*   ok 59: sign with an unknown id (1)
-*   ok 60: sign with an unknown id (2)
-*   ok 61: -u implies signed tag
-*   ok 62: creating a signed tag with -F messagefile should succeed
-*   ok 63: creating a signed tag with -F - should succeed
-*   ok 64: -s implies annotated tag
-*   ok 65: trying to create a signed tag with non-existing -F file sho=
uld fail
-*   ok 66: verifying a signed tag should succeed
-*   ok 67: verifying two signed tags in one command should succeed
-*   ok 68: verifying many signed and non-signed tags should fail
-*   ok 69: verifying a forged tag should fail
-*   ok 70: creating a signed tag with an empty -m message should succe=
ed
-*   ok 71: creating a signed tag with an empty -F messagefile should s=
ucceed
-*   ok 72: extra blanks in the message for a signed tag should be remo=
ved
-*   ok 73: creating a signed tag with a blank -m message should succee=
d
-*   ok 74: creating a signed tag with blank -F file with spaces should=
 succeed
-*   ok 75: creating a signed tag with spaces and no newline should suc=
ceed
-*   ok 76: creating a signed tag with a -F file with #comments should =
succeed
-*   ok 77: creating a signed tag with #commented -m message should suc=
ceed
-*   ok 78: creating a signed tag with #commented -F messagefile should=
 succeed
-*   ok 79: creating a signed tag with a #comment and no newline should=
 succeed
-*   ok 80: listing the one-line message of a signed tag should succeed
-*   ok 81: listing the zero-lines message of a signed tag should succe=
ed
-*   ok 82: listing many message lines of a signed tag should succeed
-*   ok 83: creating a signed tag pointing to a tree should succeed
-*   ok 84: creating a signed tag pointing to a blob should succeed
-*   ok 85: creating a signed tag pointing to another tag should succee=
d
-*   ok 86: git tag -s fails if gpg is misconfigured
-*   ok 87: verify signed tag fails when public key is not present
+* gpg not found - skipping tag signing and verification tests
+* skip 54: trying to verify an annotated non-signed tag should fail
+* skip 55: trying to verify a file-annotated non-signed tag should fai=
l
+* skip 56: trying to verify two annotated non-signed tags should fail
+* skip 57: creating a signed tag with -m message should succeed
+* skip 58: sign with a given key id
+* skip 59: sign with an unknown id (1)
+* skip 60: sign with an unknown id (2)
+* skip 61: -u implies signed tag
+* skip 62: creating a signed tag with -F messagefile should succeed
+* skip 63: creating a signed tag with -F - should succeed
+* skip 64: -s implies annotated tag
+* skip 65: trying to create a signed tag with non-existing -F file sho=
uld fail
+* skip 66: verifying a signed tag should succeed
+* skip 67: verifying two signed tags in one command should succeed
+* skip 68: verifying many signed and non-signed tags should fail
+* skip 69: verifying a forged tag should fail
+* skip 70: creating a signed tag with an empty -m message should succe=
ed
+* skip 71: creating a signed tag with an empty -F messagefile should s=
ucceed
+* skip 72: extra blanks in the message for a signed tag should be remo=
ved
+* skip 73: creating a signed tag with a blank -m message should succee=
d
+* skip 74: creating a signed tag with blank -F file with spaces should=
 succeed
+* skip 75: creating a signed tag with spaces and no newline should suc=
ceed
+* skip 76: creating a signed tag with a -F file with #comments should =
succeed
+* skip 77: creating a signed tag with #commented -m message should suc=
ceed
+* skip 78: creating a signed tag with #commented -F messagefile should=
 succeed
+* skip 79: creating a signed tag with a #comment and no newline should=
 succeed
+* skip 80: listing the one-line message of a signed tag should succeed
+* skip 81: listing the zero-lines message of a signed tag should succe=
ed
+* skip 82: listing many message lines of a signed tag should succeed
+* skip 83: creating a signed tag pointing to a tree should succeed
+* skip 84: creating a signed tag pointing to a blob should succeed
+* skip 85: creating a signed tag pointing to another tag should succee=
d
+* skip 86: git tag -s fails if gpg is misconfigured
+* skip 87: verify signed tag fails when public key is not present
 *   ok 88: git tag -a fails if tag annotation is empty
 *   ok 89: message in editor has initial comment
 *   ok 90: overwriting an annoted tag should use its previous body
@@ -6176,160 +6587,160 @@
 *   ok 64: --no-bcc overrides sendemail.bcc
 * passed all 64 test(s)
 *** t9100-git-svn-basic.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9101-git-svn-props.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9102-git-svn-deep-rmdir.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9103-git-svn-tracked-directory-removed.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9104-git-svn-follow-parent.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9105-git-svn-commit-diff.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9106-git-svn-commit-diff-clobber.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9107-git-svn-migrate.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9108-git-svn-glob.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9109-git-svn-multi-glob.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9110-git-svn-use-svm-props.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9111-git-svn-use-svnsync-props.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9112-git-svn-md5less-file.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9113-git-svn-dcommit-new-file.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9114-git-svn-dcommit-merge.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9115-git-svn-dcommit-funky-renames.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9116-git-svn-log.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9117-git-svn-init-clone.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9118-git-svn-funky-branch-names.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9119-git-svn-info.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9120-git-svn-clone-with-percent-escapes.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9121-git-svn-fetch-renamed-dir.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9122-git-svn-author.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9123-git-svn-rebuild-with-rewriteroot.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9124-git-svn-dcommit-auto-props.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9125-git-svn-multi-glob-branch-names.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9126-git-svn-follow-deleted-readded-directory.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9127-git-svn-partial-rebuild.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9128-git-svn-cmd-branch.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9129-git-svn-i18n-commitencoding.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9130-git-svn-authors-file.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9131-git-svn-empty-symlink.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9132-git-svn-broken-symlink.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9133-git-svn-nested-git-repo.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9134-git-svn-ignore-paths.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9135-git-svn-moved-branch-empty-file.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9136-git-svn-recreated-branch-empty-file.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9137-git-svn-dcommit-clobber-series.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9138-git-svn-authors-prog.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9139-git-svn-non-utf8-commitencoding.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9140-git-svn-reset.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9141-git-svn-multiple-branches.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9142-git-svn-shallow-clone.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9143-git-svn-gc.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9144-git-svn-old-rev_map.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9145-git-svn-master-branch.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9146-git-svn-empty-dirs.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9150-svk-mergetickets.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9151-svn-mergeinfo.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9152-svn-empty-dirs-after-gc.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9153-git-svn-rewrite-uuid.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9154-git-svn-fancy-glob.sh ***
-* Perl SVN libraries not found or unusable, skipping test
+* skipping git svn tests, svn not found
 * passed all 0 test(s)
 *** t9200-git-cvsexportcommit.sh ***
 *   ok 1: New file
@@ -6473,7 +6884,22 @@
 *   ok 1: setup
 *   ok 2: fast-export | fast-import
 *   ok 3: fast-export master~2..master
-*   ok 4: iso-8859-1
+* FAIL 4: iso-8859-1
+=09
+=09
+		git config i18n.commitencoding ISO8859-1 &&
+		# use author and committer name in ISO-8859-1 to match it.
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+		test_tick &&
+		echo rosten >file &&
+		git commit -s -m den file &&
+		git fast-export wer^..wer |
+			sed "s/wer/i18n/" |
+			(cd new &&
+			 git fast-import &&
+			 git cat-file commit i18n | grep "=C3=81=C3=A9=C3=AD =C3=B3=C3=BA")
+=09
+=09
 *   ok 5: import/export-marks
 *   ok 6: set up faked signed tag
 *   ok 7: signed-tags=3Dabort
@@ -6495,232 +6921,37 @@
 *   ok 23: tag-obj_tag
 *   ok 24: tag-obj_tag-obj
 * still have 1 known breakage(s)
-* passed all remaining 23 test(s)
+* failed 1 among remaining 23 test(s)
 *** t9400-git-cvsserver-server.sh ***
-*   ok 1: setup
-*   ok 2: basic checkout
-*   ok 3: pserver authentication
-*   ok 4: pserver authentication failure (non-anonymous user)
-*   ok 5: pserver authentication (login)
-*   ok 6: pserver authentication failure (login/non-anonymous user)
-*   ok 7: req_Root failure (relative pathname)
-*   ok 8: req_Root failure (conflicting roots)
-*   ok 9: req_Root (strict paths)
-*   ok 10: req_Root failure (strict-paths)
-*   ok 11: req_Root (w/o strict-paths)
-*   ok 12: req_Root failure (w/o strict-paths)
-*   ok 13: req_Root (base-path)
-*   ok 14: req_Root failure (base-path)
-*   ok 15: req_Root (export-all)
-*   ok 16: req_Root failure (export-all w/o whitelist)
-*   ok 17: req_Root (everything together)
-*   ok 18: gitcvs.enabled =3D false
-*   ok 19: gitcvs.ext.enabled =3D true
-*   ok 20: gitcvs.ext.enabled =3D false
-*   ok 21: gitcvs.dbname
-*   ok 22: gitcvs.ext.dbname
-*   ok 23: cvs update (create new file)
-*   ok 24: cvs update (update existing file)
-*   still broken 25: cvs update w/o -d doesn't create subdir (TODO)
-*   ok 26: cvs update (subdirectories)
-*   ok 27: cvs update (delete file)
-*   ok 28: cvs update (re-add deleted file)
-*   ok 29: cvs update (merge)
-*   ok 30: cvs update (conflict merge)
-*   ok 31: cvs update (-C)
-*   ok 32: cvs update (merge no-op)
-*   ok 33: cvs update (-p)
-*   ok 34: cvs update (module list supports packed refs)
-*   ok 35: cvs status
-*   ok 36: cvs status (nonrecursive)
-*   ok 37: cvs status (no subdirs in header)
-*   ok 38: cvs co -c (shows module database)
-*   ok 39: cvs annotate
-* still have 1 known breakage(s)
-* passed all remaining 38 test(s)
+* skipping git-cvsserver tests, Perl SQLite interface unavailable
+* passed all 0 test(s)
 *** t9401-git-cvsserver-crlf.sh ***
-*   ok 1: setup
-*   ok 2: cvs co (default crlf)
-*   ok 3: cvs co (allbinary)
-*   ok 4: cvs co (use attributes/allbinary)
-*   ok 5: cvs co (use attributes)
-*   ok 6: adding files
-*   ok 7: updating
-*   ok 8: cvs co (use attributes/guess)
-*   ok 9: setup multi-line files
-*   ok 10: cvs co (guess)
-*   ok 11: cvs co another copy (guess)
-*   ok 12: add text (guess)
-*   ok 13: add bin (guess)
-*   ok 14: remove files (guess)
-*   ok 15: cvs ci (guess)
-*   ok 16: update subdir of other copy (guess)
-*   ok 17: update/merge full other copy (guess)
-* passed all 17 test(s)
+* skipping git-cvsserver tests, Perl SQLite interface unavailable
+* passed all 0 test(s)
 *** t9500-gitweb-standalone-no-errors.sh ***
-*   ok 1: no commits: projects_list (implicit)
-*   ok 2: no commits: projects_index
-*   ok 3: no commits: .git summary (implicit)
-*   ok 4: no commits: .git commit (implicit HEAD)
-*   ok 5: no commits: .git commitdiff (implicit HEAD)
-*   ok 6: no commits: .git tree (implicit HEAD)
-*   ok 7: no commits: .git heads
-*   ok 8: no commits: .git tags
-*   ok 9: Make initial commit
-*   ok 10: projects_list (implicit)
-*   ok 11: projects_index
-*   ok 12: .git summary (implicit)
-*   ok 13: .git commit (implicit HEAD)
-*   ok 14: .git commitdiff (implicit HEAD, root commit)
-*   ok 15: .git commitdiff_plain (implicit HEAD, root commit)
-*   ok 16: .git commit (HEAD)
-*   ok 17: .git tree (implicit HEAD)
-*   ok 18: .git blob (file)
-*   ok 19: .git blob_plain (file)
-*   ok 20: .git commit (non-existent)
-*   ok 21: .git commitdiff (non-existent)
-*   ok 22: .git commitdiff (non-existent vs HEAD)
-*   ok 23: .git tree (0000000000000000000000000000000000000000)
-*   ok 24: .git tag (0000000000000000000000000000000000000000)
-*   ok 25: .git blob (non-existent)
-*   ok 26: .git blob_plain (non-existent)
-*   ok 27: commitdiff(0): root
-*   ok 28: commitdiff(0): file added
-*   ok 29: commitdiff(0): mode change
-*   ok 30: commitdiff(0): file renamed
-*   ok 31: commitdiff(0): file to symlink
-*   ok 32: commitdiff(0): file deleted
-*   ok 33: commitdiff(0): file copied / new file
-*   ok 34: commitdiff(0): mode change and modified
-*   ok 35: commitdiff(0): renamed and modified
-*   ok 36: commitdiff(0): renamed, mode change and modified
-*   ok 37: setup typechange commits
-*   ok 38: commitdiff(2): file renamed from foo to foo/baz
-*   ok 39: commitdiff(2): file renamed from foo/baz to foo
-*   ok 40: commitdiff(2): directory becomes file
-*   ok 41: commitdiff(2): file becomes directory
-*   ok 42: commitdiff(2): file becomes symlink
-*   ok 43: commitdiff(2): symlink becomes file
-*   ok 44: commitdiff(2): symlink becomes directory
-*   ok 45: commitdiff(2): directory becomes symlink
-*   ok 46: Create a merge
-*   ok 47: commit(0): merge commit
-*   ok 48: commitdiff(0): merge commit
-*   ok 49: Prepare large commit
-*   ok 50: commit(1): large commit
-*   ok 51: commitdiff(1): large commit
-*   ok 52: tags: list of different types of tags
-*   ok 53: tag: Tag to commit object
-*   ok 54: tag: on lightweight tag (invalid)
-*   ok 55: logs: log (implicit HEAD)
-*   ok 56: logs: shortlog (implicit HEAD)
-*   ok 57: logs: history (implicit HEAD, file)
-*   ok 58: logs: history (implicit HEAD, non-existent file)
-*   ok 59: logs: history (implicit HEAD, deleted file)
-*   ok 60: path_info: project
-*   ok 61: path_info: project/branch
-*   ok 62: path_info: project/branch:file
-*   ok 63: path_info: project/branch:dir/
-*   ok 64: path_info: project/branch:file (non-existent)
-*   ok 65: path_info: project/branch:dir/ (non-existent)
-*   ok 66: path_info: project/branch:/file
-*   ok 67: path_info: project/:/file (implicit HEAD)
-*   ok 68: path_info: project/:/ (implicit HEAD, top tree)
-*   ok 69: feeds: OPML
-*   ok 70: feed: RSS
-*   ok 71: feed: Atom
-*   ok 72: encode(commit): utf8
-*   ok 73: encode(commit): iso-8859-1
-*   ok 74: encode(log): utf-8 and iso-8859-1
-*   ok 75: opt: log --no-merges
-*   ok 76: opt: atom --no-merges
-*   ok 77: opt: "file" history --no-merges
-*   ok 78: opt: log --no-such-option (invalid option)
-*   ok 79: opt: tree --no-merges (invalid option for action)
-*   ok 80: URL: no project URLs, no base URL
-*   ok 81: URL: project URLs via gitweb.url
-*   ok 82: URL: project URLs via cloneurl file
-*   ok 83: config override: projects list (implicit)
-*   ok 84: config override: tree view, features not overridden in repo=
 config
-*   ok 85: config override: tree view, features disabled in repo confi=
g
-*   ok 86: config override: tree view, features enabled in repo config=
 (1)
-*   ok 87: config override: tree view, features enabled in repo config=
 (2)
-*   ok 88: README.html with non-ASCII characters (utf-8)
-* passed all 88 test(s)
+* skipping gitweb tests, perl version is too old
+* passed all 0 test(s)
 *** t9501-gitweb-standalone-http-status.sh ***
-*   ok 1: setup
-*   ok 2: snapshots: tgz only default format enabled
-*   ok 3: snapshots: all enabled in default, use default disabled valu=
e
-*   ok 4: snapshots: zip explicitly disabled
-*   ok 5: snapshots: tgz explicitly enabled
-*   ok 6: snapshots: good tree-ish id
-*   ok 7: snapshots: bad tree-ish id
-*   ok 8: snapshots: bad tree-ish id (tagged object)
-*   ok 9: snapshots: good object id
-*   ok 10: snapshots: bad object id
-*   ok 11: load checking: load too high (default action)
-* passed all 11 test(s)
+* skipping gitweb tests, perl version is too old
+* passed all 0 test(s)
 *** t9502-gitweb-standalone-parse-output.sh ***
-*   ok 1: setup
-*   ok 2: snapshot: full sha1
-*   ok 3: snapshot: shortened sha1
-*   ok 4: snapshot: almost full sha1
-*   ok 5: snapshot: HEAD
-*   ok 6: snapshot: short branch name (master)
-*   ok 7: snapshot: short tag name (first)
-*   ok 8: snapshot: full branch name (refs/heads/master)
-*   ok 9: snapshot: full tag name (refs/tags/first)
-*   ok 10: snapshot: hierarchical branch name (xx/test)
-* passed all 10 test(s)
+* skipping gitweb tests, perl version is too old
+* passed all 0 test(s)
 *** t9600-cvsimport.sh ***
-*   ok 1: setup cvsroot
-*   ok 2: setup a cvs module
-*   ok 3: import a trivial module
-*   ok 4: pack refs
-*   ok 5: initial import has correct .git/cvs-revisions
-*   ok 6: update cvs module
-*   ok 7: update git module
-*   ok 8: update has correct .git/cvs-revisions
-*   ok 9: update cvs module
-*   ok 10: cvsimport.module config works
-*   ok 11: second update has correct .git/cvs-revisions
-*   ok 12: import from a CVS working tree
-*   ok 13: no .git/cvs-revisions created by default
-*   ok 14: test entire HEAD
-* passed all 14 test(s)
+* skipping cvsimport tests, cvsps not found
+* passed all 0 test(s)
 *** t9601-cvsimport-vendor-branch.sh ***
-*   ok 1: import a module with a vendor branch
-*   ok 2: check HEAD out of cvs repository
-*   ok 3: check master out of git repository
-*   ok 4: check a file that was imported once
-*   still broken 5: check a file that was imported twice
-*   ok 6: check a file that was imported then modified on HEAD
-*   ok 7: check a file that was imported, modified, then imported agai=
n
-*   ok 8: check a file that was added to HEAD then imported
-*   ok 9: a vendor branch whose tag has been removed
-* still have 1 known breakage(s)
-* passed all remaining 8 test(s)
+* skipping cvsimport tests, cvsps not found
+* passed all 0 test(s)
 *** t9602-cvsimport-branches-tags.sh ***
-*   ok 1: import module
-*   ok 2: test branch master
-*   ok 3: test branch vendorbranch
-*   still broken 4: test branch B_FROM_INITIALS
-*   still broken 5: test branch B_FROM_INITIALS_BUT_ONE
-*   still broken 6: test branch B_MIXED
-*   ok 7: test branch B_SPLIT
-*   still broken 8: test tag vendortag
-*   ok 9: test tag T_ALL_INITIAL_FILES
-*   still broken 10: test tag T_ALL_INITIAL_FILES_BUT_ONE
-*   still broken 11: test tag T_MIXED
-* still have 6 known breakage(s)
-* passed all remaining 5 test(s)
+* skipping cvsimport tests, cvsps not found
+* passed all 0 test(s)
 *** t9603-cvsimport-patchsets.sh ***
-*   still broken 1: import with criss cross times on revisions
-* still have 1 known breakage(s)
-* passed all remaining 0 test(s)
+* skipping cvsimport tests, cvsps not found
+* passed all 0 test(s)
 *** t9700-perl-git.sh ***
 *   ok 1: set up test repository
-*  run 2: Perl API (/usr/bin/perl /home/tor/git/git/t/t9700/test.pl)
+*  run 2: Perl API (/usr/bin/perl /db02/people/tor/git/git/t/t9700/tes=
t.pl)
 ok 1 - use Git;
 ok 2 - open repository
 ok 3 - config scalar: string
@@ -6765,20 +6996,5 @@
 *   ok 2: Perl API
 *   ok 2: no stderr: Perl API
 * passed all 2 test(s)
-make aggregate-results
[...]
