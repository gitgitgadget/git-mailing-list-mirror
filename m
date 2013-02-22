From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: segfault fixes and validation
Date: Fri, 22 Feb 2013 12:27:33 -0800
Message-ID: <7vvc9kccwa.fsf@alter.siamese.dyndns.org>
References: <7vvc9lv9rt.fsf@alter.siamese.dyndns.org>
 <1361533663-3172-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:28:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8zDv-0006cj-6u
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 21:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab3BVU1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 15:27:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301Ab3BVU1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2013 15:27:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42B2AC02;
	Fri, 22 Feb 2013 15:27:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VShrCTnCAdgg
	3RPgWK7jMCZAa0Y=; b=BeQ3GRfVglR9jOOr8VhNylZoiXPKasYPyrwWlNNB7NF6
	ULWGXIbjHR2DDXr3cc3Ny+mjefuZwnckFfYJNeMWYHOhpVE6yTPOOo5a53hjU9fD
	CQUIMcaGj3fAt9iAqxOZsfrbwz3l6UxgNJnlYHG/3TdY5nMZLhcWhJ9v8Z77s1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gfnIAP
	iSD8jx7lSp9WGgFS6f4luiM2gYm1zUtE/aQtVHY4O/wqqSHzNC375raQdaF+dP5d
	mF4YU5wfIBJLGnvmZlQNz7jNGBZdXQNfxLp6DqnNq+yWgE5gu5SltPZ8PGTkZEEB
	88mS7wuWBTqNdw3hUfkJ1ariJ/ZbBEM0UpxRs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9837CAC01;
	Fri, 22 Feb 2013 15:27:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C399EAC00; Fri, 22 Feb 2013
 15:27:35 -0500 (EST)
In-Reply-To: <1361533663-3172-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 22 Feb
 2013 18:47:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B32647A-7D2E-11E2-A2F4-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216858>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> branch_get() can return NULL (so far on detached HEAD only) but some
> code paths in builtin/branch.c cannot deal with that and cause
> segfaults. While at there, make sure we bail out when the user gives =
2
> or more arguments, but we only process the first one and silently
> ignore the rest.

Explain "2 or more arguments" in what context, perhaps?  Otherwise
it makes it sound as if "git branch foo bar baz" is covered with
this patch, no?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, Feb 22, 2013 at 12:47 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>  > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> wri=
tes:
>  >
>  >> branch_get() can return NULL (so far on detached HEAD only)...
>  >
>  > Do you anticipate any other cases where the API call should validl=
y
>  > return NULL?
> =20
>  No. But I do not see any guarantee that it may never do that in
>  future either. Which is why I was deliberately vague with "could not
>  figure out...". But you also correctly observed my laziness there. S=
o
>  how about this? It makes a special case for HEAD but not insist on
>  detached HEAD as the only cause.

Sure.  It looks better.

What you can do is to have a single helper function that can explain
why branch_get() returned NULL (or extend branch_get() to serve that
purpose as well); then you do not have to duplicate the logic twice
on the caller's side (and there may be other callers that want to do
the same).

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6371bf9..82ed337 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -889,6 +889,15 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>  	} else if (new_upstream) {
>  		struct branch *branch =3D branch_get(argv[0]);
> =20
> +		if (argc > 1)
> +			die(_("too many branches to set new upstream"));
> +
> +		if (!branch) {
> +			if (!argc || !strcmp(argv[0], "HEAD"))
> +				die(_("HEAD does not point to any branch. Is it detached?"));
> +			die(_("no such branch '%s'"), argv[0]);
> +		}
> +
>  		if (!ref_exists(branch->refname))
>  			die(_("branch '%s' does not exist"), branch->name);

The latter part of the new code triggers when branch_get() returns
NULL while doing "git branch --set-upstream-to=3DX [Y]".  When "Y" is
string "HEAD" or missing, the first die() is triggered and says a
funny thing. If HEAD does not point to any branch, by definition it
is detached.  The user may say "Yes, I know it is detached." but the
message does not help the user to figure out what to do next.

Instead of asking "Is it detached?", perhaps we can say something
like "You told me to set the upstream of HEAD to branch X, but " in
front?  At least, that will be a better explanation for the reason
why the operation is failing.

The existing test might be wrong, by the way.  Your HEAD may point
at a branch Y but you may not have any commit on it yet, and you may
want to allow setting the upstream of that to-be-born branch to
another branch X with "branch --set-upstream-to=3DX [Y|HEAD]".

While I think it is insane to do anything before creating the first
commit on your current branch (or using "checkout --orphan" in
general) and it may not be worth our time to babysit users who do
so, but the following sequence may feel natural to them:

	git checkout --orphan X
        git branch --set-upstream-to=3Dmaster

	... perhaps create an initial commit, perhaps not ...

	git merge @{upstream}

=46or that to work sanely, perhaps the pattern

	branch =3D branch_get();
        if (!branch)
		die due to no branch;
	if (!ref_exists(branch->refname))
		die due to typo in branch name

may need to be fixed globally, replacing ref_exists(branch->refname)
with branch_exists(branch) that returns true if branch->refname is
an existing ref, or the branch in question was obtained by checking
with current_branch (in remote.c), or something like that.
