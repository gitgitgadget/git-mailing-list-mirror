From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] git-stash: fix flag parsing
Date: Sat, 25 Sep 2010 12:58:24 +1000
Message-ID: <AANLkTim_sNJYRuAB35GTT-2YXY9oJ8rEWsCgO8qv-6nf@mail.gmail.com>
References: <953B8952-8928-43B3-A05D-6AEDC5D4B565@gernhardtsoftware.com>
	<1285366534-10490-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, robbat2@gentoo.org,
	Brandon Casey <drafnel@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 04:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzKy9-0006Ii-Dn
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 04:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab0IYC62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 22:58:28 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41651 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab0IYC61 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 22:58:27 -0400
Received: by qyk36 with SMTP id 36so2182701qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 19:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t45nUrFfNcM1EPX6cbi6YpNkeqf6rzKVjG2KAj1ksgQ=;
        b=Ot8yDIwRq2nWvpoBRZxtqRnGA3vkjK7NJcx5Dn0UgxwIrc3BGrPurdb5qkPZGE5hA1
         sgEamxd/+jAdaiZlVIe5frSxg+GMi58Y22sexA2I4FKh1xQntgO4qKikAYTJKfx4J9m8
         ehfsI/m8n6oj39eyePs0I95+n6s6PCYNwQSaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pwKGvS0+5XQWJ9RAYrF++1DC2gAz5nN0Ti7OuuqInAN33CpZJqT2/PzsLERefWjeG1
         ehpB2rcCc/SZ7+7wZ9IyW04D4Z8FVoKrWAZrKMgWNNzh1RbY38dtsR2uDoaeQpSQpJd1
         ArbgrYSWzLE3E+NlG38a9AIfMJN0vHBZJqnnI=
Received: by 10.229.218.143 with SMTP id hq15mr3245405qcb.34.1285383504246;
 Fri, 24 Sep 2010 19:58:24 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Fri, 24 Sep 2010 19:58:24 -0700 (PDT)
In-Reply-To: <1285366534-10490-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157108>

Thanks Brian. I've submitted what I hope is the simplest possible
rectification of my regression - apologies for not catching this
myself!

jon.

On Sat, Sep 25, 2010 at 8:15 AM, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
> Currently git-stash uses `git rev-parse --no-revs -- "$@"` to set its
> FLAGS variable. =C2=A0This is the same as `FLAGS=3D"-- $@"`. =C2=A0It=
 should use
> `git rev-parse --no-revs --flags "$@"`, but that eats any "-q" or
> "--quiet" argument. =C2=A0So move the check for quiet before rev-pars=
e.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
> =C2=A0Not the most elegant solution, but it works.
>
> =C2=A0I think we want to add the ability for git rev-parse to underst=
and
> =C2=A0`git rev-parse --no-revs --flags -- "$@"`, but I'm not sure if =
that
> =C2=A0would break anything else and don't have the time to do it righ=
t now.
>
> =C2=A0(This time with the right CC list.)
>
> =C2=A0git-stash.sh =C2=A0 =C2=A0 | =C2=A0 15 +++++++++++----
> =C2=A0t/t3903-stash.sh | =C2=A0 =C2=A08 ++++----
> =C2=A02 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 7ce818b..b44da41 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -264,8 +264,18 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0b_tree=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i_tree=3D
>
> + =C2=A0 =C2=A0 =C2=A0 # Work around rev-parse --flags eating -q
> + =C2=A0 =C2=A0 =C2=A0 for opt
> + =C2=A0 =C2=A0 =C2=A0 do
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$opt" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -q|--quiet)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_QUIET=3Dt
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
> + =C2=A0 =C2=A0 =C2=A0 done
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0REV=3D$(git rev-parse --no-flags --symboli=
c "$@" 2>/dev/null)
> - =C2=A0 =C2=A0 =C2=A0 FLAGS=3D$(git rev-parse --no-revs -- "$@" 2>/d=
ev/null)
> + =C2=A0 =C2=A0 =C2=A0 FLAGS=3D$(git rev-parse --no-revs --flags "$@"=
 2>/dev/null)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set -- $FLAGS
>
> @@ -273,9 +283,6 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while test $# -ne 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$1" in
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -q|--quiet)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_QUIET=3D-t
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--index)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INDEX_OPTION=3D--index
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0;;
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index e8a7338..9ed2396 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -406,7 +406,7 @@ test_expect_success 'stash branch - stashes on st=
ack, stash-like argument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test $(git ls-files --modified | wc -l) -e=
q 1
> =C2=A0'
>
> -test_expect_failure 'stash show - stashes on stack, stash-like argum=
ent' '
> +test_expect_success 'stash show - stashes on stack, stash-like argum=
ent' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash clear &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished "git reset --hard HEAD"=
 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard &&
> @@ -424,7 +424,7 @@ test_expect_failure 'stash show - stashes on stac=
k, stash-like argument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> -test_expect_failure 'stash show -p - stashes on stack, stash-like ar=
gument' '
> +test_expect_success 'stash show -p - stashes on stack, stash-like ar=
gument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash clear &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished "git reset --hard HEAD"=
 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard &&
> @@ -447,7 +447,7 @@ test_expect_failure 'stash show -p - stashes on s=
tack, stash-like argument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> -test_expect_failure 'stash show - no stashes on stack, stash-like ar=
gument' '
> +test_expect_success 'stash show - no stashes on stack, stash-like ar=
gument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash clear &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished "git reset --hard HEAD"=
 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard &&
> @@ -462,7 +462,7 @@ test_expect_failure 'stash show - no stashes on s=
tack, stash-like argument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> -test_expect_failure 'stash show -p - no stashes on stack, stash-like=
 argument' '
> +test_expect_success 'stash show -p - no stashes on stack, stash-like=
 argument' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git stash clear &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished "git reset --hard HEAD"=
 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard &&
> --
> 1.7.3.234.g7bba3
>
>
