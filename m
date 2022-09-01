Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0498ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 03:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIADiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIADiN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 23:38:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839512F568
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 20:38:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y18so12525512qtv.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 20:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WYFcZx2lybPPDHAYAyII4OTzU9Ha+A8ZLdde5anOwLc=;
        b=YsDvMmgzJKk7IaquBE7LqoTwUjG1u4jo7gglkBOwZKwe/CpWVHrGqvW34/TPaAbJox
         oDtGS6P/H6jpE7knPNaNHYRU7UD9P2AAXw1PHkvJz7m5CBLim3uyILF7+gKdgevlxXpy
         fDR9p5LNRDlH8EhUSROjVfsFtP+nlEOy3bk3PBXzYK8ypnhkV9yB9+xYzjCK5p5aMI/e
         cCAS4z5Rco8p4m64RrewcllJ8mYSYGzZyaIpeE00k/ZjL6FZmQ6LMt3gNPj/oay9RQoa
         dsG3W0K8VuPi7/hAxH8Lje0DjhG73iAtvGF4TD1e/4APsAHrJvqXj4ETQm+fed6VohdT
         XKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WYFcZx2lybPPDHAYAyII4OTzU9Ha+A8ZLdde5anOwLc=;
        b=qJgZcMVtqWUn4bKldb7EzmLAI0K+1od6RAsut4qNxA0BWab0LXYNp0q6/B5dJyoK4V
         wtOVGOAe7AyeIxOfMnMu9GDBM0yi4x+dSFsdfxqvfJVmYHj1O+4G3VMz80gaPicOE+0c
         9VHR62hmLXWNgPw8k/JjGpLdIJsqD2/7AQa96hfuLFleijqNeZKpDjkwsZG7xjMWL6gq
         WmWHnDm+nRHhv+8m+OgXO/qB0zYpz6sNyMbT79HaiNkAkd+t4LYnDGswprwuRelfPql7
         7+DxxUwFNpfEY6XXRPkntCofrislFBGyiBD2k5g6tJizV0IKYOAc5qHSaSm0/u0tEk5n
         IaUQ==
X-Gm-Message-State: ACgBeo2gbNCC4QtchWAFjqsTW4dsvpNPLljSyuKxrnxoPSqJKotFedZa
        XnSOYl+FiuuglryKywGPMIpgp9gtUEk3Kjy5TVY=
X-Google-Smtp-Source: AA6agR6PFxmv9nsPxAv494dk75moPWEaXrj9AV5vtKKkN0z3z0FyV75zaKgUvwckPlM059kRjlYQLfDRVEl3tIJWBiI=
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id
 n6-20020a05622a040600b0034307ae4fe9mr22276374qtx.541.1662003491390; Wed, 31
 Aug 2022 20:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
 <feac97494600e522125b7bb202f4dc5ca020ca99.1661926908.git.gitgitgadget@gmail.com>
 <xmqq7d2odp8m.fsf@gitster.g>
In-Reply-To: <xmqq7d2odp8m.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Aug 2022 20:38:00 -0700
Message-ID: <CABPp-BGo6JST9uO-dUEXw1sx6oxCWjBzq9MftLqjcoiFhATMuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] diff: fix filtering of additional headers under --remerge-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 3:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 95433eeed9 ("diff: add ability to insert additional headers for
> > paths", 2022-02-02) introduced the possibility of additional headers.
> > Because there could be conflicts with no content differences (e.g. a
> > modify/delete conflict resolved in favor of taking the modified file
> > as-is), that commit also modified the diff_queue_is_empty() and
> > diff_flush_patch() logic to ensure these headers were included even if
> > there was no associated content diff.
>
> In the longer term, I think we may have to redo the way additional
> headers are inserted to the diff_queue.  All the diff code I am
> familiar with (read: written before this hack was introduced) trusts
> that diff_queue.nr is the number of paths that are returned by the
> diff frontend, and unless there is diffcore_break involved, there
> will be at most one diff_filepair that is about a path.
>
> Why do these need to be separate entries in the queue, not a new
> attribute added to an existing filepair?  Are we inserting pieces of
> information that are not about any paths that are involved in the
> diff?

They usually are added to an existing filepair, but as your last
question alludes to, there isn't always one that exists.

One example where this can happen is with a modify/delete conflict.
If someone got one of those and decided to keep the modified file
as-is when resolving the conflict, then there'd be no content diff to
show for that file when investigating the resulting merge commit with
--remerge-diff.  But since the point of --remerge-diff is to show
whatever work the user did to resolve conflicts, and that file was
conflicted, we want to show _something_ for that path.  Thus the
reason for creating a new "phoney" filepair just for attaching the
"remerge CONFLICT (modify/delete) ..." notice.
