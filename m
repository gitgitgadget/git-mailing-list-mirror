Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E776C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487552073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhdd9KzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgAPUfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:35:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36984 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:35:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so10478190pga.4
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cUlTNJgVJFrTbNZIROIprVuvdfSvPS0tVRBGwqsiG/A=;
        b=hhdd9KzE/A6kcmYm4qpS1GghPNdk/yel9wLlayXPl3LNF5tbnV8aQjIAJsvtpMmcLO
         gMAUdRsiEvBtFSQ+35OGELzWyyUbxCFqgrO6HE2FC3TlZWCqH+xZREBcNR2NllE2MDda
         KRW5rG4Iy/FOB7rZpMBkKA7EzOe0+OtGRs45kOfbBbD6aSnlAqV5QZQlKsUOyPC4FB9G
         fBGELyXRQsKeVtEKhHqNVhd76NLeEXCfbtRbeQNISAPyOpVANHCZHpl+ipb7GEoNvK+T
         GlLacWB9WV/X+5hZ1WqNAu8Xbt5FI9JjbkVFbHPN12bYll+JxRzeLYBHOFvH/Di9ITy7
         Telg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUlTNJgVJFrTbNZIROIprVuvdfSvPS0tVRBGwqsiG/A=;
        b=dl2Mv2YV4KBSC6cYkoDyDFHKl5mC98Wy6oPctGcjcZy2FWngHa98bORUEtQrfW5CIm
         H3j6ucwiW3vq/m+9626fMsPYn+UmG7ELLUg6wht2XWHEVDVdXPKZcLALhvW3nj7qkOSY
         Q7NKQZNNAeBa3Eqbn48RnT78nUKK578/B8BH21cepOe1N1xp8QOSh2ZFG3Lb+Mwn6B+N
         BG6k4BhwWOt4FwmYlb0A+jqT7JlsRJwam9YD0ZVctBsVxhNPpJZWQ1P+DnMZ/g0JlOTu
         7Tng3cq/ZX3bXS/bDlGT4+7lNZmgH4sQdbmlXSB7/vyD3x6C0ZZgIZeJnPspY2gcVhAD
         72+Q==
X-Gm-Message-State: APjAAAWiIFhu/Cv1Q1nrB2Yn8mV8kqBa3RtLV/ySQWvoluPLGqrAMf7s
        ClygKzQAH9oUbo3i7KfqEeU=
X-Google-Smtp-Source: APXvYqxx/9+IHv2VRV5pSGkDedtKUUek7UK4i6kvSCQU/2J13v3aj5VtvU1IT/XFbSbtBc0D+P5q0w==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr40938069pgk.357.1579206924062;
        Thu, 16 Jan 2020 12:35:24 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id g9sm27244952pfm.150.2020.01.16.12.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:35:23 -0800 (PST)
Date:   Thu, 16 Jan 2020 20:35:22 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200116203521.GA71299@google.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
 <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com>
 <20200116080624.GA253496@google.com>
 <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> Thought about this ctags case a bit more.  In contrast to the
> deployment cases you brought up (which appear to be protected by a
> branch check anyway),

To be clear, one of the two deployment cases I mentioned (gh-pages) is
protected by a branch check, but the other (git --work-tree=srvroot
checkout) is not.

>                       doesn't this one argue more that post-commit
> should be run for all rebase types?  Sure, it'd take more computation
> time, but if a user runs "git pull --rebase" and then is frustrated
> that all their tags are extremely out of date then they may be kind of
> frustrated.

Yes.  In fact I think all of these examples argue for having the
post-commit hook run once on rebase completion (and on "git am"
completion, "git merge --ff-only" completion, etc).

Of course it's not hard to find other examples that argue against
that.  We provided a hook "here's a notification that runs after git
commit runs" without tailoring it to a particular need, and on one
hand people came up with various creative ways to use it (yay!) but on
the other hand it's hard to maintain as Git's ways of making new
commits evolve.

> Of course, arguing against myself, we could always tell them to just
> implement a post-rewrite hook.

That's an interesting facet I hadn't thought about before.

It's tempting since it kind of minimizes the blast surface while
providing people a way to keep doing what they had wanted.

Historically "git cherry-pick" ran "git commit", causing it to run the
post-commit hook.  There's some related discussion at
https://lore.kernel.org/git/20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net/
of other side effects of having run "git commit".

... oh! git cherry-pick doesn't run post-rewrite.  Interesting.

To summarize what we've discussed so far:

 A. run post-commit hook consistently in rebase --am and --merge modes

    Advantages:
    * consistent with historic "rebase -i" behavior
    * supports hooks like ctags generation that want to update state to
      match what has been committed in the worktree (especially when
      preparing for the rebase to stop due to conflicts)
    * consistent with other commands like "git cherry-pick" that run the
      post-commit hook

    Disadvantages:
    * invokes hooks more often in a setting they are not used to being
      invoked in
    * slows down rebase
    * when post-commit hooks are used for deployment, exposes
      intermediate states in the middle of a rebase to the deployment
      environment
    * inconsistent with "git am"

    Mitigations:
    * could go through the normal warn about change, opt-in config,
      opt-out config cycle to make the change smoother
    * could provide new hooks (e.g., one run after a batch of objects
      is created for applications similar to "git gc --auto", one run
      when HEAD is updated for applications like the ctags one, one
      run on ref update for applications like the deployment case) and
      encourage authors to migrate to them
    * could run the post-commit hook in "git am", too

 B. stop running the post-commit hook in rebase

    Advantages:
    * makes --am and --merge consistent with minimal user impact

    Disadvantages:
    * meaning of the post-commit hook remains a muddle
    * in particular, "git am" and "git rebase" would not be consistent
      with "git cherry-pick"

    Mitigations:
    * could provide new hooks for people to migrate to to replace that
      muddle

 C. stop running the post-commit hook in rebase --merge or commit --amend

    Advantages:
    * produces a consistent definition of post-commit ("it's about new
      commits only")
    * hook authors get the same expressiveness using the post-rewrite hook

    Disadvantages:
    * the change to historical "git commit --amend" behavior is likely
      to be surprising

    Mitigations:
    * could go through the warn, opt-in config, opt-out config cycle

Any bits I've missed?

Thanks,
Jonathan
