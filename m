From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just a
 branch
Date: Mon, 12 Oct 2009 14:06:46 -0700
Message-ID: <7vr5t8coex.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDh-0002of-RQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933090AbZJLVHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 17:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbZJLVHg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932998AbZJLVHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 17:07:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 687A05667A;
	Mon, 12 Oct 2009 17:06:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=txl2bCAd9p4HDTbqPE62cn6B4
	vs=; b=ArFLfBQGXkjl+yrtONHEYLrKo2YrMTm2GOR7biWaT3CthXuyJ13Zv7GC2
	a4Ep5cL6C0lypuWQoEFYcV98g3tsqFSM0rJ0fPcb0nj1qMi0bLWxwGlr0OGX611T
	FbTyvCrL2KGQU9uPLIs5cZLghIlgX6v8GYpe7iUwxplHRQO3TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=wLf20auDsswdaPXbmJN
	70LvjabmNhpFe4FHASvFpZ2RYCfteWpP056hf5yLwcu4C+jC0FojqSWl6dvnrS+M
	HCSHmiblus9EBvURLtb1FBOi4iaYCpcNdU793MnGMhB+WwAg9EpXxIHtzVkJ38cm
	4LlQ0x7EsZ0/k81XeQyHKD5M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A84556679;
	Mon, 12 Oct 2009 17:06:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AE4856678; Mon, 12 Oct
 2009 17:06:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28E30746-B773-11DE-8D45-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130075>

Anders Kaseorg <andersk@MIT.EDU> writes:

> =E2=80=98git bisect reset=E2=80=99 could already checkout an arbitrar=
y commit if you
> were on a detached HEAD before starting the bisection.  This lets you
> specify an arbitrary commit to =E2=80=98git bisect reset <commit>=E2=80=
=99.
>
> This also provides a way to clean the bisection state without moving
> HEAD: =E2=80=98git bisect reset HEAD=E2=80=99.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  git-bisect.sh |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 6f6f039..d319b9f 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -311,8 +311,7 @@ bisect_reset() {
>  	}
>  	case "$#" in
>  	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
> -	1) git show-ref --verify --quiet -- "refs/heads/$1" ||
> -	       die "$1 does not seem to be a valid branch"
> +	1) git rev-parse --verify "$1^{commit}" || exit
>  	   branch=3D"$1" ;;
>  	*)
>  	    usage ;;

Thanks.

The "one parameter" case dates back to the original bisect implementati=
on
in commit 8cc6a08 (Making it easier to find which change introduced a b=
ug,
2005-07-30), and the only reason of existence for that case was that th=
e
code looked like this back then:

    bisect_reset() {
           case "$#" in
           0) branch=3Dmaster ;;
           1) test -f "$GIT_DIR/refs/heads/$1" || {
                  echo >&2 "$1 does not seem to be a valid branch"
                  exit 1
              }
              branch=3D"$1" ;;
            *)
              usage ;;
           esac
    ...

An important difference to notice, compared to a more recent version, i=
s
that we did not remember (nor use) the original branch, and without an
argument we always switched to 'master'.  Back then, the user who start=
ed
bisecting a side branch needed to remember the name of the branch befor=
e
starting the bisection, and needed to give that to the reset subcommand=
=2E

Because we remember where we came from these days, I do not think it ma=
kes
much sense to even keep this "one parameter" case, let alone extending
this interface to allow switching to an arbitrary commit.

I even think that the support for an explicit branch name in the reset
subcommand should eventually be deprecated, perhaps unless it matches w=
hat
is stored in BISECT_START.

The documentation, does not even talk about what the optional <branch>
argument is good for, even though it lists the optional <branch> in the
synopsis section.

Having said all that, four years and two months are looooooong time in =
git
timescale, and I am discounting, without any evidence to judge either w=
ay,
the possibility that people may have learned during that time to (ab)us=
e
this as a (very useful?) shortcut to finish the current bisection and
switch to some entirely different branch.

I offhand do not see a good rationale for such a shortcut to finish bis=
ect
and switch to another branch (IOW, I understand "it is shorter to type"=
,
but I do not see "it is often done and very useful"), but I am open to =
be
enlightened by a workflow where such a shortcut is useful.
