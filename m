Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1BC19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 03:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiGaDZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 23:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiGaDZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 23:25:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0586766C
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 20:25:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id p132so9701652oif.9
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 20:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUPJ3iAuZrqAO+K7VidCtAiTeMizJ+bi7TeGFwIns00=;
        b=NlfMXKPTSVgU2w3iR3pby23JZsyBolz5zHgM/+CJS9Jp8M42fnaCdaUjOMyxkBW63/
         yIY5CTW4Gm13rv+DQp5ryHy/Zr/Ut4z1uJuHGkKj0tNJYtefi+dVG0Vr72486ODufn1k
         rQE3vE+rCGauhPmNKmj+rntdc0dKQ4w6DXAfJlp3o649PHU1Iyj955TM2Tqy7iMDQrMN
         1gZrdNvbb7x8/r25Z9Ku7oESH8m7VfXiFJ4zil+0/tT0p7cQfgUI70FOnTqQmI6XU4fc
         OF8wd1TOKqcqbfluaDtZBpkiB58v/pNl14rVdYIqaGIkVUFKpPQJWMvyu/zn45AnzH3f
         ++kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUPJ3iAuZrqAO+K7VidCtAiTeMizJ+bi7TeGFwIns00=;
        b=FuaW+iDC1bkWzxFElb/UtepVn0vqtLboriE0WeggcTjMHf0KTJt9BfZstimyZ/J46N
         80eJZAILBaY+PBgywRzegZdx91tyArVlFwmNNSe1blG8vo35qLzGE28fnWoVbOQaJ5kb
         3QwZiXEuXomUBxeqKFmmNolO2/3thNwp6Dv3jxFreSWQvmf5fcoBSfWHu7cMylgxxwgH
         pj+JkeABWnf8JtJ+gIvvkZFl3PMertlyP7wgxJcegruho9NHL/3Nujq6Xy5AJ+J6Ag2o
         v79+8u5K9MjvJEIACsFUrAUqIy50PL4/Qr95qiaMyqio1IVKJ/2+LekyLXXYVH5EY6ga
         9gCw==
X-Gm-Message-State: ACgBeo255yKDh65gPA61PNjZYHyNkOLjpczIAoOYywrd87F6K/QyPlrn
        q0dL+miCoQPHr5Bi12FT78sswD503WD4iPhmwuA=
X-Google-Smtp-Source: AA6agR4Jei17n3jSPcEbebtoe3vr+cv7Ns3pEcq1JNa2qZlg6JRbEfSQ3Uf5mAYuQTXCc98mb2je0JdkKMSJ3WA9n0g=
X-Received: by 2002:a05:6808:1b0c:b0:33f:4448:3992 with SMTP id
 bx12-20020a0568081b0c00b0033f44483992mr460741oib.251.1659237917204; Sat, 30
 Jul 2022 20:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220729101245.6469-1-worldhello.net@gmail.com>
 <20220729101245.6469-2-worldhello.net@gmail.com> <CAPig+cQyW4Bz1kL5MriXeU6Zd93oYQU8ZuA-1gaEmAERpbTaDA@mail.gmail.com>
In-Reply-To: <CAPig+cQyW4Bz1kL5MriXeU6Zd93oYQU8ZuA-1gaEmAERpbTaDA@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 31 Jul 2022 11:25:05 +0800
Message-ID: <CANYiYbHcd3UNF2vq6YLQifEWW6eSLhB=7d23907TAbUeum2w0A@mail.gmail.com>
Subject: Re: [PATCH 1/9] t1416: more testcases for reference-transaction hook
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 2:44 PM Eric Sunshine <sunshine@sunshineco.com> wrote:

> Now that the function breaks out of the loop properly with `|| return
> 1` upon failure, it's no longer necessary to perform the directory
> check at the top of the function since the call to test_commit() will
> correctly fail if the directory does not exist. So, the function can
> be shortened to:
>
>     create_commits_in () {
>         local repo="$1" &&
>         shift &&
>         while test $# -gt 0
>         do
>             local name=$1 &&
>             shift &&
>             test_commit -C "$repo" --no-tag "$name" &&
>             local rev=$(git -C "$repo" rev-parse HEAD) &&
>             eval $name=$rev || return 1
>         done
>     }

Thanks, Eric. Appreciate for all suggestions. I prefer this version
and will use it in reroll v2.

> > +       done &&
> > +       expect=${1:-expect} &&
> > +       actual=${2:-actual-heads-and-tags} &&
> > +       indir=${indir:+"$indir"/} &&
> > +       test_path_is_file "$expect" &&
> > +       test_when_finished "rm -f \"$actual\"" &&
> > +       git ${indir:+ -C "$indir"} show-ref --heads --tags | \
> > +               make_user_friendly_and_stable_output >"$actual" &&
>
> The exit code from `git show-ref` is being lost down the pipe. You
> also don't need the `\` after `|`.

Will remove unnecessary backslash before EOL.

> > +       test_cmp "$expect" "$actual"
> > +}
> > +
> > +test_expect_success 'setup git config and common reference-transaction hook' '
> > +       git config --global \
> > +               core.hooksPath "$HOME/test-hooks" &&
>
> Nit: This would fit nicely on a single line; no need for the line splicing.

Will write in oneline.

> > +       git config --global core.abbrev 7 &&
> > +       mkdir "test-hooks" &&
> > +       write_script "test-hooks/reference-transaction" <<-EOF
> > +               exec >>"$HOME/$HOOK_OUTPUT"
> > +               printf "## Call hook: reference-transaction %9s ##\n" "\$@"
> > +               while read -r line
> > +               do
> > +                   printf "%s\n" "\$line"
>
> Nit This is the same as:
>
>     echo "\$line"

Will do.

> > +               done
> > +       EOF
> > +'
> > +
> > +test_expect_success "update-ref: create new refs" '
> > +       test_when_finished "rm -f $HOOK_OUTPUT" &&
> > +
> > +       cat >expect <<-EOF &&
> > +               ## Call hook: reference-transaction  prepared ##
>
> This and a bunch of other here-doc tags in subsequent tests are
> missing the backslash:
>
>     cat >expect <<-\EOF &&

Will add backslash unless there are variables need to be expanded.
