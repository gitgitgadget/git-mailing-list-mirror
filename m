Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E93C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 17:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjAXRdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjAXRdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 12:33:10 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D64E50D
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:33:07 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s3so11676422pfd.12
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mL7eRBllfHEOMe3YIXjSJ+YJR/G+r0QK2TOdWK8Sbaw=;
        b=qhKF9Iy8QE4iiFjuAWDRGtuno/6LEPwslNrhzFlbqcTzrtHX9K6eZp9uIz+kn1Clj3
         0w22phKQa7XrMd1P6JkK3OMmNKBiziKXyvYFOJwvA/i5T+QiWxjuBIco0pd5WrT0ftCA
         29PDwRZE4CEVSR1zlVQif59/pMpK6kctGWYpIA850D9VkIwrFvRiUH+4rxz0cWmNITB4
         yrW1cExKZ2iifoRNWsmgulmQai002aBgC64FVR3YKYFwQTvZh7hQSu5I+g5Rb2s6mE/r
         sLUw1NgFJ+N+rpE59a0w+eO1cnHWTjc24bNuNPGc32+fu7D81ICDyYO8llgSImSidaVn
         Qc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mL7eRBllfHEOMe3YIXjSJ+YJR/G+r0QK2TOdWK8Sbaw=;
        b=CceI1lz3ezXRmdxsr/7dfHbSKLtPSM8HzNpGo0mgfQAv5RMtZmZA63EIXns9y8XssK
         XXbugNdSBVv2XeNT5+x18xG33PSmM3VdmFarFdVJCTujLuGoH0wRLxgIVuusObpx5ITG
         q3p532+QMAks6NpubMUO/bXjqWitpqadJHEnwlWQTEPymQBkiwN6SLVkBQKGCssFhqm5
         U0Lm2OC/HmsEDV+B0DPPbwyvFx778y9nNp4/xsY85S8kbpD9G2njAJflkTIcr3qCvarY
         STVYCX0hq6WQFscUErhYibPqJUIyss3C7z0yAf/GpDyh5/iMi2Btuas0Lx+2y5niaUKF
         JBkA==
X-Gm-Message-State: AFqh2kr5w2IcAIUt6KUILlPf2NJyL6esvzmtCX4S5rTp5fs1AqE1O45j
        YhxSEg5kZpWU6Ccd/+lpuFQ=
X-Google-Smtp-Source: AMrXdXvypYVGe4TUU0W5P9VVPciePiOb0G18pY0PKQTdfTjQsm97jYJfpYslQm5B9unWNPnD6PnElA==
X-Received: by 2002:a05:6a00:2147:b0:58d:e2b0:e480 with SMTP id o7-20020a056a00214700b0058de2b0e480mr22224043pfk.17.1674581587125;
        Tue, 24 Jan 2023 09:33:07 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 21-20020a621415000000b0057709fce782sm1869611pfu.54.2023.01.24.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:33:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2.5 02/11] bundle: verify using connected()
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
        <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
        <771a2993-85bd-0831-0977-24204f84e206@github.com>
        <ecc6b167-f5c4-48ce-3973-461d1659ed40@github.com>
Date:   Tue, 24 Jan 2023 09:33:06 -0800
In-Reply-To: <ecc6b167-f5c4-48ce-3973-461d1659ed40@github.com> (Derrick
        Stolee's message of "Tue, 24 Jan 2023 09:16:30 -0500")
Message-ID: <xmqqfsbzhm7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> When Git verifies a bundle to see if it is safe for unbundling, it first
> looks to see if the prerequisite commits are in the object store. This
> is usually a sufficient filter, and those missing commits are indicated
> clearly in the error messages.

I am not sure if our early check is because "does the prerequisite
even exist?" is sufficient.  It is a short-cut that is cheap and can
be done without preparing the commit traversal.

> However, if the commits are present in
> the object store, then there could still be issues if those commits are
> not reachable from the repository's references. The repository only has
> guarantees that its object store is closed under reachability for the
> objects that are reachable from references.

Correct.

> Thus, the code in verify_bundle() has previously had the additional
> check that all prerequisite commits are reachable from repository
> references. This is done via a revision walk from all references,
> stopping only if all prerequisite commits are discovered or all commits
> are walked. This uses a custom walk to verify_bundle().

Correct.

> This check is more strict than what Git applies even to fetched
> pack-files.

I do not see the need to say "even" here.  In what other situation
do we make connectivity checks, and is there a need to be more
strict than others when checking fetched packfiles?

> In the fetch case, Git guarantees that the new references
> are closed under reachability by walking from the new references until
> walking commits that are reachable from repository refs. This is done
> through the well-used check_connected() method.

Correct and is a good point to make.

> To better align with the restrictions required by 'git fetch',
> reimplement this check in verify_bundle() to use check_connected(). This
> also simplifies the code significantly.

Wonderful.  I never liked the custom check done in unbundle code,
which I am reasonably sure came from scripted hack to unbundle I
wrote eons ago.

