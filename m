Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D4C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353906AbiBCT5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiBCT5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:57:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197FEC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:57:53 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y17so3129466plg.7
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3zSBwArpEB0qtn26iGn+kf6n2oJTwdw1EUWTwd1dUgI=;
        b=eYt5jKJ4MdFFMkpYH/MCo2BGF52t7hsjUt2XqkXczHAuvuLJKp2CkAlStoUIIM/krI
         56ves4eEsiNbb7hUiaTjGPT6o7+KVFcO074b/HQ0lhOptX/dR+zBAivvik3KyP43hmXR
         hey40y7F402HsrljGdNb6bAYja7deruXAp4ljY+cMdgLh2g6mQ9yBpEtLnangVP45C1E
         LObifL0nS9KG2bcXYpzk29Owldymsm3cjDcIVu0AYUv/6/Js4drn9dGl5Rl62+MoaU4D
         cNE7k4OKYb/xHc59tOKo1aGvuwPKX9wEALALLHscRTjFBSVkzwIWqzAm/e7tmc9R3g67
         rpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3zSBwArpEB0qtn26iGn+kf6n2oJTwdw1EUWTwd1dUgI=;
        b=uxO1TSCfZ4FLZlFzBNvqEPfondVJZ2vp8puQ1f4qewog/FHt5eBMy367ihxIdkGJws
         +cQOtYxHwKLZyAVia+ryn0hD2fouhvhCYvhJiWEcQQbO2Xav61aiM2pPj5vUtGLocoiD
         /YPGEN7C8/n2oWXl+7nCMxjMU6e2iBfwz4KoTI0G6mMBNp35r79szdtBfHSuMSsJ4rkG
         h4nRFXKfH4wPBBd9qqHvRMKlPEqQeY98bfHYm0QMnoJE7nLrJfbKJ8uZmm65n4LeNOj9
         Mg8tL253+SXT7mmmOrVBKvAu9W8VIFxjmmEAfGYLI31uga20wGu7XI+7K9oO5Ftzdrwh
         MUzQ==
X-Gm-Message-State: AOAM5333rdKZSLBH+k+QZjbN2Td/pXccsELpx5eMIm6A+bB0F6xDP2T5
        pLAyGU/akh7GHhZWpbXXvE8=
X-Google-Smtp-Source: ABdhPJyI0mKyjBieo5cUQb2UsVucjP35CyPsryLGAMmXdk2Cg7rUNa4OF444209mfcrPzd18mm6QEw==
X-Received: by 2002:a17:902:988e:: with SMTP id s14mr11104577plp.87.1643918272462;
        Thu, 03 Feb 2022 11:57:52 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id v17sm29235174pfm.10.2022.02.03.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:57:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
        <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 11:57:51 -0800
In-Reply-To: <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 03 Feb 2022 19:08:06
        +0000")
Message-ID: <xmqqo83nsoxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode

"cat-file: add --batch-command mode" perhaps.  The patch touching
the file "catfile.c" (which does not even exist) is an irrelevant
implementation detail to spend 2 extra bytes in "git shortlog"
output.

> From: John Cai <johncai86@gmail.com>
>
> Add new flag --batch-command that will accept commands and arguments
> from stdin, similar to git-update-ref --stdin.
>
> At GitLab, we use a pair of long running cat-file processes when
> accessing object content. One for iterating over object metadata with
> --batch-check, and the other to grab object contents with --batch.
>
> However, if we had --batch-command, we wouldnt need to keep both
> processes around, and instead just have one process where we can flip
> between getting object info, and getting object contents. This means we
> can get rid of roughly half of long lived git cat-file processes. This
> can lead to huge savings since on a given server there could be hundreds
> of git cat-file processes running.

Hmph, why hundreds, not two you listed?

Do you mean "we have two per repository, but by combining, we can do
with just one per repository, halving the number of processes"?

> git cat-file --batch-command
>
> would enter an interactive command mode whereby the user can enter in
> commands and their arguments:
>
> <command> [arg1] [arg2] NL
>
> This patch adds the basic structure for add command which can be
> extended in the future to add more commands.
>
> This patch also adds the following commands:
>
> contents <object> NL
> info <object> NL
>
> The contents command takes an <object> argument and prints out the object
> contents.
>
> The info command takes a <object> argument and prints out the object
> metadata.
>
> In addition, we need a set of commands that enable a "read session".
>
> When a separate process (A) is connected to a git cat-file process (B)

This description misleads readers into thinking as if we have just
created a daemon process that is running, and an unrelated process
can connect to it, which obviously poses a question about securing
the connection.  It is my understanding that what this creates is
just a consumer process (A) starts the cat-file process (B) locally
on its behalf under process (A)'s privilege, and they talk over pipe
without allowing any third-party to participate in the exchange, so
we should avoid misleading users by saying "is connected to" here.

> and is interactively writing to and reading from it in --buffer mode,
> (A) needs to be able to know when the buffer is flushed to stdout.

If A and B are talking over a pair pipes, in order to avoid
deadlocking, both ends need to be able to control whose turn it is
to speak (and it is turn for the other side to listen).  A needs to
be able to _control_ (not "know") when the buffer it uses to write
to B gets flushed, in order to reliably say "I am done for now, it
is your turn to speak" and be assured that it reaches B.  The story
is the same for the other side.  When a request by A needs to be
responded with multiple lines of output, B needs to be able to say
"And that concludes my response, and I am ready to accept a new
request from you" and make sure it reaches A.  "know when..." is
probably a wrong phrase here.

> Currently, from (A)'s perspective, the only way is to either 1. exit
> (B)'s process or 2. send an invalid object to stdin. 1. is not ideal
> from a performance perspective as it will require spawning a new cat-file
> process each time, and 2. is hacky and not a good long term solution.

Writing enumeration as bulletted or enumerated list would make it
much easier to read, I would think.

    From (A)'s perspective, the only way is to either 

    1. exit (B)'s process or
    2. send an invalid object to stdin.

    1. is not ideal from a performance perspective, as it will
    require spawning a new cat-file process each time, and 2. is
    hacky and not a good long term solution.

I am not sure what you exactly mean by "exit" in the above.  Do you
mean "kill" instead?

> With the following commands, process (A) can begin a "session" and
> send a list of object names over stdin. When "get contents" or "get info"
> is issued, this list of object names will be fed into batch_one_object()
> to retrieve either info or contents. Finally an fflush() will be called
> to end the session.
>
> begin NL
> get contents NL
> get info NL
>
> These can be used in the following way:
>
> begin
> <sha1>
> <sha1>
> <sha1>
> <sha1>
> get info
>
> begin
> <sha1>
> <sha1>
> <sha1>
> <sha1>
> get contents
>
> With this mechanism, process (A) can be guaranteed to receive all of the
> output even in --buffer mode.

OK, so do these "get blah" serve both as command and an implicit
"flush"?

With an implicit "flush", do we really need "begin"?

Also, from the point of view of extensibility, not saying what kind
of operation is started when given "begin" is probably not a good
idea.  "get info" and "get contents" may happen to be the only
commands that are supported right now, and the parameters to them
may happen to be just list of object names and nothing else, but
what happens when a new "git frotz" command is added and its
operation is extended with something other than object names and
pathnames?  The way to parse these parameter lines for the "get"
would be different for different commands, and if "cat-file" knows
upfront what is to be done to these parameters, it can even start
prefetching and precomputing to reduce latency observed by the
client before the final "get info" command is given.

So, from that point of view,

	begin <cmd>
	<parameter>
	<parameter>
	...
	end

may be a better design, no?
