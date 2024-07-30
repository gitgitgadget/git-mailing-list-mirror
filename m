Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13441DA24
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348228; cv=none; b=YxjegBl7r/6fi6fudr2+Oo0OY9P9mqkZZVbEkpYL/v+7vHqhn6yQpeiwHQY1TtZ/EuTAQIadMX2LyFrkOD74huXlm+vGGuqnlj7a7F9xL0Ve4uBW0S1LzH64FJgYB4gh6vZJX+8loVlh8MTVe2uNUPNlNiJglvgc9cPCaYN/jYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348228; c=relaxed/simple;
	bh=TPYFNJY2/WRMcDCTd6oCJbvNWBnA3fyEHfByVFhkkxA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k3v1DCFCjhBBmDyxUADx5lfPKp3qV8BLiKLzGA1N67nBbs3kbhwBiLbZ/SUtAL4vJ4pCgOuFcw3iHvfdKSFGWx0B/x3HlSsiir1U2bvI1NWJDTvFf4RhwWsGo5UUI3kAh35XJ9HNKI4BIGlZn8cJ7QZdLEiNzCPXxX85c3hi6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cAhUhoSI; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cAhUhoSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348217; x=1722953017; i=l.s.r@web.de;
	bh=Lro6W5eMiwjW6EqjP1bu+OoRFoirSOJw9CI1RKX/IoQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cAhUhoSIgCt+MW8bd/A4smT9T1IxMGhgJU+YU8itGIuKFv2WdG2Wfqnhvdkph1MC
	 GVtm2PM+fg1jFCs2fURmcTDvvrm7BmqjFRt+duNEX+Qix8aPWQcAUaCMkGji+sssf
	 +JB5kZMrN0UJYvOXDyHJOpoAKve+wB2DPJTUmCpqGC+lZCQrR4G48RG+3ndJ3eRek
	 FP5uUwnJNlDmJRwZcwaIXy5LKaiVSUQSjMymy4NvO/gYF78I9GEhCwWyG90GtWySM
	 DMmEOMJnW5C1Fc38vqJuOi2u/AgGj8f71l0NF9q4OANcDjepgkuhwCkVus0YvI2ns
	 2N/DMByiaZrTC+CnYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1snnt01GY3-00XJbf; Tue, 30
 Jul 2024 16:03:37 +0200
Message-ID: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Date: Tue, 30 Jul 2024 16:03:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/6] add and use if_test to simplify tests
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Kyle Lippincott <spectral@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d03Z2RZV6zTW9lL0KjUHSr9Mbsfj0po/E9DGIXLXf3/TajaKU8X
 YgHBsL/ruqfBcJomOEEKdOzoOC5xXB30wG4XDEZ68t2O+PuLUMFs3uqxjFBIz/eWg+M/v47
 oAZwBj2Mk8ofKk+Ad5+eI+pTVFCpaCCwTxWywp6GebEbdvWH3A51hEnX2B7Mv5s5epXj9T4
 pEWmDJbKx1S3skKTQhMNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bOThWGRVmOE=;KeqwWW5ULShOdRGuX7ZtpUV75o5
 y85BkbMx0pABpttE0KyriI4JiZ7zSVYfHXiDpeZTYP4pi3XErTPkHJaUWd86V0Z3mHyM/hWB5
 E9nSmoahhq4RjjsXE8O8/27hRCAQn6axoFilBQZCwdnoJM5+tWeF0VTPfJUk8F8F/b6Kk+8As
 dZJEc76XznIqtPAUEqrxB7xiRsvis5WsvcN6f7sarld7pNe/OTTVrM/IN5GAhC5dd8d169NG6
 TR9qjK1Cz4ny0cdDkvcAsggHi8O3aQRd7m5ftp0ax8ufNP3ylOoNL2jhc9lxEP9mXNVWChpAN
 D4BRsRKainxGcVv7cwrleNPpMgov8YtzCXMasPWYMy9Fkgxop1fHYpgXklUdWL9d12szjChYl
 f1XMSxVxWvuin0RZA7rvK4m/NLlCKlV8RWPQeIK44flWcfwpeX6atYLf4+uPRneRBka188/yQ
 AkOCBmSaYL/yYLm2SO7/QLmOapua5fQ8vbHTOiz3/Cp93y8rllifm8NBG5mvrTb1r274Jtbui
 QYrZQQCNgidesYJ4F32vVM/jY3NbVgggKz4DK4EL6apEZa7w9YySeQT3+YCWoOxXU4OZqe5/u
 G9o7l+y9i/gOC6KujBlzfJiALtVeRlrcGxRKFsLI0nLkgBu8H3Abn6QCByQIUskZwj6vCYfr4
 gFrtv+zOUOCjd94iMbtVeBsZPcEwFyL/+PLxFtoFy07ymNWRadsWIUh1UY0oOaNuk92h2DsEa
 B6SMpGxZHwWU9myBb7siRLqTNjoc//KYm3uhe8GzJ2UEDg9VMlF86S1Z0lAJE4pQTnWX8U8VW
 Ze4iKSdDj9WSko05EBog6KOg==

Changes since v3:
- Replace for_test with if_test, a more robust conditional-like macro.
  It stores description and location like v1, but without using strbuf.
- Drop patch 7 for t-strbuf to avoid hindering Kyle's cleanup idea.

Side note: Created with --creation-factor=3D60, as the default of 999 in
v2.46.0 pairs dropped patch 7 with new patch 4 and reports old patch 4
as dropped, which is confusing.

  t0080: use here-doc test body
  unit-tests: show location of checks outside of tests
  unit-tests: add if_test
  t-ctype: use if_test
  t-reftable-basics: use if_test
  t-strvec: use if_test

 .clang-format                    |   5 +
 t/helper/test-example-tap.c      |  35 +++
 t/t0080-unit-test-output.sh      |  60 ++++--
 t/unit-tests/t-ctype.c           |   4 +-
 t/unit-tests/t-reftable-basics.c | 228 +++++++++-----------
 t/unit-tests/t-strvec.c          | 356 ++++++++++++++-----------------
 t/unit-tests/test-lib.c          |  36 +++-
 t/unit-tests/test-lib.h          |  20 ++
 8 files changed, 405 insertions(+), 339 deletions(-)

Range-Diff gegen v3:
1:  497002df9e =3D 1:  497002df9e t0080: use here-doc test body
2:  0c1503fb5a =3D 2:  f85d4f9455 unit-tests: show location of checks outs=
ide of tests
3:  27f1f18b3d < -:  ---------- unit-tests: add for_test
-:  ---------- > 3:  77c7dfa1ad unit-tests: add if_test
4:  98a1e7abdf ! 4:  63fba50876 t-ctype: use for_test
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-ctype: use for_test
    +    t-ctype: use if_test

    -    Use the documented macro for_test instead of the internal functio=
ns
    +    Use the documented macro if_test instead of the internal function=
s
         test__run_begin() and test__run_end(), which are supposed to be p=
rivate
         to the unit test framework.

    @@ t/unit-tests/t-ctype.c
      		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
     -	int skip =3D test__run_begin(); \
     -	if (!skip) { \
    -+	for_test (#class " works") { \
    ++	if_test (#class " works") { \
      		for (int i =3D 0; i < 256; i++) { \
      			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
      				test_msg("      i: 0x%02x", i); \
5:  7c954f0864 ! 5:  ab86673484 t-reftable-basics: use for_test
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-reftable-basics: use for_test
    +    t-reftable-basics: use if_test

         The macro TEST takes a single expression.  If a test requires mul=
tiple
         statements then they need to be placed in a function that's calle=
d in
         the TEST expression.

         Remove the overhead of defining and calling single-use functions =
by
    -    using for_test instead.
    +    using if_test instead.

         Run the tests in the order of definition.  We can reorder them li=
ke that
         because they are independent.  Technically this changes the outpu=
t, but
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -		struct integer_needle_lesseq_args args =3D {
     -			.haystack =3D haystack,
     -			.needle =3D testcases[i].needle,
    -+	for_test ("binary search with binsearch works") {
    ++	if_test ("binary search with binsearch works") {
     +		int haystack[] =3D { 2, 4, 6, 8, 10 };
     +		struct {
     +			int needle;
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	const char *a[] =3D { "a", "b", "c", NULL };
     -	const char *b[] =3D { "a", "b", "d", NULL };
     -	const char *c[] =3D { "a", "b", NULL };
    -+	for_test ("names_length retuns size of a NULL-terminated string arr=
ay") {
    ++	if_test ("names_length retuns size of a NULL-terminated string arra=
y") {
     +		const char *a[] =3D { "a", "b", NULL };
     +		check_int(names_length(a), =3D=3D, 2);
     +	}
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	check(!names_equal(a, b));
     -	check(!names_equal(a, c));
     -}
    -+	for_test ("names_equal compares NULL-terminated string arrays") {
    ++	if_test ("names_equal compares NULL-terminated string arrays") {
     +		const char *a[] =3D { "a", "b", "c", NULL };
     +		const char *b[] =3D { "a", "b", "d", NULL };
     +		const char *c[] =3D { "a", "b", NULL };
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	check(!out[2]);
     -	free_names(out);
     -}
    -+	for_test ("parse_names works for basic input") {
    ++	if_test ("parse_names works for basic input") {
     +		char in1[] =3D "line\n";
     +		char in2[] =3D "a\nb\nc";
     +		char **out =3D NULL;
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -		check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
     -		strbuf_reset(&a);
     -		strbuf_reset(&b);
    -+	for_test ("parse_names drops empty string") {
    ++	if_test ("parse_names drops empty string") {
     +		char in[] =3D "a\n\nb\n";
     +		char **out =3D NULL;
     +		parse_names(in, strlen(in), &out);
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	out =3D get_be24(dest);
     -	check_int(in, =3D=3D, out);
     -}
    -+	for_test ("common_prefix_size works") {
    ++	if_test ("common_prefix_size works") {
     +		struct strbuf a =3D STRBUF_INIT;
     +		struct strbuf b =3D STRBUF_INIT;
     +		struct {
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	TEST(test_names_equal(), "names_equal compares NULL-terminated stri=
ng arrays");
     -	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
     -	TEST(test_u16_roundtrip(), "put_be16 and get_be16 work");
    -+	for_test ("put_be24 and get_be24 work") {
    ++	if_test ("put_be24 and get_be24 work") {
     +		uint32_t in =3D 0x112233;
     +		uint8_t dest[3];
     +		uint32_t out;
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     +		check_int(in, =3D=3D, out);
     +	}
     +
    -+	for_test ("put_be16 and get_be16 work") {
    ++	if_test ("put_be16 and get_be16 work") {
     +		uint32_t in =3D 0xfef1;
     +		uint8_t dest[3];
     +		uint32_t out;
6:  d619a756d7 ! 6:  64bb731ba6 t-strvec: use for_test
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-strvec: use for_test
    +    t-strvec: use if_test

         The macro TEST takes a single expression.  If a test requires mul=
tiple
         statements then they need to be placed in a function that's calle=
d in
         the TEST expression.

         Remove the cognitive overhead of defining and calling single-use
    -    functions by using for_test instead.
    +    functions by using if_test instead.
    +
    +    Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## t/unit-tests/t-strvec.c ##
     @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *=
loc, struct strvec *vec, ...)
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     -}
    -+	for_test ("static initialization") {
    ++	if_test ("static initialization") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		check_pointer_eq(vec.v, empty_strvec);
     +		check_uint(vec.nr, =3D=3D, 0);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     -}
    -+	for_test ("dynamic initialization") {
    ++	if_test ("dynamic initialization") {
     +		struct strvec vec;
     +		strvec_init(&vec);
     +		check_pointer_eq(vec.v, empty_strvec);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     -}
    -+	for_test ("clear") {
    ++	if_test ("clear") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_push(&vec, "foo");
     +		strvec_clear(&vec);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -static void t_push(void)
     -{
     -	struct strvec vec =3D STRVEC_INIT;
    -+	for_test ("push") {
    ++	if_test ("push") {
     +		struct strvec vec =3D STRVEC_INIT;

     -	strvec_push(&vec, "foo");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo: 1", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("pushf") {
    ++	if_test ("pushf") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushf(&vec, "foo: %d", 1);
     +		check_strvec(&vec, "foo: 1", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("pushl") {
    ++	if_test ("pushl") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		check_strvec(&vec, "foo", "bar", "baz", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -		"foo", "bar", "baz", NULL,
     -	};
     -	struct strvec vec =3D STRVEC_INIT;
    -+	for_test ("pushv") {
    ++	if_test ("pushv") {
     +		const char *strings[] =3D {
     +			"foo", "bar", "baz", NULL,
     +		};
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "replaced", "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("replace at head") {
    ++	if_test ("replace at head") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_replace(&vec, 0, "replaced");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", "replaced", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("replace at tail") {
    ++	if_test ("replace at tail") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_replace(&vec, 2, "replaced");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "replaced", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("replace in between") {
    ++	if_test ("replace in between") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_replace(&vec, 1, "replaced");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "oo", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("replace with substring") {
    ++	if_test ("replace with substring") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", NULL);
     +		strvec_replace(&vec, 0, vec.v[0] + 1);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("remove at head") {
    ++	if_test ("remove at head") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_remove(&vec, 0);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("remove at tail") {
    ++	if_test ("remove at tail") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_remove(&vec, 2);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("remove in between") {
    ++	if_test ("remove in between") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_remove(&vec, 1);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("pop with empty array") {
    ++	if_test ("pop with empty array") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pop(&vec);
     +		check_strvec(&vec, NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("pop with non-empty array") {
    ++	if_test ("pop with non-empty array") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_pop(&vec);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("split empty string") {
    ++	if_test ("split empty string") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "");
     +		check_strvec(&vec, NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("split single item") {
    ++	if_test ("split single item") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "foo");
     +		check_strvec(&vec, "foo", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("split multiple items") {
    ++	if_test ("split multiple items") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "foo bar baz");
     +		check_strvec(&vec, "foo", "bar", "baz", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("split whitespace only") {
    ++	if_test ("split whitespace only") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, " \t\n");
     +		check_strvec(&vec, NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", NULL);
     -	strvec_clear(&vec);
     -}
    -+	for_test ("split multiple consecutive whitespaces") {
    ++	if_test ("split multiple consecutive whitespaces") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "foo\n\t bar");
     +		check_strvec(&vec, "foo", "bar", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -{
     -	struct strvec vec =3D STRVEC_INIT;
     -	const char **detached;
    -+	for_test ("detach") {
    ++	if_test ("detach") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		const char **detached;

7:  ea088728ad < -:  ---------- t-strbuf: use for_test
=2D-
2.46.0
