Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C9567D
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721542359; cv=none; b=PX35z35u6m6YS+10BRdUUc20e+aWywK8+calQPygdIoQDtpfYSAjuSonxwkrf4WA4bSPzdut3gNHkupWU6tHNEoN6lC2Z3nUKD7ajjRpyt9xmvVzB5VfBhwcuAJDWrYB8ovJ/WveRp1atoZEhWo4EfL2x9VwgtwSPwxHriwbbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721542359; c=relaxed/simple;
	bh=ZpMEgCYF0nRpQr/eSahdiB+r7Sq+6iYFWdCl9diUykE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o2DRL+RzX7Lyoka+76R1hvVv/N0iJjYt97jwpTWCvGbz/DXNYPcrltjanZ5FPaRf1BOIDn7/9bwmKX+dopB6mpsR9DBQ1hiduJmBHeXyIQwGyMKivH1Geuo9XPs4skdzduZwFcjJka7ptE4J61etOGjt3IX4SDDuISlWmHwHK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=r8tKff1k; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="r8tKff1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721542337; x=1722147137; i=l.s.r@web.de;
	bh=p8P9oXcE9xq+4Ax/RSaX5OeaeGmAaYccjka962Y4yxg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r8tKff1kNmfjRFGATGOFeWNcwlYIAlJGOocIBkbdTn+qA82TrUWsOPh3AEgHr3HP
	 AeH7DM3BJ0s+JLKmIF/aSnKaRLXckHMmZKFJdS/kyZVDVnbHtI4SArjlYZAD5kkZa
	 Qyg0ix5GFslXSw5TlnVIyN6msTOK6s1KRptOmDyXpFOyX7OIw6u1ZANNXq4a9F+1h
	 4EC/gzncHRzC/exL+XC8SPlbEK3M/ER9e6RF7WtaQAfjV8fFPOmWM7UtOljBmSgQt
	 5CyAX8MCtDlAVSCcE9Cu3yfLqBqD1/rQ8lzU4zZlH9DAwTIPvzvLcfJhLQmuyruyw
	 VERoORzXAWAcyoJKCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi5i-1spH3J0Rnk-00XOBz; Sun, 21
 Jul 2024 08:12:17 +0200
Message-ID: <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Date: Sun, 21 Jul 2024 08:12:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/6] unit-tests: add and use for_test to simplify tests
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g5IfTYVzj7uJEec2v0JxpjSh2lWqt+bzYFt0idCt4jjtsE+LHhW
 udmOBmCgVc2dDKqTrBO+qB1+kN6zinMRoDqiJzp+as1iiBKGscaLpdtpbUVwnVMS+r6XaaL
 FcgrECaq4yPdATLk/66rA5GjYAfFd5I2zjpOfXHOdJvzudMu52g2VdssvZnQXfYUah/iEv+
 lCP3Xj9KLsTX3sEy0nfug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IiiVRc/EQC4=;hOevjxe+lMavSrS1kU4gHlbFAzJ
 1hwKAQmGQ/YRAT2D6vxbvon/YHRnnTTky5e7q+4/MufnFpVpYTuCtx3tLa12bOFkgnV0Xn88I
 /sph9exeUzlZ2DL/KhvsL1a8dtbBf9J3F92Pf0dh2OY5DvTOGlC8TWShgvk1ijZHNcM76Jm1X
 UV3oMtfVDd3krMJ4e3InAR+BJA5mU37yIFORrBpRgHvMIpwKhBp4WjMBWyT4S9sy1Ux4sg7BO
 JSrOQ3bSQ4bjRkDwgipLSv9jQwUkHXwIRku/iRJaOk4vk2jWvaVbmRp/6Q/b8K860h8B3BCpZ
 /95Ig5QuiqXhdRf+VtMjL+aVTy00lCsbjbXTr1IuaHRy/hWUSZlyO5XYg1AnX1Ri93wNlkMop
 +QuMs7nqWz9eT5Qv5Tifu33IPtILHmy9s+VR3SmjVXbrXd7PenHDtobJhKfpinvheBcwcdwt7
 sQ7yYjw7Mi0AiIKUPZZyFi0v5CMC1aglz1c+tY5D+urN3BIE9A30NB5L/wKy/F0HPR/CeM6kO
 WfHkdTy9l+ssHwT4+CtJwtiSXpHN4ffgYirz34oeAxLb9lfE3XMeSLqxjPJf/wfIeVMvxyitK
 5uNX9saWxBgvukx4AJNkkaH7NYA1rD5lSnnpFQZp+MBvteuzoGD1xLag/B9qtrdkFeC1uJ2VV
 +7wZyUoElXC2oqwM3aRBTC7JlVD1LI+aOvcuUY49S5QpPVkSWmc7IX+yH/vP9RVhLArFTHVHa
 gKgAShpKIsNoA1ifKb6lPWMbhcy8AtW0SxEbpst4R0nJmpowYINDNnXzx+MbVCGFSeEbiHB92
 HDs7qVfPJ//vu6tdHwmwg4JA==

Changes since v1:
- replace "if (TEST_RUN(...))" with "for_test (...)", a macro based on the
  keyword "for" that doesn't require changes to existing functions,
- clarify the commit messages of patches 3 and 5,
- convert the strbuf initialization tests as well.

  t0080: move expected output to a file
  unit-tests: add for_test
  t-ctype: use for_test
  t-reftable-basics: use for_test
  t-strvec: use for_test
  t-strbuf: use for_test

 .clang-format                    |   2 +
 t/helper/test-example-tap.c      |  33 +++
 t/t0080-unit-test-output.sh      |  48 +----
 t/t0080/expect                   |  76 +++++++
 t/unit-tests/t-ctype.c           |   4 +-
 t/unit-tests/t-reftable-basics.c | 228 +++++++++-----------
 t/unit-tests/t-strbuf.c          | 122 ++++++-----
 t/unit-tests/t-strvec.c          | 356 ++++++++++++++-----------------
 t/unit-tests/test-lib.h          |  19 ++
 9 files changed, 454 insertions(+), 434 deletions(-)
 create mode 100644 t/t0080/expect

Range-Diff gegen v1:
1:  6efe5a37f0 =3D 1:  5faabaea54 t0080: move expected output to a file
2:  8297c2b121 < -:  ---------- unit-tests: add TEST_RUN
-:  ---------- > 2:  d4f9fa0938 unit-tests: add for_test
3:  ec5599906d ! 3:  a7cd5a2a3a t-ctype: use TEST_RUN
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-ctype: use TEST_RUN
    +    t-ctype: use for_test

    -    Use the macro TEST_RUN instead of the internal functions
    -    test__run_begin() and test__run_end().
    +    Use the documented macro for_test instead of the internal functio=
ns
    +    test__run_begin() and test__run_end(), which are supposed to be p=
rivate
    +    to the unit test framework.

      ## t/unit-tests/t-ctype.c ##
     @@
    @@ t/unit-tests/t-ctype.c
      		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
     -	int skip =3D test__run_begin(); \
     -	if (!skip) { \
    -+	if (TEST_RUN(#class " works")) { \
    ++	for_test (#class " works") { \
      		for (int i =3D 0; i < 256; i++) { \
      			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
      				test_msg("      i: 0x%02x", i); \
4:  e589468f98 ! 4:  cc07910f88 t-reftable-basics: use TEST_RUN
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-reftable-basics: use TEST_RUN
    +    t-reftable-basics: use for_test

         The macro TEST takes a single expression.  If a test requires mul=
tiple
         statements then they need to be placed in a function that's calle=
d in
         the TEST expression.

         Remove the overhead of defining and calling single-use functions =
by
    -    using TEST_RUN instead.
    +    using for_test instead.

         Run the tests in the order of definition.  We can reorder them li=
ke that
         because they are independent.  Technically this changes the outpu=
t, but
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -		struct integer_needle_lesseq_args args =3D {
     -			.haystack =3D haystack,
     -			.needle =3D testcases[i].needle,
    -+	if (TEST_RUN("binary search with binsearch works")) {
    ++	for_test ("binary search with binsearch works") {
     +		int haystack[] =3D { 2, 4, 6, 8, 10 };
     +		struct {
     +			int needle;
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	const char *a[] =3D { "a", "b", "c", NULL };
     -	const char *b[] =3D { "a", "b", "d", NULL };
     -	const char *c[] =3D { "a", "b", NULL };
    -+	if (TEST_RUN("names_length retuns size of a NULL-terminated string =
array")) {
    ++	for_test ("names_length retuns size of a NULL-terminated string arr=
ay") {
     +		const char *a[] =3D { "a", "b", NULL };
     +		check_int(names_length(a), =3D=3D, 2);
     +	}
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	check(!names_equal(a, b));
     -	check(!names_equal(a, c));
     -}
    -+	if (TEST_RUN("names_equal compares NULL-terminated string arrays"))=
 {
    ++	for_test ("names_equal compares NULL-terminated string arrays") {
     +		const char *a[] =3D { "a", "b", "c", NULL };
     +		const char *b[] =3D { "a", "b", "d", NULL };
     +		const char *c[] =3D { "a", "b", NULL };
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	check(!out[2]);
     -	free_names(out);
     -}
    -+	if (TEST_RUN("parse_names works for basic input")) {
    ++	for_test ("parse_names works for basic input") {
     +		char in1[] =3D "line\n";
     +		char in2[] =3D "a\nb\nc";
     +		char **out =3D NULL;
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -		check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
     -		strbuf_reset(&a);
     -		strbuf_reset(&b);
    -+	if (TEST_RUN("parse_names drops empty string")) {
    ++	for_test ("parse_names drops empty string") {
     +		char in[] =3D "a\n\nb\n";
     +		char **out =3D NULL;
     +		parse_names(in, strlen(in), &out);
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	out =3D get_be24(dest);
     -	check_int(in, =3D=3D, out);
     -}
    -+	if (TEST_RUN("common_prefix_size works")) {
    ++	for_test ("common_prefix_size works") {
     +		struct strbuf a =3D STRBUF_INIT;
     +		struct strbuf b =3D STRBUF_INIT;
     +		struct {
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     -	TEST(test_names_equal(), "names_equal compares NULL-terminated stri=
ng arrays");
     -	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
     -	TEST(test_u16_roundtrip(), "put_be16 and get_be16 work");
    -+	if (TEST_RUN("put_be24 and get_be24 work")) {
    ++	for_test ("put_be24 and get_be24 work") {
     +		uint32_t in =3D 0x112233;
     +		uint8_t dest[3];
     +		uint32_t out;
    @@ t/unit-tests/t-reftable-basics.c: static int integer_needle_lesseq(=
size_t i, voi
     +		check_int(in, =3D=3D, out);
     +	}
     +
    -+	if (TEST_RUN("put_be16 and get_be16 work")) {
    ++	for_test ("put_be16 and get_be16 work") {
     +		uint32_t in =3D 0xfef1;
     +		uint8_t dest[3];
     +		uint32_t out;
5:  5805a9cbd7 ! 5:  11c1675a13 t-strvec: use TEST_RUN
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-strvec: use TEST_RUN
    +    t-strvec: use for_test

         The macro TEST takes a single expression.  If a test requires mul=
tiple
         statements then they need to be placed in a function that's calle=
d in
         the TEST expression.

    -    Remove the overhead of defining and calling single-use functions =
by
    -    using TEST_RUN instead.
    +    Remove the cognitive overhead of defining and calling single-use
    +    functions by using for_test instead.

      ## t/unit-tests/t-strvec.c ##
     @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *=
loc, struct strvec *vec, ...)
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     -}
    -+	if (TEST_RUN("static initialization")) {
    ++	for_test ("static initialization") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		check_pointer_eq(vec.v, empty_strvec);
     +		check_uint(vec.nr, =3D=3D, 0);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     -}
    -+	if (TEST_RUN("dynamic initialization")) {
    ++	for_test ("dynamic initialization") {
     +		struct strvec vec;
     +		strvec_init(&vec);
     +		check_pointer_eq(vec.v, empty_strvec);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     -}
    -+	if (TEST_RUN("clear")) {
    ++	for_test ("clear") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_push(&vec, "foo");
     +		strvec_clear(&vec);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -static void t_push(void)
     -{
     -	struct strvec vec =3D STRVEC_INIT;
    -+	if (TEST_RUN("push")) {
    ++	for_test ("push") {
     +		struct strvec vec =3D STRVEC_INIT;

     -	strvec_push(&vec, "foo");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo: 1", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("pushf")) {
    ++	for_test ("pushf") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushf(&vec, "foo: %d", 1);
     +		check_strvec(&vec, "foo: 1", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("pushl")) {
    ++	for_test ("pushl") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		check_strvec(&vec, "foo", "bar", "baz", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -		"foo", "bar", "baz", NULL,
     -	};
     -	struct strvec vec =3D STRVEC_INIT;
    -+	if (TEST_RUN("pushv")) {
    ++	for_test ("pushv") {
     +		const char *strings[] =3D {
     +			"foo", "bar", "baz", NULL,
     +		};
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "replaced", "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("replace at head")) {
    ++	for_test ("replace at head") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_replace(&vec, 0, "replaced");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", "replaced", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("replace at tail")) {
    ++	for_test ("replace at tail") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_replace(&vec, 2, "replaced");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "replaced", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("replace in between")) {
    ++	for_test ("replace in between") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_replace(&vec, 1, "replaced");
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "oo", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("replace with substring")) {
    ++	for_test ("replace with substring") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", NULL);
     +		strvec_replace(&vec, 0, vec.v[0] + 1);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("remove at head")) {
    ++	for_test ("remove at head") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_remove(&vec, 0);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("remove at tail")) {
    ++	for_test ("remove at tail") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_remove(&vec, 2);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("remove in between")) {
    ++	for_test ("remove in between") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_remove(&vec, 1);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("pop with empty array")) {
    ++	for_test ("pop with empty array") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pop(&vec);
     +		check_strvec(&vec, NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("pop with non-empty array")) {
    ++	for_test ("pop with non-empty array") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +		strvec_pop(&vec);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("split empty string")) {
    ++	for_test ("split empty string") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "");
     +		check_strvec(&vec, NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("split single item")) {
    ++	for_test ("split single item") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "foo");
     +		check_strvec(&vec, "foo", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", "baz", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("split multiple items")) {
    ++	for_test ("split multiple items") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "foo bar baz");
     +		check_strvec(&vec, "foo", "bar", "baz", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("split whitespace only")) {
    ++	for_test ("split whitespace only") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, " \t\n");
     +		check_strvec(&vec, NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -	check_strvec(&vec, "foo", "bar", NULL);
     -	strvec_clear(&vec);
     -}
    -+	if (TEST_RUN("split multiple consecutive whitespaces")) {
    ++	for_test ("split multiple consecutive whitespaces") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		strvec_split(&vec, "foo\n\t bar");
     +		check_strvec(&vec, "foo", "bar", NULL);
    @@ t/unit-tests/t-strvec.c: static void check_strvec_loc(const char *l=
oc, struct st
     -{
     -	struct strvec vec =3D STRVEC_INIT;
     -	const char **detached;
    -+	if (TEST_RUN("detach")) {
    ++	for_test ("detach") {
     +		struct strvec vec =3D STRVEC_INIT;
     +		const char **detached;

6:  188b31884b ! 6:  cd79132f95 t-strbuf: use TEST_RUN
    @@ Metadata
     Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    t-strbuf: use TEST_RUN
    +    t-strbuf: use for_test

         The macro TEST takes a single expression.  If a test requires mul=
tiple
         statements then they need to be placed in a function that's calle=
d in
    @@ Commit message
         are used for that purpose and take another function as an argumen=
t,
         making the control flow hard to follow.

    -    Remove the overhead of these functions by using TEST_RUN instead.=
  Move
    +    Remove the overhead of these functions by using for_test instead.=
  Move
         their duplicate post-condition checks into a new helper, t_releas=
e(),
         and let t_addch() and t_addstr() accept properly typed input para=
meters
         instead of void pointers.
    @@ t/unit-tests/t-strbuf.c
      static int assert_sane_strbuf(struct strbuf *buf)
      {
      	/* Initialized strbufs should always have a non-NULL buffer */
    -@@ t/unit-tests/t-strbuf.c: static void t_dynamic_init(void)
    - 	strbuf_release(&buf);
    +@@ t/unit-tests/t-strbuf.c: static int assert_sane_strbuf(struct strb=
uf *buf)
    + 	return check_uint(buf->len, <, buf->alloc);
      }

    --static void t_addch(struct strbuf *buf, const void *data)
    +-static void t_static_init(void)
     +static void t_addch(struct strbuf *buf, int ch)
      {
    +-	struct strbuf buf =3D STRBUF_INIT;
    +-
    +-	check_uint(buf.len, =3D=3D, 0);
    +-	check_uint(buf.alloc, =3D=3D, 0);
    +-	check_char(buf.buf[0], =3D=3D, '\0');
    +-}
    +-
    +-static void t_dynamic_init(void)
    +-{
    +-	struct strbuf buf;
    +-
    +-	strbuf_init(&buf, 1024);
    +-	check(assert_sane_strbuf(&buf));
    +-	check_uint(buf.len, =3D=3D, 0);
    +-	check_uint(buf.alloc, >=3D, 1024);
    +-	check_char(buf.buf[0], =3D=3D, '\0');
    +-	strbuf_release(&buf);
    +-}
    +-
    +-static void t_addch(struct strbuf *buf, const void *data)
    +-{
     -	const char *p_ch =3D data;
     -	const char ch =3D *p_ch;
      	size_t orig_alloc =3D buf->alloc;
    @@ t/unit-tests/t-strbuf.c: static void t_addstr(struct strbuf *buf, c=
onst void *da
     +
      int cmd_main(int argc, const char **argv)
      {
    - 	if (!TEST(t_static_init(), "static initialization works"))
    - 		test_skip_all("STRBUF_INIT is broken");
    - 	TEST(t_dynamic_init(), "dynamic initialization works");
    +-	if (!TEST(t_static_init(), "static initialization works"))
    +-		test_skip_all("STRBUF_INIT is broken");
    +-	TEST(t_dynamic_init(), "dynamic initialization works");
     -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
     -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
     -	TEST(setup_populated(t_addch, "initial value", "a"),
    @@ t/unit-tests/t-strbuf.c: static void t_addstr(struct strbuf *buf, c=
onst void *da
     -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
     -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
     -	     "strbuf_addstr appends string to initial value");
    ++	for_test ("static initialization works") {
    ++		struct strbuf buf =3D STRBUF_INIT;
    ++
    ++		if (!check_uint(buf.len, =3D=3D, 0) ||
    ++		    !check_uint(buf.alloc, =3D=3D, 0) ||
    ++		    !check_char(buf.buf[0], =3D=3D, '\0'))
    ++			test_skip_all("STRBUF_INIT is broken");
    ++	}
    ++
    ++	for_test ("dynamic initialization works") {
    ++		struct strbuf buf;
    ++
    ++		strbuf_init(&buf, 1024);
    ++		check(assert_sane_strbuf(&buf));
    ++		check_uint(buf.len, =3D=3D, 0);
    ++		check_uint(buf.alloc, >=3D, 1024);
    ++		check_char(buf.buf[0], =3D=3D, '\0');
    ++		strbuf_release(&buf);
    ++	}
     +
    -+	if (TEST_RUN("strbuf_addch adds char")) {
    ++	for_test ("strbuf_addch adds char") {
     +		struct strbuf sb =3D STRBUF_INIT;
     +		t_addch(&sb, 'a');
     +		t_release(&sb);
     +	}
     +
    -+	if (TEST_RUN("strbuf_addch adds NUL char")) {
    ++	for_test ("strbuf_addch adds NUL char") {
     +		struct strbuf sb =3D STRBUF_INIT;
     +		t_addch(&sb, '\0');
     +		t_release(&sb);
     +	}
     +
    -+	if (TEST_RUN("strbuf_addch appends to initial value")) {
    ++	for_test ("strbuf_addch appends to initial value") {
     +		struct strbuf sb =3D STRBUF_INIT;
     +		t_addstr(&sb, "initial value");
     +		t_addch(&sb, 'a');
     +		t_release(&sb);
     +	}
     +
    -+	if (TEST_RUN("strbuf_addstr adds string")) {
    ++	for_test ("strbuf_addstr adds string") {
     +		struct strbuf sb =3D STRBUF_INIT;
     +		t_addstr(&sb, "hello there");
     +		t_release(&sb);
     +	}
     +
    -+	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
    ++	for_test ("strbuf_addstr appends string to initial value") {
     +		struct strbuf sb =3D STRBUF_INIT;
     +		t_addstr(&sb, "initial value");
     +		t_addstr(&sb, "hello there");
=2D-
2.45.2
