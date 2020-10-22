Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B114C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91336208B3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 23:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itnDOE8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368489AbgJVXNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504396AbgJVXNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 19:13:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B85C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 16:13:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so1963195pgb.10
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imnZl/pAPBrtZ/BOKmwc/O11xzhh/BibZ9ZVvhEjRCU=;
        b=itnDOE8g8EMQbVhZmaSycGrF+VOmZao9V4u7lHdYTy9ZpOShrS8I9STpd4SKJPZ+BE
         Wq9ApGXt21DoCZs6b00wLHKHHL1IUYtjLC8/Wh+roMRnS+J2MODu/tbqeoYZpenrq7jB
         K2AZadpPWXeb2iFMS8JR1H1prTTElxCM41XiGhrULn0OXYPEL0MAfqE7C7Fv21vQq76a
         uiqoqITyv23rKi3Mp2PHmyCUhX2xk7y5T3o5LtZwR7ADsaSCE/o4hXACtA9MpF9ybIOc
         X9SXSpC5hc4zEaTyzLqUOLn+CNWXI6oWE8zVikHDUzpxLM9Eg2gSJ5spYBPTTDB2dnGX
         IYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imnZl/pAPBrtZ/BOKmwc/O11xzhh/BibZ9ZVvhEjRCU=;
        b=Z/26QIS7jWZ4RjTSXAqTWQvg4eJt2lweMOD2rjQSQaRmKXmPBGFueqn4svLVh9teXQ
         eXK264wFp/ktKjQirDxiwR1VyEwfU6T253fjq2GADio18YvcSS8Wb+4ECT7Vcy5D3cYU
         QKLV5XWv2S3360jj/Hq2vesmfhQZdm+lTA+tbCwn4bQ5o8Q494Hhex4T4BBSnq2+TPEV
         NV7etnemXpOiLF2j71GNGKxB2Pn5vIda5ct+XQpC2+Fpd6x144fLbCyyq473zEBIO8dY
         cchtQAzHVZmNiTPSdt1p8vlkdThSUFgSnlD4VbCT5japCspeyKatayNxR7/X0nDnZ04s
         hAOA==
X-Gm-Message-State: AOAM533GdB5WzkBSAvitkMr621pZKKIQdBrOXvbvQP7FAhmnK4hi1Sw7
        /psNCzWUxjWv8vpqiyxV+y7IX1160SO+HQ==
X-Google-Smtp-Source: ABdhPJwPIUx6ubSOjVnkEGNRvNOeO3JTCxsbovDeY3xzD+dapjJ4N+y5I1dPTpkotchDO5uTxWo4Lg==
X-Received: by 2002:a17:90a:740a:: with SMTP id a10mr4446935pjg.32.1603408397165;
        Thu, 22 Oct 2020 16:13:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id f9sm3380194pfe.146.2020.10.22.16.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 16:13:16 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:13:11 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: demonstrate difference between 'am' and 'apply'
Message-ID: <20201022231311.GE2774782@google.com>
References: <20201016205232.2546562-1-emilyshaffer@google.com>
 <20201016205232.2546562-3-emilyshaffer@google.com>
 <xmqqk0vpalcy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0vpalcy.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 02:53:33PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> > index 38c0852139..e64f3f10e3 100644
> > --- a/Documentation/git-am.txt
> > +++ b/Documentation/git-am.txt
> > @@ -24,6 +24,64 @@ Splits mail messages in a mailbox into commit log message,
> >  authorship information and patches, and applies them to the
> >  current branch.
> >  
> > +This command applies patches as commits. Use linkgit:git-apply[1] to apply
> > +patches to the worktree without creating commits.
> 
> I am not sure if "applies patches as commits" is acceptable,
> understandable and not misleading to normal readers.  It takes a
> mailbox with mailed patches, and for each message, applies the patch
> in it on top of the current commit and records the result as a child
> commit using the log message in it.
> 
> As "git apply" is primarily meant to work on "git diff" output, and
> it does not necessarily work on an arbitrary mbox (think: MIME), I
> do not think "if you do not want to make commit, use apply" is a
> good suggestion to begin with.  They serve completely different
> purposes and take different form of inputs.

Okay. I think I use 'git am' to apply individual mails, which also can
be applied with 'git apply'; but yes, 'git am' also can take an mbox,
and 'git apply' can't; 'git apply' can take the output of 'git diff' but
'git am' can't. I wonder how best to say so.

"This command applies patches from email (e.g. the output of 'git
format-patch', or an mbox), preserving metadata and creating commits.
Use <git-apply> to apply patches (e.g. the output of 'git format-patch'
or 'git diff') to the worktree without creating commits."

Thanks for pointing it out. I had blinders on - I use 'git format-patch'
and apply it with whichever is convenient, and in that specific case
either 'git am' or 'git apply' works. I'll try to send a new version
emphasizing the difference in input format.

 - Emily

> 
> > +
> > +EXAMPLE
> > +-------
> > +....
> > +# our sample patch, generated with 'git format-patch'
> > +$ cat ~/0001-README-add-more-text.patch
> > +From f9e01d7538c9d58b48500732b4f98f40f6ad845e Mon Sep 17 00:00:00 2001
> > +From: A U Thor <author@example.com>
> > +Date: Fri, 16 Oct 2020 13:14:42 -0700
> > +Subject: [PATCH] README: add more text
> > +
> > +Some additional context.
> > +
> > +Signed-off-by: A U Thor <author@example.com>
> > +---
> > + README | 2 +-
> > + 1 file changed, 1 insertion(+), 1 deletion(-)
> > +
> > +diff --git a/README b/README
> > +index cd08755..cfdf4e7 100644
> > +--- a/README
> > ++++ b/README
> > +@@ -1 +1 @@
> > +-Hello world!
> > ++Hello world! This is an example.
> > +--
> > +2.29.0.rc1.297.gfa9743e501
> > +
> > +# use 'git am' to create a new commit with details from the patch
> > +$ git status
> > +On branch main
> > +nothing to commit, working tree clean
> > +$ git am ~/0001-README-add-more-text.patch
> > +Applying: README: add more text
> > +$ git status
> > +On branch main
> > +nothing to commit, working tree clean
> > +$ git log --oneline
> > +dd6a400 (HEAD -> main) README: add more text
> > +90b59fb base commit
> 
> It is good to show "log" output after you injested the patch, but
> without knowing that we used to have only one commit in the history,
> the gravity of what they are seeing here may not sink in to readers'
> minds.
> 
> As I said already, I do not agree with the general idea to pretend
> that input to am is always a safe input to apply like the
> following.  However what we see above as an example session of "am"
> is an excellent thing to have, I would think.
> 
> > +# use 'git apply' to apply to the worktree without creating a commit.
> > +$ git status
> > +On branch main
> > +nothing to commit, working tree clean
> > +$ git apply ~/0001-README-add-more-text.patch
> 
> IOW, this step may even fail or produce garbage (think: MIME).
> 
> > +$ git status
> > +On branch main
> > +Changes not staged for commit:
> > +  (use "git add <file>..." to update what will be committed)
> > +  (use "git restore <file>..." to discard changes in working directory)
> > +	modified:   README
> > +
> > +no changes added to commit (use "git add" and/or "git commit -a")
> 
> 
> So, I am moderately against everything under 'use git apply' line of
> the patch.  However, I do think it is a good idea to add a note
> somewhere in the manual of "am" to say something along the lines of
> the following (placed around here, or even immediately before we
> give the sample patch we used in the above example):
> 
>     While an output of "diff format-patch" (see above/below for an
>     example) is meant to be made into a commit with "git am",
>     what you have may only be an output of "git diff" without log
>     message and is not meant to be directly made into a commit.  In
>     such a case, you may want to refer to git-apply[1] to learn how
>     to apply such a change to your working tree (and optionally to
>     the index).
>    
> It would be a good idea to redirect those readers who are looking at
> "git am" when (perhaps realizing) they should rather be looking at
> "git apply" earlier rather than later, so perhaps taking "see below"
> side and giving it as a side-note before the example starts might be
> better.
> 
> > diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> > index 91d9a8601c..38e9d8f713 100644
> > --- a/Documentation/git-apply.txt
> > +++ b/Documentation/git-apply.txt
> > @@ -32,6 +32,61 @@ This command applies the patch but does not create a commit.  Use
> >  linkgit:git-am[1] to create commits from patches generated by
> >  linkgit:git-format-patch[1] and/or received by email.
> >  
> > +EXAMPLE
> > +-------
> > +....
> > +# our sample patch, generated with 'git format-patch'
> 
> s/format-patch/diff/
> 
> I would not prepare the diff to be fed to apply with format-patch
> and use it verbatim.  This description is sewing seed to confuse
> newbies by doing so.  The "apply to the working tree, think while
> staring at the resulting 'git diff' output and decide the next move,
> which may include typing 'git commit -a -e'" workflow starts with a
> "git diff" output.
> 
> If you have format-patch output, you are still better off running
> "am [-3]" on a throw-away branch if you want to take the "think
> while staring at the diff and decide the next move" approach.  That
> may better be added to "git am" documentation, though.
> 
> > +$ cat ~/0001-README-add-more-text.patch
> > +From f9e01d7538c9d58b48500732b4f98f40f6ad845e Mon Sep 17 00:00:00 2001
> > +From: A U Thor <author@example.com>
> > +Date: Fri, 16 Oct 2020 13:14:42 -0700
> > +Subject: [PATCH] README: add more text
> > +
> > +Some additional context.
> > +
> > +Signed-off-by: A U Thor <author@example.com>
> > +---
> > + README | 2 +-
> > + 1 file changed, 1 insertion(+), 1 deletion(-)
> > +
> > +diff --git a/README b/README
> > +index cd08755..cfdf4e7 100644
> > +--- a/README
> > ++++ b/README
> > +@@ -1 +1 @@
> > +-Hello world!
> > ++Hello world! This is an example.
> > +--
> > +2.29.0.rc1.297.gfa9743e501
> 
> So, the above sample input needs to be fixed, without e-mail headers
> or potential MIME.
> 
> > +# use 'git apply' to apply to the worktree without creating a commit.
> > +$ git status
> > +On branch main
> > +nothing to commit, working tree clean
> > +$ git apply ~/0001-README-add-more-text.patch
> > +$ git status
> > +On branch main
> > +Changes not staged for commit:
> > +  (use "git add <file>..." to update what will be committed)
> > +  (use "git restore <file>..." to discard changes in working directory)
> > +	modified:   README
> > +
> > +no changes added to commit (use "git add" and/or "git commit -a")
> 
> Or "apply --index" to affect both.  If we are helping people to
> learn the command by examples, we should add it (you may only be
> interested in teaching the difference between am and apply with this
> patch, but readers' interests are not limited by yours).
> 
> > +# use 'git am' to create a new commit with details from the patch
> 
> Again, I do not think this belongs here, especially given that the
> expected input is not necessarily out of format-patch.  Instead, a
> similar and opposite referral is needed to help readers who are here
> by mistake and should instead be over there.
> 
> Thanks.
