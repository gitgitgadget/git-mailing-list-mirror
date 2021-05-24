Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1AC47085
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8CC61378
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhEXQK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbhEXQKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 12:10:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEFC049DDB
        for <git@vger.kernel.org>; Mon, 24 May 2021 08:44:00 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s10-20020a05620a030ab02902e061a1661fso20661031qkm.12
        for <git@vger.kernel.org>; Mon, 24 May 2021 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bKUlmC2w8u3rY598lwsni7pahPxnbK/uotDXrGvFFB4=;
        b=wMcDBtxJeu4sqcMVjDPE85ygUPsk4VgzwF2+ZT5N9f8Bu0qcX/8pcLsKudyOs3MN70
         S5+0LNnPhizchvQOkCJURIw2rPXK458xQXcgRlbt5KRN3p1I93wKos/fEx0QVYs9Ko1s
         pXWE73d20/SI/SMEQQkYgQAiKV9VrdJ9htDkPgI68S8q6YTX+E1IU0+VhUqKFqV2YiOa
         2FBJKRZDwrpXVitrt3n0ZALgW2fRW5m0zJB40+m7B91jaOQxN1xgRirsRE6udnODNcp3
         m8oYhZIbULktkPsVjjffdZ5+gjz9PKHGqtvP8gpUGBnrKlKc12gvD4S8iYn9BqbV0b8x
         Z2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bKUlmC2w8u3rY598lwsni7pahPxnbK/uotDXrGvFFB4=;
        b=HQl5S1aE/Uu87GHk9B/Gwm3TeBZvVOJEjd6hXtv0qIsn//rwInBbvJaFhm4QjW9kT7
         jPScB60qgjKyEj3RfDmtQJunuKqEQZgjqEKokZfoTcld0yiJg8H10IzzHM8SI+kA5usU
         Mdyh9jTBejclxpWeS4FwUVFkkUCoVP0wBBfK29+0tBmeJRQpLu3ezuspD00FauNtl05z
         NxKlpIPzWoIi9UthoUPUV5no1RL6DmHivDm8bh8apKJBzwcngq1/O8aZFr98Msmet2F4
         dO1I1jBjAEjiu+bVuN5LGFBAh7RzmO8noVFY7fSjB6Ogi9bxrjbh1jb9JcCJqmEI4lE6
         q8VQ==
X-Gm-Message-State: AOAM532LppJMvz5VupK2VnnoPth9/br8sYAsVscxtstDI/yL7SQRpRi+
        Q5nlPxCyjNbco0yjSCijiMmOfkFWtlUYnr7UefY/
X-Google-Smtp-Source: ABdhPJyd68h7Q0wn323MqW4NQTedPNGYiW8JXJXxFhFWK7P4STjL5Q96haNNI/YZrmKw6vns5QZjSyG92uNaDkkn8cJh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:c245:: with SMTP id
 w5mr30752050qvh.36.1621871039448; Mon, 24 May 2021 08:43:59 -0700 (PDT)
Date:   Mon, 24 May 2021 08:43:54 -0700
In-Reply-To: <xmqq8s4c6fbg.fsf@gitster.g>
Message-Id: <20210524154354.268200-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8s4c6fbg.fsf@gitster.g>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: Re: packfile-uri.txt: fix blobPackfileUri description
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, dyroneteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Teng Long <dyroneteng@gmail.com> writes:
> >
> >> Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
> >> and the correct format also can be seen in t5702.
> >>
> >> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> >> ---
> >>  Documentation/technical/packfile-uri.txt | 15 ++++++++-------
> >>  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > Will queue; thanks.
> >
> > Jonathan, how does this look?
> 
> Ping?

Sorry, I just got back on vacation. This looks good - it's exactly the
same as the change I approved previously [1].

Teng Long, for future reviews, the review would go faster if you
mentioned the changes in between versions (e.g. in this case, you
updated the commit message following my suggestions).

[1] https://lore.kernel.org/git/20210506164728.336409-1-jonathantanmy@google.com/
