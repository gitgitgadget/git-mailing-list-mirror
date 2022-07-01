Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD94C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGACa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGACaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:30:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90E4D16A
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:30:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d2so1560758ejy.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5PpTV5DyJJvq7S2/8yayvF8HImC4O/YwH66E8cj2HCA=;
        b=nnF/HBAH7avpNU9JClUv+IjrVw3YSx9qFf5bQDH/6taQplG143tqmdwfrhNIgtn5KB
         WjkY11wir1/pwrRpTktx/0088wpIJR/+r1qjuIsZjkvlHtTlMxo9v5wZslH54snHpQha
         u0Mmz8JoSa0GYCFuRN0jqKKeK6ULOPfUC3V2MBTX9BnSjXyiX5EVP2dZB/N9tyJYcGQU
         +PORm9kga4epJPtsSGa5ol/yXUknPJ0wAs2FLCtWrM0i0ZzzRU6yFJ+ABDiOc30FhlFz
         QxFfvVG9Ppwf3GXkCfxyZcNX6/Wz1K1HuLlp69RolWxddcan5xqjdCxM/WqUTTUJm1br
         hazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5PpTV5DyJJvq7S2/8yayvF8HImC4O/YwH66E8cj2HCA=;
        b=hxhcsdMFh2umEQhP4+lPoT1Dv0dO9hWEhPle5B/pqTRLOg/I1kbs949ZntrGAAwbaq
         Hc525lSfSyO1rryCs1Kh99PUMKsvbiilmhwKSFEZmC725k3c69mAfZKXI/IiB9Mi7i9I
         RU/KetRoQFOkx39lSHRZYZYDMrMZ9k+/EIhyG/3qCNCk6687nGJvLyhsMLSXl/Ii4+XF
         2wezs2iZa/nzPY6e80gZRXJbawZyF5G9mZLfm7GDgrHx4zv1Dyd3uI0g1kwh+8DobT+X
         T7d3fznWbtpFI1NRo6q999irQUAjDHAnxe6cRIyxiOWsIYecqEMwe31WBmj75KIbXVms
         8Asw==
X-Gm-Message-State: AJIora/LU78RjTg/gJfkJB9Qqo8DBx7j7Ipi7zSYVDdGKxvb68+6FORv
        J+V11wXZo6AKjvgwbyPVXhBmM/iFYo2ORbHwqKw=
X-Google-Smtp-Source: AGRyM1u9QtMIOTW2YDQPojgV93/uG+ir5WA1usaqys7QSNYo4CjfG9nqWb1S1tk6DWrW91AOIYv3FIC1Yt4bhCKick4=
X-Received: by 2002:a17:906:e98:b0:726:29c5:620a with SMTP id
 p24-20020a1709060e9800b0072629c5620amr12192866ejf.192.1656642652174; Thu, 30
 Jun 2022 19:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
 <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com> <20220630095357.GA2123@szeder.dev>
In-Reply-To: <20220630095357.GA2123@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 19:30:39 -0700
Message-ID: <CABPp-BG1MARvcqgPYBNQ0P1M9jZ2b8vt9btPG1oQ5_h_YM78TQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 2:54 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Jan 17, 2022 at 06:25:55PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-s=
equence-rename-caching.sh
> > index 035edc40b1e..f2bc8a7d2a2 100755
> > --- a/t/t6429-merge-sequence-rename-caching.sh
> > +++ b/t/t6429-merge-sequence-rename-caching.sh
> > @@ -697,4 +697,71 @@ test_expect_success 'caching renames only on upstr=
eam side, part 2' '
> >       )
> >  '
> >
> > +#
> > +# The following testcase just creates two simple renames (slightly mod=
ified
> > +# on both sides but without conflicting changes), and a directory full=
 of
> > +# files that are otherwise uninteresting.  The setup is as follows:
> > +#
> > +#   base:     unrelated/<BUNCH OF FILES>
> > +#             numbers
> > +#             values
> > +#   upstream: modify: numbers
> > +#             modify: values
> > +#   topic:    add: unrelated/foo
> > +#             modify: numbers
> > +#             modify: values
> > +#             rename: numbers -> sequence
> > +#             rename: values -> progression
> > +#
> > +# This is a trivial rename case, but we're curious what happens with a=
 very
> > +# low renameLimit interacting with the restart optimization trying to =
notice
> > +# that unrelated/ looks like a trivial merge candidate.
> > +#
> > +test_expect_success 'avoid assuming we detected renames' '
> > +     git init redo-weirdness &&
> > +     (
> > +             cd redo-weirdness &&
> > +
> > +             mkdir unrelated &&
> > +             for i in $(test_seq 1 10)
> > +             do
> > +                     >unrelated/$i
> > +             done &&
> > +             test_seq  2 10 >numbers &&
> > +             test_seq 12 20 >values &&
> > +             git add numbers values unrelated/ &&
> > +             git commit -m orig &&
> > +
> > +             git branch upstream &&
> > +             git branch topic &&
> > +
> > +             git switch upstream &&
> > +             test_seq  1 10 >numbers &&
> > +             test_seq 11 20 >values &&
> > +             git add numbers &&
> > +             git commit -m "Some tweaks" &&
> > +
> > +             git switch topic &&
> > +
> > +             >unrelated/foo &&
> > +             test_seq  2 12 >numbers &&
> > +             test_seq 12 22 >values &&
> > +             git add numbers values unrelated/ &&
> > +             git mv numbers sequence &&
> > +             git mv values progression &&
> > +             git commit -m A &&
> > +
> > +             #
> > +             # Actual testing
> > +             #
> > +
> > +             git switch --detach topic^0 &&
> > +
> > +             test_must_fail git -c merge.renameLimit=3D1 rebase upstre=
am &&
> > +
> > +             git ls-files -u >actual &&
> > +             ! test_file_is_empty actual
>
> There is no 'test_file_is_empty' function, but because of the ! at the
> beginning of the line it didn't fail the test.

Oops, looks like I meant test_must_be_empty.

> The minimal fix would be to use 'test_file_not_empty' instead, but I
> wonder whether we should use 'test_line_count =3D 2' instead for a tad
> tighter check.

Makes sense; since this merged about half a year ago, I'll submit a
new patch to fix this.  Thanks for catching and pointing it out!



>
> > +     )
> > +'
> > +
> >  test_done
> >
> > base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
> > --
> > gitgitgadget
