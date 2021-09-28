Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A7C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38DE60F6B
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhI1IdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbhI1IdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:33:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C4CC061604
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:31:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bd28so18724899edb.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ylz0SEnaUVqSqmxo+yPCEmTdm4KqUERS/tnB/OW3+1U=;
        b=Ly/2R0x8ytlwnISd0DZX2RdZbAyKchB2x61eaxsTeVz1a+RpVtfG+lBI8DGbzOMPTk
         axG7ZvpwapTdjkLFOXeto0VxkMaA0aBLavwZtuSl98cr4IbxaCVdAUn7oEOTpfAhpJGr
         41nqfQhIW6DKAcrXzwp4PgPESRkpmS+CibakPA7IlAWRXQnAL8qIH8f1wHtsmgTP3oZf
         qKMrWgdQowfKw1e6azaLHxzJYgcC3U/bOC+Mk4feNkQ9S6r4COIqkZcw9enBHJ9T8Vps
         gYupGefleJkLpMlZFxvBNj6mACPZpBbnSR3cZjEiCU0PB+Man5yoClxQG9h50i51+wV0
         jOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ylz0SEnaUVqSqmxo+yPCEmTdm4KqUERS/tnB/OW3+1U=;
        b=zBjccIfz66eiZskixLZ5tMMWK/h/su2EeHY8ylQWJGlnBizCW7X96xn1Af7kDkmdjb
         OVs5QDhqYvtkOmG6B0jX58A4cDIsgefVAiFuTX4CnGa4pl7GCsGn8zHt2bxY/oHlQ5ry
         mAmrFfM1c5BG3jZ7dxgtsEU+Ws9VpKheSmsHfy5BckYE3mS6JnyC6EjDR0uwQMHfZOuQ
         dYkw2MkNHDPGjzlJBDdyMivHFHkfVE+VUQx95B3s2DfNFeN25T9X8dW/dlJnNAO4mukh
         agutmZP5qsSG0VAwCswwQli48M3k2qgrzb2llWtrQ3ExHCs/9j1PurvsFVirUaUnoxAy
         MvCg==
X-Gm-Message-State: AOAM533l/BP0CaTkThL6CDOpz84j2LoqlO5ky+/xH9JlEYs/2BLAdGNT
        56AxYL3vltCsKxNjoa8QhWE=
X-Google-Smtp-Source: ABdhPJzR9BoA54EiZU87QDrVgrtUavhn2hBrq96vhLgFvXnnfXf/S5WfhRUkG/1jVmLFyQt3nuVoiA==
X-Received: by 2002:a50:e101:: with SMTP id h1mr6011782edl.245.1632817895538;
        Tue, 28 Sep 2021 01:31:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb39sm542950ejc.114.2021.09.28.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:31:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: ns/batched-fsync & en/remerge-diff (was Re: What's cooking in
 git.git (Sep 2021, #08; Mon, 27))
Date:   Tue, 28 Sep 2021 10:23:56 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8rzhmsi7.fsf@gitster.g>
Message-ID: <87a6jxxfrt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Junio C Hamano wrote:

> * ns/batched-fsync (2021-09-27) 8 commits
>  - core.fsyncobjectfiles: performance tests for add and stash
>  - core.fsyncobjectfiles: tests for batch mode
>  - unpack-objects: use the bulk-checkin infrastructure
>  - update-index: use the bulk-checkin infrastructure
>  - core.fsyncobjectfiles: add windows support for batch mode
>  - core.fsyncobjectfiles: batched disk flushes
>  - bulk-checkin: rename 'state' variable and separate 'plugged' boolean
>  - object-file.c: do not rename in a temp odb
>
>  The "core.fsyncobjectfiles" configuration variable can now be set
>  to "batch" for improved performance.
>
>  Will merge to 'next'?

This version was significantly re-rolled in response to my feedback, I
haven't had time to look at this latest version in detail, but will try
to do so soon.

I did note in
https://lore.kernel.org/git/87v92lxhh4.fsf@evledraar.gmail.com/ that it
one of Elijah's in-flight seem to have independently come up with
slightly incompatible versions of the same tmp-objdir.c API....

> * en/remerge-diff (2021-08-31) 7 commits
>  - doc/diff-options: explain the new --remerge-diff option
>  - show, log: provide a --remerge-diff capability
>  - tmp-objdir: new API for creating and removing primary object dirs
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>  - merge-ort: add ability to record conflict messages in a file
>  - merge-ort: mark a few more conflict messages as omittable
>
>  A new presentation for two-parent merge "--remerge-diff" can be
>  used to show the difference between mechanical (and possibly
>  conflicted) merge results and the recorded resolution.
>
>  Will merge to 'next'?

...i.e. this series
