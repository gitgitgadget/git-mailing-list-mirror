Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC69C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 22:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBPWfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 17:35:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B076A1
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:35:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so3724585plg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1ptWJNy6avvst6NHQ6RGNTifqq0WupgKqvMEyRgzyw=;
        b=HaVVV0I9qkLdKuXaPclc6UEMykVg7eD8igByxaGkga2Y2TRZ01Bd4rWSF+KHzxnvQu
         th/dAK86ZDbxF9YPC1IXsdwQrPAMzQzsCV5Brka726frhgzzw/byIg7AkXOvxRfXHYN6
         YN1MHnoC+/gk/ZQqmS24yt+IZCXtFtYNYjmao9qjolJwsoYgxG3eFaGizelmZj9nJ+U3
         h0j48IHMH4dTVGlLGRV1UkAELLSAhl9HnKnCbW6J9crDaq5hTpB2l1qrAQc8VJngGJHI
         RxBbvSHwpQbRr9oIBGQ5lVqBIdZa7N/FwfVzP2wXpeeSRJSX9AAI4HDPcTBMLouMI4Qk
         tulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1ptWJNy6avvst6NHQ6RGNTifqq0WupgKqvMEyRgzyw=;
        b=JXKEprk6CVWf1eqpPYhfkr++p/He1GTKjaECx+doCEjJyAIu3mX2A1S2u5NMIBGT7J
         tPaNaAkjiXJPAvnci4INwRYyDzbxsbWtoeO5gMaLtqGFwU0akdCgl812QLxbKv/BxzJk
         qcvBFd0fYuJzkNIWTLiP2ErheYAjMUow1XVqdJSd5ytUd7jA6QsbSGxJgUWfhjrmZIOo
         koSjhdS25zdAvD8HP1G4mADi28Sk8pt473FZUrzoGDLgPgFbNMfrH2mVOgZG+wW9cV9z
         /h08ve+QpdxD2sqmgUqscTyV2v9cXEx2AX128+EaYpdOxbq825sWdAyoIfWVMgxsgNDg
         qHNQ==
X-Gm-Message-State: AO0yUKWaD1U/o76zhD70wHP8zsit0T8wn0OQBjhRdaFIGYjEMmk5N8KH
        LLB50g9YOiFame35VIS4zTU=
X-Google-Smtp-Source: AK7set+JW5V8T1ovINRxaT9e5br6BKrRywaKyxUf/G6jzJ2/BDvIbALijcfr2vHy60PYyaTcSeQ0kg==
X-Received: by 2002:a17:903:230e:b0:19a:9890:eac3 with SMTP id d14-20020a170903230e00b0019a9890eac3mr8818338plh.39.1676586931262;
        Thu, 16 Feb 2023 14:35:31 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b00199023c688esm1813763pll.26.2023.02.16.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:35:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone
 options
References: <20230216193210.6yj24zhhdhoozpr3@carbon>
Date:   Thu, 16 Feb 2023 14:35:30 -0800
In-Reply-To: <20230216193210.6yj24zhhdhoozpr3@carbon> (Konstantin Khomoutov's
        message of "Thu, 16 Feb 2023 22:32:10 +0300")
Message-ID: <xmqq1qmpp7bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> GitHub and GitLab have features to create a branch using the web
>> interface, then delete the branch after it is merged. That results in a
>> lot of "gone" branches in my local clone, and I frequently find myself
>> typing `git branch -v | grep gone`. I don't want `git branch --merged`
>> because that would include branches that have been created for future
>> work but do not yet have any commits.
>
> Possibly a rather silly remark, but you could make a habit of periodically
> running
>
>   git remote prune <remotename>
>
> or fetching with "--prune".

Likely to be a silly question, but isn't doing that, to actively
remove the remote tracking branches that correspond to branches that
no longer exist at the remote, exactly what gives Alex many local
branches that are marked as "gone" (i.e. forked from some upstream
sometime in the past, but the upstream no longer exists)?

> At my $dayjob, we use GitLab, and I routinely fetch with "--prune" because
> most of the time there's no sense in seeing stale (merged in and deleted)
> branches, and if it's really needed, their then-tips can be figured out from
> the merged commits which have integrated those branches.

Yes, as a workflow, it may make sense to aggressively prune remote
tracking branches (especially if you have good backups). But I think
the feature is more about the local branches you grow with your
commits, and not about the local copies of remote branches that went
stale.

If local topic Y forked from a remote topic X, depended on what X
did, and after a while X graduated to the primary integration branch
'main' and removed at the remote, after pulling the updated 'main',
your 'log main..Y' would still exclude the work done in 'X' and show
only your work on topic 'Y'.  You could rebase 'Y' on 'main' if you
wanted to (but I strongly discourage people from doing so in _this_
project) and a tool to see which local topics like Y lost the base X
that was work-in-progress would be a way to find which ones to rebase.
