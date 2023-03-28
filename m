Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61DC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjC1RDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjC1RDD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:03:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E79EFB1
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:02:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15785337pjp.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680022979;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGF+SLsU2DyBe+3jo3B+LEJ4dBZdQBIzsgMFzdhsOSk=;
        b=YINkM3k4GR1ylCFgRfQyIRdc8xvVwU/QuncF15li/NB00j5nEGNrCibndFcfwnXsdj
         j2vvePl+e9VtVK0ebBFRy19m2BUXqSM16V9C1EDDAo+72SRdEmFut393F0miIUptKuKL
         d6xgqnKlGshqj/17A7ktbuAu+MPRGOiPq+zYEQ3TWwiWW5TADfkb9trjmuL90XCjQJOt
         H11RgSmFDhxHLnklvAMvD7y2pVH5z/vwaAFvr1j5wcobCqZB6wEtFhOhcd/xBz8S88dB
         es0bkskjcRMFIGqX28rhB8ZYDOIxh+a9LA0Esy1MfpoypPqGZG6Q0sDN1afERiEm2C0w
         w2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022979;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mGF+SLsU2DyBe+3jo3B+LEJ4dBZdQBIzsgMFzdhsOSk=;
        b=g7+Ca9ij49UTuXjKyIm/wD7CwRV3q+0dquhjXgwz3XOiFHWrJJ2R+E5LjZR962iE51
         waw0yHuqDUfIXau45Su5GWu5obGIpF4AywmQYogTJ8peuagv9xvgMbxj8B65VBFYmi5s
         95GBrSbsR/7KIjfMpG/jMLoDwL01JRP+JKcQocGTE0qpsrYlrMOB9nk7+cThAXbT5A58
         goJYNRMtSBcTv9DOstXeS7LpAfPG11ghqFce7oumdOC7xqZJIQJuDc0Yt1Be9bvaAEik
         LoKZfZwzhabQMmPs8Wy3EcQIMvBXpxrQREuM2lKAyEExNifllMO3eQ2oFUGJBGXexUYy
         0sOQ==
X-Gm-Message-State: AAQBX9cqPEjhe2eY/ekNXFx8x7hz/oBhhTri0p5As8b7VmhBfiGEaF/O
        Xk3gwV9ucHki+gBtFyLniNY=
X-Google-Smtp-Source: AKy350ZW5wdGQ7jDJnPMnA94HZDFBYi5vz/wT9uXx9ObNyuAmkWfQnPuCQt+Kt1jclzcVnN6RzQkTQ==
X-Received: by 2002:a17:902:ecc2:b0:19a:b754:4053 with SMTP id a2-20020a170902ecc200b0019ab7544053mr21774371plh.26.1680022979269;
        Tue, 28 Mar 2023 10:02:59 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d88300b0019f789cddccsm12400169plz.19.2023.03.28.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:02:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v8 0/9] config API: make "multi" safe, fix segfaults,
 propagate "ret"
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
        <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
        <kl6lo7ocdd8w.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 28 Mar 2023 10:02:58 -0700
In-Reply-To: <kl6lo7ocdd8w.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 28 Mar 2023 09:58:23 -0700")
Message-ID: <xmqqo7ocg665.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Thanks! I read through config.h to be sure, and the result looks pretty
> clear to me.

Thanks, both.  Replaced and will mark the topic for 'next' soonish.

