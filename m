Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65545134AC
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832904; cv=none; b=bs7o2oqAtsiGq/Xf49KKxAO4Ww/7j/Hf3m5L6oki9cMbA2I3hb6cDStKcSnuWhlX+PkMVN6FKFU38KVXRyCUOUExegtr48dIHvSFCP7/UsDZwdGB07/mjkfRtCb+iBMNggK5wkDgXu6IiqmBDJqyCtrTLWa59HIbXDHLr+4cQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832904; c=relaxed/simple;
	bh=6/zvWS+uE6ktrh+krjLd4/FgIGdgDm4NxCPScVMw+to=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sbGAueEERMf99jeRjnPg25/A4835UcxKJHl2dCOBgnWwqqmaVTd1qzujfFbp9xn5euQXyID9rbn5QfQvuhNlti83JGrtBnRfCQ2PH26vXKvyIxltXn2dGqATwHRJyIVWMudSlcpqG3TF18f6r/PsCyDAR975mPZHdOY3d7ZJzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YKJIQVW2; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YKJIQVW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832892; x=1722437692; i=l.s.r@web.de;
	bh=TLZAFtLvqkXdr4Vzjeyfun4VV8Y4MioPLDGDzJv46+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YKJIQVW21LLfA6BGwT+PILr9klaIX0Z+YE6HTKdOMU1VK9q0AtiqNehIGH0mFqID
	 6nj8XbIBc72mrpxnwXqRbYpqEFEtnEN/yIWFnm6r4myZgKsAzbDzh9ahGsRE377BN
	 E3E0zV5RBWNF6r5O4Rhn74gbtS7zOvBGFLAq47ayqVN8cGWsx/RTeu6o8C849/TdK
	 SJiIyRjAz9Fuox5lURznmHoSK/Mu55akU3kxp/BsL/TNfB7lRLCtoNMGn+pq0F7nP
	 AOyzjsfKSNM/V4njmeqogwoJqfQ5mI/LAJ2X08QC3zLtBfzwBGo4Yhkt/uw+UsxsK
	 R2stmdTXhxwPlAWLUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPvm-1sJ6701yKE-00zUsz; Wed, 24
 Jul 2024 16:54:52 +0200
Message-ID: <89c04cd4-11da-46cf-a061-b2e4ba09b99e@web.de>
Date: Wed, 24 Jul 2024 16:54:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 6/7] t-strvec: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Language: en-US
In-Reply-To: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k+ggB/jRcuhrFxA/N0rIeeS9vmzISBMqIx8yyaETnEN0A25f7ns
 /u67K8K/XaFFD8ITHT3dRj5fjn8ZpnKHpBanrT8uPaBxbJfrhaHDd24iCtXwDa1iCWZJvI5
 QZD8XYz4DM/v/h7M0FuKhg1oNaERIjHZp2LyjPvRik4+H8iw6vHUGNNnP8nhSlFSNg+QOF5
 8Es3Nv29cAmtUfyGE1/Lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y+/s8tI8TYE=;fuoXKOQAGR17GJtPuuWKVA9oBSU
 CNwJN502ecJrhpqaj2UjVaZEQspzRD/Cb9s2XgglZ5urMEol6gK2VmTFLhaArTvUF1D5rBAjQ
 TCfG/wUp/w9zIrB04+mTE3zQ+iDINakuKEj2agdr4L+zaPm6NTJHVRIOXVAnCxc20BITgqRSM
 yb3+sJWtvCEzX2TVEIJV1eTz/awnEi3FM+kkJl1up7RmvBSiVTmpc4mNodnGuctFH5td6cvmU
 h+oP7falBDeUQ6WdlQht7zKZgrnRYh5lnejWu+KEAxOgYO8z9/CDeNAiuvt6GjqtreETjFTxx
 a8XOmJ+CZeihQjMRibQBiFU5vtUvivziOVpePfl9xnbIS1BHz9j/HEaeLJ+xwwFu+eCjuk1rN
 sOgOFbRlhnEsR/y9Y636lR9FW8HXdZkim3lgtudKGIvY4t+hvqtlOwgCHxjj5b8pkb/VnxQAQ
 Z9ogZwNruoMMgNFBS7jptFxOa2joQ37CYDr2tUCKjJ6316Y2uGq9tBKBV4hN4bc45qUlEL7Lq
 T9DBGYa9MWr8DYmUbb0ebsMqNKKHGXBf9A7y3S6XrWLmB6KSQPyZ1f+ZYFXfQ02NL6jJjaqi1
 bZZfLIAybmdMJLeTrZx5g58tROg7Evv1nvC2oLT6P16oSgv5nlhL+djcLTen1Cz1QkvICfD4S
 OhzyiqfBhzMTUI5ele5zZmtWruG1XnsY8Aw/YMwfq2M8eIEJggWTzItynMgh+FVo2KsEqQoC6
 6CWkKdk4P3RwWkxECkcKmya3+foV24xSHvRp6G/JdUgkCPDutip89K1kqIAqAvlIoHzroznmB
 x8HO5OOlfWH0WClH53RDgdfg==

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.

Remove the cognitive overhead of defining and calling single-use
functions by using for_test instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-strvec.c | 356 ++++++++++++++++++----------------------
 1 file changed, 156 insertions(+), 200 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index d4615ab06d..4fa2c21afb 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -36,237 +36,193 @@ static void check_strvec_loc(const char *loc, struct=
 strvec *vec, ...)
 	check_pointer_eq(vec->v[nr], NULL);
 }

-static void t_static_init(void)
+int cmd_main(int argc, const char **argv)
 {
-	struct strvec vec =3D STRVEC_INIT;
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
-}
+	for_test ("static initialization") {
+		struct strvec vec =3D STRVEC_INIT;
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);
+	}

-static void t_dynamic_init(void)
-{
-	struct strvec vec;
-	strvec_init(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
-}
+	for_test ("dynamic initialization") {
+		struct strvec vec;
+		strvec_init(&vec);
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);
+	}

-static void t_clear(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_push(&vec, "foo");
-	strvec_clear(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
-}
+	for_test ("clear") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_push(&vec, "foo");
+		strvec_clear(&vec);
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);
+	}

-static void t_push(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
+	for_test ("push") {
+		struct strvec vec =3D STRVEC_INIT;

-	strvec_push(&vec, "foo");
-	check_strvec(&vec, "foo", NULL);
+		strvec_push(&vec, "foo");
+		check_strvec(&vec, "foo", NULL);

-	strvec_push(&vec, "bar");
-	check_strvec(&vec, "foo", "bar", NULL);
+		strvec_push(&vec, "bar");
+		check_strvec(&vec, "foo", "bar", NULL);

-	strvec_clear(&vec);
-}
+		strvec_clear(&vec);
+	}

-static void t_pushf(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushf(&vec, "foo: %d", 1);
-	check_strvec(&vec, "foo: 1", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("pushf") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushf(&vec, "foo: %d", 1);
+		check_strvec(&vec, "foo: 1", NULL);
+		strvec_clear(&vec);
+	}

-static void t_pushl(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	check_strvec(&vec, "foo", "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("pushl") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		check_strvec(&vec, "foo", "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_pushv(void)
-{
-	const char *strings[] =3D {
-		"foo", "bar", "baz", NULL,
-	};
-	struct strvec vec =3D STRVEC_INIT;
+	for_test ("pushv") {
+		const char *strings[] =3D {
+			"foo", "bar", "baz", NULL,
+		};
+		struct strvec vec =3D STRVEC_INIT;

-	strvec_pushv(&vec, strings);
-	check_strvec(&vec, "foo", "bar", "baz", NULL);
+		strvec_pushv(&vec, strings);
+		check_strvec(&vec, "foo", "bar", "baz", NULL);

-	strvec_clear(&vec);
-}
+		strvec_clear(&vec);
+	}

-static void t_replace_at_head(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_replace(&vec, 0, "replaced");
-	check_strvec(&vec, "replaced", "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("replace at head") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_replace(&vec, 0, "replaced");
+		check_strvec(&vec, "replaced", "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_replace_at_tail(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_replace(&vec, 2, "replaced");
-	check_strvec(&vec, "foo", "bar", "replaced", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("replace at tail") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_replace(&vec, 2, "replaced");
+		check_strvec(&vec, "foo", "bar", "replaced", NULL);
+		strvec_clear(&vec);
+	}

-static void t_replace_in_between(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_replace(&vec, 1, "replaced");
-	check_strvec(&vec, "foo", "replaced", "baz", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("replace in between") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_replace(&vec, 1, "replaced");
+		check_strvec(&vec, "foo", "replaced", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_replace_with_substring(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", NULL);
-	strvec_replace(&vec, 0, vec.v[0] + 1);
-	check_strvec(&vec, "oo", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("replace with substring") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", NULL);
+		strvec_replace(&vec, 0, vec.v[0] + 1);
+		check_strvec(&vec, "oo", NULL);
+		strvec_clear(&vec);
+	}

-static void t_remove_at_head(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_remove(&vec, 0);
-	check_strvec(&vec, "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("remove at head") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_remove(&vec, 0);
+		check_strvec(&vec, "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_remove_at_tail(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_remove(&vec, 2);
-	check_strvec(&vec, "foo", "bar", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("remove at tail") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_remove(&vec, 2);
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_remove_in_between(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_remove(&vec, 1);
-	check_strvec(&vec, "foo", "baz", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("remove in between") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_remove(&vec, 1);
+		check_strvec(&vec, "foo", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_pop_empty_array(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pop(&vec);
-	check_strvec(&vec, NULL);
-	strvec_clear(&vec);
-}
+	for_test ("pop with empty array") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pop(&vec);
+		check_strvec(&vec, NULL);
+		strvec_clear(&vec);
+	}

-static void t_pop_non_empty_array(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_pop(&vec);
-	check_strvec(&vec, "foo", "bar", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("pop with non-empty array") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_pop(&vec);
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_empty_string(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "");
-	check_strvec(&vec, NULL);
-	strvec_clear(&vec);
-}
+	for_test ("split empty string") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "");
+		check_strvec(&vec, NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_single_item(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "foo");
-	check_strvec(&vec, "foo", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("split single item") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo");
+		check_strvec(&vec, "foo", NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_multiple_items(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "foo bar baz");
-	check_strvec(&vec, "foo", "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("split multiple items") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo bar baz");
+		check_strvec(&vec, "foo", "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_whitespace_only(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, " \t\n");
-	check_strvec(&vec, NULL);
-	strvec_clear(&vec);
-}
+	for_test ("split whitespace only") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, " \t\n");
+		check_strvec(&vec, NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_multiple_consecutive_whitespaces(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "foo\n\t bar");
-	check_strvec(&vec, "foo", "bar", NULL);
-	strvec_clear(&vec);
-}
+	for_test ("split multiple consecutive whitespaces") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo\n\t bar");
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_detach(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	const char **detached;
+	for_test ("detach") {
+		struct strvec vec =3D STRVEC_INIT;
+		const char **detached;

-	strvec_push(&vec, "foo");
+		strvec_push(&vec, "foo");

-	detached =3D strvec_detach(&vec);
-	check_str(detached[0], "foo");
-	check_pointer_eq(detached[1], NULL);
+		detached =3D strvec_detach(&vec);
+		check_str(detached[0], "foo");
+		check_pointer_eq(detached[1], NULL);

-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);

-	free((char *) detached[0]);
-	free(detached);
-}
+		free((char *) detached[0]);
+		free(detached);
+	}

-int cmd_main(int argc, const char **argv)
-{
-	TEST(t_static_init(), "static initialization");
-	TEST(t_dynamic_init(), "dynamic initialization");
-	TEST(t_clear(), "clear");
-	TEST(t_push(), "push");
-	TEST(t_pushf(), "pushf");
-	TEST(t_pushl(), "pushl");
-	TEST(t_pushv(), "pushv");
-	TEST(t_replace_at_head(), "replace at head");
-	TEST(t_replace_in_between(), "replace in between");
-	TEST(t_replace_at_tail(), "replace at tail");
-	TEST(t_replace_with_substring(), "replace with substring");
-	TEST(t_remove_at_head(), "remove at head");
-	TEST(t_remove_in_between(), "remove in between");
-	TEST(t_remove_at_tail(), "remove at tail");
-	TEST(t_pop_empty_array(), "pop with empty array");
-	TEST(t_pop_non_empty_array(), "pop with non-empty array");
-	TEST(t_split_empty_string(), "split empty string");
-	TEST(t_split_single_item(), "split single item");
-	TEST(t_split_multiple_items(), "split multiple items");
-	TEST(t_split_whitespace_only(), "split whitespace only");
-	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecu=
tive whitespaces");
-	TEST(t_detach(), "detach");
 	return test_done();
 }
=2D-
2.45.2
