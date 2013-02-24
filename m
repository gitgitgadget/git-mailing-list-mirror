From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: allow pattern escape using backslashes
Date: Sun, 24 Feb 2013 01:15:31 -0800
Message-ID: <7v7gly5az0.fsf@alter.siamese.dyndns.org>
References: <1357310809-4771-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 10:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Xgh-00074N-PW
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 10:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab3BXJPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2013 04:15:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab3BXJPe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 04:15:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3601AA3E3;
	Sun, 24 Feb 2013 04:15:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7p4qOnFXlDX8zCI5VVSZB4+J8
	Xw=; b=DSzMHucqVlMPW/zaFxhTWJ4fA9r4u7zrWjv0npLFmA7S3CCXua8jasLoC
	1X9RIusZI7ArA1xjVBRj480IXhENehaQqEdJeHZbMODWXk+Ad2YFSQgMb5YdLh8a
	NPn/xy4mQTCWVeT9EeVovsHeuUMViSVnXSb6rE7eCXXXhnpsdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=oxIY8aQ4T/rcB0qY47o
	Lx9m5RNmkOBwHs/AyZ5akbjfsUoy0tOxu3jiWxrQvBnYbIV0an4C1uZemq6jFYdE
	ZQK/p9hDmXtlWXDwuZtWdSE9UmNDtZ7ysqRm4LJ5H8DH9pw/oAQ9XbFDzfj7v0u1
	z4CVvpvu5wUmpXMgOn9qYHHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 299C2A3E0;
	Sun, 24 Feb 2013 04:15:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FDE8A3DD; Sun, 24 Feb 2013
 04:15:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDFE8A30-7E62-11E2-ACE8-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216984>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Patterns in .gitattributes are separated by whitespaces, which makes
> it impossible to specify exact spaces in the pattern. '?' can be used
> as a workaround, but it matches other characters too. This patch make=
s
> a space following a backslash part of the pattern, not a pattern
> separator.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>
>  A similar patch was posted twice (during freeze time iirc). I think
>  this is a good change, so I will keep reposting until someone turns
>  it down.
>
>  We could use wildmatch for parsing here, which would support pattern=
s
>  like "Hello[ ]world". But that's not going to happen until wildmatch
>  graduates and somebody brings it up again.

Do people have any comment on this?  Do we do something similar in
the .gitignore files already?

Speaking of .gitignore, I recall that there was a hanging discussion
on allowing a pattern to name the directory that the .gitignore file
appears in, which I do not think we currently support.  With such a
feature, instead of listing "/junk" in the .gitignore file at the
top-level to say that everything inside the "junk" directory is
ignored by default, we could instead say "<this>" at the beginning
of the .gitignore file in the "junk" directory.  I think "* <attr>"
in the .gitattributes file in a directory causes "git check-attr ."
in that directory to report the <attr>, and we may want to have some
way to allow "git check-ignore ." to be affected by the .gitignore
file in the same directory in a similar way, but I do not have a
very strong opinion.  Do people have any comment on this?

It is obviously too late for this cycle to do anything on the
'master' front on this topic (or the .gitignore), but it would be
good to reach concensus early so that we know what we want to do in
the next cycle.

>  Documentation/gitattributes.txt | 6 +++---
>  attr.c                          | 8 +++++++-
>  t/t0003-attributes.sh           | 5 +++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattri=
butes.txt
> index 2698f63..113b1f8 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -20,9 +20,9 @@ Each line in `gitattributes` file is of form:
> =20
>  	pattern	attr1 attr2 ...
> =20
> -That is, a pattern followed by an attributes list,
> -separated by whitespaces.  When the pattern matches the
> -path in question, the attributes listed on the line are given to
> +That is, a pattern followed by an attributes list, separated by
> +whitespaces that are not quoted by a backslash. When the pattern mat=
ches
> +the path in question, the attributes listed on the line are given to
>  the path.
> =20
>  Each attribute can be in one of these states for a given path:
> diff --git a/attr.c b/attr.c
> index 097ae87..776f34e 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -209,7 +209,13 @@ static struct match_attr *parse_attr_line(const =
char *line, const char *src,
>  	if (!*cp || *cp =3D=3D '#')
>  		return NULL;
>  	name =3D cp;
> -	namelen =3D strcspn(name, blank);
> +	namelen =3D 0;
> +	while (name[namelen] !=3D '\0' && !strchr(blank, name[namelen])) {
> +		if (name[namelen] =3D=3D '\\' && name[namelen + 1] !=3D '\0')
> +			namelen +=3D 2;
> +		else
> +			namelen++;
> +	}
>  	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
>  	    !prefixcmp(name, ATTRIBUTE_MACRO_PREFIX)) {
>  		if (!macro_ok) {
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 807b8b8..6a5d8ab 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -24,6 +24,7 @@ test_expect_success 'setup' '
>  		echo "offon -test test"
>  		echo "no notest"
>  		echo "A/e/F test=3DA/e/F"
> +		echo "A\\ b test=3Dspace"
>  	) >.gitattributes &&
>  	(
>  		echo "g test=3Da/g" &&
> @@ -196,6 +197,10 @@ test_expect_success 'root subdir attribute test'=
 '
>  	attr_check subdir/a/i unspecified
>  '
> =20
> +test_expect_success 'quoting in pattern' '
> +	attr_check "A b" space
> +'
> +
>  test_expect_success 'negative patterns' '
>  	echo "!f test=3Dbar" >.gitattributes &&
>  	test_must_fail git check-attr test -- f
