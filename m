From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/test-hg*.sh: Do not use PYTHON_PATH
Date: Wed, 17 Apr 2013 09:45:17 -0700
Message-ID: <7vobddf6n6.fsf@alter.siamese.dyndns.org>
References: <201304171610.49384.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 17 18:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USVUD-0003gs-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab3DQQpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 12:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab3DQQpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 12:45:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E8D316C9B;
	Wed, 17 Apr 2013 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SRwhIcAp+8qs
	L87wJkOigB7jIuQ=; b=VOO71cUAFV+/Zsn1K4ia1x0F5v0YOgbXB67gToJp6ige
	i2ofCkY+U1HcNweXLRIKJddsYO7b/TksjQ8SlujrXHFQ0rkQSx8a9jyVjAotZfgb
	bjoEFrEIUFU4Fe1X9A2dGLAhWT1PiJGxfzASY3Qq8lZ8pHK3hv1l0ON9nPNCUro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZZu0DE
	QPRFZsbYY0CPRuFvba5QQt3yQwHOfJk2GVcNntl3NHSLsSXedCm3xfvWVJ/OFRZb
	ywAFowEtufaNRx9huBV0J2TzsbG8SeNRo1iYeuyRSFZmWNZjzC3w3F8Job0YMPcI
	43Jxmg7h9Z/fll3LZFonNEZ3NxMFnWNYRtHzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9570516C9A;
	Wed, 17 Apr 2013 16:45:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C98B316C95;
	Wed, 17 Apr 2013 16:45:18 +0000 (UTC)
In-Reply-To: <201304171610.49384.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Wed, 17 Apr 2013 16:10:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 300BEDB8-A77E-11E2-A981-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221552>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The test cases in contrib/remote-helpers use mercurial and python.
> Before the tests are run, we check if python can import
> "mercurial" and "hggit".
> To run this check, python pointed out by PYTHON_PATH is used.
> This may not work when different python binaries exist,
> and PYTHON_PATH is not set:
>  Makefile sets it to the default /usr/bin/python
>  The PATH may point out e.g. /sw/bin/python.
> When /sw/bin/python has the mercurial module installed,
> but /usr/bin/python has not, the test will not be run.
> Git respects PYTHON_PATH, hg does not.

The above problem analysis looks sensible.

> Use python instead of $PYTHON_PATH to check for installed modules.

But I am not sure if I agree with the solution.  Going back to the
analysis, I find this:

> This may not work when different python binaries exist,
> and PYTHON_PATH is not set:

Isn't the real problem that PYTHON_PATH is not set to point at the
instance of a python with mercurial module for it?  Why not make
sure it is set and can be seen by tests correctly?

I do not offhand know where in the contrib/remote-helpers/ part the
user is expected to tweak PYTHON_PATH variable, and if the variable
is correctly arranged to be exported to the environment when running
the tests, but your problem analysis tells me that that is the part
you would want to fix.  If a default-fallback value for PYTHON_PATH
is the easiest solution to the problem, you could even solve that in
the "export it while running the tests" logic.

Perhaps adding

	PYTHON_PATH ?=3D python
	export PYTHON_PATH

to contrib/remote-helpers/Makefile and changing nothing else would
be a starting point for a more reasonable fix to the issue?

> While at it, split exportX=3DY into 2 lines

That is an important portability fix, but as you said "while at it",
it is orthogonal.

>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  contrib/remote-helpers/test-hg-bidi.sh   | 14 +++++++++-----
>  contrib/remote-helpers/test-hg-hg-git.sh | 12 +++++++-----
>  contrib/remote-helpers/test-hg.sh        |  2 +-
>  3 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-=
helpers/test-hg-bidi.sh
> index f368953..9f4a430 100755
> --- a/contrib/remote-helpers/test-hg-bidi.sh
> +++ b/contrib/remote-helpers/test-hg-bidi.sh
> @@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
> +if ! python -c 'import mercurial'; then
>  	skip_all=3D'skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
> @@ -68,10 +68,13 @@ setup () {
>  	) >> "$HOME"/.hgrc &&
>  	git config --global remote-hg.hg-git-compat true
> =20
> -	export HGEDITOR=3D/usr/bin/true
> +	HGEDITOR=3D/usr/bin/true
> +	export HGEDITOR
> =20
> -	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
> -	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
> +	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
> +	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
> +
> +	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE
>  }
> =20
>  setup
> @@ -88,7 +91,8 @@ test_expect_success 'encoding' '
>  	git add alpha &&
>  	git commit -m "add =C3=A4lph=C3=A0" &&
> =20
> -	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
> +	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
> +	export GIT_AUTHOR_NAME &&
>  	echo beta > beta &&
>  	git add beta &&
>  	git commit -m "add beta" &&
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remot=
e-helpers/test-hg-hg-git.sh
> index 253e65a..5414f81 100755
> --- a/contrib/remote-helpers/test-hg-hg-git.sh
> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
> @@ -15,12 +15,12 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
> +if ! python -c 'import mercurial'; then
>  	skip_all=3D'skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import hggit'; then
> +if ! python -c 'import hggit'; then
>  	skip_all=3D'skipping remote-hg tests; hg-git not available'
>  	test_done
>  fi
> @@ -103,10 +103,12 @@ setup () {
>  	git config --global receive.denycurrentbranch warn
>  	git config --global remote-hg.hg-git-compat true
> =20
> -	export HGEDITOR=3D/usr/bin/true
> +	HGEDITOR=3D/usr/bin/true
> +	export HGEDITOR
> =20
> -	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
> -	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
> +  GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
> +  GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
> +  export GIT_AUTHOR_DATE GIT_COMMITTER_DATE
>  }
> =20
>  setup
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpe=
rs/test-hg.sh
> index d5b8730..8614fa1 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
> +if ! python -c 'import mercurial'; then
>  	skip_all=3D'skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
