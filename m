Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677C1CAA1
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832177; cv=none; b=EMuZH9H3qpfH/Imkuuijzs6s4b+kFUvBH+UQZFTLLo1Kr3kQLZqMf5CyMkOMPrCPrBrM1TcfyzitfIMDDCY7AjqFJRAzgIa+UAe+/BqQqqceRAUsGcjIdIKuO8vIB11axhtE29zr0QNYWKx2xmBS111t3lwMxBEf0TLAzW8NutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832177; c=relaxed/simple;
	bh=Qvkvg5sJbg20pgDTAHKPVX92ONZIJWsYBC65U6W4yN8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DqTdbirXW5DBpagptFevSo42EsmedlNWXu/q7PHQIXOADzr4cxb0657wQ2C5EpU//cIGxiMY9Rjdpo2LwJ7emcDzzoqY6QKTwzZLOrJURA1+Ha9yiG9stx9G6OlwostVGyYOq3KDgkcrvn5Sr0VbYecYWkk1MThP2HUvq/0QrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dBVwLw8w; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dBVwLw8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832163; x=1722436963; i=l.s.r@web.de;
	bh=SoMSiylfJhOCbTExPL4tJ3axdlawxbxTrlkFT9V5FU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dBVwLw8wzUbetU9gpqZXp5P492OOMwx6FO5jRv8uUiuKymGieQUq1YN0yo9cYUSS
	 aHgz4zy7m7GyY+ivG6QT7/B1hjl98TyR7vBo3+RyB1hJhv99nM+zMbRn9HIfGxVZw
	 7CJpzvxt8t9cDHjYh5pGWdMZSQ1KL6RzucZJpaXcoiDK7WJo1eOXht8hKixw5bGt8
	 OOUOW+Kd1oHd7k72RDEohquusY8DpKsGf8eDxOxpnIbJxUv1pPrOH24npaIRrMqlZ
	 C0r6LPF1YaCF2p5W02Np4e8mVK75bTuVo5yQRmFseeb5ZCCeAMx5MHeJBOWbEPIKJ
	 zFJNbF8YI3OIzyKZpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoecP-1rv7ec1GET-00cW3E; Wed, 24
 Jul 2024 16:42:43 +0200
Message-ID: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Date: Wed, 24 Jul 2024 16:42:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/7] add and use for_test to simplify tests
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XuABPfRfdvLGonnT+7R62xqqf96Hhkn21fA7dOPhk+BqHKTIWuK
 JY8NzDU8WZ2Em/NJ0zFIJbUll//ABXYyWUdhWEP2xXiI4aCoTT8xtsbnQiAm8d5x4L/URtA
 vJdB3fV0uPf8htkKB5M2SF2HeTgmTc3XoIPB6mNkSmOAuY0xFRL8nqXXbdGeQEXak5fWnfg
 EBgcc62w7S1iKkAZ5i7Nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cc0HE62yMn0=;vQZWe/kSNDWEnun6bFrEjNRIuG9
 sXTr0hFlmWciNgJqJEFJ0L9RCqu1WYiwW3/AHfsMo2PIuEr/BisgUSDEIn4O/K9yzWDtkuoxn
 MXVukr12Ly2/P1yHivRiWDZ+sgyHWnq5cnDIzgC5Pn6ImcR3XQSzwLIJRsHz+1cL/j8cOExjc
 OpkoAdWek4rLGVZ/oUhteP7f+5Epx2znbdpnwoowsQzhifUVdbFR4/WAr/fR4TVRjosu4nE2a
 y6ty3wc8VcbmdqAQcjcfpwYrvLpQP+u3PT7NDytTLMy0Ao/LzJyrUgcG7L+ODejGFGWNuEQVY
 kpRik7SWkijm2dibuXg6LYtvW8kbVEslsXfUC/IPhkyjUtfjWf65X060fIxa2Nhdtpd5Iev+v
 YjQr7HgokkIYwHHe2o0HO5Hok6eEO6825jZwyfr1duttKNSbPPbbOvQCwgenduvRD+Tv96P35
 ssjvotQyRSzyYr3iIRc/OXrmBJtURP6AU0n6lCn79vzigaAwwrP8fDb68K6G4n0DY9FkfOwHI
 jaTCXrQy0CvWefjFk20hKN9yIwJx9j3GmYMy+ywwxxSGOYlUc+XYlsLiwyyhLs3kUE788UIeW
 Z/wUsUWXvfO4cX5gjwVi0e4RIM3FxpFbWuxUk5YAHY3aJbycvGv2pai5nRLAJvNtM87u7adWz
 4qrOQQsnhghLf/RAAXzEvMWHqnsvwWg0xoe++7rS6Hd8mCNZ8bTehv2K5fIwJxMlxXeCW1q4W
 fe5Yt1ZmhAna1jjEC1SwRgIhPmO3xHuEkuVfxxHl9OkqpleMaZLCN/R/J6E8+sd4WrjxKFp8u
 TUgWDM/UXzfac7aSEOamwhEg==

Changes since v2:
- use nested here-docs in t0080 to reduce quoting and while keeping it
  self-contained,
- include spin-off patch 4e1041dc39 (unit-tests: show location of checks
  outside of tests) from seen, but with a test,
- document incompatibility of for_test and break,
- add blank line between variable declarations and rest of strbuf test
  code to match the original style.

  t0080: use here-doc test body
  unit-tests: show location of checks outside of tests
  unit-tests: add for_test
  t-ctype: use for_test
  t-reftable-basics: use for_test
  t-strvec: use for_test
  t-strbuf: use for_test

 .clang-format                    |   2 +
 t/helper/test-example-tap.c      |  35 +++
 t/t0080-unit-test-output.sh      |  60 ++++--
 t/unit-tests/t-ctype.c           |   4 +-
 t/unit-tests/t-reftable-basics.c | 228 +++++++++-----------
 t/unit-tests/t-strbuf.c          | 127 +++++------
 t/unit-tests/t-strvec.c          | 356 ++++++++++++++-----------------
 t/unit-tests/test-lib.c          |   7 +-
 t/unit-tests/test-lib.h          |  20 ++
 9 files changed, 438 insertions(+), 401 deletions(-)

Range-Diff gegen v2:
1:  5faabaea54 < -:  ---------- t0080: move expected output to a file
-:  ---------- > 1:  9b919853df t0080: use here-doc test body
-:  ---------- > 2:  9cea2b43b9 unit-tests: show location of checks outsid=
e of tests
2:  d4f9fa0938 ! 3:  5ea7472d8a unit-tests: add for_test
    @@ t/helper/test-example-tap.c: int cmd__example_tap(int argc, const c=
har **argv)
      	return test_done();
      }

    - ## t/t0080/expect ##
    -@@ t/t0080/expect: not ok 17 - messages from failing string and char =
comparison
    - # BUG: test has no checks at t/helper/test-example-tap.c:92
    - not ok 18 - test with no checks
    - ok 19 - test with no checks returns 0
    --1..19
    -+ok 20 - for_test passing test
    -+# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:98
    -+#    left: 1
    -+#   right: 2
    -+not ok 21 - for_test failing test
    -+not ok 22 - for_test passing TEST_TODO() # TODO
    -+# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:102
    -+not ok 23 - for_test failing TEST_TODO()
    -+# check "0" failed at t/helper/test-example-tap.c:104
    -+# skipping test - missing prerequisite
    -+# skipping check '1' at t/helper/test-example-tap.c:106
    -+ok 24 - for_test test_skip() # SKIP
    -+# skipping test - missing prerequisite
    -+ok 25 - for_test test_skip() inside TEST_TODO() # SKIP
    -+# check "0" failed at t/helper/test-example-tap.c:111
    -+not ok 26 - for_test TEST_TODO() after failing check
    -+# check "0" failed at t/helper/test-example-tap.c:117
    -+not ok 27 - for_test failing check after TEST_TODO()
    -+# check "!strcmp("\thello\\", "there\"\n")" failed at t/helper/test-=
example-tap.c:120
    -+#    left: "\011hello\\"
    -+#   right: "there\"\012"
    -+# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.=
c:121
    -+#    left: "NULL"
    -+#   right: NULL
    -+# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:122
    -+#    left: 'a'
    -+#   right: '\012'
    -+# check "'\\' =3D=3D '\''" failed at t/helper/test-example-tap.c:123
    -+#    left: '\\'
    -+#   right: '\''
    -+not ok 28 - for_test messages from failing string and char compariso=
n
    -+# BUG: test has no checks at t/helper/test-example-tap.c:125
    -+not ok 29 - for_test test with no checks
    -+1..29
    + ## t/t0080-unit-test-output.sh ##
    +@@ t/t0080-unit-test-output.sh: test_expect_success 'TAP output from =
unit tests' - <<\EOT
    + 	# BUG: test has no checks at t/helper/test-example-tap.c:94
    + 	not ok 18 - test with no checks
    + 	ok 19 - test with no checks returns 0
    +-	1..19
    ++	ok 20 - for_test passing test
    ++	# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:100
    ++	#    left: 1
    ++	#   right: 2
    ++	not ok 21 - for_test failing test
    ++	not ok 22 - for_test passing TEST_TODO() # TODO
    ++	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:10=
4
    ++	not ok 23 - for_test failing TEST_TODO()
    ++	# check "0" failed at t/helper/test-example-tap.c:106
    ++	# skipping test - missing prerequisite
    ++	# skipping check '1' at t/helper/test-example-tap.c:108
    ++	ok 24 - for_test test_skip() # SKIP
    ++	# skipping test - missing prerequisite
    ++	ok 25 - for_test test_skip() inside TEST_TODO() # SKIP
    ++	# check "0" failed at t/helper/test-example-tap.c:113
    ++	not ok 26 - for_test TEST_TODO() after failing check
    ++	# check "0" failed at t/helper/test-example-tap.c:119
    ++	not ok 27 - for_test failing check after TEST_TODO()
    ++	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/te=
st-example-tap.c:122
    ++	#    left: "\011hello\\\\"
    ++	#   right: "there\"\012"
    ++	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap=
.c:123
    ++	#    left: "NULL"
    ++	#   right: NULL
    ++	# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:124
    ++	#    left: 'a'
    ++	#   right: '\012'
    ++	# check "'\\\\' =3D=3D '\\''" failed at t/helper/test-example-tap.c=
:125
    ++	#    left: '\\\\'
    ++	#   right: '\\''
    ++	not ok 28 - for_test messages from failing string and char comparis=
on
    ++	# BUG: test has no checks at t/helper/test-example-tap.c:127
    ++	not ok 29 - for_test test with no checks
    ++	1..29
    + 	EOF
    +
    + 	! test-tool example-tap >actual &&

      ## t/unit-tests/test-lib.h ##
     @@
    @@ t/unit-tests/test-lib.h
     + * Run a test unless test_skip_all() has been called.  Acts like a f=
or
     + * loop that runs at most once, with the test description between th=
e
     + * parentheses and the test body as a statement or block after them.
    -+ * The description for each test should be unique.  E.g.:
    ++ * Supports continue to end the test early, but not break. The
    ++ * description for each test should be unique.  E.g.:
     + *
     + *  for_test ("something else %d %d", arg1, arg2) {
     + *          prepare();
3:  a7cd5a2a3a =3D 4:  cf2fa74e9c t-ctype: use for_test
4:  cc07910f88 =3D 5:  f2e6271124 t-reftable-basics: use for_test
5:  11c1675a13 =3D 6:  c87a17189c t-strvec: use for_test
6:  cd79132f95 ! 7:  beaf8194fd t-strbuf: use for_test
    @@ t/unit-tests/t-strbuf.c: static void t_addstr(struct strbuf *buf, c=
onst void *da
     +
     +	for_test ("strbuf_addch adds char") {
     +		struct strbuf sb =3D STRBUF_INIT;
    ++
     +		t_addch(&sb, 'a');
     +		t_release(&sb);
     +	}
     +
     +	for_test ("strbuf_addch adds NUL char") {
     +		struct strbuf sb =3D STRBUF_INIT;
    ++
     +		t_addch(&sb, '\0');
     +		t_release(&sb);
     +	}
     +
     +	for_test ("strbuf_addch appends to initial value") {
     +		struct strbuf sb =3D STRBUF_INIT;
    ++
     +		t_addstr(&sb, "initial value");
     +		t_addch(&sb, 'a');
     +		t_release(&sb);
    @@ t/unit-tests/t-strbuf.c: static void t_addstr(struct strbuf *buf, c=
onst void *da
     +
     +	for_test ("strbuf_addstr adds string") {
     +		struct strbuf sb =3D STRBUF_INIT;
    ++
     +		t_addstr(&sb, "hello there");
     +		t_release(&sb);
     +	}
     +
     +	for_test ("strbuf_addstr appends string to initial value") {
     +		struct strbuf sb =3D STRBUF_INIT;
    ++
     +		t_addstr(&sb, "initial value");
     +		t_addstr(&sb, "hello there");
     +		t_release(&sb);
7:  83dafb009d < -:  ---------- unit-tests: show location of checks outsid=
e of tests
=2D-
2.45.2
