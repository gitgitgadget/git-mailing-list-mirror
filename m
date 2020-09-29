Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93619C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167BC2083B
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/BBredP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgI2VgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2VgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 17:36:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB7C0613D2
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 14:36:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so6363674wmi.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WthdUQRuldZItbKhneH8cBnZID6XoD/ui7CVs78qT98=;
        b=m/BBredPPQ0eqF1C+9cLs4wTApbn8b/vKKC81cQw+nz5l0oPUg5Db0tgGxr5kYSlWm
         v5VZu5z/ukzEMLmKphjJH5MUmaksRZ7cwGOOUMHdTnztYPlNgQAyUOW6be2zKoRvqzP+
         gObm8zDHX17uMmCKgTPbdwtBfFqZOza64FT5QNQQwTgNML09WEP1VULXaL1vUx/hLR1X
         OBe1KDCKCTI3K8Q5y+uFeh4gHh+3i+8VELzbB16b5ftf80kN4AG7GpvfkoJ5AGSB8FuQ
         cAiHT8EOsDYsJBAgGgYSezylALmPOIHGbSfDYRHMveLqlbx7/9dEaPkgzpyfDUrhlAQx
         rBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WthdUQRuldZItbKhneH8cBnZID6XoD/ui7CVs78qT98=;
        b=QL8qKxvpNdoNiWhwcBfYuRYhg8LPK+5y1wmzq8TIbIwy962e93MJU1L5eHQ2EhfHlR
         XsgdgndGGZPleVj4kINgBuFbwKJjEduG1n44OapY7mAZ2nxxKxdnHln3+8aSSDVy0WEw
         QPZ6/SAo98z90vdeBEec8FDR4fE7Bzipk7Vr+fJ2ps+XkFNpEnkMRiJHqgFUdwFLf8Da
         9MgYCB12EJgMuvfZcmR4kEJvYFRfCB63LU9TIoYV/OwVJvTaS/suK5qshrZsmHoxrKd3
         B9GqXK98bZjcwrcYlszzggC9rFlzXjrRKqRD5wzdGwe1hpfMI3dsjwgKBXO4O4W6J9JV
         5hLg==
X-Gm-Message-State: AOAM532onvm/KzLKs/cMM3hpSoiOrkZbgYUc4WZPkoT3NEDb7du92I7B
        7mAtXAPMB74h6t+kyg2mx+Q=
X-Google-Smtp-Source: ABdhPJyRKxQ0sH5FFiBjvKFh7+zgTZPH33lvkeGW+jd0g0EAI3ElU4WJNofSTQiPTTHqBB4R5tOtig==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr6400085wmm.170.1601415365735;
        Tue, 29 Sep 2020 14:36:05 -0700 (PDT)
Received: from contrib-buster.localdomain ([212.86.35.59])
        by smtp.gmail.com with ESMTPSA id m3sm7791298wrs.83.2020.09.29.14.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:36:05 -0700 (PDT)
Date:   Tue, 29 Sep 2020 21:36:03 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 1/2] worktree: teach `list` to mark locked worktree
Message-ID: <20200929213603.GB1336@contrib-buster.localdomain>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20200928154953.30396-2-rafaeloliveira.cs@gmail.com>
 <xmqq8sctlgzx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sctlgzx.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 02:37:54PM -0700, Junio C Hamano wrote:
> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
> 
> > The output of `worktree list` command is extended to mark a locked
> > worktree with `(locked)` text. This is used to communicate to the
> > user that a linked worktree is locked instead of learning only when
> > attempting to remove it.
> >
> > This is the output of the worktree list with locked marker:
> >
> >   $ git worktree list
> >   /repo/to/main                abc123 [master]
> >   /path/to/unlocked-worktree1  456def [brancha]
> >   /path/to/locked-worktree     123abc (detached HEAD) (locked)
> 
> 
> In our log message, we tend NOT to say "This commit does X" or "X is
> done", because such a statement is often insufficient to illustrate
> if the commit indeed does X, and explain why it is a good thing to
> do X in the first place.
> 
> Instead, we 
> 
>  - first explain that the current system does not do X (in present
>    tense, so we do NOT say "previously we did not do X"), then
> 
>  - explain why doing X would be a good thing, and finally
> 
>  - give an order to the codebase to start doing X.
> 
> 
> For this change, it might look like this:
> 
>     The "git worktree list" shows the absolute path to the working
>     tree, the commit that is checked out and the name of the branch.
>     It is not immediately obvious which of the worktrees, if any,
>     are locked.
> 
>     "git worktree remove" refuses to remove a locked worktree with
>     an error message.  If "git worktree list" told which worktrees
>     are locked in its output, the user would not even attempt to
>     remove such a worktree.
> 
>     Teach "git worktree list" to append "(locked)" to its output.
>     The output from the command becomes like so:
> 
>           $ git worktree list
>           /repo/to/main                abc123 [master]
>           /path/to/unlocked-worktree1  456def [brancha]
>           /path/to/locked-worktree     123abc (detached HEAD) (locked)
>

Thank you for such detailed explanation. I totally agree that it seems
much better to organise the commit message this way, I will definitely
include this message (or something very similar) when resending these patches.

> 
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > index 32e8440cde..a3781dd664 100644
> > --- a/Documentation/git-worktree.txt
> > +++ b/Documentation/git-worktree.txt
> > @@ -96,8 +96,9 @@ list::
> >  
> >  List details of each working tree.  The main working tree is listed first,
> >  followed by each of the linked working trees.  The output details include
> > -whether the working tree is bare, the revision currently checked out, and the
> > -branch currently checked out (or "detached HEAD" if none).
> > +whether the working tree is bare, the revision currently checked out, the
> > +branch currently checked out (or "detached HEAD" if none), and whether
> > +the worktree is locked.
> 
> At the first glance, the above gave me an impression that you'd be
> adding "(unlocked)" or "(locked)" for each working tree, but that is
> not the case.  How about keeping the original sentence intact, and
> adding something like "For a locked worktree, the marker (locked) is
> also shown at the end"?

Yes, it sounds good.

> 
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 99abaeec6c..8ad2cdd2f9 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -676,8 +676,12 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
> >  		} else
> >  			strbuf_addstr(&sb, "(error)");
> >  	}
> > -	printf("%s\n", sb.buf);
> >  
> > +	if (!is_main_worktree(wt) &&
> > +	    worktree_lock_reason(wt))
> > +		strbuf_addstr(&sb, " (locked)");
> 
> Is this because for the primary worktree, worktree_lock_reason()
> will always yield true?
> 
>     ... goes and looks ...
> 
> Ah, OK, the callers are not even allowed to ask the question on the
> primary one.  That's a bit strange API but OK.
> 
> Writing that on a single line would perfectly be readable, by the
> way.
> 
> 	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
> 		strbuf_addstr(&sb, " (locked)");

Agreed. will be much better to have it in a single line.

> 
> > +	printf("%s\n", sb.buf);
> >  	strbuf_release(&sb);
> >  }
