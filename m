Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF8309F00
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560402; cv=none; b=dPQaSIP/JbNxuY/BVXlvGvzst0YKmIlGK1fSGE7C6H89tKtqCnMEHB3mbOcM2fFCZ10+I2MtisB4qkcn/4g6i34/6/XGRdMAajq9RSi3NJ6vwTLpoTO7A2VIjhlKeyOZXE4BvuC4rAgnPS5ivaReN8VIGoDeuAZyZ1tBlgljyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560402; c=relaxed/simple;
	bh=plTVpnvJ9f12+iWPtOoFpCtVVlZHRbQE5ZG2x8lmac0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiiN/Qu0AALKUZI6/R2AoKtp6q1YMqFyhCCzN2lQ/vdT+PqX4sAVIl6UyklxjYDCqxT/xRqRRWmfnXhEICbOM0Ws1CbUa5rdUCk9wE65M82dZnaXeifdrslj+IZ1LCkbSAngjm9SH9XLepTZdeBg2sfMr/cxsMOHFQ5LiwF+XyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rMHnSEzE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rMHnSEzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781560388; x=1782165188; i=l.s.r@web.de;
	bh=4ho2S7SpNXqiw97WuHpxlUynNrrJJy+PFzhl1DikNYg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rMHnSEzE+dLKAEONUdo++jiO0dWqYpFg9fy6Stgig8O8B0/Vlq+iYlSPIEtUUpns
	 U2f8hhKwBKf6wj+o0zV4ExNNAsriSsn+XyfFstR9/R+SLUU/syclYRcU6wpqEYjnG
	 Ty5zi+BSVH7fqXagNVwrS7j9siCzPw54k+tHKXTlT8Z1iCSRgxfkWNA88AQ+bhy4E
	 +iPL/oujVPiA7jwioCfUs+5jYngRubkDfVFzaun/sojv3AzRf7AYdN5AbTCIO/E4r
	 1xKdZZRanDD3yZfKUtEms3PJvgMGjCfJ694g2XnrTO8r6C/GU29DI2vOPJEokBskb
	 N/+2lzFLQqD8ZDnY2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmvj-1x3sZY3vWZ-00npuX; Mon, 15
 Jun 2026 23:53:07 +0200
Message-ID: <10a33614-837f-4166-aa30-6de28b052692@web.de>
Date: Mon, 15 Jun 2026 23:53:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cat-file: speed up default format
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
 <20260615165326.GA91269@coredump.intra.peff.net>
 <20260615170652.GB91269@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260615170652.GB91269@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XoNZVVBFZCa1FSU/XOxNhxCAgMUup7yBE6+AJc1boKG24CNcNjW
 0z7wf2GD1EA/SIYefp7oIHHL68rLuZ9Veg2vDEc+jwYCVVf4JoFWes2Cdzm6xycQL22uxrj
 5J5hisUhSD8+PxJTFlb6p7/4BWcLiHeZPXbWNmomV8qLPbUeh0xMxJKxLp6VO0DOcDvS2CR
 pH9JzQO9fRmcLkLGb2DYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mheyPAMgNzU=;QtQCBAN4YLLc0TqwAJrYWnKH3mu
 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
 tBzNA2ZJiLU+UBPCTA=

On 6/15/26 7:06 PM, Jeff King wrote:
> On Mon, Jun 15, 2026 at 12:53:26PM -0400, Jeff King wrote:
>=20
>> It uses per-atom callback functions which is nice and clean, though we
>> might be able to do even better with a big ugly switch() statement.
>=20
> Being the curious sort, I swapped it out for a big switch statement.
> Patch below, but it does not seem to be any faster.
>=20
> So the bottom line is I think you could gain a little bit of performance
> by pre-parsing (versus strbuf_expand() on each object). Around 3% for
> something that actually looks at the objects, though more like 15% if
> for just dumping the objectnames.
>=20
> IMHO that is probably not worth it for a custom parsing system just for
> cat-file.  But if we were to finally unify ref-filter and cat-file (and
> even --pretty=3Dformat) then it would probably worth doing this kind of
> pre-parsing.
It could be worth it for cat-file alone if we find the right balance, as
it already does do a separate parsing step, but that is awkward with its
mark_query checks all over the place and remembers only object property
requirements and no other format string details.

Making the opcodes small should be beneficial.  We need only a handful
of them, so a byte each should suffice.  We can use a strbuf for that.

We can also store literal characters in there.  An opcode plus with a
payload char incurs an overhead of 50%, which sounds high, but at least
the default format only has two of them and it's much better than
storing pointer plus size for an overhead of more than 90% in case of a
single char.

That gets us closer to native speed, at least on an Apple M1:

Benchmark 1: ./git_fp cat-file --batch-all-objects --batch-check=3D'%(obje=
ctname)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):     992.7 ms =C2=B1   3.2 ms    [User: 967.5 =
ms, System: 23.8 ms]
  Range (min =E2=80=A6 max):   990.1 ms =E2=80=A6 1000.7 ms    10 runs

Benchmark 2: ./git_switch cat-file --batch-all-objects --batch-check=3D'%(=
objectname)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):     991.8 ms =C2=B1   1.6 ms    [User: 967.0 =
ms, System: 23.3 ms]
  Range (min =E2=80=A6 max):   989.3 ms =E2=80=A6 994.4 ms    10 runs

Benchmark 3: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):     985.8 ms =C2=B1   2.9 ms    [User: 960.5 =
ms, System: 23.6 ms]
  Range (min =E2=80=A6 max):   982.9 ms =E2=80=A6 993.0 ms    10 runs

Benchmark 4: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame) %(objecttype) %(objectsize)'
  Time (mean =C2=B1 =CF=83):     982.1 ms =C2=B1   3.2 ms    [User: 956.7 =
ms, System: 23.6 ms]
  Range (min =E2=80=A6 max):   979.2 ms =E2=80=A6 989.2 ms    10 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname) %(obje=
cttype) %(objectsize)' ran
    1.00 =C2=B1 0.00 times faster than ./git cat-file --batch-all-objects =
=2D-batch-check=3D'%(objectname)-%(objecttype)-%(objectsize)'
    1.01 =C2=B1 0.00 times faster than ./git_switch cat-file --batch-all-o=
bjects --batch-check=3D'%(objectname)-%(objecttype)-%(objectsize)'
    1.01 =C2=B1 0.00 times faster than ./git_fp cat-file --batch-all-objec=
ts --batch-check=3D'%(objectname)-%(objecttype)-%(objectsize)'


A Ryzen laptop gives me noisy numbers that seem to suggest your
switch-based code already won, but the more compact representation is at
least not worse:

Benchmark 1: ./git_fp cat-file --batch-all-objects --batch-check=3D'%(obje=
ctname)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):     397.5 ms =C2=B1   8.0 ms    [User: 326.9 =
ms, System: 39.4 ms]
  Range (min =E2=80=A6 max):   388.1 ms =E2=80=A6 410.0 ms    10 runs

Benchmark 2: ./git_switch cat-file --batch-all-objects --batch-check=3D'%(=
objectname)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):     388.2 ms =C2=B1   4.2 ms    [User: 318.2 =
ms, System: 39.2 ms]
  Range (min =E2=80=A6 max):   382.8 ms =E2=80=A6 395.7 ms    10 runs

Benchmark 3: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):     385.5 ms =C2=B1   5.7 ms    [User: 311.2 =
ms, System: 43.2 ms]
  Range (min =E2=80=A6 max):   377.0 ms =E2=80=A6 392.9 ms    10 runs

Benchmark 4: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame) %(objecttype) %(objectsize)'
  Time (mean =C2=B1 =CF=83):     397.5 ms =C2=B1   8.4 ms    [User: 321.9 =
ms, System: 45.2 ms]
  Range (min =E2=80=A6 max):   382.1 ms =E2=80=A6 406.5 ms    10 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname)-%(obje=
cttype)-%(objectsize)' ran
    1.01 =C2=B1 0.02 times faster than ./git_switch cat-file --batch-all-o=
bjects --batch-check=3D'%(objectname)-%(objecttype)-%(objectsize)'
    1.03 =C2=B1 0.03 times faster than ./git_fp cat-file --batch-all-objec=
ts --batch-check=3D'%(objectname)-%(objecttype)-%(objectsize)'
    1.03 =C2=B1 0.03 times faster than ./git cat-file --batch-all-objects =
=2D-batch-check=3D'%(objectname) %(objecttype) %(objectsize)'

Ren=C3=A9


diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0d1998784c..5667a13e93 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -36,8 +36,6 @@ enum batch_mode {
 	BATCH_MODE_QUEUE_AND_DISPATCH,
 };
=20
-struct format_item;
-
 struct batch_options {
 	struct list_objects_filter_options objects_filter;
 	int enabled;
@@ -50,7 +48,7 @@ struct batch_options {
 	char input_delim;
 	char output_delim;
 	const char *format;
-	struct format_item *parsed_format;
+	struct strbuf parsed_format;
 };
=20
 static const char *force_path;
@@ -320,30 +318,16 @@ struct expand_data {
 };
 #define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID }
=20
-struct format_item {
-	enum {
-		FORMAT_TYPE_END =3D 0,
-		FORMAT_TYPE_LITERAL,
-		FORMAT_TYPE_OBJECTNAME,
-		FORMAT_TYPE_OBJECTTYPE,
-		FORMAT_TYPE_OBJECTSIZE,
-		FORMAT_TYPE_OBJECTSIZE_DISK,
-		FORMAT_TYPE_REST,
-		FORMAT_TYPE_DELTABASE,
-		FORMAT_TYPE_OBJECTMODE,
-	} type;
-	union {
-		struct {
-			const char *p;
-			size_t len;
-		} literal;
-	} u;
-	/*
-	 * We could make a true tree here with child/next pointers, which would
-	 * be necessary if we had recursive formats, like %(if). But for our
-	 * simple formats for now it is enough to have a linear set of items,
-	 * so we'll just allocate an array and terminate it with a NULL entry.
-	 */
+
+enum item_type {
+	FORMAT_TYPE_LITERAL,
+	FORMAT_TYPE_OBJECTNAME,
+	FORMAT_TYPE_OBJECTTYPE,
+	FORMAT_TYPE_OBJECTSIZE,
+	FORMAT_TYPE_OBJECTSIZE_DISK,
+	FORMAT_TYPE_REST,
+	FORMAT_TYPE_DELTABASE,
+	FORMAT_TYPE_OBJECTMODE,
 };
=20
 static int is_atom(const char *atom, const char *s, int slen)
@@ -352,84 +336,66 @@ static int is_atom(const char *atom, const char *s, =
int slen)
 	return alen =3D=3D slen && !memcmp(atom, s, alen);
 }
=20
-static int parse_atom(struct format_item *fmt, const char *atom, int len,
+static int parse_atom(struct strbuf *parsed_format, const char *atom, int=
 len,
 		      struct expand_data *data)
 {
 	if (is_atom("objectname", atom, len)) {
-		fmt->type =3D FORMAT_TYPE_OBJECTNAME;
+		strbuf_addch(parsed_format, FORMAT_TYPE_OBJECTNAME);
 	} else if (is_atom("objecttype", atom, len)) {
 		data->info.typep =3D &data->type;
-		fmt->type =3D FORMAT_TYPE_OBJECTTYPE;
+		strbuf_addch(parsed_format, FORMAT_TYPE_OBJECTTYPE);
 	} else if (is_atom("objectsize", atom, len)) {
 		data->info.sizep =3D &data->size;
-		fmt->type =3D FORMAT_TYPE_OBJECTSIZE;
+		strbuf_addch(parsed_format, FORMAT_TYPE_OBJECTSIZE);
 	} else if (is_atom("objectsize:disk", atom, len)) {
 		data->info.disk_sizep =3D &data->disk_size;
-		fmt->type =3D FORMAT_TYPE_OBJECTSIZE_DISK;
+		strbuf_addch(parsed_format, FORMAT_TYPE_OBJECTSIZE_DISK);
 	} else if (is_atom("rest", atom, len)) {
 		data->split_on_whitespace =3D 1;
-		fmt->type =3D FORMAT_TYPE_REST;
+		strbuf_addch(parsed_format, FORMAT_TYPE_REST);
 	} else if (is_atom("deltabase", atom, len)) {
 		data->info.delta_base_oid =3D &data->delta_base_oid;
-		fmt->type =3D FORMAT_TYPE_DELTABASE;
+		strbuf_addch(parsed_format, FORMAT_TYPE_DELTABASE);
 	} else if (is_atom("objectmode", atom, len)) {
-		fmt->type =3D FORMAT_TYPE_OBJECTMODE;
+		strbuf_addch(parsed_format, FORMAT_TYPE_OBJECTMODE);
 	} else
 		return 0;
 	return 1;
 }
=20
-static struct format_item *parse_format(const char *start,
-					struct expand_data *data)
+static void parse_format(struct strbuf *parsed_format,
+			 const char *start, struct expand_data *data)
 {
-	struct format_item *ret =3D NULL;
-	size_t nr =3D 0, alloc =3D 0;
-
 	while (1) {
-		const char *percent =3D strchrnul(start, '%');
 		const char *end;
=20
-		if (percent !=3D start) {
-			ALLOC_GROW(ret, nr + 1, alloc);
-			ret[nr].type =3D FORMAT_TYPE_LITERAL;
-			ret[nr].u.literal.p =3D start;
-			ret[nr].u.literal.len =3D percent - start;
-			nr++;
+		while (*start && *start !=3D '%') {
+			strbuf_addch(parsed_format, FORMAT_TYPE_LITERAL);
+			strbuf_addch(parsed_format, *start++);
 		}
=20
-		if (!*percent)
+		if (!*start)
 			break;
=20
-		start =3D percent + 1;
+		start++;
=20
-		ALLOC_GROW(ret, nr + 1, alloc);
 		if (skip_prefix(start, "%", &start) || *start !=3D '(') {
-			ret[nr].type =3D FORMAT_TYPE_LITERAL;
-			ret[nr].u.literal.p =3D "%";
-			ret[nr].u.literal.len =3D 1;
+			strbuf_addch(parsed_format, FORMAT_TYPE_LITERAL);
+			strbuf_addch(parsed_format, '%');
 		} else if ((end =3D strchr(start + 1, ')')) &&
-			   parse_atom(&ret[nr], start + 1, end - start - 1, data)) {
+			   parse_atom(parsed_format, start + 1, end - start - 1, data)) {
 			start =3D end + 1;
 		} else {
 			strbuf_expand_bad_format(start, "cat-file");
 		}
-		nr++;
 	}
-
-	ALLOC_GROW(ret, nr + 1, alloc);
-	ret[nr].type =3D FORMAT_TYPE_END;
-
-	return ret;
 }
=20
-static void expand_format(struct strbuf *sb, struct format_item *fmt,
+static void expand_format(struct strbuf *sb, struct strbuf *parsed_format=
,
 			  struct expand_data *data)
 {
-	for (; fmt->type; fmt++)
-		switch (fmt->type) {
-		case FORMAT_TYPE_END:
-			BUG("we should have already left the loop!");
-			break;
+	for (size_t i =3D 0; i < parsed_format->len; i++)
+		switch (parsed_format->buf[i]) {
 		case FORMAT_TYPE_OBJECTNAME:
 			strbuf_add_oid_hex(sb, &data->oid);
 			break;
@@ -453,7 +419,7 @@ static void expand_format(struct strbuf *sb, struct fo=
rmat_item *fmt,
 				strbuf_addf(sb, "%06o", data->mode);
 			break;
 		case FORMAT_TYPE_LITERAL:
-			strbuf_add(sb, fmt->u.literal.p, fmt->u.literal.len);
+			strbuf_addch(sb, parsed_format->buf[++i]);
 		}
 }
=20
@@ -641,7 +607,7 @@ static void batch_object_write(const char *obj_name,
 	if (!opt->format) {
 		print_default_format(scratch, data, opt);
 	} else {
-		expand_format(scratch, opt->parsed_format, data);
+		expand_format(scratch, &opt->parsed_format, data);
 		strbuf_addch(scratch, opt->output_delim);
 	}
=20
@@ -1010,9 +976,8 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval =3D 0;
=20
-	opt->parsed_format =3D parse_format(opt->format ?
-					  opt->format : DEFAULT_FORMAT,
-					  &data);
+	parse_format(&opt->parsed_format,
+		     opt->format ? opt->format : DEFAULT_FORMAT, &data);
 	if (opt->transform_mode)
 		data.split_on_whitespace =3D 1;
=20
@@ -1152,6 +1117,7 @@ int cmd_cat_file(int argc,
 	const char *exp_type =3D NULL, *obj_name =3D NULL;
 	struct batch_options batch =3D {
 		.objects_filter =3D LIST_OBJECTS_FILTER_INIT,
+		.parsed_format =3D STRBUF_INIT,
 	};
 	int unknown_type =3D 0;
 	int input_nul_terminated =3D 0;

