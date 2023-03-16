Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C7DC74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCPWjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 18:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCPWjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 18:39:13 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6ABC48B8
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:39:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id u22-20020a17090abb1600b0023f0575ebf0so2700160pjr.9
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679006349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AukwTaCWuGa6tYXxHnXoJ8CVri7mDAOPs0Up9nyRu0M=;
        b=pCJj2I3EmE74zvTQ8Rnu0xIUj9I4gSddl0cdBIA/m+kiza6IpvRZJqgpDJJ8gWrTmm
         Wdd1HgUfOLyo8Nh/P99UYhNbqMs0IwpZd8H0YnuiPoSdl+OfhY1kfO1dLgfiEJG+HYiz
         Yml/bMhVJkXdWsk3DeuxaFnt6G+jIKwCMC8cT+LpOIN/XitnepSPinx2eNrXjncM+xuY
         fU3P9VOHZ01PRA0T0f9g0VTUfjizUA6a6wXemYWZ5mHnOqikhTmfEC/OK1f5FCt9W+Ns
         TYoGRWqZGtU4ONbsr1hUW/+UM0u1QD0HmJ6OlIqOwFJpnT3+ND67zA4QkvVoNgP81Lar
         MK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AukwTaCWuGa6tYXxHnXoJ8CVri7mDAOPs0Up9nyRu0M=;
        b=exJytGfPrgNPnq7kPXrSPxWRpiomyw0lIxcBDV94YzWWKfbfEqfPyEOpizHfpogQte
         bY03ggaQW5BeB9+8caUPq+8q2BULTA7Xpy+VfCNHuHjgm6pRCsQzzXRjwh1md7HBwyYR
         5mpUrtC3fJgLA64MdRfgfRLCuz9QrHDOZG6ScSj4UK00C3TSr8ztpXEQvwFdWhltI4N1
         SIcDeBS0/W0t0eWShcmTW3/EAOzV+O21PAl3lQfBwUp1/CN5OvOiS/5rYVwoHWqu1Ar/
         L79MM0C1CBlMCkQ1Xp2ZLGnocAe7req0iYjo2se5q8CYvEsEdN+3xb3/6bj47e+Wmdnz
         P6DQ==
X-Gm-Message-State: AO0yUKVmHKRT/wgSc6KK9Xyb4+D6zA1movTp1uKzof5aP/a3XzLwWACw
        LVmrDyJ0mFQOx7oLXvBiw2ByJROZT2djsQ==
X-Google-Smtp-Source: AK7set9DTZfdp3nqFw0D1pQk6dyJtiRCD9wOj0e2GOW2BeriCs1ROXle476WSBJct+g0APb7cx8BlxvQqhf5YA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a65:6d96:0:b0:503:2583:effb with SMTP id
 bc22-20020a656d96000000b005032583effbmr1332275pgb.9.1679006349710; Thu, 16
 Mar 2023 15:39:09 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:39:00 -0700
In-Reply-To: <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com>
Mime-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
 <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com> <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com>
Message-ID: <kl6lwn3guxrv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

>> Your doc patch explains the rules pretty clearly, but perhaps it doesn't
>> explain this mental model clearly enough, hence the confusion. If we
>> don't find a good way to communicate this (I think it is clear, but
>> other reviewers seem yet unconvinced), I wouldn't mind taking Phillip's
>> suggestion to have "--rebase-merges" override
>> "rebase.rebaseMerges='specific-mode'".
>
> I got the impression that everyone, including Phillip,[1] already
> agrees that the proposed documentation is clear about the interaction
> between the config option and the command line option. However, it is
> a little weird when you consider that other flags with optional
> arguments, like `git branch --track`, unconditionally override their
> corresponding config options.[2]

Ah, I didn't consider other options like `git branch --track`. I haven't
looked into what is the norm, but I think we should follow it (whatever
it is).

If other reviewers have a strong idea of what this norm is, I am happy
to defer to them. If not, I can look into it given some time.

> Let me ask a different but related question: If we add a
> rebase-evil-merges mode, do you think that would be orthogonal to the
> rebase-cousins mode?

I am not an expert on this, so perhaps my opinion isn't that important
;)

My understanding is that `[no-]rebase-cousins` affects which commits get
rebased and onto where, whereas `rebase-evil-merges` would affect how
the merge commits are generated (by rebasing the evil or by simply
recreating the merges). From that perspective, it seems like yes, the
two would be orthogonal.

Hm. Maybe this means that we'd be introducing a new option, and that my
hunch that we would change the default to `rebase-evil-merges` is more
wrong than I expected.

Though I guess this doesn't really affects what we do with the CLI
options _now_, since the discussion is about what we do about defaults,
and what the default is is quite immaterial.

>
> -Alex
>
> [1] https://lore.kernel.org/git/7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk/
> [2] https://lore.kernel.org/git/5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk/
