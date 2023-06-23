Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA26EB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 06:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFWGZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFWGZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 02:25:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1F211C
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 23:25:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so246538e87.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687501553; x=1690093553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3u+gF6TYIP5jjEmX6rsIDjh9YHNa6WvIF5d6jz3wsk=;
        b=XPx2k9henQLgRRPlHYKAb+ylAMpjqvNDQwnhU7mK9w9iXDpdRyljkd+1ZeKI1DHV1+
         QnjLNGc7pRq/dYm8jP29aMeJfBF4OYvmsQw91sC/jFp811BHDWNBBzylyk4S8IkpkAlQ
         xaqNq9aE494Ozjh1HxCJXsZt3/X4BXKo1Oh+HIuX+5A9xbqzwF3omfGnqAwJEBeWsVNO
         /CbOao4ZDgiUehNCMnx2k9cRq5c7ZhfDdvxgd93IwzRtkfhbR/KqRCVKWfAEAbvZCyay
         /iC6WsVqRp2vSlpIQ3GX3iwq96Zko/HbiymsA9qfDIGoFKkNcywn+Kb/c1/hzO1MtsZI
         MlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687501553; x=1690093553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3u+gF6TYIP5jjEmX6rsIDjh9YHNa6WvIF5d6jz3wsk=;
        b=e2mczeeJKtXCKIPqzbBTJZWkg2M8fsvVcRoeVkXBjWN6vUu45EGzpUkHhHoCFUFxi2
         BORA0P+zkKHxTrl3g+x3HzqPVPSDZkG1to5W0vbzTF5dy6bSSV6zNujC/gAIiTFoGNc6
         Wx1lKJ11mp2z/L0ETraLJAlWAxiMJ9Nk8hRJ+jim6m9MOXPRHzdk3EG4TmOrCvVRYWzY
         6B+hyeciW5LlevfEYXXRxrjQ8xXXA2M1f1OF03KdRTWl0u/VfqvzL8cUkb7V7wwaV/Fc
         TDIj8tiuVElMdzerkOFpjLsIK3wuKI6nbofgbEJAKFU/9bH5MDgMx1vVFrXdntrsxqmE
         gMpw==
X-Gm-Message-State: AC+VfDwZPVSi3a0x9uSUCNf3WoKwD3nQ05VykRqU48btKUaqEs6mhwkd
        fGtsIu1FP2nAKx+uHuubPF/H05zkJ+DWBfu/xyOVW/93iPo=
X-Google-Smtp-Source: ACHHUZ4UoMXkEQE85LHAdqIXbR9+T1AaPPunk/Vw2yHT1k9EmHiPUYzt4iifzzgQU3LRAMoSPvKw8xpz2qRjqg9TQtc=
X-Received: by 2002:ac2:4d8e:0:b0:4f8:f4d8:c8d1 with SMTP id
 g14-20020ac24d8e000000b004f8f4d8c8d1mr7173562lfe.2.1687501552665; Thu, 22 Jun
 2023 23:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
 <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
In-Reply-To: <xmqq4jmzc91e.fsf_-_@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Jun 2023 23:25:40 -0700
Message-ID: <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Joshua Hudson <jhudson@cedaron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 5:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> When an external merge driver dies with a signal, we should not
> expect that the result left on the filesystem is in any useful
> state.  However, because the current code uses the return value from
> run_command() and declares any positive value as a sign that the
> driver successfully left conflicts in the result, and because the
> return value from run_command() for a subprocess that died upon a
> signal is positive, we end up treating whatever garbage left on the
> filesystem as the result the merge driver wanted to leave us.

Yeah, I think the tradition was exit code =3D=3D number of conflicts for
some merge processes.  Not particularly useful when the driver died
from some signal.

> run_command() returns larger than 128 (WTERMSIG(status) + 128, to be
> exact) when it notices that the subprocess died with a signal, so
> detect such a case and return LL_MERGE_ERROR from ll_ext_merge().

Makes sense.

>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This time with an updated title, a minimal documentation, and an
>    additional test.
>
>  Documentation/gitattributes.txt |  5 ++++-
>  ll-merge.c                      |  9 ++++++++-
>  t/t6406-merge-attr.sh           | 23 +++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> index 02a3ec83e4..6deb89a296 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1132,7 +1132,10 @@ size (see below).
>  The merge driver is expected to leave the result of the merge in
>  the file named with `%A` by overwriting it, and exit with zero
>  status if it managed to merge them cleanly, or non-zero if there
> -were conflicts.
> +were conflicts.  When the driver crashes (e.g. killed by SEGV),
> +it is expected to exit with non-zero status that are higher than
> +128, and in such a case, the merge results in a failure (which is
> +different from producing a conflict).

Looks good.

>  The `merge.*.recursive` variable specifies what other merge
>  driver to use when the merge driver is called for an internal
> diff --git a/ll-merge.c b/ll-merge.c
> index 07ec16e8e5..ba45aa2f79 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -243,7 +243,14 @@ static enum ll_merge_result ll_ext_merge(const struc=
t ll_merge_driver *fn,
>                 unlink_or_warn(temp[i]);
>         strbuf_release(&cmd);
>         strbuf_release(&path_sq);
> -       ret =3D (status > 0) ? LL_MERGE_CONFLICT : status;
> +
> +       if (!status)
> +               ret =3D LL_MERGE_OK;
> +       else if (status <=3D 128)
> +               ret =3D LL_MERGE_CONFLICT;
> +       else
> +               /* died due to a signal: WTERMSIG(status) + 128 */
> +               ret =3D LL_MERGE_ERROR;
>         return ret;
>  }

Likewise.

> diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> index 5e4e4dd6d9..b50aedbc00 100755
> --- a/t/t6406-merge-attr.sh
> +++ b/t/t6406-merge-attr.sh
> @@ -56,6 +56,12 @@ test_expect_success setup '
>         ) >"$ours+"
>         cat "$ours+" >"$ours"
>         rm -f "$ours+"
> +
> +       if test -f ./please-abort
> +       then
> +               echo >>./please-abort killing myself
> +               kill -9 $$
> +       fi
>         exit "$exit"
>         EOF
>         chmod +x ./custom-merge
> @@ -162,6 +168,23 @@ test_expect_success 'custom merge backend' '
>         rm -f $o $a $b
>  '
>
> +test_expect_success 'custom merge driver that is killed with a signal' '
> +       test_when_finished "rm -f output please-abort" &&
> +
> +       git reset --hard anchor &&
> +       git config --replace-all \
> +       merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
> +       git config --replace-all \
> +       merge.custom.name "custom merge driver for testing" &&
> +
> +       >./please-abort &&
> +       echo "* merge=3Dcustom" >.gitattributes &&
> +       test_must_fail git merge main &&
> +       git ls-files -u >output &&
> +       git diff --name-only HEAD >>output &&
> +       test_must_be_empty output
> +'
> +

I was about to comment that we needed to clean up the please-abort
file, then realized I just missed it in my first reading of the
test_when_finished line.  So, patch looks good.

Reviewed-by: Elijah Newren <newren@gmail.com>
