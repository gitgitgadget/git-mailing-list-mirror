Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA042C10F00
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7320674
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0ewCNty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGQDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Mar 2020 11:03:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43675 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGQDl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Mar 2020 11:03:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id j5so5465881otn.10
        for <git@vger.kernel.org>; Sat, 07 Mar 2020 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HP7hU/5KVSdiMOvsu+9rq4anBeW8zDqqmLqHruGqdU=;
        b=u0ewCNtyyLirkODrQzGiRtFW9n0qnQvotDnvEVcOuX6eNCzK575IRPgh/oLeXTpMA8
         BicEtUFujlNRjy2FyWw8ITxwcRU/fsuy6k1YBBjjFkKmmzRqyhyxSwDnmpJUhnyyldFN
         gUi30Da381TRL6SRjpBYqWXGRfhvbxTTGDNLmgrHqy7iRXPBe2HVyzlkEiLgZM0Ue/ow
         Kku3iLPLt2PTxhQygANAJmPQMStvRdrE8N+0h9XTKLDZMQ3dRzaAY8SIl1bi2RxQrjHR
         u1rJfrLuV73AnlWSABkXXAodxRJny/XmqpFo0ZxewH5FrVsIIIeAJIZOMvh4Yi5qpM54
         cnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HP7hU/5KVSdiMOvsu+9rq4anBeW8zDqqmLqHruGqdU=;
        b=XtgMTNkVpUHFvtZNQSbj5RGH6egPKP3Sk6QsQdtn4hsAHbxdRg02DZRx7NIrObrqMF
         NcQsm67i9XeCMur3Wvd4l5ibgNqN3iJhBg9x1M+QEIbWSpNAlJrDTsDrR26f8crh2Wsv
         FFpv6LkPhiAOiBIAZ4h3loe6vS4T2PpT+BH7wBtkRV/gu0hSTuQAUQgeIr0N/7gakhZF
         GRf1yVIihkb7b0FrNw3/7h+3HwaSN5mBWXUcg2doPo6m678bOz/8vy26nDEt5WUyApD2
         o7awLSvp8A7tkuKQGdIZA5GrboaNDwlhpTUELsbES56I5qXJgpsOlnSxDRNFjCV+92tj
         UTGA==
X-Gm-Message-State: ANhLgQ10f5h5PonrFAtKW1GJ7wrrQsU4BV6KvtMWjxhoTxk3aryY0AQX
        AprVrzr0ipK0nk+/lzR34dQ3LblMITdc8Avo+VXMYEl0
X-Google-Smtp-Source: ADFU+vsPn6F6+K+UHpUqo5NZhrDtWxhf8Cnd5NtbBZWq143fUVg+8+ueKYWJmJ2C1VDrUJtTlFUTi9zcrWHyhC+sZXs=
X-Received: by 2002:a9d:7b4c:: with SMTP id f12mr6943176oto.345.1583597020612;
 Sat, 07 Mar 2020 08:03:40 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
 <3165171583586403@sas1-2bf44b70450e.qloud-c.yandex.net>
In-Reply-To: <3165171583586403@sas1-2bf44b70450e.qloud-c.yandex.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Mar 2020 08:03:30 -0800
Message-ID: <CABPp-BECOarg+G-_oz83i0EuKuypJQA=wyjnfG4U0heG=0L0hg@mail.gmail.com>
Subject: Re: Git Merge 2020 slides and reproducibility
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 7, 2020 at 5:38 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
>
> 06.03.2020, 18:00, "Elijah Newren" <newren@gmail.com>:
> > Hi,
> >
> > Had a few different folks ask me at Git Merge about slides for my
> > talk. I said I'd post them on github somewhere, but in case you were
> > one of the folks and have a hard time finding it...they are up at
> > https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
> > and steps to reproduce the speedups I got can be found at
> > https://github.com/newren/git/blob/git-merge-2020-demo/README.md
> > (though be forewarned that the code is has lots of fixmes & ifdefs &
> > other problems, has awful commit messages, etc.; I will be cleaning it
> > up soon).
>
> Hello, I've just tried your branch on my repository and it seems like it can
> be a salvation from all rename-related pain that I'm regularly facing when
> doing merges and cherry-picks! Thank you very much, I hope it will be
> integrated into mainline soon.

Wow, thanks for trying it out.  Please note that while it _might_ be
okay to use for real work, I am not that confident that it is.  There
are a number of factors making the 'demo' label I gave it a rather
fitting one:

  * I only started using it personally on a real world repository (or
two) about a week and a half ago. (Before then, I knew merge-ort
didn't work.)
  * The second real world repo I used it on uncovered a bug in my code
that the testsuite didn't catch[1]
  * Although I've tested with two real world repos now, that testing
was very minimal; I was focused on getting the demo ready and
implementing as many optimizations as I could.
  * While the outer merge, rebase, and cherry-pick commands will
accept a bunch of merge-machinery options and pass them along,
merge-ort flat ignores them all.
  * merge-ort is hardcoded for merge.directoryRenames=true, when the
default should be merge.directoryRenames=conflict
  * it has a bunch of FIXMEs, some of which are code cleanliness
issues but some of which represent minor bugs

[1] https://lore.kernel.org/git/911de63afa274b0791e4d4252934a5e9b0031f10.1582762465.git.gitgitgadget@gmail.com/

Also...

> However, when testing my previous merges which had to be done with helper
> script, I've encountered case of
>
> CONFLICT (directory rename split)
>
> Is there any way to prevent conflict in this case if files are the same, and
> merge their contents if there are differences? I think it would be reasonable
> to assume that move done in newest commit should win, and allow user
> to change strategy via command line option, provide explicit hint where files
> should be moved, or maybe even decide it interactively.

This conflict message is known to trigger in some cases where it
shouldn't; it may be that you're just experiencing annoyance from
that.  Let me fix that issue before worrying about workarounds.


Also, if you try out the 'fast-rebase' builtin from that branch (which
is a demo only and not meant to become a real command), note that its
usage message is really helpful:
$ git fast-rebase -h
fatal: usage: read the code, figure out how to use it, then do so

It's the kind of thing you put in code when you're trying to get it
working the night before you'll include its results in your talk (and
finish getting it to work the morning of)...



Anyway, thank you very much for giving it a whirl and reporting, just
please be cautious about depending on it since it's still work in
progress.

Elijah
