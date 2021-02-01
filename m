Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E3C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D77E64E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBAQRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 11:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBAQR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 11:17:27 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B171C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 08:16:46 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w8so19354460oie.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iQBFX6rRSQWlrwzx+P8n8yxQMkGjSznMTncFKCmuy+s=;
        b=Ci3m++Rbhf1J+G1vnOxd2aAa6Kb9mxOYdycryEROtG/XEh1GwTERWIAO6eJKE0oaPY
         JIqwvyYwbww+n0Jg6flpD4BzpmvjEeVhMgsIpytRPNRErTyrxzqyGA8WhlFAb/jycltL
         AJkVNySJA1QmGYtczDByGMbl+3fY3wcweznydiqGrvnjeYyqPsvnAy0PFSd6lO07cI/w
         MH1u4n4oJ+jNBMtLcXH7AvAWOJubHh47UsXf+Pm70pSIGJGFgevZ8eYdWfgtOlALTXbZ
         mCHOD7tgIZHFwUJLBYX9tmexi69f8bCJl8H2I7Cuam6aUaNJCrRQDIq2eHrZPuhqpwGE
         9XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQBFX6rRSQWlrwzx+P8n8yxQMkGjSznMTncFKCmuy+s=;
        b=i734RzMOFbkjKFc/ezqP7EORzJz43cLZ4axB/BTHqkTLhgXooMI5R9QLV8VPzaVhLL
         JciulQYbGjSeAJ5YYCwMt/BycJms/ZmmIZKsoVgw5jiTEO5ayVu7PT6x+yZlmCapLLQE
         zJaVu+gaLkD9CaidtP1MEjorxqdSuI1GBb/w2MvlNq84j2yL0G3atmEhwbHKYePx89KY
         1O+WTKYDMxKkhsyyafmn8LiV6oAgdduXDgHPAh0pKvJnAGckpSGq91K6e4hIlErn6fXZ
         ihpbEZKvNxJYcvCkmMDXBFsp34BRvz6/hCRR4JYsPBUJ6DuYzcpDXGnQ2xYnSBDlN+Cw
         HbBg==
X-Gm-Message-State: AOAM532u1IfZ05ix9P81wZSsshuhwgBOwgVEn9bAdsBiv4QHlpL+0NEy
        3BBdgaDVdUuCBzaOHSDUaKFk/C4YhMLyQT+sZik=
X-Google-Smtp-Source: ABdhPJzKX4RmqIuXAXKkZ/J1zWnF2P213fzrFrWYwy5b8SdgPwufdPYHHtnTtj2JziEjsYj9Wj06ELluFBdtMB/5n2U=
X-Received: by 2002:aca:5290:: with SMTP id g138mr11692318oib.44.1612196206110;
 Mon, 01 Feb 2021 08:16:46 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POLQ_6cZHh0UCaavNBL7+FcMEX8bwb=VxvNMtmO0ZSCPwg@mail.gmail.com>
In-Reply-To: <CAGP6POLQ_6cZHh0UCaavNBL7+FcMEX8bwb=VxvNMtmO0ZSCPwg@mail.gmail.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 2 Feb 2021 00:18:49 +0800
Message-ID: <CAOLTT8RVL15NUVJHz657yeAycuUeOR6i4Z6TGehLPRjrUxmoTw@mail.gmail.com>
Subject: Re: The error subcommand given by git tab completion.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git gui works normally for me in arch.
You should go to install some dependent commands.

Hongyi Zhao <hongyi.zhao@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Ubuntu 20.04, the `git TAB' will give me the following available subco=
mmands:
>
> $ git TAB
> add               deborig           merge             rm
> am                describe          mergetool         send-email
> apply             diff              mv                shortlog
> archive           difftool          notes             show
> bisect            fetch             pull              show-branch
> blame             format-patch      push              sparse-checkout
> branch            fsck              range-diff        stage
> bundle            gc                rebase            stash
> checkout          gitk              reflog            status
> cherry            grep              remote            submodule
> cherry-pick       gui               repack            switch
> citool            help              replace           tag
> clean             init              request-pull      whatchanged
> clone             instaweb          reset             worktree
> commit            latexdiff         restore
> config            log               revert
>
> Then I try the following:
>
> $ git gui
> git: 'gui' is not a git command. See 'git --help'.
>
> The most similar commands are
>     gc
>     grep
>     init
>     pull
>     push
>
> The git version is shown as below:
>
> $ git --version
> git version 2.25.1
>
> As you can see, gui is among the auto-completed subcommands list, but
> it can be run like the manner of other subcommands. Any hints for this
> problem?
>
> Regards
> --
> Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
> Theory and Simulation of Materials
> Hebei Polytechnic University of Science and Technology engineering
> NO. 552 North Gangtie Road, Xingtai, China
