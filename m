From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/12] worktree.c: test if branch being rebased in another worktree
Date: Wed, 20 Apr 2016 11:04:31 -0700
Message-ID: <xmqqh9eww40g.fsf@gitster.mtv.corp.google.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:04:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aswUi-0006w3-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcDTSEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 14:04:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998AbcDTSEe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 14:04:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FFF113517;
	Wed, 20 Apr 2016 14:04:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uryKOsmtkkhA
	JE+sCT3lhQH69Ms=; b=j49G9xdwlV+H6WqbU3ouAEYUk0HdhCo1Dmgqyigm67A6
	VVzM7kIQWiwHILk16/Qwp3srVRCc8pamwIBUVuNXZdyUBGWYzcBYHWinWhoyEeF+
	T/BFJ16bgKlrgMmOZ5QNx9cU2QvQlIGzZLR+EXfIn3maoAIern4KUHGKnxTjeXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fap+TY
	3IeTI98fB5/5MUImUk0Rh4Mw5j5zadKzS5ryeV5hLcdSI59YsWmD5qyxB9Ke17YG
	g1v2YdgKqVU9wBzExSRXnc2DWMiR+AJLUU53nIPDDhgLpCg4R7zcJcA+D/XEvrKq
	xLvJPZesh7Ab8RN7Gk5wHhsGiRh9bLhzEXJZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 281CC13516;
	Wed, 20 Apr 2016 14:04:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 926EF13515;
	Wed, 20 Apr 2016 14:04:32 -0400 (EDT)
In-Reply-To: <1461158693-21289-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Apr 2016 20:24:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55803372-0722-11E6-A553-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292048>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Subject: Re: [PATCH v2 09/12] worktree.c: test if branch being rebase=
d in another worktree

Lacks the verb?  Perhaps s/being/is/ is sufficient.

> This function find_shared_symref() is used in a couple places:
>
> 1) in builtin/branch.c: it's used to detect if a branch is checked ou=
t
>    elsewhere and refuse to delete the branch.
>
> 2) in builtin/notes.c: it's used to detect if a note is being merged =
in
>    another worktree
>
> 3) in branch.c, the function die_if_checked_out() is actually used by
>    "git checkout" and "git worktree add" to see if a branch is alread=
y
>    checked out elsewhere and refuse the operation.
>
> In cases 1 and 3, if a rebase is ongoing, "HEAD" will be in detached
> mode, find_shared_symref() fails to detect it and declares "no branch=
 is
> checked out here", which is incorrect.

which is technically correct but is not what we want to check.

> This patch tightens the test. If the given symref is "HEAD", we try t=
o
> detect if rebase is ongoing. If so return the branch being rebased. T=
his
> makes checkout and branch delete operations safer because you can't
> checkout a branch being rebased in another place, or delete it.

Is rebase the only thing that tentatively detach before working on
the real branch?  It may be currently the case, but I would imagine
that we want to makefind-shared-symref to be responsible for
detecting new cases other than rebase that we may introduce in the
future, in which case we may want to leave come comment near the
function to describe that expectation.

> Special case for checkout. If the current branch is being rebased,
> git-rebase.sh may use "git checkout" to abort and return back to the
> original branch. The updated test in find_shared_symref() will preven=
t
> that and "git rebase --abort" will fail as a result.
> find_shared_symref() and die_if_checked_out() have to learn a new
> option ignore_current_worktree to loose the test a bit.

s/loose/&n/

> +void die_if_checked_out(const char *branch, int ignore_current_workt=
ree)
>  {
>  	const struct worktree *wt;
> =20
> -	wt =3D find_shared_symref("HEAD", branch);
> +	wt =3D find_shared_symref("HEAD", branch, ignore_current_worktree);
>  	if (wt) {
>  		skip_prefix(branch, "refs/heads/", &branch);
>  		die(_("'%s' is already checked out at '%s'"),
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index efcbd8f..6041718 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1111,7 +1111,7 @@ static int checkout_branch(struct checkout_opts=
 *opts,
>  		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
>  		if (head_ref &&
>  		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
> -			die_if_checked_out(new->path);
> +			die_if_checked_out(new->path, 1);
>  		free(head_ref);
>  	}

So the idea is "if the branch is checked out (or "being worked on"
even if technically the HEAD is detached, like with 'rebase')
anywhere, callers of die-if-checked-out in general want to die; but
for this caller, it is OK if the place the branch is checked out or
being worked on is in this repository"?

I understand die_if_checked_out() taking that "ignore this one" bit
may be sensible, but I do not understand why find_shared_symref()
needs to be told about it.  The change makes the meaning of the
find_shared_symref() function unclear.  It used to mean "This
symbolic ref cannot point at the same ref in different worktrees, so
for a given pair of a symbolic ref and a concrete ref, there can be
at most one worktree in which the symbolic ref points at that ref".
That is already a mouthful.  As the worktree structure already have
"Am I the current worktree?" bit, "ignore" logic can easily be done
inside die_if_checked_out() and that would help find_shared_symref()
stay simpler and more focused function, no?
