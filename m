Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338CC77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjDQPp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjDQPpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 11:45:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E3CD
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 08:45:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id la15so2879428plb.11
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746353; x=1684338353;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJVrpteTr+FuXCJVgY9VeiRryl1WYTKF6kmJ4C9PObc=;
        b=iSRGLQDTiHF32IfROS924vF84e/Szmrs2OfQ7iFWlYX/o7BkKx7YpLa7osup8TNFbc
         L6/lSxgFOhC+wOngYLOXvVbxD6oYgxz+26FV9SrgUuKdJqIq8LEv6ZRl8qlAy1CrJygz
         peyzpFYvYykrZUhK8pbsOAoGu5WVdHRPqVMeeEIfPXmemiCxQIfnCILO0ePjZ/p522Vr
         GtJdEzK8RoEf3aTOiOlANwprCWXjywh36qOiCz950SCiVkYTXnbnv2F/EMuTFImGiDW9
         zJ2QUu0i1yg4IOBxPNxF7jLjU/KhF5C/48txf3XQLmMzjcy6sWFhE90JAARh1OZTu6JQ
         XbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746353; x=1684338353;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJVrpteTr+FuXCJVgY9VeiRryl1WYTKF6kmJ4C9PObc=;
        b=GySqaoXvoQACJ1zzooh831zInWxDwYll/R0cudF+U2cyrq03JdEKuDx4C6Wl1sPUXi
         SMI8IAcuMr37K9QtWubKnW/mp8+jvTu829KJsezT4hXjuLU4QTaAiZi7vv0BrcQPi1FA
         9oHvsvKiXQrsPVl+1N06xJ+7nrtVKq7DTCWkNquMCOuZkEoC+QuiHd49wmqe7mENVtUr
         aTiz4bIhmjTEwEBPhndQizcYVAJTjbMiURt6/GrgGxmloA3vR+e/BYXxfcc90K3WvKRi
         yReQZJpXrG4VcUXwoBWg1H4e3831zHIndZunmEjzm0N2aFLvUCeBEf4EaElkjtE4srkQ
         zQ/g==
X-Gm-Message-State: AAQBX9e5LTI6S6lknfINdgFEeXf/ilPXXqtky6RvHSaRbj0PoJXM+lAh
        FF9/amCALZZymuUHp+f565I=
X-Google-Smtp-Source: AKy350bKhq9EyafGIghoIk3IfsWakWOT0kulOzMCbx1sZaB7CnmChUGuVTn3Ii7agCALbL+TNhUyyw==
X-Received: by 2002:a17:902:8484:b0:1a6:34ea:6bc6 with SMTP id c4-20020a170902848400b001a634ea6bc6mr12717584plo.14.1681746353357;
        Mon, 17 Apr 2023 08:45:53 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902a71400b001a6ef7bd435sm1198871plq.104.2023.04.17.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:45:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
References: <20230407072415.1360068-1-christian.couder@gmail.com>
        <20230407072415.1360068-12-christian.couder@gmail.com>
        <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
        <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
        <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
Date:   Mon, 17 Apr 2023 08:45:52 -0700
In-Reply-To: <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
        (Elijah Newren's message of "Sat, 15 Apr 2023 12:07:10 -0700")
Message-ID: <xmqqy1mqo6kv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> For instance, can users pass multiple ranges?
>
> There's no such thing as multiple ranges for most commands (see
> f302c1e4aa0 ("revisions(7): clarify that most commands take a single
> revision range", 2021-05-18))
>
> However, users should absolutely be allowed to specify something like
>
>   $ git replay --onto new-base master..my-topic some-base..other-topic
>
> which is one revision range, and I'd expect replay to take commits in
> the history of either my-topic or other-topic, which are not in the
> history of either master or some-base, and replay them.

It is one revision range "^master ^some-base my-topic other-topic"
if we let traditional revision parser to work on them, and in many
topologies, it would mean something unexpected for users who thought
that the user gave two ranges.  E.g. some-base may be an ancestor of
master, in which case commits in the "some-base..master" range is
not included in the result.  Or some-base may be able to reach
my-topic, in which case no commits from master..my-topic range
appears in the result, etc.

But should we be forever limited by the "A..B is always equivalent
to ^A B"?

Shouldn't replaying master..my-topic and some-base..other-topic,
when some-base is an ancestor of master, replay two overlapping
range, possibly recreating some commits twice (when some-base falls
in between master..my-topic, for example), if the user is willing to
accept the consequences?

We can still keep the "so called 'range' is just commits that are
reachable from a positive end and are not reachable from any
negative end, and by definition there is no such thing as multiple
ranges" as an option for advanced users and trigger the semantics
when one negative end is written explicitly with ^A notation, but in
applications like cherry-pick where it is convenient to work on
multiple ranges, we may want to extend our worldview to allow A..B
C..D (especially when these two are distinct ranges---imagine the
case where B is an ancestor of C) to mean "we have two ranges, and
we mean the union of the commits in these two ranges".

We'd need to design carefully what should happen for trickier cases
like A..B C (does it mean the traditional "a single range of commits
that are reachable from either B or C, but never reachable from A",
or does it mean "the union of commits A..B that are reachable from B
but not from A and commits C that are reachable from C all the way
down to root"?), though.
