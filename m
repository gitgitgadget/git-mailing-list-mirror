Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30B11F461
	for <e@80x24.org>; Thu, 16 May 2019 05:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEPFyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 01:54:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34589 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfEPFyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 01:54:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id 7so841563uah.1
        for <git@vger.kernel.org>; Wed, 15 May 2019 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+eZqa+trlxPJqVDWFcxfEMkEoiRlGkDghk0gJSUSu8=;
        b=FqWShZWwRgRefTbLdqVnvPMuSlAkrRxUVjmQ2hWG5+nVdsFBSa0xeodCFRanZgxWKP
         tAls51KIH5cKCHuo1Zo2KtpbK0hJhnLrKZKcedik9e16/pvWD8nLnI3jzSGBVcs1ZC3G
         99Mnh5TZ7c3JLB++9VKy+tkE5JfqwrtfM7FRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+eZqa+trlxPJqVDWFcxfEMkEoiRlGkDghk0gJSUSu8=;
        b=Ff62OxC2mTdn8JHwSpDLJlrR31kIT356cG5051+NUprWQ4pmXF0QrBNMHDZnOa1/++
         Xrz2bMkD01mBlBl3oG6EBdS2hqP1c2OiAsU29Uc9t30VEu9UZYT4tnVpC6eUxRONtQE1
         /dEGnVMr7zXe+q9E8biju08qUCP1jIf2Xpk3W3/hjSaRe3jO7GRETtM+TlOnLkoDLsB2
         XhvWoofKHgDiico7bthFK6iz5E5i7f3ebC3syfnqBDp4lliJQtlKZtf1RnJfNeD9WclV
         3W51RDXDqtGDUGYAYvCNyQBxAVGKe0ruOU2HZZf0mwYpsFu5YiCYjSIjMe3F76AXuQMQ
         nSUg==
X-Gm-Message-State: APjAAAXqLHkbHJ4HEaLJeNzgL89/Lc1vL+HPBG5NMdoHH8ApatUU3pOk
        6K/mzqaj+weEX4+Euj4zRl0wQW+sfZc1+zRt/tIywg==
X-Google-Smtp-Source: APXvYqxRMxFXFUrILxbqrIv+bVX9fHZMNKSME3WkQHDTAeqJRXoJggiyPz/qrNvFRarlcdc6niwA8+Z5yCph6cAl9JU=
X-Received: by 2002:ab0:720a:: with SMTP id u10mr17925235uao.22.1557986071095;
 Wed, 15 May 2019 22:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <ad63393c24c7346c5b606b29579dfacad4d307f3.1557477247.git.e@nanocritical.com>
 <xmqq8sv8709a.fsf@gitster-ct.c.googlers.com> <CABPp-BGZQz=4KVpZ6v+p12tDPMBJ8eFWuOH1mjQQrhpksU8NzQ@mail.gmail.com>
In-Reply-To: <CABPp-BGZQz=4KVpZ6v+p12tDPMBJ8eFWuOH1mjQQrhpksU8NzQ@mail.gmail.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Wed, 15 May 2019 22:54:19 -0700
Message-ID: <CAH_=xobEd6ZiifEJOnvW8KdN78zLWv5UirFTiEk722YyP_b5Kw@mail.gmail.com>
Subject: Re: [PATCH v3] fast-import: checkpoint: only write out refs and tags
 if we changed them
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 5:36 PM Elijah Newren <newren@gmail.com> wrote:
> with during the fast-import process.  However, the whole reason for
> your patch is because checkpoints are in use *and* people are updating
> the repo during the fast-import process, so this area that was likely
> overlooked in the past now is pretty important to get right.

A little bit of background on our particular use case: fast-import is
used to perform frequent history (re)writing and is a great (and fast)
way to modify many refs without having to touch a checkout. For us, an
alternative would be to use libgit but this is simpler, multiprocess
and non-blocking, and doesn't have any additional dependencies.

We use --force: our fast-import frontend independently watches the
repo for updates so we are generally aware of external updates to the
repo. (And if we race with an external change, we can live with that
-- although being able to finely control which ref updates we want to
force and which ones we expect to be FF would be great, but that's for
another patch.)

We would like to use checkpoints to keep fast-import running, which
has the advantage of keeping some Git state in memory. Restarting git
fast-import every time we want to make a change is doable, but more
expensive.

With the current behavior, we have to shut down fast-import after
every checkpoint (in other words, we can't really use them) and
restart when needed, ensuring we don't overwrite refs we didn't intend
to change this time. Alternatively, we could maintain an up-to-date
(wrt .git/ on disk) mapping ref -> sha1 for all refs we've ever
changed, and make sure to precede any checkpoint with a bunch of
intended-to-be-no-op reset commands, which effectively let fast-import
know about external changes to refs that we do not wish to overwrite.

But this patch seemed like a better path forward.


> Looking at the fast-import code, it appears that update_branch and
> update_tag both set a global 'failure' flag whenever a branch cannot
> be updated due to it not being a fast-forward.  It prints a "warning"
> but this is likely because it wants to update whatever branches and
> tags it can and report issues on any it can't, and then after that's
> done then exit.  Since branches and tags are typically just updated at
> the very end of the process (again, based on the documentation
> suggesting checkpoints aren't necessary), the end of program exit can
> also be thought of as the "exit immediately after failing branch/tag
> updates".  My current suspicion is that the current checkpointing code
> not checking the 'failure' flag was an oversight.  If the user doesn't
> want branches/tags forcibly updated, and they do want checkpoints when
> the branches/tags get updated as input comes in, and there is the
> possibility that external folks modify thing, then I think it makes
> sense to abort the import once the checkpoint is finished (i.e. update
> whatever branches/tags we can and then error out); continuing to
> process the input stream seems wrong, because:
>   * the reason to use checkpoints is because the fast-import process
> is taking a long time; if it was quick, there'd be no reason to
> manually checkpoint.  Therefore...
>   * the user may be forced to backup and redo the long-lived
> fast-import process anyway; we've cost them time by not erroring out
> immediately
>   * we allow errors to accumulate (other branches could have failures
> to update later in the fast-import process), causing users to have to
> figure out whether one or many failures were reported and then have to
> try to track down if they have one or multiple causes
>   * the users are less likely to notice early "warning" without
> erroring out, but the cause (someone else updating a ref) may be
> harder to diagnose the longer it has been since the external ref
> update.

We use --force so I don't have an immediate interest in how checkpoint
errors are handled.

In a separate response to Junio, I suggested an alternative mechanism
to signal checkpoint conflicts on --cat-blob-fd, but I think it would
generally be fine if fast-import were to simply exit on such an error.
To reliably figure out which updates made it to disk and which didn't,
one can obtain expected OIDs with get-mark before initiating a
checkpoint, and compare with refs on disk after an error.

I'm not sure if such a change should be behind a flag or not. I think
anyone running without --force does care if a ref update is rejected;
and we're unlikely to break much by erroring out early. But maybe some
users out there don't check the exit status of fast-import and haven't
noticed that some branch they don't really care about is not being
updated successfully while everything else gets updated fine?

Thanks for the thoughtful analysis.

Eric
