From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Hard coded string length cleanup
Date: Fri, 20 Dec 2013 08:53:27 -0800
Message-ID: <xmqqfvpnea60.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<52B38213.2070702@web.de>
	<CACsJy8Bb4+V1DEdEmRwj10Oozi8U430ZHDCj_UhnXZcaR-wQ=g@mail.gmail.com>
	<52B397FF.4050808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 20 17:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu3KS-0003wP-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 17:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab3LTQxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 11:53:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3LTQxb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Dec 2013 11:53:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE08C59AC5;
	Fri, 20 Dec 2013 11:53:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nkh+/C1gzlfs
	H9PlzRQtwXIq1LU=; b=Qk7OUHreaRvJwSaqIgtVqyS3cWj4E2PDn0MhhUXPTsA2
	X+FDdT5JYqIDwJg1NtJ680b077B3iz0pSdODDtoPk5viTE3YDe99agCqe4p/ALYi
	s1MvPQZhmM4IuRHhUHzI433Aou0N5aUkTqqhpZgILIACr2vn7bbjHuCpGWNx2h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N13g8S
	VtYviTjzDFXnEvzBnW0l9peqvJ/47Z/ZQ64EXlFeYG6UMy7nTlloTskCNx6sg6/A
	eK2ZX4IwO0ATfkP6F06jPJKyM9O5ubWmxRZMLu35r9At5otcxCQrWRRxix0yJ6Tx
	Nq84Jn9dGVTtTOhHPis+qXMUc64RKMB+qY7jM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC8C859AC3;
	Fri, 20 Dec 2013 11:53:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15C0F59AC2;
	Fri, 20 Dec 2013 11:53:30 -0500 (EST)
In-Reply-To: <52B397FF.4050808@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Fri, 20
	Dec 2013 02:06:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40E56EA8-6997-11E3-B867-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239576>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 20.12.2013 00:50, schrieb Duy Nguyen:
>> On Fri, Dec 20, 2013 at 6:32 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>> Seeing that skip_prefix_defval is mostly used in the form
>>> skip_prefix_defval(foo, prefix, foo) I wonder if it makes sense to
>>> first change skip_prefix to return the full string instead of NULL
>>> if the prefix is not matched.  Would the resulting function cover
>>> most use cases?  And would it still be easily usable?
>>=20
>> That was skip_prefix_gently() that I forgot to replace in a commit
>> message, before I turned it into _defval variant. The reason for
>> _defval is it could be use to chain expression together without addi=
ng
>> temporary variables, e.g.
>>=20
>> -       if (starts_with(line->buf, ">From") && isspace(line->buf[5])=
) {
>> +       if (isspace(*skip_prefix_defval(line->buf, ">From", "NOSPACE=
"))) {
>>=20
>> Without _defval, one would need to do if ((p =3D skip_prefix(..)) &&
>> isspace(*p)). I'm not entirely sure this is a good thing though as i=
t
>> could make it a bit harder to read.
>
> That usage is quite rare compared to occurrences of
> skip_prefix_defval(foo, prefix, foo), no?  Adding a temporary variabl=
e
> for them wouldn't be that bad if we can simplify the API to a single
> function -- if that one is usable, that is.
>
> On the other hand, we could add a special function for that example
> and we'd already have three users in the tree (patch below).  I think
> that's too narrow a use case for a library function, though.  Doing
> the following instead in the three cases doesn't seem to be too bad:
>
> 	rest =3D skip_prefix(line->buf, ">From");
> 	if (rest !=3D line->buf && isspace(*rest)) {

Yeah, I personally feel that the "NOSPACE" hack is a bit too ugly to
live in a code meant to be maintained for a longer term.  The above
with a "rest" variable, whose assignment is outside if () condition,
is so far the easiest to read, at least to me.

I am not convinced if skip-prefix-and-space is even a good
abstraction of anything; it feels a bit too specialized.

Thanks.

> ---
>  builtin/apply.c    | 2 +-
>  builtin/mailinfo.c | 4 ++--
>  git-compat-util.h  | 1 +
>  strbuf.c           | 9 +++++++++
>  4 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index b0d0986..b96befd 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -433,7 +433,7 @@ static unsigned long linelen(const char *buffer, =
unsigned long size)
> =20
>  static int is_dev_null(const char *str)
>  {
> -	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
> +	return skip_prefix_and_space(str, "/dev/null") !=3D str;
>  }
> =20
>  #define TERM_SPACE	1
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 2c3cd8e..2575989 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -328,11 +328,11 @@ static int check_header(const struct strbuf *li=
ne,
>  	}
> =20
>  	/* for inbody stuff */
> -	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
> +	if (skip_prefix_and_space(line->buf, ">From") !=3D line->buf) {
>  		ret =3D 1; /* Should this return 0? */
>  		goto check_header_out;
>  	}
> -	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
> +	if (skip_prefix_and_space(line->buf, "[PATCH]") !=3D line->buf) {
>  		for (i =3D 0; header[i]; i++) {
>  			if (!memcmp("Subject", header[i], 7)) {
>  				handle_header(&hdr_data[i], line);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index dcb92c4..a083918 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -355,6 +355,7 @@ extern int prefixcmp(const char *str, const char =
*prefix);
>  extern int ends_with(const char *str, const char *suffix);
>  extern int suffixcmp(const char *str, const char *suffix);
>  extern const char *skip_prefix(const char *str, const char *prefix);
> +extern const char *skip_prefix_and_space(const char *str, const char=
 *prefix);
> =20
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
> =20
> diff --git a/strbuf.c b/strbuf.c
> index 222df13..768331f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -47,6 +47,15 @@ const char *skip_prefix(const char *str, const cha=
r *prefix)
>  			return str;
>  }
> =20
> +const char *skip_prefix_and_space(const char *str, const char *prefi=
x)
> +{
> +	const char *p =3D skip_prefix(str, prefix);
> +	if (((p !=3D str) || !*prefix) && isspace(*p))
> +		return p + 1;
> +	else
> +		return str;
> +}
> +
>  /*
>   * Used as the default ->buf value, so that people can always assume
>   * buf is non NULL and ->buf is NUL terminated even for a freshly
