Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E76C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 04:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjEPE0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEPE0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 00:26:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561273AAF
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:26:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f14f266b72so13496078e87.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684211180; x=1686803180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irOaz8VLpeoxJsnakEbIpPs5TV9B22jXD/CC60BCpSs=;
        b=sphFf9nv6uWjfOChaOY9JwVLZ4NPVLQoQGcfy/d5V6FDvdTxagoOdUDvQ+BVkrUYXZ
         ZN6JiY3wPKLAPF9nPtqQCuuBf/P84VAjm8yUx014mf9KovQxKqVLjWpgpHPsxHG2ngcg
         Y/agHKKcHUQHatIOFHWiawg29Q+IpKTOZPNvGQeUXhzWH9RXC5i5wYzqIoNzz68wx5jS
         GJfY0cH8/8KaO1sN40UuF//H/i/MIIn37QuUH4rPGJc8E36O9T+OpfdNW8vv99fBOwqq
         TGATL+R7vFOrrhQjYE1Scg9Nar2868PFbYJMjSfwiuyW38CGiQzcsQYwC/imTPye9UMl
         wypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684211180; x=1686803180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irOaz8VLpeoxJsnakEbIpPs5TV9B22jXD/CC60BCpSs=;
        b=T+uJ6Cw6gB69pqgxP7Cnf1wOW2qn2zNq4gGeVfcS4/rDvvH+CfDO2zGcfotYilvrJi
         2t7U+Say9C3Ab3SSgLHpHr61x/pXfHjcOgDpcW9Fjg8em8hq/iv8OeHBQJxaJ84oS6qE
         o0N0d7sKOTS8NavSFh23276vqpGAF09N9d8pnWe4BdJi4yM4KbfpyVc+aPAOBcE9AOp8
         I3SYf/yk+1/fU62JLmoM2p9s5+2Gdd38dG/lK8yp7c41z1QkU0WA8ki93t+g9GijCjRM
         ZzVWhhHs97XcvAEveYYTsAxFt8e4Cb7ItrX7WtmfpZv7RhO/Q4y+f/iphJ3kVBS03ym/
         tEtg==
X-Gm-Message-State: AC+VfDwitH4aCiPr3zmrz1ZOaztxByeKCuTPg9LzqAqWkPrZAmaGRJeH
        f4+emV3l2oglSi6vMiq4mQ27Cfx4dwfwMSKCUHg=
X-Google-Smtp-Source: ACHHUZ6u3meGtEpbA2o+BI91GU22kx63x6tbZdDmJxl/QOxb/Yq9lq3sR057pSsjzBuop/TxEza3S0tu1iatM+owXpM=
X-Received: by 2002:ac2:4d19:0:b0:4eb:1048:1285 with SMTP id
 r25-20020ac24d19000000b004eb10481285mr6084409lfi.47.1684211180188; Mon, 15
 May 2023 21:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com> <20230509175347.1714141-15-christian.couder@gmail.com>
In-Reply-To: <20230509175347.1714141-15-christian.couder@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 21:26:06 -0700
Message-ID: <CABPp-BHmbU=8dr_H1393eLtbN4zkaaWsKhMHzjABd7nfVG1Grg@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] replay: add --contained to rebase contained branches
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2023 at 10:54=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Let's add a `--contained` option that can be used along with
> `--onto` to rebase all the branches contained in the <revision-range>
> argument.
>
> Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-replay.txt | 16 +++++++++++++++-
>  builtin/replay.c             | 12 ++++++++++--
>  t/t3650-replay-basics.sh     | 29 +++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
> index 439b2f92e7..3e06ab2f5e 100644
> --- a/Documentation/git-replay.txt
> +++ b/Documentation/git-replay.txt
> @@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without =
touching working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
> +'git replay' [--contained] (--onto <newbase> | --advance <branch>) <revi=
sion-range>...

Should this be

  'git replay' ([--contained] --onto <newbase> | --advance <branch>)
<revision-range>...

?

>
>  DESCRIPTION
>  -----------
> @@ -90,6 +90,20 @@ top of the exact same new base, they only differ in th=
at the first
>  provides instructions to make mybranch point at the new commits and
>  the second provides instructions to make target point at them.
>
> +What if you have a stack of branches, one depending upon another, and
> +you'd really like to rebase the whole set?
> +
> +------------
> +$ git replay --contained --onto origin/main origin/main..tipbranch
> +update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
> +update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> +update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
> +------------
> +
> +In contrast, trying to do this with rebase would require 3 separate
> +rebases, eacho of which involves a different <ONTO> and <UPSTREAM> and

s/eacho/each/

> +forces you to first check out each branch in turn.

This paragraph isn't true anymore with rebase's --update-refs, right?

> +
>  When calling `git replay`, one does not need to specify a range of
>  commits to replay using the syntax `A..B`; any range expression will
>  do:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index c146f38f58..4d24eb95d8 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -256,6 +256,7 @@ int cmd_replay(int argc, const char **argv, const cha=
r *prefix)
>         const char *advance_name =3D NULL;
>         struct commit *onto =3D NULL;
>         const char *onto_name =3D NULL;
> +       int contained =3D 0;
>
>         struct rev_info revs;
>         struct commit *last_commit =3D NULL;
> @@ -266,7 +267,7 @@ int cmd_replay(int argc, const char **argv, const cha=
r *prefix)
>         int ret =3D 0, i;
>
>         const char * const replay_usage[] =3D {
> -               N_("git replay (--onto <newbase> | --advance <branch>) <r=
evision-range>..."),
> +               N_("git replay [--contained] (--onto <newbase> | --advanc=
e <branch>) <revision-range>..."),

Possibly need to update this here too.

>                 NULL
>         };
>         struct option replay_options[] =3D {
> @@ -276,6 +277,8 @@ int cmd_replay(int argc, const char **argv, const cha=
r *prefix)
>                 OPT_STRING(0, "onto", &onto_name,
>                            N_("revision"),
>                            N_("replay onto given commit")),
> +               OPT_BOOL(0, "contained", &contained,
> +                        N_("advance all branches contained in revision-r=
ange")),
>                 OPT_END()
>         };
>
> @@ -301,6 +304,10 @@ int cmd_replay(int argc, const char **argv, const ch=
ar *prefix)
>                 usage_with_options(replay_usage, replay_options);
>         }
>
> +       if (advance_name && contained)
> +               die(_("options '%s' and '%s' cannot be used together"),
> +                   "--advance", "--contained");

But the code does check that these are incompatible.  Good.


> +
>         repo_init_revisions(the_repository, &revs, prefix);
>
>         argc =3D setup_revisions(argc, argv, &revs, NULL);
> @@ -363,7 +370,8 @@ int cmd_replay(int argc, const char **argv, const cha=
r *prefix)
>                         continue;
>                 while (decoration) {
>                         if (decoration->type =3D=3D DECORATION_REF_LOCAL =
&&
> -                           strset_contains(update_refs, decoration->name=
)) {
> +                           (contained || strset_contains(update_refs,
> +                                                         decoration->nam=
e))) {
>                                 printf("update %s %s %s\n",
>                                        decoration->name,
>                                        oid_to_hex(&last_commit->object.oi=
d),
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index bca405c431..3fb4167e69 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -122,4 +122,33 @@ test_expect_success 'using replay on bare repo to pe=
rform basic cherry-pick' '
>         test_cmp expect result-bare
>  '
>
> +test_expect_success 'using replay to also rebase a contained branch' '
> +       git replay --contained --onto main main..topic3 >result &&
> +
> +       test_line_count =3D 2 result &&
> +       cut -f 3 -d " " result >new-branch-tips &&
> +
> +       git log --format=3D%s $(head -n 1 new-branch-tips) >actual &&
> +       test_write_lines F C M L B A >expect &&
> +       test_cmp expect actual &&
> +
> +       git log --format=3D%s $(tail -n 1 new-branch-tips) >actual &&
> +       test_write_lines H G F C M L B A >expect &&
> +       test_cmp expect actual &&
> +
> +       printf "update refs/heads/topic1 " >expect &&
> +       printf "%s " $(head -n 1 new-branch-tips) >>expect &&
> +       git rev-parse topic1 >>expect &&
> +       printf "update refs/heads/topic3 " >>expect &&
> +       printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
> +       git rev-parse topic3 >>expect &&
> +
> +       test_cmp expect result
> +'
> +
> +test_expect_success 'using replay on bare repo to also rebase a containe=
d branch' '
> +       git -C bare replay --contained --onto main main..topic3 >result-b=
are &&
> +       test_cmp expect result-bare
> +'
> +
>  test_done
> --
> 2.40.1.491.gdff9a222ea
>
