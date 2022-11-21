Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F59EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKUAH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUAH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:07:57 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB12AE35
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:07:55 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id x16so5012029ilm.5
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+S9zFcr0wqxg9obqgX1HbTPAAHQJAPUjBxh3D0gaq8=;
        b=ssSN9JagM6+UDrfSc2BFHmHH6eXJyY8ErviPlDtcVdKjt3NYwnEg9JVjPtq/XQkhqx
         zOF5GD7mgwLOWLKvz4ftsZtPs7tDfwRjrQiSBfUYgjkBnuKxQFntHboItW76UaBg/1XH
         C0AnrsvzUFvmV56AzZcgc7mTXsbBfIHDArT5iK6fkxx0BadOkbNOF3htv8UXAojRL1zQ
         oNOG6q/Sdv6TMqRuiF1NBkzyi3bh9YZz92yDwTJW5B7dO0kHt2UHGpdjplbyRZ/pDiQn
         Nw+/AHq2zcwbfQTv3zFYRpwu3u5onnHqpINajawGWJ2V7OJDCLCSLrczIQpSSgAKJsdQ
         oMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+S9zFcr0wqxg9obqgX1HbTPAAHQJAPUjBxh3D0gaq8=;
        b=ZadHCs0L6h4dX2i5P5MDdPqSTUb67cANGSy6e4KK/TFNVFRcn71BdI/KIV4Tv/qhmN
         HpAxM/o8jnAeFmrsGUx0NqNEEXUGfYApENsCdaCbMqg4Th7AyLNyx4XKFBd9uAOrxKbZ
         abrNJireNeoGKVFkzCicgGej0iNNq9yEyczXq25ZULQgCx5MgW7GsjWvjzILrPKPW9CM
         rsk86xm2QmX16sAOrxWry07X1JphpVffEwEwTdTy1thBnsL/7d6N5tc1V5uDGSZHKrnX
         +lutmxcFBTLlSOefT3XUBfN/N2qgsbIYyZ8Nb3LHzihjTVRoLxw84YInRGSk74gpvsVR
         nJUQ==
X-Gm-Message-State: ANoB5plx2MLOuQeDiTBtcwVSz3O+TZz+gRxmih6i6bkr9zy0G4EtYlHa
        qP7VLT6lzZ5wKe33e6LcT5zk9Q==
X-Google-Smtp-Source: AA0mqf5XX2RK83ZE9I7T6GzBe1gkIYo65GUqnnJe2u0OmohRqPgJGOjyA9rO1Nq6TQefQU9BDBJpyw==
X-Received: by 2002:a92:9504:0:b0:300:7a6d:c37c with SMTP id y4-20020a929504000000b003007a6dc37cmr6929210ilh.32.1668989275153;
        Sun, 20 Nov 2022 16:07:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a19-20020a6b6613000000b006bcd45fe42bsm3690283ioc.29.2022.11.20.16.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:07:54 -0800 (PST)
Date:   Sun, 20 Nov 2022 19:07:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y3rBWUidFe6SVmWI@nand.local>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com>
 <Y3LD1CtKBoDhPdSZ@nand.local>
 <qp0556o2-6q18-8556-0n8s-p28831qr6qs6@tzk.qr>
 <Y3fLdJ7CIIU8fj0g@nand.local>
 <q39q9rr7-or29-5510-5177-2s92n8qs2540@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <q39q9rr7-or29-5510-5177-2s92n8qs2540@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 12:36:25AM +0100, Johannes Schindelin wrote:
> I am referring to the fact that Git for Windows has run with a very
> different solution for this problem, for years, yet it was rejected upon
> upstreaming, and had to be replaced by a completely different workaround.
>
> It's not just a simple "earlier round of review" at all that is the issue
> I am describing.

Right. Having read the earlier thread myself, I am familiar with the
context. So I'm not trying to dismiss it as just another round of
review, but instead try to steer the commit message in a more
constructive direction.

> It is a very real concern of future readers who know what patches are
> currently in Git for Windows and who all of a sudden do not find the `git
> test-tool cmp` code anymore in Git for Windows and then see that `git diff
> --no-index` is used and naturally want to know what the heck happened.
>
> This is context relevant to understand why the particular approach
> implemented in the patch was chosen and another one was discarded (when
> that other approach has served Git for Windows very well for several
> years), for which the commit message is precisely the appropriate place. I
> am quite lost trying to understand why I am asked to remove said context,
> leaving future readers puzzled e.g. in the case that it should turn out to
> have been a terrible idea to use the quite complex diff machinery for as
> simple a task as `test_cmp`. It sounds to me like I am asked to make my
> contribution worse ("worsimprove" is the term I recently learned to
> describe this) instead of helping me to improve it.

No. I am not suggesting you remove context at all. But what I am saying
is that describing the last attempt at upstreaming by saying it "saw a
lot of backlash and distractions during review and was therefore
abandoned" is not helpful.

If it saw backlash and distraction: why? What about the approach caused
backlash? Describing that thing as an alternative approach and
explaining concretely why it was disliked is the sort of context that I
think we should aim for in our commit messages.

But characterizing the review outright as full of backlash and
distractions is not helpful to future readers, and it is not a kind way
to treat others on the list who may have participated in that review.

> The advice you provided directly contradicts what is written in
> https://git-scm.com/docs/SubmittingPatches#describe-changes, after all
> (ignore the funny grammar for now unless you want to add a tangent to this
> already long thread):
>
> 	The body should provide a meaningful commit message, which:
>
> 	    [...]
>
> 	    3. alternate solutions considered but discarded, if any.

I am saying that, as written, the commit message does not explain what
the alternative approaches were in great detail.

Thanks,
Taylor
