From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 6/8] t5520: test --rebase failure on unborn branch with index
Date: Mon, 18 May 2015 11:00:01 -0700
Message-ID: <CAGZ79kbXcWiK-9_NDCERNbi-m1cPiuukZ75r6TWwoUBsnyUGiA@mail.gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPKs-0007yX-56
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbbERSAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:00:07 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35820 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbbERSAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:00:03 -0400
Received: by igbyr2 with SMTP id yr2so55382815igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8V8jz875gypiYnRfgNo7E5J+GoIqGCP8sBC1zWeVqFo=;
        b=nDQlpGIglTSO/k8rt12emB03BAjQ4VZCuHc0Qu7w76nGLwMnxIJ9Gn1KuwfqSgOID2
         gSrMkNDrNVSreuyNqhOyKETm3lPvvOfWd2qkwv78BmQK1ObfJnqY1O+xmxCpEfRHMQFV
         sJKKChaHqn6FSl9lhLx4Kw4Yb/0gVIHoMjBruIH5Id3DFKqmX9fqZQYxLbcGnVWBw14N
         aVEfk9mUcQWuNSoVaL+ce8pIE8xFaXu/MQ3QMeC1AZzfInFuw+Mk0tc8IUVfVYpVvGXG
         B9FWwPGqcs2YtRz0mXAhjG9Y94FxKIa7G03IxVvcLedlKmWUpm/clxqWIttXNVTSUwsF
         N7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8V8jz875gypiYnRfgNo7E5J+GoIqGCP8sBC1zWeVqFo=;
        b=heicUuamaB6IOOlg6jqwcnj+28GQBZ06APGDBybNm3j1uMxmT3b6mmCk1mL1lRe2+g
         +pb5Xa6VgfIWtwThojD+araIBU5dzW/niPY/PbFi9q3qfoeE0LgO2FNcpR2VHF8GuMMJ
         66OItLJGz6asVrWzDl2WNIqLFtLs1oD85BaO9Z4G89JN6TTtVIjD0dhb3HUgUuz7SvKE
         5eQboEncvQ5zBcP4tWRcQq17Q2msKwCzDlhrSDcMW7lHfHEeRIMguxTNoScmoMd75dH0
         wCnlOuUJ7IphmFsta5qsmmGnnXQFi/apM3nqc7h0EVOC1BrpocSpQgKA/ZWrhYiqYDnV
         BhPw==
X-Gm-Message-State: ALoCoQnu1PBea/IxUB7iPf//PKr8v3Vl2mhnKcrdAr8cXhy2qZy17Ap1Pge1cICkJnbLDz6YLIy3
X-Received: by 10.107.132.223 with SMTP id o92mr31315122ioi.49.1431972001436;
 Mon, 18 May 2015 11:00:01 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 11:00:01 -0700 (PDT)
In-Reply-To: <1431955978-17890-7-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269288>

On Mon, May 18, 2015 at 6:32 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Commit 19a7fcb (allow pull --rebase on branch yet to be born,
> 2009-08-11) special cases git-pull on an unborn branch in a different
> code path such that git-pull --rebase is still valid even though there
> is no HEAD yet.
>
> This code path still ensures that there is no index in order not to lose
> any staged changes. Implement a test to ensure that this check is
> triggered.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> * Removed use of "verbose".
>
>
>  t/t5520-pull.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index f991439..4d649a5 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -413,6 +413,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
> +       test_when_finished "rm -rf empty_repo2" &&
> +       git init empty_repo2 &&
> +       (
> +               cd empty_repo2 &&
> +               echo staged-file >staged-file &&
> +               git add staged-file &&
> +               test "$(git ls-files)" = staged-file &&
> +               test_must_fail git pull --rebase .. master 2>../err &&
> +               test "$(git ls-files)" = staged-file &&
> +               test "$(git show :staged-file)" = staged-file
> +       ) &&
> +       test_i18ngrep "unborn branch with changes added to the index" err

So when seeing this line outside the parenthesis section, I immediately thought
there must be a reason you put it outside. The reason is not obvious
to me though.
So I'd suggest to move the test_i18ngrep inside the section above.

> +'
> +
>  test_expect_success 'setup for detecting upstreamed changes' '
>         mkdir src &&
>         (cd src &&
> --
> 2.1.4
>
