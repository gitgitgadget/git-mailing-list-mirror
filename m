Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE4C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2739A613A9
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbhI2Gpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:45:47 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35647 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbhI2Gpr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:45:47 -0400
Received: by mail-ed1-f52.google.com with SMTP id l8so4638077edw.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DT1VkyEZrmmWwx1FB/Xg9nrjHiX4XZoKYfr034jRu4=;
        b=CeCWwVjzajZs7WQ63ju5OLYePnqgJ8TVAZhEI5v7H0goeHD09VLjZcMNWtoeWpDNH3
         eFPRy6Z0vCMGTRhiE2rF5QEoYKC7b6dhUjgRfm97IDv433YSooqoSTxgRxC6ZmJelFUu
         +RTmqZxeuKdgkjF4SEC3JPB5FIk95VOt/PHT1KO37eC42tHYusPj3aB0COWQF+igpMDx
         NV6/djK9B7gjfD7XZvA8xRH2dIy7HqJmyjp3bFZLbIl6q6wjYzk/q7JJ3w8xNx8In4Dd
         a+u/2Rq39WYTlIZw/i7xDJ+uW5BUAgUHc4LZeKsq+RBdB7X0Kkr7loP6457O4O+rIPIx
         SMVQ==
X-Gm-Message-State: AOAM5321YLrZozz9OLc9V1GG6qtXK6AQAjqNxNte/c7mUlvWkrP5ndZ4
        d1Vp7LjrCA8cUremZhsAhUVtH2F0hP1EZp0RdRM=
X-Google-Smtp-Source: ABdhPJxIgj3ZK/jGCZp7J1+7+4qfp0ecvrfXC0/7Kdiqp/P6n1UZeu+FZMrctTQ0mmwEi5YCP4PTRDV8Sl2c0ZhAHb4=
X-Received: by 2002:a50:e0c8:: with SMTP id j8mr12815327edl.283.1632897845747;
 Tue, 28 Sep 2021 23:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <kl6lh7e53nnn.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lh7e53nnn.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Sep 2021 02:43:54 -0400
Message-ID: <CAPig+cS7PF=F0XWO-EyVz_KuLnbnhQi3N01gyozSv99PmB_1RA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Use default values from settings instead of config
To:     Glen Choo <chooglen@google.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 1:59 PM Glen Choo <chooglen@google.com> wrote:
> I wasn't clear about this in the original message, but I think this is
> ready to merge in its current form. I'd love to hear from reviewers who
> can poke holes in that :)
>
> Cc Eric and Taylor who have given the most review on v1 (thanks again!).
> I believe I've addressed your comments and I'd be interesting in hearing
> your thoughts on v2.

I re-read the entire thread and left a few comments on the v2 patches.
One or two of the comments might be actionable (i.e. deserve a
re-roll), but most are probably subjective.

Oh, I forgot to mention in my review of [3/3] that in:

    In the case where core.multiPackIndex is not set in the config, the auto
    condition would fail, causing the incremental-repack task to not be
    run. Because we always want to consider the default values, we should
    just always just use the_repository->settings.

you can probably drop one or both "just"s.
