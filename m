Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77830C77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjEEVHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEEVHG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:07:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2242835BE
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:07:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7766d1f2so2720256276.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683320824; x=1685912824;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irW4I9+rWXmOMqkhMDs/wo75GkO6iU5IkMxSCFzQ+IE=;
        b=1oP0LDitx4Q7t1WR8YljJ3zePFga7g1jSJ/B6vXbgxluBNW8ZU/rFcX5UN3mX1Wvs4
         pyYoPrTUFRMExD6AFl8bfd1/8Yr73dbnHFclDDHwgPtS42LZejXt4Qbj2xPvxoIKAk6L
         S3WQhkXkduJ8yfedMOloYhuK3a7ZNmsE7kPU0nUp/9cBBgkIVc9KzxdTj95orEzW8MBe
         kEVu6zH3SvCt0Pq8DeT0v9aVkNWocbVDV33/6LUNq3gLUKHONUNUk/42ch2i1W/YQMrF
         +NG0vIpWz4RpFD7XDjfypnZHzrEZ5HKDk/J57b645BV+3fEc6wZSUdSOW2n8Rxgfdxes
         Oh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683320824; x=1685912824;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=irW4I9+rWXmOMqkhMDs/wo75GkO6iU5IkMxSCFzQ+IE=;
        b=QEhZzkBue2+MjG9a4m1FxgdS7UqhYLcoH4YVjSh0w/cJB+/GFET7aGcsfWhGX0677c
         asrxqPmyWHWlgAToF5IXFMPJ+OcD9bFkmGX+4qnaIh+9elZipOGAChwtYaVyUgJdDKxC
         PXnXJgXWNnwI67VsjCLPeJpvieJV0MVTu+brRE7+bBewcIpO8r5R/3VD1NUl8my+Gq0g
         IcQkE94Gz65ydPbGuATlSFvSIL3G4oZUj/350awTQodk+mvfziaetbz1M+Bh/2ijz6UC
         Eua8KJSsej9M9IeFGobufitocmgNanrlDhEK5mok5gtOis0IjoL8BXRrBCCdxc91rab1
         fv2g==
X-Gm-Message-State: AC+VfDxP1KlqpdbGLYnm00b+SHSMtuIRCnmXuKi1Dzga0xmGtgfFVEgX
        cx5eB/nJ786YaujRDDFUVbCWymZLptWsbBAObQ5D
X-Google-Smtp-Source: ACHHUZ6z/iDiooKHA8Cb/KlcaRm3vXciiZwcCvMt6R7znTtJueHiF+/CChpVFqaNuWtV8ujLwnw4VDFu7ZZ392ZGrjHf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:a6fc:f615:7180:efdd])
 (user=jonathantanmy job=sendgmr) by 2002:a25:584:0:b0:b8f:54f5:89ff with SMTP
 id 126-20020a250584000000b00b8f54f589ffmr1732357ybf.11.1683320824329; Fri, 05
 May 2023 14:07:04 -0700 (PDT)
Date:   Fri,  5 May 2023 14:07:02 -0700
In-Reply-To: <230501.868re8jna4.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230505210702.3359841-1-jonathantanmy@google.com>
Subject: Re: [PATCH 10/14] (RFC-only) config: finish config_fn_t refactor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> But as I pointed out in
> https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20230317T042408Z-av=
arab@gmail.com/
> I think this part (and the preceding two commits) are really taking is
> down the wrong path.
>=20
> To demonstrate why, here's a patch-on-top of this topic as a whole where
> I renamed the "kvi" struct members. I've excluded config.c itself (as
> its internals aren't interesting for the purposes of this discussion):

[snip patch showing where kvi is used]

Ah, thanks for this patch. One of my objections to your proposal in the
aforementioned thread is that we would end up with a lot of callback-
taking config functions that have 2 variants, one for the kvi callback
and one for the non-kvi callback, but here your patch shows that it
won't be the case.

Your approach does look like a reasonable one.

As for my own opinions, (before =C3=86var sent this email) I took a look
at these patches myself and had some issues with at least the first
2: in patch 1, kvi_fn() replaces fn() for some but not all invocations
of fn() (in patch 2, you can see one such invocation that was not
changed), and I was having difficulty thinking of what kind of bugs
I should watch out for since not all invocations were changed; and
in patch 2, the safeguard of not setting kvi and source together was
removed and likewise I was having difficulty thinking of what kind of
bugs could occur from both being set at once inadvertently. I was going
to suggest reordering the patches such that the large-scale refactoring
(and any supporting patches like [PATCH 06/14] config: inline
git_color_default_config) should occur first (or waiting for a reviewer
who is convinced that patches 1 and 2 are OK, I guess), but having now
seen that sidestepping a large part of this makes sense, sidestepping
seems like a good idea to me.
