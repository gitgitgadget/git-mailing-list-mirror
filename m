Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB4C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 19:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiGPTar (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiGPTar (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 15:30:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24E1EAF9
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 12:30:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v28so4443529qkg.13
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVO3C+KBCWlOv3fahazuYPXEpUADLL400AqDkMr0+cs=;
        b=eHfDd/Vgacb4+yMGA0Xoljxc229ldejG9HDLSAz9E4J6e1gRd6jlLAATyic0GxQaQs
         poTDkCjPUvUdyVG9fnAbiBAypg81e8yedAlAfEk7kRMwqZEt2D8OzujYNzPHPic0ea6n
         SMmDpK6iPdlEUIRTI1Rz24L/qcgIfWpivNE2yvD4V4SQ4k7ZlkyOW2XeqEY+gwJoLklf
         61Nkpxw469hBBVwwdlF/K+mvhejGOuRLxpitn1TsgWfus+eZSdIUXAEHWfjArdauKu6f
         5WVFkGOzIMj/SjVSa91Y/nTiaRBUBkiWjhL0zbIdF6URGaWWnWibeOlfc6y6BqrEHA6W
         8e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVO3C+KBCWlOv3fahazuYPXEpUADLL400AqDkMr0+cs=;
        b=y5ZHh4JmCHxvCpOilaDew5LbwzxvzTfRBBC6baTa2uPQzo39Mk46nytwA/0ssBaRWo
         qMrG8WNWwnMiULAq3mm/DYlicmJSBjVTcFhN+WQSKkboYMd/rvMU6WPr/uantJ4+40Mg
         cknV1Z1Guttbo0pjNSXOQfYlnm5WW+rEQaOJgQMugZK/hq3uCwVv4izXy/TvpSA49xM7
         fwJFwJambzyVWvXPNObCP+vg2HkFACV3683ATAhK/Q0Ovkvhc3zr05NckaqaSwiL2zTy
         tDuFNaqQ/yx7Iykb7d4K+3bmOhPI+TteZ+lQQ9GPfVM8NCf2ZqiM8rmkb4iwE1M/wXhM
         j0OA==
X-Gm-Message-State: AJIora9iWzzofb0qNJd1BHF/wvrir4YPoBE0sFEEM/wTpMA5oaSZ3YMl
        PM2q09bHGnc86Fl5cD2RG0AyBbjcF1VIld07WVo=
X-Google-Smtp-Source: AGRyM1tRu5Lv+37TPaAwMQGTv4gf00GX3guiwW1C/Riyw8Ohb76J4gsrUu2uA5PNVa+47ceCfimzvPJ7pXUS22GNOA8=
X-Received: by 2002:a05:620a:4547:b0:6b5:879c:5891 with SMTP id
 u7-20020a05620a454700b006b5879c5891mr13227967qkp.187.1657999845368; Sat, 16
 Jul 2022 12:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 12:30:34 -0700
Message-ID: <CABPp-BENsp3uc7J_xS0gr_yjWQ25NVuJbdHzCMEcaaGYvLEiKA@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 6:07 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
[...]
>
> +--update-refs::
> +--no-update-refs::
> +       Automatically force-update any branches that point to commits that
> +       are being rebased. Any branches that are checked out in a worktree
> +       or point to a `squash! ...` or `fixup! ...` commit are not updated
> +       in this way.

I think the second sentence here should be split.  In particular, I
don't think I understand the second half of the second sentence.  Do
you intend to say here that branches pointing to a `squash!` or
`fixup!` will instead update the first `pick` in the ancestry of such
a commit, rather than that such branches are entirely excluded from
any updates?  That's what I observed in my testing of your v3, at
least, and that's the behavior I'd expect this feature to implement,
but this documentation doesn't match.

[...]
> @@ -5660,6 +5764,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>                 item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
>         }
>
> +       if (update_refs && todo_list_add_update_ref_commands(todo_list))
> +               return -1;
> +

As a tangent, I find it interesting that you add the update-ref
commands as a post-processing step rather than as a part of
sequencer_make_script().  I don't think you need to change anything,
but I am curious due to my git-replay work if you find it advantageous
to do it this way.
