From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] pretty: add aliases for pretty formats
Date: Mon, 26 Apr 2010 02:25:16 -0500
Message-ID: <20100426072516.GA30416@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-4-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 09:24:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6IgF-0000AP-Pk
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 09:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab0DZHYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 03:24:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44290 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0DZHY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 03:24:29 -0400
Received: by pvg2 with SMTP id 2so4495pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=unDKJkTH5QYhMb+TLM9LsiNDNsEy4hhldhx2ckyPObI=;
        b=ZTnai8t6FHDSXYEX9XPkzb3TP1hYsY/7eztCF9yR3mZKvpjz25hygcgeakACdQYVIV
         mr8GWnXsG9C9H1kI/OUILPjLVgHuNWxkiDhnppu6Uy2OJWozGT92nwqUNGn/KXly7Obn
         UwQYRwA9vkb5ItHxP/qBA0OR+WQSxqz1qU/mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XKusBObVazW4ScD/AoMLgWrYm/G9fyYgqgo/kkDZncxBmsYqJaryl+M23khN9Ef7ok
         C18KN/n9wNUsbN9IsRcu9h58h4vJohJSUYbjRLGjJTITIVGIO+hmm1r5EL9HrXRvj3t5
         iUALmjd22Xj8q4PoNhXLmSDGAF301DZp8qfvo=
Received: by 10.143.26.20 with SMTP id d20mr1556327wfj.31.1272266668727;
        Mon, 26 Apr 2010 00:24:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2916805iwn.15.2010.04.26.00.24.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 00:24:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272232579-18895-4-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145794>

Will Palmer wrote:

> format.pretty.<name>::
>        Alias for a --pretty=3D format string, as specified in
>        linkgit:git-log[1]. Any aliases defined here can be used just
>        as the builtin pretty formats could. For example, defining
>        "format.pretty.hash =3D format:%H" would cause the invocation
>        "git log --pretty=3Dhash" to be equivalent to running
>        "git log --pretty=3Dformat:%H".

Ah, so I could use=20

	[format "pretty"]
		wrapped =3D "format:\
	%C(yellow)commit %H%n\
	Merge: %p%n\
	Author:	%aN <%aE>%n\
	Date:	%ad%n%n%w(80,4,4)%s%n\
	%+b"

and then by default I get the standard medium, but with --format=3Dwrap=
ped,
I get my imitation of it.  Sounds very useful, thanks.

> diff --git a/pretty.c b/pretty.c
> index f884f48..d49fec7 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -11,6 +11,16 @@
>  #include "reflog-walk.h"
> =20
>  static char *user_format;
> +static struct cmt_fmt_map {
> +	const char *name;
> +	enum cmit_fmt format;
> +	const char *user_format;
> +	int is_tformat;
> +	int is_alias;
> +} *commit_formats =3D NULL;
> +static size_t commit_formats_len =3D 0;
> +static size_t commit_formats_alloc =3D 0;
> +static struct cmt_fmt_map *find_commit_format(const char *sought);
> =20
>  static void save_user_format(struct rev_info *rev, const char *cp, i=
nt is_tformat)
>  {
> @@ -21,22 +31,134 @@ static void save_user_format(struct rev_info *re=
v, const char *cp, int is_tforma
>  	rev->commit_format =3D CMIT_FMT_USERFORMAT;
>  }
> =20
> -void get_commit_format(const char *arg, struct rev_info *rev)
> +static int git_pretty_formats_config(const char *var, const char *va=
lue, void *cb)
> +{
> +	if (!prefixcmp(var, "format.pretty.")) {

Simpler to use

	if (prefixcmp(var, "format.pretty."))
		return 0;

to avoid keeping the reader in suspense.

> +		struct cmt_fmt_map user_format =3D {0};
> +		const char *fmt;
> +
> +		user_format.name =3D xstrdup(&var[14]);
> +		user_format.format =3D CMIT_FMT_USERFORMAT;
> +		git_config_string(&fmt, var, value);

git_config_string() does a strdup(), but we were about to either
discard the value or do that ourselves anyway...

> +		if (!prefixcmp(fmt, "format:") || !prefixcmp(fmt, "tformat:")) {
> +			user_format.is_tformat =3D fmt[0] =3D=3D 't';
> +			fmt =3D strchr(fmt, ':') + 1;
> +		} else if (strchr(fmt, '%'))
> +			user_format.is_tformat =3D 1;
> +		else
> +			user_format.is_alias =3D 1;
> +		user_format.user_format =3D fmt;

=2E.. or rather we would be, if this reused code from get_commit_format=
/
save_user_format.

> +
> +		ALLOC_GROW(commit_formats, commit_formats_len+1,
> +			   commit_formats_alloc);
> +		memcpy(&commit_formats[ commit_formats_len ], &user_format,
> +		       sizeof(user_format));
> +		commit_formats_len++;

Why not build it in place?  Not for performance reasons (that could go
either way); it is just that that would seem simpler to me.

> +	}
> +	return 0;
> +}

Regarding the next piece: I suspect the review would be easier if
it had been more than one patch.  Maybe three patches:

 1 restructure get_commit_format to read from a (dynamic) list of
   supported formats that is not its responsibility

 2 infrastructure for format aliases (this is not needed for
   --format=3Ddatelist where datelist =3D "tformat:%h %cd")

 3 new configuration for user-defined formats and format aliases

Maybe 3 could come before 2, since it seems like complicated.

The new call graph looks like this:

 setup_revisions() ->
   handle_revision_opt() ->
   get_commit_format() ->
   find_commit_format() ->
   setup_commit_formats() ->
   git_config() ->
   git_pretty_formats_config()

This means we have to have searched for a repository before parsing
these arguments; this constraint already exists for parsing the actual
revision arguments (maybe some day we will defer handling those
arguments for some reason).

I would have put the setup_commit_formats() call in setup_revisions()
to make this more obvious, but I suppose this way you save time if no
--format option is used.

> +
> +static void setup_commit_formats(void)
>  {
>  	int i;
> -	static struct cmt_fmt_map {
> -		const char *n;
> -		size_t cmp_len;
> -		enum cmit_fmt v;
> -	} cmt_fmts[] =3D {
> -		{ "raw",	1,	CMIT_FMT_RAW },
> -		{ "medium",	1,	CMIT_FMT_MEDIUM },
> -		{ "short",	1,	CMIT_FMT_SHORT },
> -		{ "email",	1,	CMIT_FMT_EMAIL },
> -		{ "full",	5,	CMIT_FMT_FULL },
> -		{ "fuller",	5,	CMIT_FMT_FULLER },
> -		{ "oneline",	1,	CMIT_FMT_ONELINE },
> +	const char **attempted_aliases =3D NULL;
> +	size_t attempted_aliases_alloc =3D 0;
> +	size_t attempted_aliases_len;
> +	struct cmt_fmt_map builtin_formats[] =3D {
> +		{ "raw",	CMIT_FMT_RAW,		NULL,	0 },
> +		{ "medium",	CMIT_FMT_MEDIUM,	NULL,	0 },
> +		{ "short",	CMIT_FMT_SHORT,		NULL,	0 },
> +		{ "email",	CMIT_FMT_EMAIL,		NULL,	0 },
> +		{ "full",	CMIT_FMT_FULL,		NULL,	0 },
> +		{ "fuller",	CMIT_FMT_FULLER,	NULL,	0 },
> +		{ "oneline",	CMIT_FMT_ONELINE,	NULL,	1 }

nitpick: Might be less noisy if the null format string field were the
last field.

>  	};
> +	commit_formats_len =3D ARRAY_SIZE(builtin_formats);
> +	ALLOC_GROW(commit_formats, commit_formats_len, commit_formats_alloc=
);
> +	memcpy(commit_formats, builtin_formats,
> +	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
> +
> +	git_config(git_pretty_formats_config, NULL);

I suspect the body of the next loop should be its own function to keep
the reader=E2=80=99s attention.

> +
> +	for (i =3D ARRAY_SIZE(builtin_formats); i < commit_formats_len; i++=
) {
> +		attempted_aliases_len =3D 0;
> +		struct cmt_fmt_map *aliased_format =3D &commit_formats[i];
> +		const char *fmt =3D commit_formats[i].user_format;
> +		int j;

declaration after statement

> +
> +		if (!commit_formats[i].is_alias)
> +			continue;
> +
> +		while ((aliased_format =3D find_commit_format(fmt))) {
[...]

Is this the right time to do this check?  Maybe we could check lazily
when the format is used.

> +			if (!aliased_format->is_alias)
> +				break;
> +
> +			fmt =3D aliased_format->user_format;
> +			for (j=3D0; j<attempted_aliases_len; j++) {
> +				if (!strcmp(fmt, attempted_aliases[j])) {
> +					aliased_format =3D NULL;
> +					break;
> +				}
> +			}

Example:

	[format "pretty"]
		foo =3D nonsense
		one =3D foo
		two =3D foo

one is treated as an alias, but two is not.  Why?

> +			if (!aliased_format)
> +				break;

Is to escape from the wider loop?  I think this is a valid use for goto=
=2E

> +
> +			ALLOC_GROW(attempted_aliases, attempted_aliases_len+1,
> +				   attempted_aliases_alloc);
> +			attempted_aliases[attempted_aliases_len] =3D fmt;
> +			attempted_aliases_len++;
> +		}

Example:

	[format "pretty"]
		foo =3D medium
		xyzzy =3D one
		one =3D foo
		two =3D foo
		frotz =3D two

At the end of this loop, attempted_aliases contains:

	one
	foo
	two

Every alias which is itself referred to by an alias is listed.

> +		if (aliased_format) {
> +			commit_formats[i].format =3D aliased_format->format;
> +			commit_formats[i].user_format =3D aliased_format->user_format;
> +			commit_formats[i].is_tformat =3D aliased_format->is_tformat;
> +			commit_formats[i].is_alias =3D 0;
> +		} else
> +			commit_formats[i].format =3D CMIT_FMT_UNSPECIFIED;
> +	}
> +}

Why go to the trouble to build attempted_aliases when it is never used?

I suspect I=E2=80=99ve completely misunderstood, so I=E2=80=99m stoppin=
g here.  Maybe
someone else can clear it up or take over.

Jonathan
