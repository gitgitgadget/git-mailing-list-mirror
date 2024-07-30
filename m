Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA261A2576
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348670; cv=none; b=WDRqgJmaIk8knoZpBYC9ceBvysULBTAvHYhp0AjZegL41Ycs2OlED53pa6LF1OH95C3Xh29dODu6NxlwUQv4iQGBZhySF+zw6oC+XmQaHI91deeGgZD591NYJWvGRGmvqi8ec2vzaS1E1B7CjHvxlgoPEvmiFXIG7gmUCKkD90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348670; c=relaxed/simple;
	bh=23dLN2TBH1DrPuXJh41PXdy48UUOEO6FbQ2EHmgHigs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FIcr5TgonGjJqpzIW7rWYWMqRgfID4OiMMV6DUXzVVXdj9pZOQSRJMJGd/i9Dy+XI/BAwRN/bEpLg5l9eYNftI4bLT3OFhduwN7Vhe5s+q5dMmsazPVBMe7VkkxWvTzXUyrGQlYAw+kE2JyNRwLsE+3wXXMHkunkdJqc3DbT6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=py36Z8kq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="py36Z8kq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348659; x=1722953459; i=l.s.r@web.de;
	bh=MVtYYBjWvvgr5tfMlqcJ0DIeNRGpuZdRwZT+r6vJ0bY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=py36Z8kqecReh/qeAd8NaknUZvtF/mUxscqUF6MsiCtM7OyhGFF5gm0OA2ew9xmM
	 P4MrxKZNSN/0xqnWU2eZVNWyTjLNiAppAlMy6+quLw09NpO6ZzJIUjqoVCXl3qRY+
	 ZRZ4jsO2G159rUTz8NtttqezmKZG5v17ymLTYPDZAanxTnun6D/0KS5Ay5y9gtekn
	 YmLBrXuQja9g5OF3lmzsbf5OMspwb998CMESz9BgdMjiwz6FprVSqYVyBYLWVW26r
	 zKBVP9sKCC7YxaO6IVgOuxUUIl2MqXo8XxZMvtjYozkxvg0EeC31ffceUfmEhMNvh
	 qovJkS3+XLLKZtA4Tg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWoU-1so8Yl1nR2-00NpXU; Tue, 30
 Jul 2024 16:10:59 +0200
Message-ID: <a382818b-40ab-4243-9842-579b2e99022f@web.de>
Date: Tue, 30 Jul 2024 16:10:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 5/6] t-reftable-basics: use if_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Kyle Lippincott <spectral@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Language: en-US
In-Reply-To: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sD9pFQNU6tQjhZfu0ntZo36+r8N12bqSlWDgHpYbritbcv09Zib
 tYnxEa+YdGw5baUb8lh8UQHC32eDr0zKSBPR/NtS4c//CiCzwrCmyM+4ZVqhyyhYrcEaeqF
 D/sMbJvjJVgiJFvX87FsKiRZvAvecIzFr0X18qLwzXgy4DBSLdpMeGeSVeYV0sSYSoouSTm
 9waWq8NU/ua57IbUAtiwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jhWsnOxJo4o=;CiRMWO0IrR/2A1B0j3WQv6ABWAV
 kN1Cvlz27qKami58g6NvL6pSR3BjaHDmCFqzHsPGLIdwEDRLPg6oZEPbKO5R8qA4VxUmvD6i9
 091uvEtX4sfPGwE7ga4BVyyoOEscBA5HTm8g2eeIuVG2TRM0CRla8lkIwZDZ0hYi+oTyJqJI5
 +Dm6s6sz5jh690Ddak5Hgt/+e9FR4cybPu3WNvZpAnGXJOGGoAgvhiGj052LS50Nn5Cn2iFBY
 MYJ9oiVSEG9SNJhX5b4tpkhTP6++rR9jC6anjzm3lMD6J/bgxi481GQsllNEzX4Q1aLByZdKM
 FPWvbv0u4Loo4FZtJsWgUlAlCUMivaORQMCUq/HvKJN2RJHkFET1bXPqC+djAhZ7x6+2FAk2+
 6ecmtL76bE7ObQshxrVDkPZi0gS6VAHhY9htfuK3rhw0UxVS+FXLiQe7PnrFS6ZOsQeCD8NL0
 ksDb1PnpzbiBmIJ+KD0zNZiAVzDUdQWQkUrqnDkiRgiwjA4Cl4Z/3alvDI+HzA3857sXc0Jnd
 Q3wvGdp9gWki3YbEVmu3rHEvvyJK2Mk2yGwaNIkd9Cs0nFbTAYNGfLRUaRfnF0Nv+lHtKu/q1
 URGQ5s4G+wWnduc98+tPut+9KNExp92wHRNuAVg/tOhCbXMzY+MJ1C2iUeq6wJmdE/Bxf07tM
 FaBG2HHSZ1J8I3kVeeccfAjIuWEEZq29OduuDLIp1YlpWwwrUeUFP9PVVUOz2Nsz8ccr61bea
 BFDRhUkWUadJmbNBc6NezS7nWJBTwCcxe4B26KLMm/qbIeX3k19TbBLS8HgMydxG8RaH/tiZy
 qslaDrrbQgL5EDFMwPomy1aA==

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.

Remove the overhead of defining and calling single-use functions by
using if_test instead.

Run the tests in the order of definition.  We can reorder them like that
because they are independent.  Technically this changes the output, but
retains the meaning of a full run and allows for easier review e.g. with
diff option --ignore-all-space.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-reftable-basics.c | 228 ++++++++++++++-----------------
 1 file changed, 106 insertions(+), 122 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-ba=
sics.c
index 4e80bdf16d..1dd60ab5f0 100644
=2D-- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -20,141 +20,125 @@ static int integer_needle_lesseq(size_t i, void *_ar=
gs)
 	return args->needle <=3D args->haystack[i];
 }

-static void test_binsearch(void)
+int cmd_main(int argc, const char *argv[])
 {
-	int haystack[] =3D { 2, 4, 6, 8, 10 };
-	struct {
-		int needle;
-		size_t expected_idx;
-	} testcases[] =3D {
-		{-9000, 0},
-		{-1, 0},
-		{0, 0},
-		{2, 0},
-		{3, 1},
-		{4, 1},
-		{7, 3},
-		{9, 4},
-		{10, 4},
-		{11, 5},
-		{9000, 5},
-	};
-
-	for (size_t i =3D 0; i < ARRAY_SIZE(testcases); i++) {
-		struct integer_needle_lesseq_args args =3D {
-			.haystack =3D haystack,
-			.needle =3D testcases[i].needle,
+	if_test ("binary search with binsearch works") {
+		int haystack[] =3D { 2, 4, 6, 8, 10 };
+		struct {
+			int needle;
+			size_t expected_idx;
+		} testcases[] =3D {
+			{-9000, 0},
+			{-1, 0},
+			{0, 0},
+			{2, 0},
+			{3, 1},
+			{4, 1},
+			{7, 3},
+			{9, 4},
+			{10, 4},
+			{11, 5},
+			{9000, 5},
 		};
-		size_t idx;

-		idx =3D binsearch(ARRAY_SIZE(haystack), &integer_needle_lesseq, &args);
-		check_int(idx, =3D=3D, testcases[i].expected_idx);
+		for (size_t i =3D 0; i < ARRAY_SIZE(testcases); i++) {
+			struct integer_needle_lesseq_args args =3D {
+				.haystack =3D haystack,
+				.needle =3D testcases[i].needle,
+			};
+			size_t idx;
+
+			idx =3D binsearch(ARRAY_SIZE(haystack),
+					&integer_needle_lesseq, &args);
+			check_int(idx, =3D=3D, testcases[i].expected_idx);
+		}
 	}
-}

-static void test_names_length(void)
-{
-	const char *a[] =3D { "a", "b", NULL };
-	check_int(names_length(a), =3D=3D, 2);
-}
-
-static void test_names_equal(void)
-{
-	const char *a[] =3D { "a", "b", "c", NULL };
-	const char *b[] =3D { "a", "b", "d", NULL };
-	const char *c[] =3D { "a", "b", NULL };
+	if_test ("names_length retuns size of a NULL-terminated string array") {
+		const char *a[] =3D { "a", "b", NULL };
+		check_int(names_length(a), =3D=3D, 2);
+	}

-	check(names_equal(a, a));
-	check(!names_equal(a, b));
-	check(!names_equal(a, c));
-}
+	if_test ("names_equal compares NULL-terminated string arrays") {
+		const char *a[] =3D { "a", "b", "c", NULL };
+		const char *b[] =3D { "a", "b", "d", NULL };
+		const char *c[] =3D { "a", "b", NULL };

-static void test_parse_names_normal(void)
-{
-	char in1[] =3D "line\n";
-	char in2[] =3D "a\nb\nc";
-	char **out =3D NULL;
-	parse_names(in1, strlen(in1), &out);
-	check_str(out[0], "line");
-	check(!out[1]);
-	free_names(out);
-
-	parse_names(in2, strlen(in2), &out);
-	check_str(out[0], "a");
-	check_str(out[1], "b");
-	check_str(out[2], "c");
-	check(!out[3]);
-	free_names(out);
-}
+		check(names_equal(a, a));
+		check(!names_equal(a, b));
+		check(!names_equal(a, c));
+	}

-static void test_parse_names_drop_empty(void)
-{
-	char in[] =3D "a\n\nb\n";
-	char **out =3D NULL;
-	parse_names(in, strlen(in), &out);
-	check_str(out[0], "a");
-	/* simply '\n' should be dropped as empty string */
-	check_str(out[1], "b");
-	check(!out[2]);
-	free_names(out);
-}
+	if_test ("parse_names works for basic input") {
+		char in1[] =3D "line\n";
+		char in2[] =3D "a\nb\nc";
+		char **out =3D NULL;
+		parse_names(in1, strlen(in1), &out);
+		check_str(out[0], "line");
+		check(!out[1]);
+		free_names(out);
+
+		parse_names(in2, strlen(in2), &out);
+		check_str(out[0], "a");
+		check_str(out[1], "b");
+		check_str(out[2], "c");
+		check(!out[3]);
+		free_names(out);
+	}

-static void test_common_prefix(void)
-{
-	struct strbuf a =3D STRBUF_INIT;
-	struct strbuf b =3D STRBUF_INIT;
-	struct {
-		const char *a, *b;
-		int want;
-	} cases[] =3D {
-		{"abcdef", "abc", 3},
-		{ "abc", "ab", 2 },
-		{ "", "abc", 0 },
-		{ "abc", "abd", 2 },
-		{ "abc", "pqr", 0 },
-	};
-
-	for (size_t i =3D 0; i < ARRAY_SIZE(cases); i++) {
-		strbuf_addstr(&a, cases[i].a);
-		strbuf_addstr(&b, cases[i].b);
-		check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
-		strbuf_reset(&a);
-		strbuf_reset(&b);
+	if_test ("parse_names drops empty string") {
+		char in[] =3D "a\n\nb\n";
+		char **out =3D NULL;
+		parse_names(in, strlen(in), &out);
+		check_str(out[0], "a");
+		/* simply '\n' should be dropped as empty string */
+		check_str(out[1], "b");
+		check(!out[2]);
+		free_names(out);
 	}
-	strbuf_release(&a);
-	strbuf_release(&b);
-}

-static void test_u24_roundtrip(void)
-{
-	uint32_t in =3D 0x112233;
-	uint8_t dest[3];
-	uint32_t out;
-	put_be24(dest, in);
-	out =3D get_be24(dest);
-	check_int(in, =3D=3D, out);
-}
+	if_test ("common_prefix_size works") {
+		struct strbuf a =3D STRBUF_INIT;
+		struct strbuf b =3D STRBUF_INIT;
+		struct {
+			const char *a, *b;
+			int want;
+		} cases[] =3D {
+			{"abcdef", "abc", 3},
+			{ "abc", "ab", 2 },
+			{ "", "abc", 0 },
+			{ "abc", "abd", 2 },
+			{ "abc", "pqr", 0 },
+		};

-static void test_u16_roundtrip(void)
-{
-	uint32_t in =3D 0xfef1;
-	uint8_t dest[3];
-	uint32_t out;
-	put_be16(dest, in);
-	out =3D get_be16(dest);
-	check_int(in, =3D=3D, out);
-}
+		for (size_t i =3D 0; i < ARRAY_SIZE(cases); i++) {
+			strbuf_addstr(&a, cases[i].a);
+			strbuf_addstr(&b, cases[i].b);
+			check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
+			strbuf_reset(&a);
+			strbuf_reset(&b);
+		}
+		strbuf_release(&a);
+		strbuf_release(&b);
+	}

-int cmd_main(int argc, const char *argv[])
-{
-	TEST(test_common_prefix(), "common_prefix_size works");
-	TEST(test_parse_names_normal(), "parse_names works for basic input");
-	TEST(test_parse_names_drop_empty(), "parse_names drops empty string");
-	TEST(test_binsearch(), "binary search with binsearch works");
-	TEST(test_names_length(), "names_length retuns size of a NULL-terminated=
 string array");
-	TEST(test_names_equal(), "names_equal compares NULL-terminated string ar=
rays");
-	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
-	TEST(test_u16_roundtrip(), "put_be16 and get_be16 work");
+	if_test ("put_be24 and get_be24 work") {
+		uint32_t in =3D 0x112233;
+		uint8_t dest[3];
+		uint32_t out;
+		put_be24(dest, in);
+		out =3D get_be24(dest);
+		check_int(in, =3D=3D, out);
+	}
+
+	if_test ("put_be16 and get_be16 work") {
+		uint32_t in =3D 0xfef1;
+		uint8_t dest[3];
+		uint32_t out;
+		put_be16(dest, in);
+		out =3D get_be16(dest);
+		check_int(in, =3D=3D, out);
+	}

 	return test_done();
 }
=2D-
2.46.0
