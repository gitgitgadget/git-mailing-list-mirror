From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one
 action multiple times
Date: Tue, 30 Jul 2013 23:22:11 +0200
Message-ID: <51F82E83.30203@googlemail.com>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com> <7va9l3x34f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig15AD34ED3C1D03A855134D35"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 23:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4HMw-00079Q-SU
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 23:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977Ab3G3VWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 17:22:05 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:37630 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab3G3VWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 17:22:04 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so2721931eaj.26
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=fH5tmR1i0pBBQdJWWxLMTzcao5F030qPHiMXSIlDKR4=;
        b=KLlGJAdXcKCnKaYhY/InYlML97tRSeSqV//JkfBJ57HUQGJwv6g23uWDKkiYNB6jCp
         RTTs7YlfKL49pmSBtXeoIyzuErabV4mFmcx0OLlVxyF5XNs2rsdVO9qIPMAJaDQYhc2G
         sKB5pwucWd3SMwfPq0wnGXvOFpZIlSIYrXGWIJ79hPYMqrJyuknN/7tu67RAJs+WTr8B
         Joo+GVDLhQR+RB9Q343Yam/fGpBVLpWyB0+oHuJtCsToIBDKt7cRTjVjmUO1zi0RXxI9
         KunBvtPoXohJNy/RKiY6FCX41GJd54cqoQO+9lQrCPK5EoG5ATb8PpZp7Hqg/tGmoT1O
         cMDQ==
X-Received: by 10.15.73.197 with SMTP id h45mr65249065eey.146.1375219321840;
        Tue, 30 Jul 2013 14:22:01 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id p49sm113485373eeu.2.2013.07.30.14.22.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 14:22:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7va9l3x34f.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231391>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15AD34ED3C1D03A855134D35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/30/13 21:24, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> As of b04ba2bb (parse-options: deprecate OPT_BOOLEAN, 2011-09-27),
>> the OPT_BOOLEAN was deprecated.
>> While I am going to replace the OPT_BOOLEAN by the proposed OPT_BOOL o=
r
>> the OPT_COUNTUP to keep existing behavior, this commit is actually a
>> bug fix!
>>
>> In line 499 we have:
>> 	if (list + delete + verify > 1)
>> 		usage_with_options(git_tag_usage, options);
>> Now if we give one of the options twice, we'll get the usage informati=
on.
>> (i.e. 'git tag --verify --verify <tagname>' and
>> 'git --delete --delete <tagname>' yield usage information and do not
>> do the intended command.)
>>
>> This could have been fixed by rewriting the line to
>> 	if (!!list + !!delete + !!verify > 1)
>> 		usage_with_options(git_tag_usage, options);
>> or as it happened in this patch by having the parameters not
>> counting up for each occurrence, but the OPT_BOOL just setting the
>> variables to either 0 if the option is not given or 1 if the option is=

>> given multiple times.
>=20
> Makes twisted sort of sense ;-).
>=20
>> However we could discuss if the negated options do make sense
>> here, or if we don't want to allow them here, as this seems valid
>> (before and after this patch):
>>
>> 	git tag --no-verify --delete <tagname>
>=20
> It probably does not.  As you hinted in your earlier patch, we may
> want to introduce a "only can set to true" boolean used solely to
> specify these things.  They are disguised as "options", but are in
> fact command operation modes that are often mutually exclusive.
>=20
> For these operation modes that are mutually exclusive, there are
> multiple possible implementations:
>=20
>  * One OPT_BOOL_NONEG per option; the code ensures the mutual
>    exclusion with "if (list + delete + verify > 1)";
>=20
>  * One OPT_BIT per option in a single variable; the code ensures the
>    mutual exclusion with count_bits, which may be a lot more
>    cumbersome;
>=20
>  * OPT_SET_INT that updates a single variable to enum; instead of
>    making it an error to give two conflicting modes, this would give
>    us the last-one-wins rule.
>=20
> Unlike usual "options", we generally do not want the last-one-wins
> semantics for command operation modes, I think.
>=20
> Perhaps we would want something like this?
>=20
> -- >8 --
> Subject: [PATCH] parse-options: add OPT_CMDMODE()
>=20
> This can be used to define a set of mutually exclusive "command
> mode" options, and automatically catch use of more than one from
> that set as an error.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  parse-options.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  parse-options.h |  3 +++
>  2 files changed, 56 insertions(+), 5 deletions(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index c2cbca2..62e9b1c 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -43,8 +43,42 @@ static void fix_filename(const char *prefix, const c=
har **file)
>  	*file =3D xstrdup(prefix_filename(prefix, strlen(prefix), *file));
>  }
> =20
> +static int opt_command_mode_error(const struct option *opt,
> +				  const struct option *all_opts,
> +				  int flags)
> +{
> +	const struct option *that;
> +	struct strbuf message =3D STRBUF_INIT;
> +	struct strbuf that_name =3D STRBUF_INIT;
> +
> +	/*
> +	 * Find the other option that was used to set the variable
> +	 * already, and report that this is not compatible with it.
> +	 */
> +	for (that =3D all_opts; that->type !=3D OPTION_END; that++) {
> +		if (that =3D=3D opt ||
> +		    that->type !=3D OPTION_CMDMODE ||
> +		    that->value !=3D opt->value ||
> +		    that->defval !=3D *(int *)opt->value)
> +			continue;
> +
> +		if (that->long_name)
> +			strbuf_addf(&that_name, "--%s", that->long_name);
> +		else
> +			strbuf_addf(&that_name, "-%c", that->short_name);
> +		strbuf_addf(&message, ": incompatible with %s", that_name.buf);
> +		strbuf_release(&that_name);
> +		opterror(opt, message.buf, flags);
> +		strbuf_release(&message);
> +		return -1;
> +	}
> +	return opterror(opt, ": incompatible with something else", flags);
> +}
> +
>  static int get_value(struct parse_opt_ctx_t *p,
> -		     const struct option *opt, int flags)
> +		     const struct option *opt,
> +		     const struct option *all_opts,
> +		     int flags)
>  {
>  	const char *s, *arg;
>  	const int unset =3D flags & OPT_UNSET;
> @@ -83,6 +117,16 @@ static int get_value(struct parse_opt_ctx_t *p,
>  		*(int *)opt->value =3D unset ? 0 : opt->defval;
>  		return 0;
> =20
> +	case OPTION_CMDMODE:
> +		/*
> +		 * Giving the same mode option twice, although is unnecessary,
> +		 * is not a grave error, so let it pass.
> +		 */
> +		if (*(int *)opt->value && *(int *)opt->value !=3D opt->defval)
> +			return opt_command_mode_error(opt, all_opts, flags);
> +		*(int *)opt->value =3D opt->defval;
> +		return 0;
> +
>  	case OPTION_SET_PTR:
>  		*(void **)opt->value =3D unset ? NULL : (void *)opt->defval;
>  		return 0;
> @@ -143,12 +187,13 @@ static int get_value(struct parse_opt_ctx_t *p,
> =20
>  static int parse_short_opt(struct parse_opt_ctx_t *p, const struct opt=
ion *options)
>  {
> +	const struct option *all_opts =3D options;
>  	const struct option *numopt =3D NULL;
> =20
>  	for (; options->type !=3D OPTION_END; options++) {
>  		if (options->short_name =3D=3D *p->opt) {
>  			p->opt =3D p->opt[1] ? p->opt + 1 : NULL;
> -			return get_value(p, options, OPT_SHORT);
> +			return get_value(p, options, all_opts, OPT_SHORT);
>  		}
> =20
>  		/*
> @@ -177,6 +222,7 @@ static int parse_short_opt(struct parse_opt_ctx_t *=
p, const struct option *optio
>  static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
>                            const struct option *options)
>  {
> +	const struct option *all_opts =3D options;
>  	const char *arg_end =3D strchr(arg, '=3D');
>  	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NU=
LL;
>  	int abbrev_flags =3D 0, ambiguous_flags =3D 0;
> @@ -253,7 +299,7 @@ is_abbreviated:
>  				continue;
>  			p->opt =3D rest + 1;
>  		}
> -		return get_value(p, options, flags ^ opt_flags);
> +		return get_value(p, options, all_opts, flags ^ opt_flags);
>  	}
> =20
>  	if (ambiguous_option)
> @@ -265,18 +311,20 @@ is_abbreviated:
>  			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
>  			abbrev_option->long_name);
>  	if (abbrev_option)
> -		return get_value(p, abbrev_option, abbrev_flags);
> +		return get_value(p, abbrev_option, all_opts, abbrev_flags);
>  	return -2;
>  }
> =20
>  static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg=
,
>  			    const struct option *options)
>  {
> +	const struct option *all_opts =3D options;
> +
>  	for (; options->type !=3D OPTION_END; options++) {
>  		if (!(options->flags & PARSE_OPT_NODASH))
>  			continue;
>  		if (options->short_name =3D=3D arg[0] && arg[1] =3D=3D '\0')
> -			return get_value(p, options, OPT_SHORT);
> +			return get_value(p, options, all_opts, OPT_SHORT);
>  	}
>  	return -2;
>  }
> diff --git a/parse-options.h b/parse-options.h
> index c378b75..2404e06 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -13,6 +13,7 @@ enum parse_opt_type {
>  	OPTION_COUNTUP,
>  	OPTION_SET_INT,
>  	OPTION_SET_PTR,
> +	OPTION_CMDMODE,
>  	/* options with arguments (usually) */
>  	OPTION_STRING,
>  	OPTION_INTEGER,
> @@ -130,6 +131,8 @@ struct option {
>  #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
>  #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), N=
ULL, \
>  				      (h), PARSE_OPT_NOARG, NULL, (p) }
> +#define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NU=
LL, \
> +				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
>  #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N=
_("n"), (h) }
>  #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (=
a), (h) }
>  #define OPT_STRING_LIST(s, l, v, a, h) \
>=20

Your approach seems more like what we really want, however I'd have
some points:
 * Is it a good idea to have so many different OPT_MODE or
   OPTION_MODE defines? In my attempts I tried to reuse existing
   OPTION_s to not pollute the parsing infrastructure with more
   lines of code. ;)

 * You can only have one OPTION_CMDMODE in one argv vector right?
   I searched through the commands (... > 1) and did not find any
   places, where we'd want to have multiple 'groups' of exclusive=20
   commands, such as (either A or B) and/or (either C or D)
   This cmd_mode would just all a (either A, B, C or D), but that
   should be good for now.

 * This command mode could also be used for builtin/branch:
	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!u=
nset_upstream > 1)
		usage_with_options(builtin_branch_usage, options); =20
   as well as commit:
	if (!!also + !!only + !!all + !!interactive > 1)
		die(_("Only one of --include/--only/--all/--interactive/--patch can be =
used."));
   as well as for checkout:
	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_bra=
nch) > 1)
		die(_("-b, -B and --orphan are mutually exclusive"));
   So if we'd introduce this command mode, I'd be happy to supply patches=

   for branch, commit and checkout to use the new exclusive mechanism.
=20
So I think I like it.
Reviewed-by: Stefan Beller <stefanbeller@googlemail.com>



--------------enig15AD34ED3C1D03A855134D35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+C6LAAoJEJQCPTzLflhqICMP/3ZoITJ1+M+91+FtlTi4HP5h
hhwPu1odqshr/hVjhMG1t3jjhB04ZSjz2uw6TJAo7/7wbFKgZw8/yc9RZbfSb1pb
8sCO9ksJ85fKJHy1xIhNd+xlUSztPqKABBD0MClVb7DQUQe3TTKfYUTEbGw9kF5k
V++bX96qtEP1lATgu8m6LQo66yI+Jz6K61KLagJf7AbD+b4WBIjQWfRNARob1dz1
nIj0Y1njobEUBHVo1ig+VBP9Df3cFajDIl8Kt/6g3CIjFP/+XQv3TguAaemVJF37
wIG0yBbTlNsyVCcBquGm41NVkg9zRW/WaSWllSWm4FV3AmIyufpq49IHsLCLTpYk
F6rZyrfn0cX3cF/I4ikWbcONruAYx/TtEG6FFkeXDxbIh64Dw0u5v5D+QHBLfrMQ
bfWXXnFDVvdWgyVIs/cdNPD2dZn/kqhQ2pBA1KwItc/K1ChrwBu3grLfC6lLtzHw
FxP3YPXEK7xOd2c6yxzoGdyCIPmlSwG6Kr3C6n1+QsCZALqV+d+BCucAwZD6Bfk9
USqVq1hZ+1/qg7DPXY22ATTzm1ppL6OyssR/1tkGx9WhVbAA6ZXBwaBZS1eseon+
0SYay5QodkaUiMR4vsNF4+XjV93muXBpQFDhHVZPdMmf/w58kr4C3WcXkuVQ99MB
wJuMqqavB78sECEZPWN1
=d2Ln
-----END PGP SIGNATURE-----

--------------enig15AD34ED3C1D03A855134D35--
