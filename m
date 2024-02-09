Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E57B3D2
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501485; cv=none; b=HO8GhyeQ8pzgN+jYpWKmQKBRDeqsXim3lEFsCo+k6ZNNZeO/LNltEANJxO1pscdYiU1nHxweIRH8COC7i4NLOMdyvvBqjmFk1IMSeBWAwVUET7bGaJIqGcPXssXBCN2yvVf05W4nGm48lJCWJFf/PoN4l63N8dxYJU4VBRz0uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501485; c=relaxed/simple;
	bh=eyWOjdeHqfeqUCPMRzTnFKpGsUcya0nwtPdHmDV23fI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8ulqq7TH0IwaezQhGLicQp4i6gSVFadvnX804AUOcYCPE+Go0OvbPrm9Amb5rX4/xga9mb9EerdDoWqHsVzgSsqj8oGJzIL2EbflamUu9eknwTlsJ4FCLtqZjCFZh7fdd+WJQJ4b8E/hG0GVRUbeDieZigSP5dJ509Ww625qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gu5YjI1V; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gu5YjI1V"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 241301DA562;
	Fri,  9 Feb 2024 12:58:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eyWOjdeHqfeq
	UCPMRzTnFKpGsUcya0nwtPdHmDV23fI=; b=Gu5YjI1VO+RIL/IFLtaSRsPfVdyu
	N+8+FbvX2x+mr28JQFwnbSeYi4b5yKJh6VffQAqbMkSYeYVQQNzkQ4IxakvzsPsB
	VPC27Dmw3CcXPlfj+WHJPcAyUhp1JK+4smQdURTEppAf2d5TkldiglHRPzWnd11K
	IiymaExzdxYYAPg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A20F1DA561;
	Fri,  9 Feb 2024 12:58:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 786DD1DA55E;
	Fri,  9 Feb 2024 12:58:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Tiago Pascoal" <tiago@pascoal.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: git column fails (or crashes) if padding is negative
In-Reply-To: <571fb353-af1d-4cc9-a2c2-197296685623@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 09 Feb 2024 17:27:59 +0100")
References: <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
	<571fb353-af1d-4cc9-a2c2-197296685623@app.fastmail.com>
Date: Fri, 09 Feb 2024 09:57:59 -0800
Message-ID: <xmqqttmhfrko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C37FBFDA-C774-11EE-8B07-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> ```
> $ seq 1 24 | git column --mode=3Dcolumn --padding=3D-1
> 12345678910<binary?><numbers>
> $ seq 1 24 | git column --mode=3Dcolumn --padding=3D-3
> fatal: Data too large to fit into virtual memory space.
> $ seq 1 24 | git column --mode=3Dcolumn --padding=3D-5
> fatal: Out of memory, malloc failed (tried to allocate 1844674407370955=
1614 bytes)
> ```
>
> This is an =E2=80=9CInternal helper command=E2=80=9D under the =E2=80=9C=
plumbing=E2=80=9D suite. And I
> get the impression that sometimes these fallthroughs are treated as
> =E2=80=9Cdon=E2=80=99t do that=E2=80=9D. But I don=E2=80=99t know.

If the nonsense input is easy to tell, then telling "don't feed
nonsense input" to the user while rejecting such nonsense input
would be a good idea.

> On the other hand it failing inside malloc looks weird. Why not catch
> this before the malloc call is made?

Presumably, the parameter we prepare before calling malloc() is of
unsigned type, and feeding a negative value to such a callchain
would cast it to a large unsigned value?

Indeed, whereever cops.padding is referenced in column.c, it clearly
is assumed that it is a non-negative value.  *width accumulates the
width of data items plus padding, and it also is used to divide some
number to arrive at the number of columns, so by tweaking the padding
to the right value, you probably should be able to cause division by
zero, too, in column.c:layout().

Hopefully the attached would be a good place to start (I am not
going to finish it with log message, tests, and fixes to other
places).

 builtin/column.c | 2 ++
 column.c         | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git c/builtin/column.c w/builtin/column.c
index e80218f81f..8537d09d2b 100644
--- c/builtin/column.c
+++ w/builtin/column.c
@@ -45,6 +45,8 @@ int cmd_column(int argc, const char **argv, const char =
*prefix)
 	memset(&copts, 0, sizeof(copts));
 	copts.padding =3D 1;
 	argc =3D parse_options(argc, argv, prefix, options, builtin_column_usag=
e, 0);
+	if (copts.padding < 0)
+		die(_("--padding must be non-negative"));
 	if (argc)
 		usage_with_options(builtin_column_usage, options);
 	if (real_command || command) {
diff --git c/column.c w/column.c
index ff2f0abf39..9cc703832a 100644
--- c/column.c
+++ w/column.c
@@ -189,7 +189,7 @@ void print_columns(const struct string_list *list, un=
signed int colopts,
 	memset(&nopts, 0, sizeof(nopts));
 	nopts.indent =3D opts && opts->indent ? opts->indent : "";
 	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";
-	nopts.padding =3D opts ? opts->padding : 1;
+	nopts.padding =3D (opts && 0 < opts->padding) ? opts->padding : 1;
 	nopts.width =3D opts && opts->width ? opts->width : term_columns() - 1;
 	if (!column_active(colopts)) {
 		display_plain(list, "", "\n");
@@ -373,7 +373,7 @@ int run_column_filter(int colopts, const struct colum=
n_options *opts)
 		strvec_pushf(argv, "--width=3D%d", opts->width);
 	if (opts && opts->indent)
 		strvec_pushf(argv, "--indent=3D%s", opts->indent);
-	if (opts && opts->padding)
+	if (opts && 0 < opts->padding)
 		strvec_pushf(argv, "--padding=3D%d", opts->padding);
=20
 	fflush(stdout);
