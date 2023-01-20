Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A18C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 12:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjATMFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 07:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjATMFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 07:05:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B559FDDF
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 04:05:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g205so3791223pfb.6
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 04:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1fsfTTaVgUKfNaFqwRlDg4AvISvkdCMiJ38jlJ7YSU=;
        b=akuyg0hqY6P4PCGuT70JOO7BBjc3Wm9KJm0wIhWgkPvGl1LnlU0gl3UWEVzxlsg8uo
         bJW7mQKEXMOoQN62ojApxxdvMIExvIn2VRVn1WO3MK6/oa7VqbnxvIhe5D8zEzFOG8+9
         MJ3UNumetmkDTUL/U6cjv0sx6nYy2gthnMQcf5OEroGG2+T5/VVjjMwsuwrKbBXOVvy1
         BN76iio/IcUWt4yKKyafMhC39JE5wS5atG02SH6TAHsEnDmyrEb3D/wPWXE40GDIJ6JN
         seCOWoX3M/xYZnfNE8jSJf/HYK3bCjknphOmPl43mSZD9v8/NsSKLnddSCc3JAowYdqC
         AknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1fsfTTaVgUKfNaFqwRlDg4AvISvkdCMiJ38jlJ7YSU=;
        b=M3r7dj2pEqLE9lKPxRwZxbUO7i8/cswFzr3e9Yz9mLZhkfzu6leeW3nD95BBGf6Kc0
         CNx4kIZTb5bdl1k43BSDl0IxBijJeDkbXLkGaqRWFtKLJATWFC9zqaUI1/UFqjJcN9Pa
         LIipkDxKNnluDWbmfIeyVFZ9x5XVTMFtz1X8n+sIaNC6aTfPkR/2BeS+QMbjkkmhQUEE
         JdVKbTlw4TTp+CBvJqmHLQbv6iczvk4025epv3RUK/ztPdTY5jM3YNXZhwzbMLt80vRW
         B+wjU7ldeRkhCaqR1s3Yi63hi4wt1voLcepzLaORLP+45gqp0GOcfzN3dfEwX0mP38Xk
         wjCw==
X-Gm-Message-State: AFqh2kpi3B1EJSPI1APYeacUqR/1qSMEP7mgfWZe2LrsYdfUcMqQcIrE
        ENBrovhSPiOEJjETVYBqu6w=
X-Google-Smtp-Source: AMrXdXsVJWkHiP1J9oPE2ZKQbg/uCRuyJ7kkci7FIu+eTnaTIoc0hZ3oxH4KdaucMFLcJvPiC0rOrw==
X-Received: by 2002:a05:6a00:4207:b0:580:eeae:e4ba with SMTP id cd7-20020a056a00420700b00580eeaee4bamr15856307pfb.4.1674216323387;
        Fri, 20 Jan 2023 04:05:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z26-20020aa79f9a000000b0058da92f7c8dsm9713305pfr.17.2023.01.20.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:05:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
        <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 04:05:22 -0800
In-Reply-To: <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 20 Jan 2023
        04:56:12 +0000")
Message-ID: <xmqq5yd1za0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> The `-C` option to rebase was introduced with 67dad687ad ("add -C[NUM]
> to git-am", 2007-02-08).
> ...
> As per the git-apply documentation for the `-C` option:
>     Ensure at least <n> lines of surrounding context match...When fewer
>     lines of surrounding context exist they all must match.
>
> The fact that format-patch was not passed a -U option to increase the
> number of context lines meant that there would still only be 3 lines of
> context to match on.

I am afraid that this is only less than half true.  Isn't the
intended use of -C<num> similar to how "patch --fuzz" is used?

That is, even when a patch does not cleanly apply with full context
in the incoming diff, by requiring *smaller* number of lines to
match, the diff *could* be forced to apply with reduced precision?

My read of "even if context has changed a bit" in the log of that
commit is exactly that.  And for such a use case (which I think is
the primary use case for the feature), you do not need to futz with
the patch generation side at all.

commit 67dad687ad15d26d8e26f4d27874af0bc0965ce2
Author: Michael S. Tsirkin <mst@kernel.org>
Date:   Thu Feb 8 15:57:08 2007 +0200

    add -C[NUM] to git-am
    
    Add -C[NUM] to git-am and git-rebase so that patches can be applied even
    if context has changed a bit.
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Junio C Hamano <junkio@cox.net>
