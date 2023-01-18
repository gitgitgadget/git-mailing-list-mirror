Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1700C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjARQ0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjARQZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:25:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B001E4B1A3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:24:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so52426909lfv.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/t6/33Oye+q6IKl6Sn3Ji6bDCAYQCHaV2w0LUbXWf2k=;
        b=acpTyWSUA0XIeLpjbw5uBR5PrO/2kuD+CzRY4+DUujxM/aVF1cbBdRtkyY4m8klDeF
         zZHcAomuU6EX4RrymEpa/xrUFNrIXd03KYefQq6EqadzGpNBx2n6M9OCQrnT2gjaohc2
         k8eRnWXfoLjlSzgQKSt9zkONJTv1Qag/NYGNOdBV42U37wMN3zNMq/ZJVLNvQymN/XMn
         m9FJXylqneon+he+ArlLgzl78TpT9Piho3vkXKmKiYSb09ZhVfAy9o+eifQrdK0nE0ZT
         vyx3WnpMkvUwb4VtlMXNrEySOIAne0r2j9XFfNxdwuA4tgtlyQlx4rWXXowYYzXbc6ra
         8otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t6/33Oye+q6IKl6Sn3Ji6bDCAYQCHaV2w0LUbXWf2k=;
        b=02+PJqL0eUFgF8ERk0lgyfOGkEIBLKV4XqCNYqWF/mzYJzWmNcYKSKNmEJ0GfMgp/a
         8um5mh4J3SyjcltePhZK4tCJZgFyGThDUJ8b9unERNDPNGo7iXBMxV7Ui5WownDa27Aw
         R4NYMDz9Qh0dbRrLTFWPRNfJkpTmo+51MsV7N3BWyk3Lxp4vZ4aNlaX5Rox0kJC4SLDP
         Oy2czkNrvB6NVmbRSjGN9wuwxwlYl5aTMRemynrPDVLxa5Ki8quN5t9Y4/uajX1A4ceN
         gx38neOEMh69fkfQRmXgvZUwrhv4i574XTQiz1Y7BppjLvj50kGvT2DAjQ7QPg3MoqWK
         DwGA==
X-Gm-Message-State: AFqh2kqGxqJbLf7RT1DWiX1jB9Y7jLYLitranQ38/Y0dOJ5FcaaJiG2Q
        LBj3IGUo4R18GaYsMemG+ZGzC84oHidcVEHwdRChO0na9Z0=
X-Google-Smtp-Source: AMrXdXuMX05Zf1WIsOS/RSEHqIU6HwUI5CxadRPh2C33JQwhVyYkxQXGQKbX3sWLP5SpUlsUfEVQRCn53KsYVe6fv9w=
X-Received: by 2002:a05:6512:3685:b0:4b5:a843:58cf with SMTP id
 d5-20020a056512368500b004b5a84358cfmr782608lfs.531.1674059059826; Wed, 18 Jan
 2023 08:24:19 -0800 (PST)
MIME-Version: 1.0
References: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com> <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
In-Reply-To: <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Jan 2023 08:24:07 -0800
Message-ID: <CABPp-BGLVMoGiCeBMvyRhQmUSDEv8U7_U8=4B=Fh94=p_=QJVQ@mail.gmail.com>
Subject: Re: [BUG?] 'git rebase --update-refs --whitespace=fix' incompatible,
 but not enforced
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 7:51 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 1/17/2023 5:02 PM, Philippe Blain wrote:
> > Hi Elijah and Stolee,
> >
> > First, Stolee, thanks a lot for adding '--update-refs', it is very useful (I've
> > added it to my config so I don't forget to use it).
>
> I'm glad you're using it, and thanks for the report!
>
> > I recently learned that 'git rebase --whitespace=fix' exists, which is also
> > great but since it uses the apply backend, it can't be used with --update-refs.
> > I understand this, and the fact that adding '--whitespace=fix' to the merge
> > backend would be a big task; this is not what this email is about.
>
> I also use --whitespace=fix, and am disappointed that it doesn't work with
> --update-refs. I guess I just haven't used it in my workflows that depend on
> --update-refs.
>
> > I think there is a bug in that the code does not enforce the fact that
> > both options can't be used together.  Whenever '--whitespace' or '-C' are used,
> > the code defaults to the apply backend:
> ...
> > but 'is_merge' only checks if 'opts->type == REBASE_MERGE', so the check only
> > works if --merge was given explicitely, but not when none of '--merge' or '--apply'
> > were given (and so the default "merge" backend is used).
> >
> > I would have expected the code to die telling me --update-refs and --whitespace
> > are incompatible. But instead it defaulted to --apply, and (of course) did not
> > update the refs in my history (which I found out later).
>
> Yes, I agree that there should be an error message (and a die(), not just a
> warning). I quickly whipped up the patch below, which should resolve your
> concern.
>
> Note that I was a bit worried about users with the config option and not
> just those that specify the option over the command-line. I put in an extra
> warning for those users, but I could see the community wanting different
> behavior there.
>
> Let me know what you think. If we need a new version, I'll create a new
> thread for that review.

I was just about to post a patch as well --
https://github.com/gitgitgadget/git/pull/1466.

> --- >8 ---
> From fe310b37796b0b15554481eb1cfa3942a9200b4b Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Wed, 18 Jan 2023 10:38:18 -0500
> Subject: [PATCH] rebase: die for both --apply and --update-refs
>
> The --apply backend is not compatible with the --update-refs option,
> which requires the interactive backend. Without any warning, users
> running 'git rebase --whitespace=fix' with --update-refs (or
> rebase.updateRefs=true in their config) will realize that their non-HEAD
> branches did not come along for the ride.
>
> Fix this with a die() message in the presence of both options. Since we
> cannot distinguish between the --update-refs option and the config
> option at this point, do an extra check to see if --update-refs was
> implied by the config and present a helpful warning to use
> --no-update-refs.
>
> It is possible that users might want to be able to use options such as
> --whitespace=fix with rebase.updateRefs=true in their config without
> explicitly adding --no-update-refs. However, it is probably safest to
> require them to explicitly opt-in to that behavior. Users with the
> config option likely expect that their refs will be automatically
> updated and this will help warn them that the action they are doing is
> likely destructive to their branch organization.
>
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/rebase.c              | 21 +++++++++++++++++++++
>  t/t3404-rebase-interactive.sh | 12 ++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 1481c5b6a5b..5330258c865 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1247,6 +1247,27 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 die(_("The --edit-todo action can only be used during "
>                       "interactive rebase."));
>
> +       /* Check for arguments that imply --apply before checking --apply itself. */
> +       if (options.update_refs) {
> +               const char *incompatible = NULL;
> +               if (options.git_am_opts.nr)
> +                       incompatible = options.git_am_opts.v[0];
> +               else if (options.type == REBASE_APPLY)
> +                       incompatible = "--apply";

git_am_opts can include "-q" which is not incompatible since it's also
supported under the merge backend.

> +
> +               if (incompatible) {
> +                       int from_config = 0;
> +                       if (!git_config_get_bool("rebase.updaterefs", &from_config) &&
> +                           from_config) {
> +                               warning(_("you have 'rebase.updateRefs' enabled in your config, "
> +                                         "but it is incompatible with one or more options;"));
> +                               warning(_("run again with '--no-update-refs' to resolve the issue"));
> +                       }
> +                       die(_("options '%s' and '%s' cannot be used together"),
> +                           "--upate-refs", incompatible);
> +               }
> +       }

We already have imply_merge() to catch the range of incompatibilities;
can we just use it?

> +
>         if (trace2_is_enabled()) {
>                 if (is_merge(&options))
>                         trace2_cmd_mode("interactive");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 462cefd25df..8681c8a07f8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2123,6 +2123,18 @@ test_expect_success '--update-refs: check failed ref update' '
>         test_cmp expect err.trimmed
>  '
>
> +test_expect_success '--apply options are incompatible with --update-refs' '
> +       for opt in "--whitespace=fix" "-C1" "--apply"
> +       do
> +               test_must_fail git rebase "$opt" --update-refs HEAD~1 2>err &&
> +               grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
> +
> +               test_must_fail git -c rebase.updateRefs=true rebase "$opt" HEAD~1 2>err &&
> +               grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
> +               grep "you have '\''rebase.updateRefs'\'' enabled" err || return 1
> +       done
> +'
> +

t3422 exists specifically for checking for incompatibilities of such
options; the test should go over there.

I have both changes over at
https://github.com/gitgitgadget/git/pull/1466; it doesn't include the
"--no-update-refs" hint, but maybe that's good enough?  If so, I can
submit it.  If not, do you want to alter or adopt some parts of my
patch and submit a v2?
