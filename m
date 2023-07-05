Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6261DEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGER5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjGER5W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:57:22 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA261985
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:57:20 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso32481cf.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688579840; x=1691171840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azLwAOJ678kvuoEdIbL0IsyaadjxewEX61S/kzuA/2s=;
        b=qYbs2cpfkiRCF6WqczndLIdzLdZ/00+lNx5dKITku0pdAvZWkE3WrmfPZVwoStVMPd
         ACPGWhgu6sASVGCV4HUlAhXEt2Rnfl/x8CULWss6OF+mfIKBVBNY6Kxcy/fDDjXiIHck
         ii9RJp1sscyjTEXr3LatbBZN1Mpwp207273R7O3LOXM7aZBL/XKzg1cCiFiP4sVbwuR0
         zsY7F5qREBKBpIDR9DBKHdeTnM/6EaH+Enrfygp9fOFz8koG5xoq1xReSgnBlfI1bSla
         Kkq9hhCmRQF65b0cN9cgp0sAa0g56aLPL0Uu8KXPAN4LKnw/QglP5hlebY7bpDdSYw9F
         quzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688579840; x=1691171840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azLwAOJ678kvuoEdIbL0IsyaadjxewEX61S/kzuA/2s=;
        b=ktTUBbfFVKjk1THI7NYiyYHGEdAVZ/5I46xgfSWOAWXB0xNbO7Ux92Um5NGPq3Q3Gd
         BbdjS7ytIZiUXoxs9X+1gPstzpYZj2IT7MyprpR9sR/b2AIvS9qIjw2Zf1yFKarGB6x5
         Bs/8sXvauhC3U8HPccCGK2CPDHjLOFv9huktAn8AM2h+YRQ97GVVzsuTwl/0qxAGEzTi
         F+oqhtyGsjK7NnYi7HbbqrZQZHHoim4L+dwauNPvkbsV64XJ4faL1V28mbJgbk23f758
         I+hKgpi0DXTf42bIMAdxDHNKvfv8QxMaAoVNTD0Y/I1MrfDOyCm9W7QS/sjrOKJTKi1b
         uxUw==
X-Gm-Message-State: ABy/qLY+VkMj27HFAYuUTVLuTFPnR1stRbhpc/b7IGryC8pA1eRhANeG
        UuZUIz6gu1RjQ+pacCntIbppqDu7VJinoMhjKtENyg==
X-Google-Smtp-Source: APBJJlG+QK9WmjYJGehGmsWAZuNmSZtfqE0I5vyO6FnOKxKqmqJRDkC7/V+0AIQKNRcGIcJnx81ZavxsijqjzSDYOZI=
X-Received: by 2002:a05:622a:199a:b0:3f8:6685:c944 with SMTP id
 u26-20020a05622a199a00b003f86685c944mr18034qtc.14.1688579839740; Wed, 05 Jul
 2023 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-2-calvinwan@google.com> <05df2971-0f26-6da3-093b-7de5d7a5dbca@github.com>
In-Reply-To: <05df2971-0f26-6da3-093b-7de5d7a5dbca@github.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 5 Jul 2023 10:57:08 -0700
Message-ID: <CAFySSZCYpxNcK6Tfagk1ZBs6cOT9XvWm2b3DJhN0fSPsQCWR1g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] trace2: log fsync stats in trace2 rather than wrapper
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This function does not belong in 'trace2.h', IMO. The purpose of that file
> is to contain the generic API for Trace2 (e.g., 'trace2_printf()',
> 'trace2_region_(enter|exit)'), whereas this function is effectively a
> wrapper around a specific invocation of that API.
>
> You note in the commit message that "wrapper.c should not directly log
> trace2 statistics" with the reasoning of "[it's] a library boundary," but I
> suspect the unstated underlying reason is "because it tracks 'count_fsync_*'
> in static variables." This case would be better handled, then, by replacing
> the usage in 'wrapper.c' with a new Trace2 counter (API introduced in [1]).
> That keeps this usage consistent with the API already established for
> Trace2, rather than starting an unsustainable trend of creating ad-hoc,
> per-metric wrappers in 'trace2.[c|h]'.

The underlying reason is for removing the trace2 dependency from
wrapper.c so that when git-std-lib is compiled, there isn't a missing
object for  trace_git_fsync_stats(), resulting in a compilation error.
However I do agree that the method I chose to do so by creating an
ad-hoc wrapper is unsustainable and I will come up with a better
method for doing so.

>
> An added note re: the commit message - it's extremely important that
> functions _anywhere in Git_ are able to use the Trace2 API directly. A
> developer could reasonably want to measure performance, keep track of an
> interesting metric, log when a region is entered in the larger trace,
> capture error information, etc. for any function, regardless of where in
> falls in the internal library organization.

I don't quite agree that functions _anywhere in Git_ are able to use
the Trace2 API directly for the same reason that we don't have the
ability to log functions in external libraries -- logging common,
low-level functionality creates an unnecessary amount of log churn and
those logs generally contain practically useless information. However,
that does not mean that all of the functions in git-std-lib fall into
that category (usage has certain functions definitely worth logging).
This means that files like usage.c could instead be separated into its
own library and git-std-lib would only contain files that we deem
"should never be logged".

> To that end, I think either the
> commit message should be rephrased to remove that statement (if the issue is
> really "we're using a static variable and we want to avoid that"), or the
> libification effort should be updated to accommodate use of Trace2 anywhere
> in Git.

Besides potentially redrawing the boundaries of git-std-lib to
accommodate Trace2, we're also looking into the possibility of
stubbing out tracing in git-std-lib so that it and other libraries can
be built and tested, and then when Trace2 is turned into a library,
it's full functionality can be linked to.
