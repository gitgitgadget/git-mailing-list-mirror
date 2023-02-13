Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF1C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBMS2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjBMS1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:27:47 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701D2201C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:27:07 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-52bfa3dfd95so174719117b3.9
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AAaUGQ7s1P/TTeIW0LY5CRrNDKiD5IyjynePJ3IipUw=;
        b=iKI1el852wlcyQomXU2NO1O7ORWrckjEB7cdkSUXETjCKWwQBJip3QHAxKDIJh7qNo
         gBZo7+9969vMn+kuYwb9hwSZs6r494iF4qZaZ4NcGtGin3IPUy/uVdYB9JP9jaglc4nJ
         bUxv/vOMFDzPkhnr7p/fzIlbH33mbq1uTZ9CIlWRx+v67UzTYItux1FAVka46yZ1wNnV
         InE+RoYzznkBthEA3uUnHp8stNJakFbwyK9FDMrke+2HSJoJEODv9oBfjz28uR7nxb42
         jQXZK8Mw2Tzk5rNhDP9gMwEOibRraSdfGfYYDeMbywrY9VylURHyJtOmPVAtcNddah26
         DqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAaUGQ7s1P/TTeIW0LY5CRrNDKiD5IyjynePJ3IipUw=;
        b=MOqrghb+9jenItZvjJUh/cMxTKwbjJx43AjqAfFSaaiFBqIpqx1eZ84Qy0z52G3aCh
         /5IE5MF2UHFk3Ex4cim0neTT5/C5FVECY9wjB63REXkU3pCQv8rToAmcxqAFy/gtLHcx
         L1DKiJLCXgbL8LNj5HNHYweUBu06Pnel/m7ykPwmN4IJpcmcMoiRlRlD+Kp5amgINJ3L
         G2E/DqN5Z16bvqauY0RGxY04G5fnrvgN+fVo7AzQCJlF5LQUciPv6T6AGGOF9VzgvWH6
         2/9kgOUGOhf3zT+Rp0M5+/SxCkEruxy/DtdG2VjB14AR5aPsRHyDw4XYIWfsQ+tkpb29
         nqsg==
X-Gm-Message-State: AO0yUKVPg6Y+CK+asG1m331IaEr+5xOmS0HbZgpDLpdafqDkiMP62xqj
        3MmckjK8TZogtvYhSGtbExWwZY5XwkAp0jh13USaNQ==
X-Google-Smtp-Source: AK7set8hV9sRMvkjhFl4ARgPHfFY8InlVo+NyJpgsKBy6lU22pMwp5yBQhBAzr9+PHe1uDJvX2dHXP7wGcjfc1g85OE=
X-Received: by 2002:a81:8804:0:b0:527:bdc3:c0fb with SMTP id
 y4-20020a818804000000b00527bdc3c0fbmr3319637ywf.344.1676312821847; Mon, 13
 Feb 2023 10:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-2-calvinwan@google.com>
 <kl6lo7pyax9q.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqbklxcv1v.fsf@gitster.g>
In-Reply-To: <xmqqbklxcv1v.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 13 Feb 2023 10:26:50 -0800
Message-ID: <CAFySSZDMO6=YL6wVxyfj6h8piTFg7OygMdqdELspnQWpm4yJ7A@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        avarab@gmail.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Sidenote: One convention from JS that I like is to name such event
> > listeners as "on_<event_name>", e.g. "on_output_buffered".
>
> Thanks for bringing this up.  I agree that "Upon X happening, do
> this" is a very good convention to follow.  I think the callback is
> made whenever the child emits to the standard error stream, so
> "on_error_output" (if we are worried that "error" has a too strong
> "something bad happend" connotation, then perhaps "on_stderr_output"
> may dampen it) perhaps?

"on_stderr_output" sounds much better than "duplicate_output". I
did spend much time trying to come up with a better name, but
couldn't find anything that conveyed what the expected use case
of this function was. Thanks, I'll rename it on my next reroll.
