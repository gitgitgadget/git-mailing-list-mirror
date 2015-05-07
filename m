From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 03/12] t5520: test work tree fast-forward when fetch
 updates head
Date: Thu, 7 May 2015 09:23:22 -0700
Message-ID: <CAGZ79kY88=r83x_eZ+RgUb9CAFTN4uukB11RwJhY+GNKL3Tq0Q@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOa8-0004nh-VX
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbbEGQXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:23:24 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34307 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbEGQXX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:23:23 -0400
Received: by iedfl3 with SMTP id fl3so48534352ied.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4X6jp/0KifUc1WX5FEq5ENYzfuKRygI0+sahrcTF4j0=;
        b=SSqXLcPKM/DeJ8q2XfN8xgBRdhqcA9DYIy+McwVhQFFOKNRcv2zBHXGWRIWGY8Snr1
         Z3sqiXkeOnevby7sxJzULLCnUvjkS6LGl2s2LOSKYh570oMThpXzZrZPIk13v0pLSBmu
         ZQeidBlbWNASYG798pB1UHUOls9ahrI8dKkGrtfrju41P/Kokh9AaQUpibkXxxjfoxkP
         7jIvhcgKBmgW8B/ya2OTvqy7kUIKFuBH/J+ZDrgu3dQvi/TEhiSkgbuRYfp5utBDCSLh
         MlQ0RakUvPggvxhJfiNwt1TxufG3ueqrhc6X2XMQjgin81nPnIaTumFTv69Y/RaK6yfD
         2XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4X6jp/0KifUc1WX5FEq5ENYzfuKRygI0+sahrcTF4j0=;
        b=Wn1Z1fyZP44VYXEhEeXJeEoE+GqHtgkko/b1vkuHOrmx21Rp2ZAkEX66r0MAGn2UpB
         ZG9Eu1S4LMYkydamcpAEmoJP93U3PmWMX/E6KYB7aJAT06evWxpDCmrivqZ/LZSflpKf
         DI+HhTdn4CTKLVSo3fG3ydmN7fVLbBxaMRcdA8QuZ+lJCxycVnVzIKNUweuHFBlJm22G
         9sngQ4e9CY6Thgo1MpnX/SKHSsgIEjvxu21jwVVjQiokGjTOrY3XpmBNCxsqD+e8c26i
         FbPtPlRp3vqgt2uZVfmWlYcUXA8qFuScURigm14D42EEW2uDGyJWp5Xgft27SsqUgmTo
         WyYw==
X-Gm-Message-State: ALoCoQn+99jOck11pYkYBUR4T8RNP6LkJhDNYLylAxyWA8zdReTqRPzAWsWfSi24jfqEvFQcliS5
X-Received: by 10.107.170.226 with SMTP id g95mr5960144ioj.2.1431015802828;
 Thu, 07 May 2015 09:23:22 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 7 May 2015 09:23:22 -0700 (PDT)
In-Reply-To: <1430988248-18285-4-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268541>

On Thu, May 7, 2015 at 1:43 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since commit b10ac50f (Fix pulling into the same branch), git-pull,
> upon detecting that git-fetch updated the current head, will
> fast-forward the working tree to the updated head commit.
>
> Implement tests to ensure that the fast-forward occurs in such a case,
> as well as to ensure that the user-friendly advice is printed upon
> failure.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     * Ensure that on fast-forward failure, if there is a conflict, the work
>       tree should not be touched.
>
>  t/t5520-pull.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 37ff45f..99b6f67 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -185,6 +185,28 @@ test_expect_success 'fail if the index has unresolved entries' '
>         test_cmp expected file
>  '
>
> +test_expect_success 'fast-forwards working tree if branch head is updated' '
> +       git checkout -b third master^ &&
> +       test_when_finished "git checkout -f copy && git branch -D third" &&
> +       echo file >expected &&
> +       test_cmp expected file &&
> +       git pull . second:third 2>out &&
> +       test_i18ngrep "fetch updated the current branch head" out &&
> +       echo modified >expected &&
> +       test_cmp expected file
> +'
> +
> +test_expect_success 'fast-forward fails with conflicting work tree' '
> +       git checkout -b third master^ &&
> +       test_when_finished "git checkout -f copy && git branch -D third" &&
> +       echo file >expected &&
> +       test_cmp expected file &&
> +       echo conflict >file &&
> +       test_must_fail git pull . second:third 2>out &&
> +       test_i18ngrep "Cannot fast-forward your working tree" out &&
> +       test `cat file` = conflict

same comments as in patch 1 apply here.

> +'
> +
>  test_expect_success '--rebase' '
>         git branch to-rebase &&
>         echo modified again > file &&
> --
> 2.1.4
>
