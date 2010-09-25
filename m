From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v1] stash show: fix breakage in 1.7.3
Date: Sat, 25 Sep 2010 17:15:14 +1000
Message-ID: <AANLkTikmCR+fYJfYU9RidnD143BsEA-Lz+V8jEO_hs-y@mail.gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
	<1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, git@vger.kernel.org,
	brian@gernhardtsoftware.com, casey@nrlssc.navy.mil
X-From: git-owner@vger.kernel.org Sat Sep 25 09:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzOyq-0003uH-4Y
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab0IYHPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 03:15:16 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:65101 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab0IYHPP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 03:15:15 -0400
Received: by qyk36 with SMTP id 36so2356134qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XpNSz3z+OYymLUTGu9+CzZU1cFzaRkFCVx7x/7Vl/nw=;
        b=uiy8r1ZPOEOF7QfD9J9Hr8+IngfYdJ5V0FR/4PHcohfRKtsXXMAPz1kLp60J6vRvj8
         i18OHkLPMFSm2NvHblS4fE/iAjsf/PnukZVx7m6VGnd3pKq/+Lcf5fZvYKmYZT9P3Jc6
         IJKkrEgw/PRV1HvSJUAs6g3fzB87cKpzgtXA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jbt7+y21A4Xpa3t1sVxbQONWS77I+aIpn89jLKf62QSESqaIEHbp6QNgZELqMbH1TD
         fo+uUS1qjOYxnjxanR92D5clsCMrOL+0W73RxHxFU7RyYpaO4znyDNsi8Pqm0JnCZ+qM
         QZ/Kuanexwc07r8vsmoSeft7HjpOqqi7zmQx8=
Received: by 10.229.233.80 with SMTP id jx16mr3362324qcb.62.1285398914410;
 Sat, 25 Sep 2010 00:15:14 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 00:15:14 -0700 (PDT)
In-Reply-To: <1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157125>

| Added Brandon to distribution - apologies for earlier omission.

jon.

On Sat, Sep 25, 2010 at 1:32 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> The detached-stash series regressed support for
> =C2=A0 git stash show stash@{0}
>
> due to a faulty assumption that:
> =C2=A0 git rev-parse --no-revs -- stash@{0}
>
> would treat stash@{0} as a revision reference and
> thus not output it.
>
> This patch restores the behaviour of git stash show
> so that git rev-parse is not used for parsing flags
> and only flag like options are assigned to
> the FLAGS variable.
>
> It has been tested with Brandon Casey's improved t3903 tests.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =C2=A0git-stash.sh | =C2=A0 =C2=A05 +----
> =C2=A01 files changed, 1 insertions(+), 4 deletions(-)
>
> This revision further simplifies the parsing code
> by removing use of git rev-parse for FLAGS parsing
> altogether.
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 7ce818b..8b18bb5 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -265,9 +265,6 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i_tree=3D
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0REV=3D$(git rev-parse --no-flags --symboli=
c "$@" 2>/dev/null)
> - =C2=A0 =C2=A0 =C2=A0 FLAGS=3D$(git rev-parse --no-revs -- "$@" 2>/d=
ev/null)
> -
> - =C2=A0 =C2=A0 =C2=A0 set -- $FLAGS
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FLAGS=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while test $# -ne 0
> @@ -282,7 +279,7 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0;;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FLAGS=3D"${FLAGS}${FLAGS:+ }$=
1"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> --
> 1.7.2.14.g132f5.dirty
>
>
