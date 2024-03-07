Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E91369BB
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840569; cv=none; b=jlNUBK9b7uE+JylqbhIE7ab/W9LfhaIJ1NALE4NhyCEtbOJsTyOBFFKGEIbQStpJ5w0Onw5SzxVNOBu89FcwpXBelGy0llPYjgE8EV3W3LTICtE6BEyXuaOquatS4SMS/IXM+doXWuXYPYAjkCRUlyzMLPyJ7xcvhQQqNZ4lI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840569; c=relaxed/simple;
	bh=kLRfU41WEbDdtCddrEIT5wbyPFZ4DI3dMVRTIg/wuf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL/W2Vj7AAwLPu36jZJKZ7EF/Bx8ZaADBRuDXqfiQMX4qZaMXeaY33UcGXdD3Lapuhstoegmoe5iGMDpv4Ikt8xL2Zd9LZwkiCvriuIiibfda6uEkmBTQiNsbkfFhVqU6NehxPT4q2Q+d2NEPEtYKPGffIMdwOLNiii6VpzEvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eJ3CqJHL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eJ3CqJHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709840543; x=1710445343; i=l.s.r@web.de;
	bh=kLRfU41WEbDdtCddrEIT5wbyPFZ4DI3dMVRTIg/wuf8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=eJ3CqJHL7F3cZ9eHQzXth4hnHbQoaIDWvKNyoqDrmzgr9dhoPycO/uOciTkO8eHN
	 yHGmZ8llswem7ZGmopfduBbKAhxbq20f2ED5RWcWdQOqI1qnrUuK/269e6aQes9PA
	 UaHAIgrgq2vRb1kLOLjN6aPsaAkErzUzwJ/5ndu63CDATo4z9rfvBspXdB4TZaydj
	 yMV1K8Dvxw18lBX/SxcZgyWrI3NJcPAdeRrPQVkmgxic1sr8pHSN3wnkD2SVpoJLz
	 Lv22yeohEl2ZeDp2VDNu2+hTqRfzakWEfkroPsoICxAo9oC4ZCi4C2BuHJnF1WyoC
	 TOzdsaqQdUBGoNdXVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1rI1M70g76-00Qtej; Thu, 07
 Mar 2024 20:42:23 +0100
Message-ID: <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
Date: Thu, 7 Mar 2024 20:42:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240307092638.GK2080210@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:do+vCGx9MYuthJVW7a1A7DpWZKjVtIqrErv8ob5nAstCtv0l1jU
 vpr9B2NdJkOKGNTePH/Set6XJ4ZuHtxK1KPaEaRvAjpZAHY+qf2/y1EuS1vbOgohxq6EhLW
 LwnTO/tRP9V/rt8eQuQln8ZqVKOTuF7iMVpno4ph+NcuOui3DN5CrxGnKIknSQANYNNOfhj
 UguzdggKYqg9swj0GtfrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a55K+a5FK40=;opZzDYTZaJ9QvxMYUm8atDIDVGx
 WAHeDRZVQuM5svQIcnjkc1LB6I/O5IT5mRgRR4vzvwOPbDUcFg+Fu3BYGE7quk9uaVPzEGhnf
 WGoBl3kR2KB+wTaE7/gsQk4WCimDMpH9P6H+i8SKUAoGMfQq56YQGT94MY77HLqSHXBsGUXHG
 BtSdBIGvL5kmZy6Y+OU/d/qAT0jlSIHXJwmN9Sx+GoK2mv6YkECGsuhk81twLFDjBoAXNCx3B
 qsvsejDJ+2L5OXZSEcuXkLnLj/XTK8kz2BX5mDwC01vrdGn9DYieapbdSFSWvpe9x7gMleC5v
 WpRSF6dBW1Q81j13jWMM/VJ320gUSyE/1LYTpRK9R4xf5Ips5cKSsiK8c2Ypw2RliKgNMFBVq
 0Q7654Mo9jxL9eXhq3m9aNSpqfEmb5zfBk1LMg/msloVuRP509iI7BgdCxFprdyHCi5df418r
 LXY9SdR0Yby8rouYms1aUQMjX9unOwQ0OnsaH351SPSr/a7QvFoCSZn+lMm12pCvT0Hpe2tUu
 YfhtBj7iKcXyj1FKHEiHnIULUjTxc2TtHErL/PxxWRjqy3dH1wiBjBIfmJjBb1p0ecb/z1R2f
 fCraABUYrBpi/RtIWaVQSRtccjjOWrQ2GwQEzpdqsx3aVvspMkn7DR1Rz6ypTxAv+iEn3nKlL
 iecu1tviioGy05as+VySS4auGkCYsnY96sxuvp/nQQcVedVym9qFMrObylIixyXMBWnwe2ZaC
 YyBZ+2yCL9LXd4oL89Uv4p3icJvtXNTXX9q0MA6CUgPejFpWh8M2Bgerx3v2DG6rohtjBgOOs
 zgCez5QeHsBY6C4Y40A/t6Pho/wCQYC6l4J+/jsr3wDYU=

Am 07.03.24 um 10:26 schrieb Jeff King:
> As with the previous patch, we need to swap out single-byte matching for
> something like starts_with() to match all bytes of a multi-byte comment
> character. But for cases where the buffer is not NUL-terminated (and we
> instead have an explicit size or end pointer), it's not safe to use
> starts_with(), as it might walk off the end of the buffer.
>
> Let's introduce a new starts_with_mem() that does the same thing but
> also accepts the length of the "haystack" str and makes sure not to walk
> past it.
>
> Note that in most cases the existing code did not need a length check at
> all, since it was written in a way that knew we had at least one byte
> available (and that was all we checked). So I had to read each one to
> find the appropriate bounds. The one exception is sequencer.c's
> add_commented_lines(), where we can actually get rid of the length
> check. Just like starts_with(), our starts_with_mem() handles an empty
> haystack variable by not matching (assuming a non-empty prefix).
>
> A few notes on the implementation of starts_with_mem():
>
>   - it would be equally correct to take an "end" pointer (and indeed,
>     many of the callers have this and have to subtract to come up with
>     the length). I think taking a ptr/size combo is a more usual
>     interface for our codebase, though, and has the added benefit that
>     the function signature makes it harder to mix up the three
>     parameters.
>
>   - we could obviously build starts_with() on top of this by passing
>     strlen(str) as the length. But it's possible that starts_with() is a
>     relatively hot code path, and it should not pay that penalty (it can
>     generally return an answer proportional to the size of the prefix,
>     not the whole string).
>
>   - it naively feels like xstrncmpz() should be able to do the same
>     thing, but that's not quite true. If you pass the length of the
>     haystack buffer, then strncmp() finds that a shorter prefix string
>     is "less than" than the haystack, even if the haystack starts with
>     the prefix. If you pass the length of the prefix, then you risk
>     reading past the end of the haystack if it is shorter than the
>     prefix. So I think we really do need a new function.

Yes.  xstrncmpz() compares a NUL-terminated string and a length-limited
string.  If you want to check whether the former is a prefix of the
latter then you need to stop comparing when reaching its NUL, and also
after exhausting the latter.  So you need to take both lengths into
account:

int starts_with_mem(const char *str, size_t len, const char *prefix)
{
	size_t prefixlen =3D strlen(prefix);
	return prefixlen <=3D len && !xstrncmpz(prefix, str, prefixlen);
}

Using memcmp() here is equivalent and simpler:

int starts_with_mem(const char *str, size_t len, const char *prefix)
{
	size_t prefixlen =3D strlen(prefix);
	return prefixlen <=3D len && !memcmp(str, prefix, prefixlen);
}

And your version below avoids function calls and avoids traversing the
strings beyond their common prefix, of course.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Arguably starts_with() and this new function should both be inlined,
> like we do for skip_prefix(), but I think that's out of scope for this
> series.

Inlining would allow the compiler to unroll the loop for string
constants.  I doubt it would do that for variables, as in the code
below.

Inlining the strlen()+memcmp() version above might allow the compiler
to push the strlen() call out of a loop.

Would any of that improve performance noticeably?  For the call sites
below I doubt it.  But it would probably increase the object text size.

> And it's possible I was simply too dumb to figure out xstrncmpz() here.
> I'm waiting for Ren=C3=A9 to show up and tell me how to do it. ;)

Nah, it's not a good fit, as it requires the two strings to have the
same length.

>
> IMHO this is the trickiest commit of the whole series, as it would be
> easy to get the length computations subtly wrong.
>
>  commit.c    |  3 ++-
>  sequencer.c |  4 ++--
>  strbuf.c    | 11 +++++++++++
>  strbuf.h    |  1 +
>  trailer.c   |  4 ++--
>  5 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index ef679a0b93..531a666cba 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1796,7 +1796,8 @@ size_t ignored_log_message_bytes(const char *buf, =
size_t len)
>  		else
>  			next_line++;
>
> -		if (buf[bol] =3D=3D comment_line_char || buf[bol] =3D=3D '\n') {
> +		if (starts_with_mem(buf + bol, cutoff - bol, comment_line_str) ||
> +		    buf[bol] =3D=3D '\n') {
>  			/* is this the first of the run of comments? */
>  			if (!boc)
>  				boc =3D bol;
> diff --git a/sequencer.c b/sequencer.c
> index 991a2dbe96..664986e3b2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1840,7 +1840,7 @@ static int is_fixup_flag(enum todo_command command=
, unsigned flag)
>  static void add_commented_lines(struct strbuf *buf, const void *str, si=
ze_t len)
>  {
>  	const char *s =3D str;
> -	while (len > 0 && s[0] =3D=3D comment_line_char) {
> +	while (starts_with_mem(s, len, comment_line_str)) {
>  		size_t count;
>  		const char *n =3D memchr(s, '\n', len);
>  		if (!n)
> @@ -2562,7 +2562,7 @@ static int parse_insn_line(struct repository *r, s=
truct todo_item *item,
>  	/* left-trim */
>  	bol +=3D strspn(bol, " \t");
>
> -	if (bol =3D=3D eol || *bol =3D=3D '\r' || *bol =3D=3D comment_line_cha=
r) {
> +	if (bol =3D=3D eol || *bol =3D=3D '\r' || starts_with_mem(bol, eol - b=
ol, comment_line_str)) {

If the strspn() call is safe (which it is, as the caller expects the
string to be NUL-terminated) then you could use starts_with() here and
avoid the length calculation.  But that would also match
comment_line_str values that contain LF, which the _mem version does not
and that's better.

Not sure why lines that start with CR are considered comment lines,
though.

>  		item->command =3D TODO_COMMENT;
>  		item->commit =3D NULL;
>  		item->arg_offset =3D bol - buf;
> diff --git a/strbuf.c b/strbuf.c
> index 7c8f582127..291bdc2a65 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -24,6 +24,17 @@ int istarts_with(const char *str, const char *prefix)
>  			return 0;
>  }
>
> +int starts_with_mem(const char *str, size_t len, const char *prefix)
> +{
> +	const char *end =3D str + len;
> +	for (; ; str++, prefix++) {
> +		if (!*prefix)
> +			return 1;
> +		else if (str =3D=3D end || *str !=3D *prefix)
> +			return 0;
> +	}
> +}

So this checks whether a length-limited string has a prefix given as a
NUL-terminated string.  I'd have called it mem_starts_with() and have
expected starts_with_mem() to check a NUL-terminated string for a
length-limited prefix (think !strncmp(str, prefix, prefixlen)).

> +
>  int skip_to_optional_arg_default(const char *str, const char *prefix,
>  				 const char **arg, const char *def)
>  {
> diff --git a/strbuf.h b/strbuf.h
> index 58dddf2777..3156d6ea8c 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -673,6 +673,7 @@ char *xstrfmt(const char *fmt, ...);
>
>  int starts_with(const char *str, const char *prefix);
>  int istarts_with(const char *str, const char *prefix);
> +int starts_with_mem(const char *str, size_t len, const char *prefix);
>
>  /*
>   * If the string "str" is the same as the string in "prefix", then the =
"arg"
> diff --git a/trailer.c b/trailer.c
> index fe18faf6c5..f59c90b4b5 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char *b=
uf, size_t len)
>
>  	/* The first paragraph is the title and cannot be trailers */
>  	for (s =3D buf; s < buf + len; s =3D next_line(s)) {
> -		if (s[0] =3D=3D comment_line_char)
> +		if (starts_with_mem(s, buf + len - s, comment_line_str))
>  			continue;
>  		if (is_blank_line(s))

Another case where starts_with() would be safe to use, as
is_blank_line() expects (and gets) a NUL-terminated string, but it would
allow matching comment_line_str values that contain LF.

>  			break;
> @@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *b=
uf, size_t len)
>  		const char **p;
>  		ssize_t separator_pos;
>
> -		if (bol[0] =3D=3D comment_line_char) {
> +		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str))=
 {

We're in the same buffer, so the above comment applies here as well.

>  			non_trailer_lines +=3D possible_continuation_lines;
>  			possible_continuation_lines =3D 0;
>  			continue;
