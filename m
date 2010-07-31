From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2 v2] checkout: add a test for creating a new branch 
	with regexp as a starting point
Date: Sat, 31 Jul 2010 10:24:13 +0000
Message-ID: <AANLkTi=+60yK8A-bYT6ySFTxXxmCD9nD_LW1WX2GgDbm@mail.gmail.com>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
	<20100731001919.GB24129@wo.int.altlinux.org>
	<AANLkTin11hHryAbJiOkiBH5TfpPbKREJK-ekWkd4fDhw@mail.gmail.com>
	<20100731014449.GA19956@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sat Jul 31 12:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of9Ep-0002J3-QF
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 12:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab0GaKYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 06:24:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35552 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0GaKYO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 06:24:14 -0400
Received: by iwn7 with SMTP id 7so2203817iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NC4vJKJ2mhGylUc+4M4Y70TWeAo0ezBl2SwKLyvnRqo=;
        b=MOTVQvkTMtjuvJeinFtWqOVCwFeNroUuOt5d8CnvG+IOw5cIqEpiK3I8uCHDnIHp6j
         7/HDWY6P7GUcb55wH2Ek/+ofq56xWvrwQ/5YfDOrHxYi0S+kTTQ4OHjAaTi5eHXrMmLN
         n7uLfqV4TaBPvCDWRyQA6bi3xBQPXZm03vu0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QqfmAc+ejrcaYWQu2A53+l/eZhdHdmFYF0wtqPPxPwAm83MhTXbiv3UaYu8b0v4Gk1
         3l7fg0iHzA1XeSyLHGdLeEiu414yzysk9BEDOhx67dwidd5c6DEypQhbua35Vtb+maHQ
         oFj/GA8czMA4sWAJj1wcMTH9lcCHzXdk35Ni8=
Received: by 10.231.66.79 with SMTP id m15mr3168984ibi.197.1280571853640; Sat, 
	31 Jul 2010 03:24:13 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 31 Jul 2010 03:24:13 -0700 (PDT)
In-Reply-To: <20100731014449.GA19956@wo.int.altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152319>

On Sat, Jul 31, 2010 at 01:44, Dmitry V. Levin <ldv@altlinux.org> wrote=
:
> Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> =C2=A0t/t2018-checkout-branch.sh | =C2=A0 25 +++++++++++++++++++++---=
-
> =C2=A01 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 1caffea..6ada870 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -4,12 +4,13 @@ test_description=3D'checkout '
>
> =C2=A0. ./test-lib.sh
>
> -# Arguments: <branch> <sha> [<checkout options>]
> +# Arguments: <branch> <start_point> [<checkout options>]
> =C2=A0#
> =C2=A0# Runs "git checkout" to switch to <branch>, testing that
> =C2=A0#
> =C2=A0# =C2=A0 1) we are on the specified branch, <branch>;
> -# =C2=A0 2) HEAD is <sha>; if <sha> is not specified, the old HEAD i=
s used.
> +# =C2=A0 2) HEAD points to the same commit as <start_point> does;
> +# =C2=A0 =C2=A0 =C2=A0if <start_point> is not specified, the old HEA=
D is used.
> =C2=A0#
> =C2=A0# If <checkout options> is not specified, "git checkout" is run=
 with -b.
> =C2=A0do_checkout() {
> @@ -17,7 +18,8 @@ do_checkout() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exp_ref=3D"refs/heads/$exp_branch" &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# if <sha> is not specified, use HEAD.
> - =C2=A0 =C2=A0 =C2=A0 exp_sha=3D${2:-$(git rev-parse --verify HEAD)}=
 &&
> + =C2=A0 =C2=A0 =C2=A0 start_point=3D${2:-HEAD}
> + =C2=A0 =C2=A0 =C2=A0 exp_sha=3D$(git rev-parse --verify $start_poin=
t) &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# default options for git checkout: -b
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z "$3" ]; then
> @@ -26,7 +28,7 @@ do_checkout() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opts=3D"$3"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> - =C2=A0 =C2=A0 =C2=A0 git checkout $opts $exp_branch $exp_sha &&
> + =C2=A0 =C2=A0 =C2=A0 git checkout $opts $exp_branch $start_point &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test $exp_ref =3D $(git rev-parse --symbol=
ic-full-name HEAD) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test $exp_sha =3D $(git rev-parse --verify=
 HEAD)
> @@ -118,7 +120,22 @@ test_expect_success 'checkout -b to an existing =
branch fails' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail do_checkout branch2 $HEAD2
> =C2=A0'
>
> +test_expect_failure 'checkout -b new_branch :/regexp' '
> + =C2=A0 =C2=A0 =C2=A0 # clean up from previous test
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> +
> + =C2=A0 =C2=A0 =C2=A0 do_checkout old_regexp_branch branch1 &&
> + =C2=A0 =C2=A0 =C2=A0 # The first commit in this test should not be =
referenced by
> + =C2=A0 =C2=A0 =C2=A0 # other branches or tags.
> + =C2=A0 =C2=A0 =C2=A0 test_commit first a a "" &&
> + =C2=A0 =C2=A0 =C2=A0 test_commit second &&
> +
> + =C2=A0 =C2=A0 =C2=A0 do_checkout new_regexp_branch :/first
> +'
> +
> =C2=A0test_expect_success 'checkout -B to an existing branch resets b=
ranch to HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 # clean up from previous test
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout branch1 &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do_checkout branch2 "" -B
> --
> 1.7.2.1

Looks good, thanks.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
