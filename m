From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2 1/2] t5520-pull: Add testcases showing spurious 
	conflicts from git pull --rebase
Date: Sun, 8 Aug 2010 20:01:52 +0000
Message-ID: <AANLkTikhsFfCfmR2V8iSRvU73B5yW=_kqJAEfAGgxpLY@mail.gmail.com>
References: <1281294286-27709-1-git-send-email-newren@gmail.com>
	<1281294286-27709-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, santi@agolina.net,
	Johannes.Schindelin@gmx.de
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 22:02:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiC4G-000864-Ew
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0HHUBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 16:01:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47548 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab0HHUBy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 16:01:54 -0400
Received: by iwn33 with SMTP id 33so3128584iwn.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wmQjZ2c8Yja2Ds60IdT+jJ0z5UasU2RjRgL7RxSfmN4=;
        b=LmBU4ylsAjs+w08YBddZknxnlNechdR6SjMcNlUCZOgRdIwx/004v+g36uOSIHydlE
         s/PuuGfVF+GGwkdi5dkjYedFRN6kmL5TdzuEoIIcPwv4iALViq+WXljvLzVBeljXwZ6q
         iR0CK5lruXhR1pIPzyHve5jsa6AYGoX5B1pFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cSMieYgqaDoHyDDtWwyY04yMzp1Tg9yEM0mKUaXV2/5edZG5TXuCaPRr4ROhjbCGf+
         lJoLMzW0ptUBby5buabkIbKiC1tqV6YHYU2VX7aDieloyfSX0e4AAXacJBv0LjhREwQ/
         r6VHsLkl7bCYzkKl3i23rA8abBExkW1B1ZD0I=
Received: by 10.231.159.203 with SMTP id k11mr17798572ibx.115.1281297712887; 
	Sun, 08 Aug 2010 13:01:52 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 8 Aug 2010 13:01:52 -0700 (PDT)
In-Reply-To: <1281294286-27709-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152922>

On Sun, Aug 8, 2010 at 19:04, Elijah Newren <newren@gmail.com> wrote:
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> =C2=A0t/t5520-pull.sh | =C2=A0 58 +++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 58 insertions(+), 0 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 319e389..1624dd3 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -160,4 +160,62 @@ test_expect_success 'pull --rebase works on bran=
ch yet to be born' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect actual
> =C2=A0'
>
> +test_expect_success 'setup for detecting upstreamed changes' '
> + =C2=A0 =C2=A0 =C2=A0 mkdir src &&
> + =C2=A0 =C2=A0 =C2=A0 (cd src &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git init &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in $(seq 1 10); do echo $i; done >=
 stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git add stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "Initial revision"
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 git clone src dst &&
> + =C2=A0 =C2=A0 =C2=A0 (cd src &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/5/43/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "5->43" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/6/42/ stuff &&

Please use sed so the test doesn't depend on perl being present.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Make it bigger" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0correct=3D$(git rev-parse HEAD)
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/5/43/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Independent discovery =
of 5->43"
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_failure 'git pull --rebase detects upstreamed changes' '
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git pull --rebase &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0test -z "$(git ls-files -u)"
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_success 'setup for avoiding reapplying old patches' '
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0(git rebase --abort || true) &&

If you're ignoring the git rebase --abort return value:

  (cd dst &&
    git rebase --abort;
    git reset ...)

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard origin/master
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 git clone --bare src src-replace.git &&
> + =C2=A0 =C2=A0 =C2=A0 rm -rf src &&
> + =C2=A0 =C2=A0 =C2=A0 mv src-replace.git src &&
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/2/22/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Change 2" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/3/33/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Change 3" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/4/44/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -a -m "Change 4" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git push &&
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -pi -e s/44/55/ stuff &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit --amend -a -m "Modified Chang=
e 4"
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_failure 'git pull --rebase does not reapply old patches'=
 '
> + =C2=A0 =C2=A0 =C2=A0 (cd dst &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0(git pull --rebase || true) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0test 1 =3D $(find .git/rebase-apply -nam=
e "000*" | wc -l)
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> =C2=A0test_done
> --
> 1.7.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
