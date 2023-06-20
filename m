Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA445EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFTVBm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 20 Jun 2023 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFTVBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:01:41 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617610C2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:01:39 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-62ff6cf5af0so46379016d6.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687294898; x=1689886898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkku1FuY5w6oLOniTtIxhR1b08A6U4ywKAQujq9xfYM=;
        b=e1ixBgvfckYYl+aWQ82hCgswYMaYElPAtFEFmG592m2+vC2zvZE3E6JVY6SMIdHyG2
         soTTJ4F9G9m8mgJ+urGHskuFu2VcobfLBLrXAOwOeUjVFfWCOt76XJy5e5+CA1bz7pc2
         yXFfq2I2jxR6oyUve9q3S81GSWhIoyG4ZhoBy7LaCSy9RJLWIzzQkPG2UJ2zn5CoWejL
         Oeyg+XebWcuIENFs3IybBuE2dkskGL55j4Y6LwpZD8gri3nNPj0yC3jDmOUKKRbrmfFw
         krjPzwEK9ntGeu3wRuHadmcuxutuGJk2MWreDt8K+ScHLLmCfBOmen7kU0WBiEN8s9HF
         saNg==
X-Gm-Message-State: AC+VfDw4pBWULcAJgp/SazYBq20j6EygCxRy7FFYTpfAJHSQJnuGijOV
        4tOBzwUq/TA2iI7kaTPnECi449nmXhgl2Z+YVSA=
X-Google-Smtp-Source: ACHHUZ6TuNeYyYdNtNKXRWUXxI9shl7lX6cXPfgMhhKfSW/xJRBKXP8nHUGKGP9HcjcCFVSr4+vqIJnmGDyXDeSz2Xk=
X-Received: by 2002:a05:6214:230d:b0:631:fb35:27e1 with SMTP id
 gc13-20020a056214230d00b00631fb3527e1mr3644255qvb.4.1687294898350; Tue, 20
 Jun 2023 14:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
 <pull.1232.v3.git.1687219414844.gitgitgadget@gmail.com> <xmqqy1keodjj.fsf@gitster.g>
 <1540e884-08c7-922e-1fd9-65616268c1c9@gmail.com>
In-Reply-To: <1540e884-08c7-922e-1fd9-65616268c1c9@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Jun 2023 17:01:27 -0400
Message-ID: <CAPig+cTXUKTWYhLpu-zRf4DFhHq_BnLZFznEc3pk-qiqcS0_CA@mail.gmail.com>
Subject: Re: [PATCH v3] Introduced force flag to the git stash clear subcommand.
To:     Nadav Goldstein <nadav.goldstein96@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 4:05 PM Nadav Goldstein
<nadav.goldstein96@gmail.com> wrote:
> > I am not sure how much value users would get by requiring "--force",
> > though.  I know this was (partly) modeled after "git clean", but
> > over there, when the required "--force" is not given, the user would
> > give "--dry-run" (or "-n"), and the user will see what would be
> > removed if the user gave "--force".  If missing "--force" made "git
> > stash clear" show the stash entries that would be lost, then after
> > seeing an error message, it would be easier for the user to decide
> > if their next move should be to re-run the command with "--force",
> > or there are some precious entries and the user is not ready to do
> > "stash clear".
> >
> > But just refusing to run without giving any other information will
> > just train the user to give "git stash clear --force" without
> > thinking, because getting "because you did not give the required
> > --force option, I am not doing anything" is only annoying without
> > giving any useful information.
>
> I see, but isn't the same argument apply for git clean? if not adding
> the force flag, the same message as I wrote appear in git clean (I
> copied it from there), and it will exit without any other information,
> hence given your argument, running git clean is also not very useful.

For what it's worth, I had the same reaction as Junio upon reading
this patch; specifically, that it will train users to type "git stash
clear --force" mechanically without thinking, thus won't be much of a
safeguard.

> I suggested in the beginning of this thread to ask the user if he is
> sure he want to proceed (default to no), and only if he wrote y/yes
> proceed with the action (and force will just do it, or requireforce=false).
>
> The reason I suggested it is because when running git stash clear, it
> will remain in the user recent commands, and when the user will navigate
> through the commands history in the terminal, he might accidentally fire
> git stash clear, and this confirmation will be another safeguard against
> this mistake.
>
> Maybe it will be useful for git clean as well for the same reasons.
> Also when the user types git clean, I argue he wanted to clean or he did
> it by mistake, and In both scenarios I don't see why making git clean
> just fail will be useful.

"git clean" is in a rather different (and more severe) boat since file
deletion is irrevocable, whereas a stash thrown away by "git stash
clear" (or "git stash drop") can be recovered (at least until it gets
garbage-collected). So, rather than adding a --force option or an
interactive "yes/no" prompt, perhaps a better approach would be to
have "git stash clear" (and "git stash drop") print out advice
explaining to the user how to recover the dropped stash(es), much like
"git switch" or "git checkout" prints advice explaining how to recover
commits left dangling on a detached head.
