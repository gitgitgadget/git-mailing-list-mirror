Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F44C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2928B20719
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvVOqVy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCYVV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:21:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34119 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCYVV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:21:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so3660674otl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcRS9LiLp8/ZvM5WgaZzKlYSFsXLpd+gWecNf3NseMg=;
        b=qvVOqVy48OdbCGebwFytc5R4ecYYTeHjqZWIpqYqYPFOF9XQJgT8b0/2EM+2yH4hhL
         cSgTYsoJ/7g3SZpfEr+G3w7hMxRVcr5md9dRuM1QgXir7h9Ri+5c8nGMF5qRG/t3Y8Q0
         64vAp4gAPtZFkW5ebYQkxcrB3ZqmlXUFBb/DY1voIBlKAG4T2mm569Uvgkhg/wTyZZXc
         jshGzwvJX5w/y5qlPeksUHILJaY2MKzfKifxTZs39f+VkLDLWPAljTTvfCHd1emfRZi1
         lL7wRqc+oSblUaYitNBc7J5WbPFF1Z3C2Up7nWwZakTvpsam/TAQ9VlC+CcoV3VIhHe4
         apcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcRS9LiLp8/ZvM5WgaZzKlYSFsXLpd+gWecNf3NseMg=;
        b=goVwP4UKpbgHuhQb49ZuoFSQr0TI2k/z3/Ku+HzAPCW5FgBqjx0xDS0U054M7AHUqH
         +kE4TddVF28Hxhw67LlCF9AqRMS+KvqhBA7fcbGukcduEuy3iDqaXPd8Q4eFx1hLMuH+
         KGPcGyns8pQW4LfmXLsv6Gl7WNHseR7+TaL5SeDiGtymOYTDhxG8DoVnavtcoS38USuR
         svLmGZFAQqzWZPHMzXj00KuAfGlPBJ67NsFrocDTwRchsGb/SMDjWaKvtHiY2OWot/NW
         xDY7ZXI/lGudZaKS90epqljPLZ6cSLxTAUsRxWN6QWtkmeuIbzTuIRf+EIAxPOTFZXgY
         mH5g==
X-Gm-Message-State: ANhLgQ3R+yA9MPA9O1uUh3PE/V0Ay2higSai6/C3WpMHYm+YegYIoAez
        5UtKcale4B3EoENp2SFGzyURO1xXXTtX0bnG4H6WPY6B
X-Google-Smtp-Source: ADFU+vsRajJDiCX+GuOVeMgrwquW0ISY2h5x61V+NwFD698kg+nhcNntNZFSf9aJsKCHgrHpsKnQ19JhzdXrZgg0kaw=
X-Received: by 2002:a05:6830:1ad4:: with SMTP id r20mr4150111otc.316.1585171284390;
 Wed, 25 Mar 2020 14:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net>
In-Reply-To: <20200325053908.GC651138@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Mar 2020 14:21:13 -0700
Message-ID: <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Jeff King <peff@peff.net>
Cc:     Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 10:40 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 24, 2020 at 08:38:04PM -0700, Norbert Kiesel wrote:
>
> > I track an upstream repo with "pull.rebase = true" where I do a `git
> > pull` followed by a `git log -p ORIG_HEAD..` for a branch to see
> > changes since the last "pull".  I normally do not commit to this
> > branch and thus this normally is a "fast-forward" merge.
> >
> > Starting with 2.26 this no longer works because ORIG_HEAD is always
> > set to HEAD after my `git pull`.
> >
> > I track other prances from the same repo where I do local changes and
> > then want the `git pull --rebase` and I thus do not want to
> > give up on the `pull.rebase = true` configuration.
>
> I can imagine this is related to the switch to the "merge" backend for
> git-pull, which may be more eager to overwrite ORIG_HEAD. Perhaps try:
>
>   git -c rebase.backend=apply pull
>
> and see if that behaves differently.
>
> I tried to reproduce what you're seeing, but my recipe doesn't seem to
> show any difference between the two versions:
>
> -- >8 --
> #!/bin/sh
>
> rm -rf repo
>
> git init -q repo
> cd repo
> echo content >base && git add base && git commit -q -m base
> git clone -q . dst
> echo content >new && git add new && git commit -q -m new
>
> cd dst
> git rev-parse HEAD >.git/ORIG_HEAD
> echo before: $(git log -1 --oneline ORIG_HEAD)
> git -c pull.rebase=true pull -q ..
> echo after: $(git log -1 --oneline ORIG_HEAD)
> -- 8< --
>
> We don't seem to touch ORIG_HEAD in either case. But maybe a more
> complex set of pulled commits would trigger it?

I can't duplicate either.  I suspected that perhaps rebase.autoStash
might help cause it to happen if you had local changes, but I didn't
succeed in reproducing with that either.

Norbert: Any ideas what you may be doing differently to trigger this?
And does it still happen with rebase.backend=apply, as Peff asked
about?


Elijah
