Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FBC2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944552072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmt2JniD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgDGPNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:13:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39052 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgDGPNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:13:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id x11so3467456otp.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoMG037JcX5tPYkgKPjGlWXSrm0emFKOCFi1D/pYSC8=;
        b=Rmt2JniDNH3DaSlvGYcOoVGqct087qg2unhsdMp4tUd87Y7woXZ5aaPuOtD5IENDKQ
         /cfhUFEV58IHNek7f+oyLZfGDNAnwf36HdEb3kPQfsW2XEtFfdtSpolml9JJHCg04KHs
         y6DmIpbpQpf11INcixrpbPudl51n98C+GUcp1cGWgNqsuqOovEVm0K1fO7iEf37hiIK0
         w8qm0sFfFRsz0YP0/IpUzuTzp+J/2NkNC7K6W6e7++V+aa7Porg/28vkRK2H9Vo9Vzds
         /uaDaiq9Tl7GnzohVsrpGOHj5am3JOS/8RY5awN9rnoNGM8SczPhe9wKRuZTD2nHFrGl
         zdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoMG037JcX5tPYkgKPjGlWXSrm0emFKOCFi1D/pYSC8=;
        b=pA8TVC6rhJw7V18cB2Ylw7+nI/AkQ9eZ0ty7g4r5mH7UWF9PcCUYMkab6ggC94Z3Pg
         hCKUle2J4DbxM+y3WeSCoU+Z9Ej39bZIMDOuQrz9Y6/UY7zwcpULra7/Bt8HdQQhrzUB
         rv7qnJdt9xIV/w9ymgjC+LPmjJaltvtKdSYeHFG7oLtqTa59q5JMT7bsnUgTEsLmS6xU
         EReAoSWgLaUNqf3dJjW8Se/sB7kIrhpGWoBiEcHYI2/yKxJ2hJYXeTQzSzcU8DB1vGTZ
         EL3kbb4ZmvnMXSltszTI5tGfbzFCzwlVHlfBjuOjruas0tLFfFD2s0bx04+nHVwORoZ6
         fadw==
X-Gm-Message-State: AGi0PuZms9XYkdPm/+EidExI8o1XEDHSCDJ4+KiNFfasZuuJmYq0ry9o
        hvJgIyvvRe1mRLQibKlVY3qmNQz5pp83Xkoetsk=
X-Google-Smtp-Source: APiQypKkEP8Iy9xReKiCCnh4odW7ASzuEG/F3+8JeedYe54JvMP4pOPiQ7D9aQm7pSxi9c8t3VwMAlMDTuTjbt1yA+E=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr2042458oti.162.1586272421422;
 Tue, 07 Apr 2020 08:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200407141125.30872-7-phillip.wood123@gmail.com>
In-Reply-To: <20200407141125.30872-7-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 08:13:30 -0700
Message-ID: <CABPp-BFZknddcEcAz02T7Uej0jNWtKAUW8hwS6CdMfAa5BhGgA@mail.gmail.com>
Subject: Re: [PATCH 6/6] t3433: improve coverage
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add tests to check --ignore-whitespace and --ignore-date are remembered
> when running `rebase --continue` and to check
> --committer-date-is-author-date with --ignore-date gives the expected
> result.

Thanks for adding these.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3433-rebase-options-compatibility.sh | 55 +++++++++++++++++++++++++

t3433 is taken by t3433-rebase-across-mode-change.sh in upstream.
When you revert the reversion of Rohit's changes, perhaps you need to
rename his t3433 to some other file?

Also, the name "rebase-options-compatibility" suggest to me that it's
just checking whether certain options can be used together.  Perhaps
the --ignore-whitespace and --ignore-date tests you add should go
somewhere else?

>  1 file changed, 55 insertions(+)
>
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index 8247d01442..a13c341301 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -7,6 +7,8 @@ test_description='tests to ensure compatibility between am and interactive backe
>
>  . ./test-lib.sh
>
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
>  GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>  export GIT_AUTHOR_DATE
>
> @@ -70,6 +72,22 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
>         test_cmp expect file
>  '
>
> +test_expect_success '--ignore-whitespace is remembered when continuing' '
> +       cat >expect <<-\EOF &&
> +       line 1
> +       new line 2
> +       line 3
> +       EOF
> +       (
> +               set_fake_editor &&
> +               FAKE_LINES="break 1" &&
> +               export FAKE_LINES &&
> +               git rebase -i --ignore-whitespace main side
> +       ) &&
> +       git rebase --continue &&
> +       test_cmp expect file
> +'
> +
>  test_expect_success '--committer-date-is-author-date works with am backend' '
>         GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>         git rebase --committer-date-is-author-date HEAD^ &&
> @@ -135,6 +153,16 @@ test_expect_success '--ignore-date works with interactive backend' '
>         grep "+0000" authortime
>  '
>
> +test_expect_success '--ignore-date works after conflict resolution' '
> +       test_must_fail git rebase --ignore-date -i \
> +               --onto commit2^^ commit2^ commit2 &&

I don't see any todo list here; is there a reason you are using -i
instead of say -m?  (Similar question applies for the subsequent tests
you add below too?)

> +       echo resolved >foo &&
> +       git add foo &&
> +       git rebase --continue &&
> +       git log --pretty=%ai >authortime &&
> +       grep +0000 authortime
> +'
> +
>  test_expect_success '--ignore-date works with rebase -r' '
>         git checkout side &&
>         git merge --no-ff commit3 &&
> @@ -143,4 +171,31 @@ test_expect_success '--ignore-date works with rebase -r' '
>         ! grep -v "+0000" authortime
>  '
>
> +test_expect_success '--ignore-date with --committer-date-is-author-date works' '
> +       test_must_fail git rebase -i --committer-date-is-author-date \
> +               --ignore-date --onto commit2^^ commit2^ commit3 &&
> +       git checkout --theirs foo &&
> +       git add foo &&
> +       git rebase --continue &&
> +       git log -2 --pretty=%ai >authortime &&
> +       git log -2 --pretty=%ci >committertime &&
> +       test_cmp authortime committertime &&
> +       ! grep -v "+0000" authortime
> +'
> +
> +test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
> +       GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
> +               git rebase -i --strategy=resolve --ignore-date \
> +               --committer-date-is-author-date side side &&
> +       git log -1 --pretty=%ai >authortime &&
> +       git log -1 --pretty=%ci >committertime &&
> +       test_cmp authortime committertime &&
> +       grep "+0000" authortime
> + '
> +
> +# This must be the last test in this file
> +test_expect_success '$EDITOR and friends are unchanged' '
> +       test_editor_unchanged
> +'
> +
>  test_done
> --
> 2.26.0
>
