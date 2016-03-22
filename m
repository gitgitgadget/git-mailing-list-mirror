From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] branch -D: allow - as abbreviation of '@{-1}'
Date: Tue, 22 Mar 2016 11:00:40 +0100
Message-ID: <vpqegb2omrb.fsf@anie.imag.fr>
References: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	sbeller@google.com
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:00:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiJ7N-0001Ke-CR
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 11:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758456AbcCVKAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 06:00:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37395 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758368AbcCVKAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 06:00:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2MA0d9Z013766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 22 Mar 2016 11:00:39 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2MA0ec6021223;
	Tue, 22 Mar 2016 11:00:40 +0100
In-Reply-To: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
	(Elena Petrashen's message of "Tue, 22 Mar 2016 11:24:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 22 Mar 2016 11:00:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2MA0d9Z013766
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459245640.35493@cA29tbrV6aCINEyNPdxTDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289502>

Hi, and thanks for the quick reroll.

A small advice: don't hesitate to reply to reviewers in the thread for
v1. As a reviewer, I appreciate a quick reply like "OK, will do in v2",
or even "I disagree, I think my version is better because: ..." (I'm no=
t
_always_ right ;-) ).

Elena Petrashen <elena.petrashen@gmail.com> writes:

> Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>
> ---
> This micro-patch is meant to allow =E2=80=9C-=E2=80=9C as a short-han=
d for
> =E2=80=9C@{-1} for branch -D (Cf. $gmane/230828):
>
> * based on the discussion on the previous version of the patch,
> added the advice on how to restore the deleted branch using
> git branch deleted_name sha1 - to ensure safety and=20
> newbie-friendliness
>
> * git branch (-d | -D) is not supposed to accept any other
> arguments except for branch name so it makes sense to replace
> the argv[i] with @{-1}. We will not lose the opportunity to
> use it for something different for other git branch uses if
> we will decide it=E2=80=99s required.

As much as possible, try to distinguish new things in this version and
general remarks on your patch. Here, the first point is new and could
appear below "Changes since v1". The second is not new, I think you can
either consider that it is a followup to previous discussion (as Eric
interpreted it in v1) and remove the comment from v2, or consider it as
a justification of why your patch is sensible and include it in the
commit message (what I suggested in v1, but Eric more or less convinced
me that I was wrong).

> * if there=E2=80=99s no previous branch in the repository yet, a
> specific warning message is given

As I said in v1, I think this is a separate topic and should be moved t=
o
a separate patch. As I said above, you are free to disagree (and it's
not terribly important), but avoid leaving discussions open.

One point in favor of splitting the patch is that it's a good exercice
for a newcommer ;-).
> +	if (!strcmp(argv[dash_position], "-")){

Style: space between ) and {.

> @@ -213,7 +223,8 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds,
>  	for (i =3D 0; i < argc; i++, strbuf_release(&bname)) {
>  		const char *target;
>  		int flags =3D 0;
> -
> +		if (expand_dash_shortcut (argv, i))
> +			dash_shortcut =3D 1;

Nit: the blank line removal is not needed.

> +			if (dash_shortcut =3D=3D 1)
> +			       printf( _("\nIf that happened by mistake, you may want to =
restore"

Style: no space after (.

> +				" it with:\n\ngit branch %s %s\n"), bname.buf,
> +				find_unique_abbrev(sha1, DEFAULT_ABBREV));

I think the message is overly long (4 '\n', and I think "If that
happened by mistake" is not needed, just "to restore the branch,
run ..." would be enough).

A rule that is usually applied for messages with Git:

* If the message is triggered by a user-error, then it's OK to have a
  long and possibly scary message: advanced users are not supposed to
  see it.

* If the message is seen by normal users in daily usage, then

  - we try to keep it as short as possible.

  - if it's not short enough, we allow disabling it with an advice.*
    configuration variable.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
