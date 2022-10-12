Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7F6C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 14:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJLOVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJLOVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 10:21:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA80CAE56
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 07:21:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3573ed7cc15so157049347b3.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlJjzxhxpmnxnxhjGem2ueFlxHmbIPWNkMWfQSlZ/g8=;
        b=faY8ypou0S5mWWcHeR+q449+RlYjR2k8JeKdUHANYHhILNkkZ2L5uEikZJyunWBh87
         PTwp/f/O+7jOpYIRetz8RdQZTqgtz2QMDzHwi/IfS4ARnV5Ud145spOfUfW+ktTK2dU3
         MUukeU0Xvvi0qvisMOr9iI5af06M6CjUyh78Kvk6hRa4IK0qrzDSCy6ahls42VruMAjs
         lK54RyDXjnpRvZjbKMaDsfJg/bsQtEZz60c3S25ec3+ObtWvK7bFSOro0BqwVDqS9QNW
         iRiilf3fIh91nV32hhvQymdHMN/6M/j2agQMndOh3i7VEqNA/HOMjiwDKqB25jZ2q4ys
         E8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlJjzxhxpmnxnxhjGem2ueFlxHmbIPWNkMWfQSlZ/g8=;
        b=sDIsNX42bLZZbhCJzHy/ehRjyxdCV6u9+daHVWXOa1UGzPYvmxQN5zTbBeHafqN5bX
         /L2Wpf3mKtu/w/DkVocXcp3kSRjnD8A516rHrEt4pztL5gzlXQVOyM9TDHeoUs1DNGKX
         Iwv96Lo2gVcSVAu2dhCae13F1tzZ+Hm59z5oVDmH+Zo23l1K+bFpNXIuj5rju9cF3Vg/
         r0mr320epqew9pf3QXuEiFsDOoHKuAuJyeUETCxkVN4qTmbuTZngF+oNCoNuBBICQ6S4
         KXK8w7kE5V3UkvmF5JNq+CC3DpgWkhqhy3A1XsBhQP2D/O9nsawa8L+c9yVHCpct7qXi
         wSXg==
X-Gm-Message-State: ACrzQf2d0tf91xgqhPYs36wq0M56AqAUClxqSMfY5NSILCL7Q/7AhTo0
        ftf5yJiV2YFHVeR9UdfcEd93bK7EM45vQfypIMI=
X-Google-Smtp-Source: AMsMyM4gcoDoKq1yjjW5/P2YroFHez2VU0Nk2NzgEZ1vCiYw8xbakZxKBl1wiZ2kJkjDfGzkgKNwdt2hS2ATfc4FjkE=
X-Received: by 2002:a0d:e2ce:0:b0:360:ed8f:c1b5 with SMTP id
 l197-20020a0de2ce000000b00360ed8fc1b5mr11780457ywe.365.1665584481088; Wed, 12
 Oct 2022 07:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com> <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
 <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
 <xmqqleplmz3n.fsf@gitster.g> <Y0Zig4XUePPhMaA3@danh.dev> <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
In-Reply-To: <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 12 Oct 2022 16:21:09 +0200
Message-ID: <CAP8UFD3sa-jLFO31QZ6QG=Udg-H73rn6h46QpnVRGekT1o0gmg@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 12:38 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> I am using ubuntu(wsl)

On a regular Ubuntu `sudo apt install xmlto` should install xmlto and
you should be good to go.
