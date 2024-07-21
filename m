Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C9443D
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721543103; cv=none; b=nQQMHLj4jZNvCDE1evGLXqvK7XBXPU4LPPCCIu2HSmyyddEkyFN+oBB1wm1WPeW+FFWGyvR/odgwhjkVlRltvA0GLb3VAOQB3Mqk6nsIWWjDI7hUR/LL5TiUDqkNJAv0It9UdDii608s1kY75vM/9rTIp33II6PsmfM0VqC+DXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721543103; c=relaxed/simple;
	bh=6/zvWS+uE6ktrh+krjLd4/FgIGdgDm4NxCPScVMw+to=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k2tu16do2BK3wtPFmyJN9L0PLPX7EPpCnBTCULqmH0j/FLcGwu57nRhWqIPVrE2mg/0HYTvo4LBTG2uMS5UmH/jU2odPKGDwTi4oK68ycN35IXsyYA7yc8zGJ/XNUqx8Tos+Z5XtS+qMRfUe60QXVVjm7s2XlrpBVF7l62ltDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hzQWOLSD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hzQWOLSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721543091; x=1722147891; i=l.s.r@web.de;
	bh=TLZAFtLvqkXdr4Vzjeyfun4VV8Y4MioPLDGDzJv46+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hzQWOLSDeb5hlviK/RA3n44VJuxuhCSw8Dzbrbk8KS9jayS6lBZbNV2GiAmaSUOn
	 G9I8+iqlJ4LdgmHEA+6LFrHjdnrVmP4I7SH7UZ9jIBon3pVRAZ+wuWUJ+Yzi9pWO3
	 aGBS74o6UIBRjBbIVgLfLW0Jw7eXpIC/HMtlg0ceqcf5uZPF5+8oGqt1S51XUfgo0
	 MWlV5IjzjikVGU2GJDcgnq0VkeTRp8OWLO+6WMJhtHLZMFtPSHiM2ZmZOfmabxZNO
	 QrZ7n2WeOzye8koJ3rBo11hkStnirF5hibs9Y0EE14AVTaqVx8nSIfTfiy2HDL8B6
	 IiEG81RiQ66hAkYCVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LsH-1sL8J748OR-0117Qx; Sun, 21
 Jul 2024 08:24:51 +0200
Message-ID: <d64b0668-dbd2-411b-bc5c-19667a01b7d7@web.de>
Date: Sun, 21 Jul 2024 08:24:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/6] t-strvec: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Language: en-US
In-Reply-To: <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4z4cbeVK8P2sIkVrcvvnCfmIXTNWq+Ia4P0qmazFu3yGSqwcVg8
 ijN37PcZs4mL5XfxPbvga/R5vVk1Yu7fwAOKJ/uKV/O3g4A4vHOE4Fxa8vK8pMzbncn1Q3i
 DnDsoG6YwMwmYL0Q/5GcMa28PUUxmg12BpTyS4AoBZKKKmts5DUKwB8IuEiOllfOZgeXj2O
 0TBdIgxNl4DBauo/cA6GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GpmfmmDayLU=;/cLQ6nI7SWf0oa4CTn6AYofBkQo
 6iorh4r05mos8+9Dw0LKvucml7baiOjF62tiLyBq+fg3ONP5uYTCxZfmW8D51V1XL6//fjp+1
 y4p+qvj0hptGgjLKFoxJxXY3dS4XKf8fYVQDq9pw7G0fnqGnOMED2qCZqx4YqEAiUZbLtmjN5
 DQPRaSL94thyGbIzKc7ALmQWsB+mhGcDteh0Nwhp9bzlCaXPvLR2iXWdJn/WBUdVXvq9dX6EZ
 pELV3HL1WSWfCHU2Gku+ht9FTL8N6LgnC/rUEGYtCJF9B1LUfORjwUJRRe5A/+jXN7aoCjlhV
 0s6Uar0s9T5jWEUsXVEkg83O7wvIjIJT1j3vHUeFx0aNJ0/asMVE7vy0U8Jd3SIzNmes6qTgE
 wTt8oZuJEUSRoT9Y9mflwqmxgXu04kMyZp072PfYYw467XufmPAFAZ5WvFDH8Hy589FMutiqt
 +OugMC8OB/huNdT42wb/PrZwiEzkdeCkb/cYG0CxQKpm/XESJ3yGJZS3fH6yZPlowrLYTugpm
 CUavgSwbJNndvBWrNHP+m0BM6nhwXC2wm9aOH7RqEFQBaNQ2rL4IElao6kOZaR1O1dWOOH/Y5
 rKHgcXGirfX0XHJ2Lm3ssl6r6ZGjaV9GAJunaPQ0kjX5Vxl713vBESEMnUbFGp3nL8tzYkXBY
 vgaH4gVV6VDsk2Brf19W1MLQpV3NJ2jdqo9PrzCK24kD9uDLr0ak1p+aCRsMBm7x4EZn9dkWM
 8UWXpknaL5M8N/uNsw89SoXk3o4yynA6QXsnZqHjVTPxMslz4mJ7OsDCnxJB7befeaNOyOHHE
 WmMLK2ndXodS9PhztadDPsYQ==

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
