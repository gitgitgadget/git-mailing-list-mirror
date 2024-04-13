Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9A2114
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712966872; cv=none; b=A+ZoyhqgUYmyOxMLnVDFSIoUkRz8aAgxJ9I76AngX3R33LPffo/LdjYu6aj+r0KaPoTdL/T2dNmssOwlXQC5IdSaoWzLQuMvsPiS1yzA3J0hHTayM+GD5FgYIV+Qn7cScvjLHLp4cv8mU9+HkkZRIKBmLF5vyBEL9UgBUJli2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712966872; c=relaxed/simple;
	bh=IJmhyrTcm5riuaeSR9ptUwiYkon5q7whpf6+O/NClGo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1wg3sOKAjUNGz71pn4iOWGv39fvcFhMQ1WtQ2v4Kcc4waDGnFIJ0qNqFqQlDl+7KDdMjMPZ2F/nfitJbWUOWrDZ3hvf3whSjedfme93Btev5JLePCE/xKym8Bj/+acrByUAnHy39A9P//NpVqSkmyv1uvhHbXzmAeE+XVcf0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=f3qJb2aa; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="f3qJb2aa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712966866; x=1713226066;
	bh=usWZ04mG+v5wkiUzkpR7QwKaWfYklCQv+z/QEomiRXE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=f3qJb2aah97rj/LJpZpTJjld789IgIWxJgi7Ltbp/lolspRJTam39br7ovLq2TvRi
	 1ZIh/AxEYaG8Rknt4v3ra0nlWVnbsWtCj4+pfU/m80q09kxhKeaF+kMwEOHs7wo098
	 a9zNe7A61DZg8rUt5u9pQsKhUWSQgWscTP2OD2YdVBTWGGiuQRubM1wXbHz/YMaTaY
	 2qGlHFGnndRbvE/LXuLNV8q0cFpK75lYg78b3WpsHSIqCQbGOIK1qesGeC65kcpgiz
	 fpmxTQ4PLgK1raTJm/dSmW0QKHnakthjTrKhmS2MVDSTVKtwjKHJ7F+aR8gLoxthm7
	 4v5SYohlxS92g==
Date: Sat, 13 Apr 2024 00:07:38 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 1/8] fast-import: tighten path unquoting
Message-ID: <41A4023D-E468-4D63-9881-57392D06D852@archibald.dev>
In-Reply-To: <xmqqle5io7zf.fsf@gitster.g>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev> <d6ea8aca465eaed4b18b546b5d484bc98fdaa377.1712907684.git.thalia@archibald.dev> <xmqqle5io7zf.fsf@gitster.g>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 12, 2024, at 09:34, Junio C Hamano <gitster@pobox.com> wrote:
> Thalia Archibald <thalia@archibald.dev> writes:
>> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> index 782bda007c..ce9231afe6 100644
>> --- a/builtin/fast-import.c
>> +++ b/builtin/fast-import.c
>> @@ -2258,10 +2258,56 @@ static uintmax_t parse_mark_ref_space(const char=
 **p)
>> return mark;
>> }
>>=20
>> +/*
>> + * Parse the path string into the strbuf. It may be quoted with escape =
sequences
>> + * or unquoted without escape sequences. When unquoted, it may only con=
tain a
>> + * space if `include_spaces` is nonzero.
>> + */
>=20
> It took me three reads to understand the last sentence.  It would
> have been easier if it were written as "it may contain a space only
> if ...".  I'd also named it "allow_unquoted_spaces"---it is not like
> this function includes extra spaces on top of whatever was given.

Patrick commented on this earlier too:

> On Mar 28, 2024, at 01:21, Patrick Steinhardt <ps@pks.im> wrote:
>>=20
>> On Fri, Mar 22, 2024 at 12:03:18AM +0000, Thalia Archibald wrote:
>>> +/*
>>> + * Parse the path string into the strbuf. It may be quoted with escape=
 sequences
>>> + * or unquoted without escape sequences. When unquoted, it may only co=
ntain a
>>> + * space if `allow_spaces` is nonzero.
>>> + */
>>> +static void parse_path(struct strbuf *sb, const char *p, const char **=
endp, int allow_spaces, const char *field)
>>> +{
>>> + strbuf_reset(sb);
>>> + if (*p =3D=3D '"') {
>>> + if (unquote_c_style(sb, p, endp))
>>> + die("Invalid %s: %s", field, command_buf.buf);
>>> + } else {
>>> + if (allow_spaces)
>>> + *endp =3D p + strlen(p);
>>=20
>> I wonder whether `stop_at_unquoted_space` might be more telling. It's
>> not like we disallow spaces here, it's that we treat them as the
>> separator to the next field.
>=20
> I agree, but I=E2=80=99d rather something shorter, so I=E2=80=99ve change=
d it to `include_spaces`.

With all that in mind, I think Patrick is right that the best way to
think of this is that space functions as a field separator, conditional
on this flag. In practice, that leads to restrictions on whether you
can write paths that contain spaces without quotes.

As to naming, `allow_spaces` and `include_spaces` are problematic for
the reasons you both have pointed out. I think `stop_at_unquoted_space`
is problematic, because that=E2=80=99s not where it stops when quoted, but
rather at the close quote. I think that `include_unquoted_spaces` is
good, because it describes that spaces are included in this field when
it is an unquoted string. `allow_unquoted_spaces` implies that its an
error to have a space, but no such error is raised here.

How=E2=80=99s this change? I=E2=80=99ve reworded the relevant sentence and =
specified any
=E2=80=9Cit=E2=80=9Ds and replaced the =E2=80=9Cwhen unquoted, =E2=80=A6=
=E2=80=9D qualifier with =E2=80=9Cunquoted
strings may =E2=80=A6=E2=80=9D to reduce ambiguity.

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fd23a00150..2070c78c56 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2259,12 +2259,13 @@ static uintmax_t parse_mark_ref_space(const char **=
p)
}

/*
- * Parse the path string into the strbuf. It may be quoted with escape seq=
uences
- * or unquoted without escape sequences. When unquoted, it may only contai=
n a
- * space if `include_spaces` is nonzero.
+ * Parse the path string into the strbuf. The path can either be quoted wi=
th
+ * escape sequences or unquoted without escape sequences. Unquoted strings=
 may
+ * contain spaces only if `include_unquoted_spaces` is nonzero; otherwise,=
 it
+ * stops parsing at the first space.
 */
static void parse_path(struct strbuf *sb, const char *p, const char **endp,
-=09=09int include_spaces, const char *field)
+=09=09int include_unquoted_spaces, const char *field)
{
=09if (*p =3D=3D '"') {
=09=09if (unquote_c_style(sb, p, endp))
@@ -2272,7 +2273,7 @@ static void parse_path(struct strbuf *sb, const char =
*p, const char **endp,
=09=09if (strlen(sb->buf) !=3D sb->len)
=09=09=09die("NUL in %s: %s", field, command_buf.buf);
=09} else {
-=09=09if (include_spaces)
+=09=09if (include_unquoted_spaces)
=09=09=09*endp =3D p + strlen(p);
=09=09else
=09=09=09*endp =3D strchrnul(p, ' ');
@@ -2282,7 +2283,7 @@ static void parse_path(struct strbuf *sb, const char =
*p, const char **endp,

/*
 * Parse the path string into the strbuf, and complain if this is not the e=
nd of
- * the string. It may contain spaces even when unquoted.
+ * the string. Unquoted strings may contain spaces.
 */
static void parse_path_eol(struct strbuf *sb, const char *p, const char *fi=
eld)
{
@@ -2295,7 +2296,7 @@ static void parse_path_eol(struct strbuf *sb, const c=
har *p, const char *field)

/*
 * Parse the path string into the strbuf, and ensure it is followed by a sp=
ace.
- * It may not contain spaces when unquoted. Update *endp to point to the f=
irst
+ * Unquoted strings may not contain spaces. Update *endp to point to the f=
irst
 * character after the space.
 */
static void parse_path_space(struct strbuf *sb, const char *p,


Thalia
