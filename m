From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch, upload-pack: add --no-shallow for infinite
 depth
Date: Thu, 10 Jan 2013 19:55:29 -0800
Message-ID: <7vtxqocr0u.fsf@alter.siamese.dyndns.org>
References: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
 <1357875005-21956-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 04:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtVim-0004oJ-QH
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab3AKDze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 22:55:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846Ab3AKDzd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 22:55:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B850BB95B;
	Thu, 10 Jan 2013 22:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xf2c57Rg3b9Z
	YoEIpNxaS2Ejivg=; b=aHJYpj2RVw91umxKX0F8oY7LwGLIXPirftEi1fBDJEp6
	4qflfvF1sP4GZRJE0LDbtbOBjsmOsBaqDrIx5ZdEwFKdrxjvLIH9ebps86KvxHyj
	mVh2TSCfPKpESFZbe3roZmOeWN2gjiWKBj4swmc1x/7+drtQ8I/Z3cp5X8oR5g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qlIE+Q
	fEl5+rLiq99MCo72gny1DKpyBLhlgrKmYGuwxh+u0n+guw0e/rNlgCk15LzyS8WO
	pjaJLCN9hFMScaADczUDcRijdlUtck54ntoxR0MnbKrXmsWUIBZcWwZWHsdNBn19
	h5+ZR1EbcgaUI3urXQJs5xl4cTbh7HsLMMLv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA74FB959;
	Thu, 10 Jan 2013 22:55:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D256BB954; Thu, 10 Jan 2013
 22:55:31 -0500 (EST)
In-Reply-To: <1357875005-21956-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 11 Jan
 2013 10:30:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BED0F3D6-5BA2-11E2-9A78-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213172>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The user can do --depth=3D2147483647 (*) for infinite depth now. But
> it's hard to remember. Any other numbers larger than the longest
> commit chain in the repository would also do, but some guessing may
> be involved. Make easy-to-remember --no-shallow an alias for
> --depth=3D2147483647.

I think "no shallow" makes sense in a much more important way than
"infinite depth", and this patch is a good idea for a reason
entirely different from the justification your log message makes ;-)

We explain that "clone --depth=3D<number>" is a way to end up with a
partial repository that contains only the recent history, and while
this may give users a smaller repository, in return the result will
be a "shallow repository" with certain limitations (i.e. fetching or
cloning from such a repository will be refused).

We also explain that the reason to use --depth=3D<number> is to grab
some history behind what you originally acquired into your "shallow
repository" so that you have deeper history than your original
"shallow repository".

A reader who does not know how this shallowness is implemented
cannot be blamed if she thinks the shallowness is a permanent
attribute of a repository, and once a repository is tainted by
shallowness, it cannot be wiped away by deepening it, because
nowhere in the documentation we say the "shallowness" will go away
once you grabbed enough number of older commits with it.

Calling the option "--no-shallow" (or even better, "--unshallow",
meaning "make it a repository that is no longer shallow") makes it
crystal clear that the option is about wiping away the shallowness.
Of course, the result has to contain an untruncted history, but that
is a mere side effect and an implementation detail from the end
user's point of view.

> Make upload-pack recognize this special number as infinite depth. The
> effect is essentially the same as before, except that upload-pack is
> more efficient because it does not have to traverse to the bottom
> any more. The chance of a user actually wanting exactly 2147483647
> commits depth, not infinite, on a repository with a history that long=
,
> is probably too small to consider.
>
> (*) This is the largest positive number a 32-bit signed integer can
>     contain. JGit and older C Git store depth as "int" so both are OK
>     with this number. Dulwich does not support shallow clone.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/fetch-options.txt     |  4 ++++
>  Documentation/git-fetch-pack.txt    |  2 ++
>  Documentation/technical/shallow.txt |  3 +++
>  builtin/fetch.c                     | 15 ++++++++++++++-
>  commit.h                            |  3 +++
>  t/t5500-fetch-pack.sh               | 16 ++++++++++++++++
>  upload-pack.c                       | 13 ++++++++++---
>  7 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-op=
tions.txt
> index 6e98bdf..012d1b2 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -13,6 +13,10 @@
>  	to the specified number of commits from the tip of each remote
>  	branch history. Tags for the deepened commits are not fetched.
> =20
> +--no-shallow::
> +	Deepen to the roots of the repository's history (i.e. the
> +	result repository is no longer shallow).
> +

Mentioning both is a good thing, but I think "no longer shallow" is
more important aspect of this operation than "deepen to the roots".

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 6322e8a..6a6e672 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -264,6 +264,22 @@ test_expect_success 'clone shallow object count'=
 '
>  	grep "^count: 52" count.shallow
>  '
> =20
> +test_expect_success 'fetch --depth --no-shallow' '
> +	(
> +		cd shallow &&
> +		test_must_fail git fetch --depth=3D1 --no-shallow
> +	)
> +'
> +
> +test_expect_success 'infinite deepening (full repo)' '
> +	(
> +		cd shallow &&
> +		git fetch --no-shallow &&
> +		git fsck --full &&
> +		! test -f .git/shallow

This looks as if fsck is what removes .git/shallow but I do not
think that is what is being tested...

> diff --git a/upload-pack.c b/upload-pack.c
> index 6142421..88f0029 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -670,10 +670,17 @@ static void receive_needs(void)
>  	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
>  		return;
>  	if (depth > 0) {
> -		struct commit_list *result, *backup;
> +		struct commit_list *result =3D NULL, *backup =3D NULL;
>  		int i;
> -		backup =3D result =3D get_shallow_commits(&want_obj, depth,
> -			SHALLOW, NOT_SHALLOW);
> +		if (depth =3D=3D INFINITE_DEPTH)
> +			for (i =3D 0; i < shallows.nr; i++) {
> +				struct object *object =3D shallows.objects[i].item;
> +				object->flags |=3D NOT_SHALLOW;
> +			}
> +		else
> +			backup =3D result =3D
> +				get_shallow_commits(&want_obj, depth,
> +						    SHALLOW, NOT_SHALLOW);

Nice.  Thanks.
