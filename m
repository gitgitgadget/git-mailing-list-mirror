Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCAAC77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 22:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEIWqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIWqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 18:46:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0A5590
        for <git@vger.kernel.org>; Tue,  9 May 2023 15:46:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a75194eebso8142041276.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683672374; x=1686264374;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV1i6qLtqr8bTL5lXtOTjil+jWv1C+qrdHtHwxDYa8Y=;
        b=fOC02cZlRDHy6+FdaXPWeM0kenw+Q31NuFKIB/W7YzKxPSTHADjxNyYub3eci19rm/
         Gx/g6KMgnSjS8ahD/gd7aLD+JHmhQHsllfxQ0Ztkvkyj9WjpDCyVHB4kOhoV/1m2+U6M
         1JtWLiniPvxcldB1LSRnq0HXbhbSIFkf4EG8lFl6JyfjJ8vOWtySxZyksL3rdkEBSNJR
         t1pU9mHEv0o6MaQhc6ZNsERCeK9wCr0yuLheLcQVCI1O/CO+gm0CzCcBKH5ZMzYgfZ34
         3nZL3/ihtOG+1pYSFm1nVAo4NIQRXSodDJj2NI1j5PfqMI6BPQsSkrG/UVoiipn94+al
         PvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683672374; x=1686264374;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MV1i6qLtqr8bTL5lXtOTjil+jWv1C+qrdHtHwxDYa8Y=;
        b=LaDWa2r6XQSDu/+M4gO5fsnyrCq+zMUQVNOICqrMyBRRbsBt2h/qBrRsXDAGV922vh
         TLIwqVMNYho0e2raddlAu+ddR2Rh5vJzO99AovBDwfz0nw2IRtHTkpV8TbQld6RVq+gA
         9Ur1c15ESDvO43o6XekM9Lw4wmJyNvnwcktIwNE3ZnoHHrnX6MzXnJgBB/+o00mewy52
         GUxdcf1LQgsnNJxaIp5qyrup9iECZDSEwt5abONRwxsYlZwepWFyK0+zkfmsJ5+qq0Le
         dBeii+twQjJmsxd0FmEp96duwliFNs9OrfL7CuxIda4JahLzgcVvx4GBQVcs1Q9FPROn
         fswQ==
X-Gm-Message-State: AC+VfDwhDn3lJz52Iu/L4RC+M3Paq3HSOVRQ8Lh2asdP9BNfBtwC3SwU
        ipwYJJg9rQQRFQaSukoxVRQ5jqJfugHU2A==
X-Google-Smtp-Source: ACHHUZ5UpAdjaX/7fs79vIqG1oRbH1shxe9/k3mIjAARdl+QM1hJIOJcnLghLYG8cWswnmP2t+HsMI0wpvWf4w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:bfd0:0:b0:ba1:be7d:fbe3 with SMTP id
 q16-20020a25bfd0000000b00ba1be7dfbe3mr9829707ybm.11.1683672374532; Tue, 09
 May 2023 15:46:14 -0700 (PDT)
Date:   Tue, 09 May 2023 15:46:12 -0700
In-Reply-To: <20230505210702.3359841-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230505210702.3359841-1-jonathantanmy@google.com>
Message-ID: <kl6ly1lxyvgr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 10/14] (RFC-only) config: finish config_fn_t refactor
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've covered most your response to =C3=86var upthread, so I'll omit that.

Jonathan Tan <jonathantanmy@google.com> writes:

> As for my own opinions, (before =C3=86var sent this email) I took a look
> at these patches myself and had some issues with at least the first
> 2: in patch 1, kvi_fn() replaces fn() for some but not all invocations
> of fn() (in patch 2, you can see one such invocation that was not
> changed), and I was having difficulty thinking of what kind of bugs
> I should watch out for since not all invocations were changed; and
> in patch 2, the safeguard of not setting kvi and source together was
> removed and likewise I was having difficulty thinking of what kind of
> bugs could occur from both being set at once inadvertently. I was going
> to suggest reordering the patches such that the large-scale refactoring
> (and any supporting patches like [PATCH 06/14] config: inline
> git_color_default_config) should occur first (or waiting for a reviewer
> who is convinced that patches 1 and 2 are OK, I guess), but having now
> seen that sidestepping a large part of this makes sense, sidestepping
> seems like a good idea to me.

In an off-list discussion, we described some plausible ways to organize
the refactor that would make it easier for a reviewer to confirm safety.

I haven't tried that yet because it sounds like you'd prefer the
sidestepping approach. Do you prefer that primarily for safety reasons,
or is it largely motivated by other concerns too (e.g. reducing churn or
sidestepping produces a better API)? If the primary concern is just
safety, I'm somewhat confident that we can find some way to organize
this that makes it easier to review and I should just do it.
