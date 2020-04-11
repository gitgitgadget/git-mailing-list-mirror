Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DBBC2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC1620753
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCzLUZmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDKBL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:11:56 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48493 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKBL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 21:11:56 -0400
Received: by mail-pf1-f202.google.com with SMTP id d16so3281344pfo.15
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kII02JBN1jUzmr01IsyK4LB2WlIejyaT1GDiA/rUqu4=;
        b=uCzLUZmGFxoOETr/MFwzNIREXhCaSzwwMi/3U/lK5v23BDzEik1UrsLFWb46AlBXQB
         Hlq5Qf1ufWj/6Jd20KrA94FUAVAlPp09pin+kJkOzdPOfo0TM2Jpci2UxO9ohAc8ZDqh
         1prOTebho3XKzyrznRm09YPpfQ/mDVmA9bEbNheGsjOaZ8EzSdoIsdui5boA0JGwpeLF
         IjW5b3E7rJIv/hBX6t5WUGE70cCriSovI0U4CXukYjcYbJlTJyakyMd1014b4uN8h1Xm
         DenkZfbOWSZr2Wa4HZ3UgRCnKMPSaAmliHYX++BktLc7bmjKhwP+wbv5JnPTOJn2sQe2
         uEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kII02JBN1jUzmr01IsyK4LB2WlIejyaT1GDiA/rUqu4=;
        b=qdmq6lzrn8Us1eJI9bzOBhM8cYLx/9LE0bJ5o8vj5vT9xLfkKD3M4Md4QKFVFYDQDF
         KEueyDjeZSiautO9dSjIXtXFwYYfFNfhX280l3Ih3A+PnLmaZlN8kK/sufC2pCxGBybl
         oYbdPcXPEvcIuMXujdOdzQLsMBo9wI6qN57pHaSraAlUs4wH9uXLW8g3okeZxe9EScM2
         ucK4PqWGnBSreVSo5A8n7eydk/oawLni92evg1s0eHShvt+JWTOWHZi1aWPFTmkiCnrI
         Xcma25rLXchGAWvA6BHJRnhI0qSxiycva2QVAsiZD2quDoZm7fxBEEKzVRjuDYQuSjqK
         wfBg==
X-Gm-Message-State: AGi0PuYr9mCJ0wb6FlBeDDm8SyCjuLWdlkMLd9R+scWvmr6AwSQzRTSK
        BTlC9IeMVa0eUfGIV+UvWrGi7tOfaOtdJHFLJSRq
X-Google-Smtp-Source: APiQypJqzAW+tyeWopEgn7U+XxN/1YLEswNARPLUsyflTlHEnYYKWzwRcVSbLezdNYWHsLx8olTthGQrELvzQZK3SKBu
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr8380874pjb.110.1586567515070;
 Fri, 10 Apr 2020 18:11:55 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:11:52 -0700
In-Reply-To: <CABPp-BFEtd9X1XJwwpJ2YP6a4Zyc_yevwnMfNA+Dr45p4-7YEA@mail.gmail.com>
Message-Id: <20200411011152.115895-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BFEtd9X1XJwwpJ2YP6a4Zyc_yevwnMfNA+Dr45p4-7YEA@mail.gmail.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        congdanhqx@gmail.com, gitster@pobox.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >   Reapply all clean cherry-picks of any upstream commit instead of
> >   dropping them. (If these commits then become empty after rebasing,
> >   because they contain a subset of already upstream changes, the
> >   behavior towards them is controlled by the `--empty` flag.)
> 
> Perhaps add "preemptively" in there, so that it reads "...instead of
> preemptively dropping them..."?

Sounds good. Yes I can do this.

> > If this works, I'll send out a new version containing Elijah's patches
> > and mine in whatever branch my patch shows up in [1].
> >
> > [1] https://lore.kernel.org/git/xmqqd08fhvx5.fsf@gitster.c.googlers.com/
> 
> Yeah, I was making changes to this exact same area in my series to
> reference your flags.[2]
> 
> [2] https://lore.kernel.org/git/e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com/
> 
> Would you mind if I took your proposed changes, put them in your
> patch, and then rebased your patch on top of my series and touched up
> the wording in the manpage to have the options reference each other?

Go ahead! Thanks.

> > > Why not just list --keep-cherry-pick[s] in the list of options that
> > > require use of the merge backend (i.e. the list containing '--merge')
> > > instead of adding another sentence here?
> >
> > My reading of the list containing "--merge" is that they *trigger* the
> > merge backend, not require the merge backend. My new option requires but
> > does not trigger it (unless we want to change it to do so, which I'm
> > fine with).
> 
> Interesting; what part of the man page comes across that way?  That
> may just be poor wording.

"--merge" is documented as "Use merging strategies to rebase", which I
interpret as triggering the merge backend. There are other things in the
list like "--strategy" and "--interactive", which seem to be things that
trigger the merge backend too, so I concluded that the list is about
triggering the merge backend, not requiring it.

> However, if an option requires a certain backend, is there a reason
> why we would want to require the user to manually specify that backend
> for their chosen option to work?  We know exactly which backend they
> need, so we could just trigger it.  For every other case in rebase I
> can think of, whenever a certain backend was required for an option we
> always made the option trigger that backend (or throw an error if a
> different backend had already been requested).

I guess I wanted to leave open the option to have the same feature in
the "apply" (formerly "am") backend. The use cases I am thinking of
won't need that in the near future (for partial clone to make use of it
in the "apply" backend, the "apply" backend would have to be further
improved to batch fetching of missing blobs), though, so it might be
best to just require and trigger "merge" (like the other cases you
mention). I'll do that in the next version.
