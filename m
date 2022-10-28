Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F9FA3745
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJ1Vk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1Vk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:40:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA5EA9E0
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:40:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso10999430pjg.5
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TGjGPjghyxub3F2jGUufkInPPAPDxHsqh3i/yOadMI=;
        b=O7YC6DmW3a1BlW+keSnvNtG6s8sLNVfN9ZEw3l83Bc7qklJMs4eJLx0GN/epysSgqW
         s5jFVQSnelPDOlzKg5PLTVxsfkP1mRpCj8S9yI14XYSHho/g8uIPxdXMKvV6Ghua6UH7
         SyLfQyhYQSu9V6nAx5ta6okFZ5jMXLDffdOcXEISS/zpObk+HiRxGjMzZyjU8Xw5W6NQ
         2Na37YmFC7NHlVuzz1rxGsu3iaQ7jOIkydd095f/XgLZa2IPv2MhJcYts09RTpDp6akK
         8B6Nf0XWPUM2YuzGaFzoiQ0pG6g7c4u7WiaPG/ABLd/vx7QLT/ud+vjOcBim3tuzsSg5
         /95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5TGjGPjghyxub3F2jGUufkInPPAPDxHsqh3i/yOadMI=;
        b=GP5wS1IO2LoC9OY8HlR+5h9UbetLeYm+mGxbM+lKTceT0pNB1hgLndTbaYrRmfnw6L
         kiLxxfg/XiRDjwZiq5HrXj9AyygKA1tdjli8y+LdNuzpgD2tsDuj1VdwW4IKPwpnCxAM
         QPuV9yTduvxlOsIFDX3fxhsRas0Rtt3f3EHXpQiW/lgeQP/vV80Cexi3qaj6z4XAe/4q
         zRLdGFkLGHu3fvmOp2MFyRYV09B2dgVT8rWloejfJXy+BTzUCuned/yT8F3Z2dUvgQ0d
         /gF5SrFr0L1D1MczIhnXeBK/OVz+f1CVpHR/GI+F6rQ6ZpUZ3YEtYdDIGCEwkPO1tDvf
         LSfQ==
X-Gm-Message-State: ACrzQf23zQfuYLJfg7D+dskmP2b1vWLVCVb3UfuQjxWzUEtkqfLGanSH
        FW6afy17zalfYognnvlHIl/TfhfDsDE=
X-Google-Smtp-Source: AMsMyM71r3og9TMd0wzeNatb+YX6jaZ7mtpiuVTFjXQreNWUosjBnPxI1B26Mk5824TU0R/KJ/E0EA==
X-Received: by 2002:a17:902:8682:b0:186:95c9:5d0 with SMTP id g2-20020a170902868200b0018695c905d0mr1016194plo.25.1666993224145;
        Fri, 28 Oct 2022 14:40:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w73-20020a627b4c000000b0056baebf23e7sm3360202pfc.141.2022.10.28.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:40:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/8] clone: teach --detach option
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
        <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 14:40:22 -0700
In-Reply-To: <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Fri, 28 Oct 2022 20:14:49
        +0000")
Message-ID: <xmqqmt9fhbjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Teach "git clone" the "--detach" option, which leaves the cloned repo in
> detached HEAD (like "git checkout --detach"). In addition, if the clone
> is not bare, do not create the local branch pointed to by the remote's
> HEAD symref (bare clones always copy all remote branches directly to
> local branches, so the branch is still created in the bare case).
>
> This is especially useful in the "submodule.propagateBranches" workflow,
> where local submodule branches are named after the superproject's
> branches, so it makes no sense to create a local branch named after the
> submodule's remote's branch.

Wouldn't it the same thing to do "git clone -n && git checkout
--detach"?  If this is a pure implementation detail of another
command and will never be used directly by end users, I am not
sure if we should add a new option to do this.

Especially because it is probably not hard to perform internally an
equivalent of "checkout --detach" without forking these days,
judging from the fact that merges and rebases need to do so.
