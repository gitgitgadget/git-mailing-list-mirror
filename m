Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021921518C
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419790; cv=none; b=gtw/QjcxwJ9UrnAzhyTEp0XtwVvCbdeTfWGOuhuqFkmSbolT7cK61d4b2zO09G5dVp6FN8vVoROx0qvbbs6EmtXaDELGK4S5MBq5p/fym7gIAdB/p3cRbqwOUTcevQBj12inOh3V2AG2TQpaa23G4VWuTq1LcH82LREtso7dRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419790; c=relaxed/simple;
	bh=Slq6JuqNsvB8/5HKNUHOf6nwHkl5FiCmNj6/XpFG530=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wi+PETbLmv/VizZe69bs0U+qKgCHkVT330FYhm/SZXZNLr9k6AsM7ip6eewNk32TkGUjai9FvoxOdhFJuemY0i+rfjv+tx4Gnz7sASCsziMqnNFHXicTcZqTnbPlpLzyjlIws6aaFGu35D8YmGLy2aQAL2d9i7QHAVwXsfgMId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=GKZXP+VZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="GKZXP+VZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736419783; x=1737024583;
	i=johannes.schindelin@gmx.de;
	bh=EAsXzYyyjS3g+tGcq7sy4l2xBRvFT6YEMpEsSqjN9R0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GKZXP+VZeiW+7cKUKMqfLefRJjCQI6Kv81UkcotTWXDDoQD5hVafIeOzts/z6YXg
	 HlQHImV0opdRsrhuRfzVcuUbhUwKmRCj4GOHhQNj7H4aOcpZIW+8CEft7F3Uj9OrH
	 koVHyJR17DnERmW+L+R1uEDgyMJ7vuh+G3PJjTXAHP5HqM7ZKShG3IiC0yhb6koiv
	 I3krgnHKqnx7w73Bj3l3QeUUmlVR5FfnOUGx9B+A2Cu7nzWU46fXcYgEH/M2aw7yx
	 SZgWFmu1D1VaDfEKXl+/5t7p4xWuFc0vkSS++VeBAZcLXCxCtsJvJ22ycslkhRnMS
	 xsbilGiR7T69qrR4bQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1t4NbX1Uzk-00NIP9; Thu, 09
 Jan 2025 11:49:43 +0100
Date: Thu, 9 Jan 2025 11:49:43 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
In-Reply-To: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
Message-ID: <c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OKZXtI12YPncFKiHsRMeqUrtqPAikiUO2jZn/XzHL0TbfRUdHg1
 wwRj2cKVPEZ54+Ec/HuzVcyxDbXxtgS1b8kVslfoMXEFNRO+bSVzG3OvcjMFpFfC2OlZg+Y
 8uueCSZk6i6zHsD9sE9++afro6hItHQTr5gxdMlBEenD5ZzBtazRNZxZC+gyb8nBXS12YY+
 v758vYsJ/VsxVEHnHD8lQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:40geR9d8I28=;abVSoaukxQxWG2wloWeEZCcqZgC
 C7XGzVLDCDOXlxpqWrk6t7LEV7sAbPgCKbCWKvrD8rfpUH1RHpUmRWLcWTLQ0Bfp7o56eYdrK
 8nB7si/vivKuJIHD2AKZatXaRDRs/6MAONEJqUi2h9vOquBiWSWCEZW9a52dHhoLfzWDptbk9
 d27uMX0dFjVFyrag57tT2Cafm40HblXSUs0RPuSsyc5XR4CgHTR48+IpXshw5plpML79Egkze
 Ahq74UDU5kmiCMRlXn+v0nmG7M+RIMyD4ybyDWJqocRFpAjzfqTx2Kz6iVdzGrx4GHZ47RxWc
 OmiOVfTQD8VmZb371dFUfYAvToIoDwvCEnGZnUkxCpNv+JyB6aWG9oX04zLugOHR7iGXL1JJ0
 54KjALd0f/gNn9nX2Ep6ho4PMMPq4kMWEGzbRq1YUXC+8zcHhn3E4R0Nhm9fVGKgQgoMdjvvL
 pR7X+E/zo586LdlfUAmPt4EQ6UClkXT4U/Qz2krz9UzQTh0kZeNl4PlSWbIpZjtv5uZqW0XXj
 ta/WiC7A+D36NifUOSuY1WN0rNSuvjDBoH+dIkUMtMBTBKbzcEezvzK/tQMwA+KHIBpyI2Sn9
 IwdKkOYJ4tpO+gwtzBPeV5mhdZGiXU+XYTdMhOkUEhvtbGKVmxmf6QjXToZhKKDGLyn/8j11n
 MvgLQzHj/NuhrZ2tMjDhDiTMu6E0k3eHvPe5CoUoHo8Layko3iR2OnafAV/fdTyDXdhbMcmbk
 aMXnNj+bLrsJYBswId7rSzShaH4ymc6xIYsnfkVuAeESwvy9tle7R9Bc1PaOP9wTn7gVJkwMO
 860idK6975KSWVHHJpi1VW8XRNy1NnbYhqrl9CfQc9L0m6MK/FYgGzoEQoaZHiig8e1oNjV/f
 HHpczeSmgXJzPoE45AwvcPzO5UreUT9NSTU0dNoKm9ftB06NuLwddLNQNVJBKoc7bZrK4BOGy
 paQr+poP71QRWMlFDlaDE7lwcZhUo4Wkq694WoQgoZEAUQs91lmB66iT/a1JK7V35CFk7AHeA
 Sq5WHGUp6U8DEC5s6JjLeK3puW8JeHb5OQRnc5mt2U65D2iwTf/v7+uDxo3u34ipRGE8faYFS
 NSz0hWZBU=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 9 Jan 2025, Patrick Steinhardt wrote:

> In 6411a0a896 (builtin/blame: fix type of `length` variable when
> emitting object ID, 2024-12-06) we have fixed the type of the `length`
> variable. In order to avoid a cast from `size_t` to `int` in the call to
> printf(3p) with the "%.*s" formatter we have converted the code to
> instead use fwrite(3p), which accepts the length as a `size_t`.
>
> It was reported though that this makes us read over the end of the OID
> array when the provided `--abbrev=3D` length exceeds the length of the
> object ID. This is because fwrite(3p) of course doesn't stop when it
> sees a NUL byte, where as printf(3p) does.
>
> Fix the bug by reverting back to printf(3p) and culling the provided
> length to `GIT_MAX_HEXSZ` to keep it from overflowing when cast to an
> `int`.
>
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> This fixes the issue reported in [1]. Thanks!

Thank you for the quick fix! We will need to adjust it a little more,
though:

>
> Patrick
>
> [1]: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
> ---
>  builtin/blame.c  | 4 +++-
>  t/t8002-blame.sh | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 867032e4c16878ffd56df8a73162b89ca4bd2694..ad91fe9e97f90625dd2708fb=
d44bf2dd24a337a6 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -475,6 +475,8 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent, int
>  		char ch;
>  		size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
>  			the_hash_algo->hexsz : (size_t) abbrev;
> +		if (length > GIT_MAX_HEXSZ)
> +			length =3D GIT_MAX_HEXSZ;

This causes a subtle change of behavior because there are a couple of
conditional code blocks between this change and the `printf()` call
decrease `length`, i.e. specifying values larger than the maximal hex size
causes potentially-desirable, different behavior (and think about
https://www.hyrumslaw.com/).

>
>  		if (opt & OUTPUT_COLOR_LINE) {
>  			if (cnt > 0) {
> @@ -505,7 +507,7 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent, int
>  			length--;
>  			putchar('?');
>  		}
> -		fwrite(hex, 1, length, stdout);
> +		printf("%.*s", (int)length, hex);
>  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
>  			const char *name;
>  			if (opt & OUTPUT_SHOW_EMAIL)
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..fcaba8c11f7ede084e069eef=
d292f337e8396cb4 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbre=
v with full length' '
>  	check_abbrev $hexsz --no-abbrev
>  '
>
> +test_expect_success 'blame --abbrev gets truncated' '
> +	check_abbrev 9000 --abbrev=3D$hexsz HEAD

This is actually incorrect: it passes `--abbrev=3D$hexsz` instead of a val=
ue
that needs to be truncated.

> +'
> +
>  test_expect_success '--exclude-promisor-objects does not BUG-crash' '
>  	test_must_fail git blame --exclude-promisor-objects one
>  '
>
> ---
> base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
> change-id: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71

Here is my proposed fixup:

=2D- snipsnap --
[PATCH] fixup! builtin/blame: fix out-of-bounds read with excessive `--abb=
rev`

The test case needs to actually test an excessive `--abbrev` value.

Also, when calling `git blame --abbrev=3D<N>` with an `N` that is larger
than the maximal OID hex size, there is a subtle side effect that makes
it behave _differently_ than specifying said maximal hex size: When the
command outputs boundary, unblamable or ignored commits' OIDs, those
outputs are prefixed with characters indicating this, and the `abbrev`
value is used to align the information that comes after the OID,
clipping it as needed. Specifying a "too large" abbrev value here tells
Git that yes, we want the full OIDs and don't you worry about alignment.

Thanks to SHA-256 being _larger_ than the default SHA-1-based OIDs, and
thanks to clipping at `GIT_MAX_HEXSZ`, this change of behavior can only
be observed when running the test in SHA-256 mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/blame.c  | 9 +++++++--
 t/t8002-blame.sh | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ad91fe9e97f9..5b4976835066 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -475,8 +475,13 @@ static void emit_other(struct blame_scoreboard *sb, s=
truct blame_entry *ent, int
 		char ch;
 		size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
 			the_hash_algo->hexsz : (size_t) abbrev;
-		if (length > GIT_MAX_HEXSZ)
-			length =3D GIT_MAX_HEXSZ;
+
+		/*
+		 * Leave enough space for ^, * and ? indicators (boundary,
+		 * unblamable, ignored).
+		 */
+		if (length > GIT_MAX_HEXSZ + 3)
+			length =3D GIT_MAX_HEXSZ + 3;

 		if (opt & OUTPUT_COLOR_LINE) {
 			if (cnt > 0) {
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index fcaba8c11f7e..71fa70a64679 100755
=2D-- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -127,7 +127,7 @@ test_expect_success '--no-abbrev works like --abbrev w=
ith full length' '
 '

 test_expect_success 'blame --abbrev gets truncated' '
-	check_abbrev 9000 --abbrev=3D$hexsz HEAD
+	check_abbrev 9000 --abbrev=3D9000 HEAD..
 '

 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
=2D-
2.48.0.rc0.windows.1

