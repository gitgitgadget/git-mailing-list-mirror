Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E63C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7A261394
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbhDFPXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:23:32 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:46675 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhDFPX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 11:23:27 -0400
Received: by mail-ej1-f47.google.com with SMTP id u21so22568452ejo.13
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 08:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puIV1szCSHlxGLKU4UkyOdk7yuuH6ucrlJOA+fuKbRA=;
        b=hJ7ixpRPT3avhY+GcWe+Wk8sJUVOxC5bQoArKvTfgOpVEB0i4Mz1eOqJYsGtYfumsb
         55H0OjMlkzde8Z26x3CYQcfKUv25K24xAYPUCEFLg17ybDk/RpYmsiwWT48BdbS9ikix
         Jm6M+yfeAt6NjZtulJUabFBUCiXSbFaW9qHlG1gJXxdW4fV9t8z0w+bffhW/kDzC/cuP
         drw7lAT8nEBw2WEtKqJwvUk1Osgb0g9l7SiWAUhcMy4+ayXu9h2gemFPPnMEdC5kl4rS
         gJU+10/h8UVIjsCV9OYxEVzbvBkAx3JYXrwE+lJF0F9WCHuVRKaepkdmMEMcElifh+fS
         xmDw==
X-Gm-Message-State: AOAM531U629aQdJSzPeGEkFeH6Os2noRp9ZXzVJINf+QPvpPOSlb2Xgv
        /dlMnYSbN0pMSbvhOh9aqnzRY5czu2argHrSZ2k=
X-Google-Smtp-Source: ABdhPJyeRl5Y+rHWJFliXISJJq03dzZzJIJbeDcuWXVzVbYqaCmLttaPBm/yM3rODlUcB5NWEfGReKbujiPAs3toc1E=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr35266622ejr.371.1617722597882;
 Tue, 06 Apr 2021 08:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
 <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
 <CAPig+cSfzpynO5es+B4=7_Dz-qTHNXpDeUVxs7z5yffQFgWU=A@mail.gmail.com>
 <xmqqzgyc62yl.fsf@gitster.g> <37f0ff6c-b493-35b5-5ca0-92703f82e333@gmail.com>
In-Reply-To: <37f0ff6c-b493-35b5-5ca0-92703f82e333@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Apr 2021 11:23:06 -0400
Message-ID: <CAPig+cT8aqS1zaVqDSdycj6b9f3y7Mgn6TB9Sc1RY4_WomsY7Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 6, 2021 at 7:21 AM Derrick Stolee <stolee@gmail.com> wrote:
> I was not intending to make this re-entrant/thread safe. The intention
> was to make it easy to consume the formatted string into output such
> as a printf without needing to store a temporary 'char *' and free() it
> afterwards. This ensures that the only lost memory over the life of the
> process is at most one buffer. At minimum, these are things that could
> be part of the message to justify this design.

This has the failing that it won't work if someone calls it twice in
the same printf() or calls it again before even consuming the first
returned value, so this fails:

    printf("foo: %s\nbar: %s\n",
        refspec_item_format(...),
        refspec_item_format(...));

as does this:

    const char *a = refspec_item_format(...);
    const char *b = refspec_item_format(...);

Historically this project would "work around" that problem by using
rotating static buffers in the function, but we've mostly been moving
away from that for several reasons (can't predict how many buffers
will be needed, re-entrancy, etc.).

> So, I'm torn. This seems like a case where there is value in having
> the return buffer be "owned" by this method, and the expected
> consumers will use the buffer before calling it again. I'm not sure
> how important it is to do this the other way.

If history is any indication, we'd probably end up moving away from
such an API eventually anyhow.

> Would it be sufficient to justify this choice in the commit message
> and comment about it in the method declaration? Or is it worth adding
> this templating around every caller:
>
>         char *buf = refspec_item_format(rsi);
>         ...
>         <use 'buf'>
>         ...
>         free(buf);

An alternative would be to have the caller pass in a strbuf to be
populated by the function. It doesn't reduce the boilerplate needed by
the caller (still need to create and release the strbuf), but may
avoid some memory allocations. But if this isn't a critical path and
won't likely ever be, then passing in strbuf may be overkill.

> I don't need much convincing to do this, but I hadn't properly
> described my opinion before. Just a small nudge would convince me to
> do it this way.

For the reasons described above and earlier in the thread, avoiding
the static buffer seems the best course of action.
