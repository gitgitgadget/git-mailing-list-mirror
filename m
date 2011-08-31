From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Wed, 31 Aug 2011 15:54:35 -0700
Message-ID: <7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
 <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Sep 01 00:54:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QytgD-0008Hg-R0
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 00:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab1HaWyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 18:54:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757177Ab1HaWyi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2011 18:54:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD71148CF;
	Wed, 31 Aug 2011 18:54:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=06fE2kyJ1m/+
	Uqnqr3MYflA4BkY=; b=OogAXMcXXBj1sYHCP+Po/ueu8yYqo7z1tWc3gCyDEG2O
	5pF2dsv7FXHEN8HuMn4Y7bB3ea92l3LgC+ux1TSiVJ4STHTFOKyp57juZD6rxi+K
	ZAKih5rXvkaaq8ENjMPwYfzuBurvoOuK4XFmQSuajSsyJplb64ZfmHIYOdM6mQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VqvA7b
	+6GamYVONEgsMU0XVwqpCzIQ+mllVbM6X3lsxKpLiZAsHGw0BZgixqhtRI+D925V
	eCXeVpGG6oo7Y7yctsZ3n0Neg/+EhtslyzGg72wP0KZoxFd2fsH1yfWJIlAcchK9
	bUbY9ifzVffj71lCgSg/0I5bf34ZkBQegkGrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41D648CE;
	Wed, 31 Aug 2011 18:54:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4D0248CD; Wed, 31 Aug 2011
 18:54:36 -0400 (EDT)
In-Reply-To: <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
 (=?utf-8?Q?=22Micha=C5=82=09G=C3=B3rny=22's?= message of "Wed, 31 Aug 2011
 11:11:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3386909E-D424-11E0-884D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180509>

Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> writes:

> Now %(contents:subject) contains the message subject, %(contents:body=
)
> main body part and %(contents:signature) GPG signature.
> ---

Please sign-off when submitting the final round of this patch.

> +The complete message in a commit and tag object is `contents`.
> +Its first line is `contents:subject`, the remaining lines
> +are `contents:body` and the optional GPG signature
> +is `contents:signature`.

To match the parsing of commit objects, I would prefer to see "subject"=
 to
mean "the first paragraph" (usually the first line alone but that is
purely from convention), but that probably is a separate topic.

To paraphrase the last part of your sentence, if a tag is merely annota=
ted
and not signed, contents:signature would be empty (I am just making sur=
e
that I am reading the description correctly).

Is it possible to get %(contents) with a combination of these three new
variants, or does the calling script need to see if each part is empty =
and
decide where to place newlines?  IOW, a na=C3=AFve attempt:

	--format=3D'%(contents:subject)\n%(contents:body)\n%(contents:signatur=
e)'

is not equivalent to

	--format=3D'%(contents)'

right?

> @@ -478,18 +481,20 @@ static void find_subpos(const char *buf, unsign=
ed long sz, const char **sub, con
>  	buf =3D strchr(buf, '\n');
>  	if (!buf) {
>  		*body =3D "";
> +		*signature =3D *body;
>  		return; /* no body */
>  	}
>  	while (*buf =3D=3D '\n')
>  		buf++; /* skip blank between subject and body */
>  	*body =3D buf;
> +	*signature =3D buf + parse_signature(buf, strlen(buf));

If there is no signature, parse_signature() would return (size_t) 0, no=
?
I suspect it may be easier for the caller if *signature pointed at the
terminating NUL at the end of the whole thing in such a case. Otherwise=
,
the caller that finds the buf and the signature points at the same addr=
ess
cannot tell if the object was a signed tag with no message

	$ git tag -s -m "" empty-tag

or if it was an annotated but not signed tag.

Or better yet, you may even want to stuff NULL there if there is no sig=
nature
so that it is absolutely clear for the caller which case it is.

>  static void grab_sub_body_contents(struct atom_value *val, int deref=
, struct object *obj, void *buf, unsigned long sz)
>  {
>  	int i;
> -	const char *subpos =3D NULL, *bodypos =3D NULL;
> +	const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
> =20
>  	for (i =3D 0; i < used_atom_cnt; i++) {
>  		const char *name =3D used_atom[i];
> @@ -500,19 +505,26 @@ static void grab_sub_body_contents(struct atom_=
value *val, int deref, struct obj
>  			name++;
>  		if (strcmp(name, "subject") &&
>  		    strcmp(name, "body") &&
> -		    strcmp(name, "contents"))
> +		    strcmp(name, "contents") &&
> +		    strcmp(name, "contents:subject") &&
> +		    strcmp(name, "contents:body") &&
> +		    strcmp(name, "contents:signature"))
>  			continue;
>  		if (!subpos)
> -			find_subpos(buf, sz, &subpos, &bodypos);
> +			find_subpos(buf, sz, &subpos, &bodypos, &sigpos);
>  		if (!subpos)
>  			return;
> =20
> -		if (!strcmp(name, "subject"))
> +		if (!strcmp(name, "subject") || !strcmp(name, "contents:subject"))
>  			v->s =3D copy_line(subpos);
>  		else if (!strcmp(name, "body"))
>  			v->s =3D xstrdup(bodypos);
>  		else if (!strcmp(name, "contents"))
>  			v->s =3D xstrdup(subpos);
> +		else if (!strcmp(name, "contents:body"))
> +			v->s =3D xstrndup(bodypos, sigpos - bodypos);
> +		else if (!strcmp(name, "contents:signature"))
> +			v->s =3D xstrdup(sigpos);

Again, how does this work for an annotated but not signed tag?
