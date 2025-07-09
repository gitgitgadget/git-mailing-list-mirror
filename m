Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62028640A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053480; cv=none; b=Nfvv5Laepr0YpXtturVJ4WDNPR6B2NLdS91Gv1CNSHPT0yh/MhNKoyBxA9iGDnI5E32KSu7ZyfCkX4NKxMTaYU7H7wzB9ttsNpy4PPjWQwf2fHK0VBF4oOSFiGq3ARUBHXa8KgkB7ye8WltkELsk4Ry5iJqTTCqGUBqWGmbNv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053480; c=relaxed/simple;
	bh=q5KtqP4r5ldGxvv+QMzZpjFOlp0U+bhgSMQLWZ8DCuc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KQSMx0Ht4RYD2S/rC6xeq6h/mITIbHYrFtWKVTXKm97V7bCFIjhIEjBpd632vyPVMolW+hwkcVsmo7hCAUt1J1EHv+LElWEp5WFQ2TqjDm36zgK/U0bfBt3MYoBJMBTXIkII+k+MGL1Fziu7xwqlt2PzZLtg334gdq3KiK2xrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VTTq6YXd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VTTq6YXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752053476; x=1752658276; i=l.s.r@web.de;
	bh=in47f3sXm4SDnvGO/Mrr/2M8RmaZshlGHrjCapV81rg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VTTq6YXd864zQmGJ+LaIdHXYzD9KPgaqklYMT6KlW6IcgJ4tO9698GCWKLzF2tc1
	 Y4ZQtCc70mMO1TzBYCqA0fY69498uc4Zr/INpujQO9eODSGghiXs0jrvbRGIPkD0s
	 gnZWDZo3qW17gr1COJwXdAhQ3539BdXlv8uTefAnlypo8e1z2RtrYbXwPfKOcbiwj
	 stqBpQTBE46B0YX0d6I+e52/tyUbetQ2iVQJXAcyp19CsX6gEN+fuFn6oawWqjE7+
	 pUfE2XFxxZJlema7gR3bOMM1COqOfjY2pz0/FU5SPmMjayT9oPs/VNg6tSoMrikp4
	 yacVoyhRJGtsy2ieEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1v4JpC2QUK-00fFbB; Wed, 09
 Jul 2025 11:26:10 +0200
Message-ID: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Date: Wed, 9 Jul 2025 11:26:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/7] parse-options: add more precision handling
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NboiYSzdeXBLGQPxeFtN765CiU5G7ilvbEjEYaPVewEpUn7k+gF
 imyUr20j6bmHBnMfgJx0Y3+Q6DiF2ifhmstZ4HG43rYwl9SOIFOIG5J4lWkjlDK5Ie0hDgm
 6hhQYVyFHl/0g9Tcl7EEsLg/1x+cU7fdreCP4OcQ0tsJ4bBKZPD67rclOjp1/30u4LWDlwm
 v5yQU2wpsiLtpqVNdH95A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T3JzpPTOd/A=;R7XN0ibw+uS7FWmVRmuOtyEYZzF
 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
 5A==

Extend precision handling to all options that currently blindly use an
int pointer to access value variables.  This allows the safe use of
smaller and larger integer types.

Sign handling might be nice as well (especially for OPTION_COUNTUP), but
is out of scope for this series.

Changes since v1:
- Enable PARSE_OPT_NOARG checking for OPTION_BITOP explicitly in a new
  separate patch instead of as a side-effect.
- Split out do_get_int_value().
- This allows us to use optbug() only where it makes sense, in
  build_cmdmode_list().  This lets the function report all
  PARSE_OPT_CMDMODE options with invalid precision in one go.
- Use the same BUG call in get_int_value() as in set_int_value(),
  for consistency.
- Store the precision in build_cmdmode_list() instead of an example
  option, which is hopefully easier to follow.
- Rename the size parameter of signed_int_fits() for consistency.

  parse-options: require PARSE_OPT_NOARG for OPTION_BITOP
  parse-options: add precision handling for PARSE_OPT_CMDMODE
  parse-options: add precision handling for OPTION_SET_INT
  parse-options: add precision handling for OPTION_BIT
  parse-options: add precision handling for OPTION_NEGBIT
  parse-options: add precision handling for OPTION_BITOP
  parse-options: add precision handling for OPTION_COUNTUP

 builtin/am.c                  |   1 +
 builtin/rebase.c              |   1 +
 builtin/update-index.c        |   6 ++
 builtin/write-tree.c          |   1 +
 parse-options.c               | 155 +++++++++++++++++++++++++---------
 parse-options.h               |   7 ++
 t/helper/test-parse-options.c |  17 +++-
 7 files changed, 146 insertions(+), 42 deletions(-)

Interdiff against v1:
diff --git a/parse-options.c b/parse-options.c
index 0dd08a3a77..5224203ffe 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -68,23 +68,34 @@ static char *fix_filename(const char *prefix, const ch=
ar *file)
 		return prefix_filename_except_for_dash(prefix, file);
 }
=20
-static intmax_t get_int_value(const struct option *opt)
+static int do_get_int_value(const void *value, size_t precision, intmax_t=
 *ret)
 {
-	switch (opt->precision) {
+	switch (precision) {
 	case sizeof(int8_t):
-		return *(int8_t *)opt->value;
+		*ret =3D *(int8_t *)value;
+		return 0;
 	case sizeof(int16_t):
-		return *(int16_t *)opt->value;
+		*ret =3D *(int16_t *)value;
+		return 0;
 	case sizeof(int32_t):
-		return *(int32_t *)opt->value;
+		*ret =3D *(int32_t *)value;
+		return 0;
 	case sizeof(int64_t):
-		return *(int64_t *)opt->value;
+		*ret =3D *(int64_t *)value;
+		return 0;
 	default:
-		optbug(opt, "has invalid precision");
-		BUG("invalid 'struct option'");
+		return -1;
 	}
 }
=20
+static intmax_t get_int_value(const struct option *opt, enum opt_parsed f=
lags)
+{
+	intmax_t ret;
+	if (do_get_int_value(opt->value, opt->precision, &ret))
+		BUG("invalid precision for option %s", optname(opt, flags));
+	return ret;
+}
+
 static enum parse_opt_result set_int_value(const struct option *opt,
 					   enum opt_parsed flags,
 					   intmax_t value)
@@ -107,9 +118,9 @@ static enum parse_opt_result set_int_value(const struc=
t option *opt,
 	}
 }
=20
-static int signed_int_fits(intmax_t value, size_t size)
+static int signed_int_fits(intmax_t value, size_t precision)
 {
-	size_t bits =3D size * CHAR_BIT;
+	size_t bits =3D precision * CHAR_BIT;
 	intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
 	intmax_t lower_bound =3D -upper_bound - 1;
 	return lower_bound <=3D value && value <=3D upper_bound;
@@ -137,7 +148,7 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
=20
 	case OPTION_BIT:
 	{
-		intmax_t value =3D get_int_value(opt);
+		intmax_t value =3D get_int_value(opt, flags);
 		if (unset)
 			value &=3D ~opt->defval;
 		else
@@ -147,7 +158,7 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
=20
 	case OPTION_NEGBIT:
 	{
-		intmax_t value =3D get_int_value(opt);
+		intmax_t value =3D get_int_value(opt, flags);
 		if (unset)
 			value |=3D opt->defval;
 		else
@@ -157,7 +168,7 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
=20
 	case OPTION_BITOP:
 	{
-		intmax_t value =3D get_int_value(opt);
+		intmax_t value =3D get_int_value(opt, flags);
 		if (unset)
 			BUG("BITOP can't have unset form");
 		value &=3D ~opt->extra;
@@ -169,7 +180,7 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
 	{
 		size_t bits =3D CHAR_BIT * opt->precision;
 		intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
-		intmax_t value =3D get_int_value(opt);
+		intmax_t value =3D get_int_value(opt, flags);
=20
 		if (value < 0)
 			value =3D 0;
@@ -318,7 +329,9 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
=20
 struct parse_opt_cmdmode_list {
 	intmax_t value;
-	const struct option *opt, *reference_opt;
+	void *value_ptr;
+	size_t precision;
+	const struct option *opt;
 	const char *arg;
 	enum opt_parsed flags;
 	struct parse_opt_cmdmode_list *next;
@@ -331,21 +344,25 @@ static void build_cmdmode_list(struct parse_opt_ctx_=
t *ctx,
=20
 	for (; opts->type !=3D OPTION_END; opts++) {
 		struct parse_opt_cmdmode_list *elem =3D ctx->cmdmode_list;
+		void *value_ptr =3D opts->value;
=20
-		if (!(opts->flags & PARSE_OPT_CMDMODE) || !opts->value)
+		if (!(opts->flags & PARSE_OPT_CMDMODE) || !value_ptr)
 			continue;
=20
-		while (elem && elem->reference_opt->value !=3D opts->value)
+		while (elem && elem->value_ptr !=3D value_ptr)
 			elem =3D elem->next;
 		if (elem)
 			continue;
=20
 		CALLOC_ARRAY(elem, 1);
-		elem->reference_opt =3D opts;
-		elem->value =3D get_int_value(opts);
+		elem->value_ptr =3D value_ptr;
+		elem->precision =3D opts->precision;
+		if (do_get_int_value(value_ptr, opts->precision, &elem->value))
+			optbug(opts, "has invalid precision");
 		elem->next =3D ctx->cmdmode_list;
 		ctx->cmdmode_list =3D elem;
 	}
+	BUG_if_bug("invalid 'struct option'");
 }
=20
 static char *optnamearg(const struct option *opt, const char *arg,
@@ -367,7 +384,11 @@ static enum parse_opt_result get_value(struct parse_o=
pt_ctx_t *p,
 	char *opt_name, *other_opt_name;
=20
 	for (; elem; elem =3D elem->next) {
-		intmax_t new_value =3D get_int_value(elem->reference_opt);
+		intmax_t new_value;
+
+		if (do_get_int_value(elem->value_ptr, elem->precision,
+				     &new_value))
+			BUG("impossible: invalid precision");
=20
 		if (new_value =3D=3D elem->value)
 			continue;
=2D-=20
2.50.0
