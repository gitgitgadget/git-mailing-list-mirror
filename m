From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/2] stash: fix accidental apply of non-existent stashes
Date: Wed, 6 Apr 2011 09:23:12 +1000
Message-ID: <BANLkTik4sJwvBsnS855YEV=1akpGqYaspA@mail.gmail.com>
References: <20110405212025.GA3579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Fag-0005JI-4I
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1DEXXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 19:23:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61285 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab1DEXXM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 19:23:12 -0400
Received: by iyb14 with SMTP id 14so869207iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3RMbdjI59526CrLh3K9P9UyMLOPrB4eWyz5R6ZVKOyE=;
        b=MG7V42WWlcokd8Kh3c5s0BCDiPc8ug+CPxgJTioU2h2DKZnmWRPCMbg5kUGap5cZ+v
         BThwsDDthPx9OGUvSkLUFmfpt/uMVExg9KcUUbwEI4ntqaEMHARrZ7ZquylJPjEr5IMO
         MsE9FJOolf+XoHToA7MA1v9Jt2QabDZXWNQrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UV9puChLz9uvxw5V5qOgdUvMOd35wMUAb2Wp361McaArQch9B7pXYSXvYBrZebEkn9
         K/+GqPzH0aixLZ6k5Q0FTmjhpM9Hvhu9Plze2KAGhPeb0P6OxlqTBKbUKcmgpbyq5pqu
         eKA26ypPYK2526AbcKfDeJVFr8C6i8JNc+ggU=
Received: by 10.42.161.196 with SMTP id u4mr472145icx.11.1302045792311; Tue,
 05 Apr 2011 16:23:12 -0700 (PDT)
Received: by 10.42.241.197 with HTTP; Tue, 5 Apr 2011 16:23:12 -0700 (PDT)
In-Reply-To: <20110405212025.GA3579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170939>

On Wed, Apr 6, 2011 at 7:20 AM, Jeff King <peff@peff.net> wrote:
> Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Jon Seymour <jon.seymour@gmail.com>

I've also submitted a patch that fixes the test that should have caught=
 this.

jon.

> ---
> =C2=A0git-stash.sh =C2=A0 =C2=A0 | =C2=A0 12 +-----------
> =C2=A0t/t3903-stash.sh | =C2=A0 =C2=A06 ++++++
> =C2=A02 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index a305fb1..a5b1dc3 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -264,7 +264,7 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0b_tree=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i_tree=3D
>
> - =C2=A0 =C2=A0 =C2=A0 REV=3D$(git rev-parse --no-flags --symbolic "$=
@" 2>/dev/null)
> + =C2=A0 =C2=A0 =C2=A0 REV=3D$(git rev-parse --no-flags --symbolic "$=
@") || exit 1
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FLAGS=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for opt
> @@ -310,16 +310,6 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IS_STASH_LIKE=3Dt &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$ref_stash" =3D "$(git rev-parse --s=
ymbolic-full-name "${REV%@*}")" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IS_STASH_REF=3Dt
> -
> - =C2=A0 =C2=A0 =C2=A0 if test "${REV}" !=3D "${REV%{*\}}"
> - =C2=A0 =C2=A0 =C2=A0 then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # maintainers: it =
would be better if git rev-parse indicated
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # this condition w=
ith a non-zero status code but as of 1.7.2.1 it
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # it did not. So, =
we use non-empty stderr output as a proxy for the
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # condition of int=
erest.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test -z "$(git rev=
-parse "$REV" 2>&1 >/dev/null)" || die "$REV does not exist in the stas=
h log"
> - =C2=A0 =C2=A0 =C2=A0 fi
> -
> =C2=A0}
>
> =C2=A0is_stash_like()
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index f62aaf5..11077f0 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -37,6 +37,12 @@ test_expect_success 'parents of stash' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp output expect
> =C2=A0'
>
> +test_expect_success 'applying bogus stash does nothing' '
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git stash apply stash@{1} &&
> + =C2=A0 =C2=A0 =C2=A0 echo 1 >expect &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect file
> +'
> +
> =C2=A0test_expect_success 'apply needs clean working directory' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 4 > other-file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add other-file &&
> --
> 1.7.4.3.13.g0b769.dirty
>
>
