Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F13DC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1BF613C9
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGIQM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIQM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:12:56 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F8C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 09:10:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so5932990ott.1
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZVKHCQMDGubsjxvR7QQw8597uF+x5S3itSrtX576FvQ=;
        b=EXQ+pUX0SyFvbtpqng8SrllwhiXA7Yvt6DQzQCBbkYVlRpRa/E7aVfijlqo2hDgBN3
         n/RrPTLdCbzFnaQOVb+az5nXd7ISyg0d9YICYDeJVVLWTMGYjJphaXa77LKfFpOkwreh
         qasfyCwaUYQYFIx0KJYNM9QlWO3jzHMiiVpbyn2v7LDyqEOOff7lkqhhgbd97Jc/uV8/
         JkCy9hwzjv1Oef32rmV0ea2xrcoPaF420ceQ+i2YyxQEMqCys44CEl0xWqF0bzLbEU4w
         CRbPEDNnCgnbgwmwCbBhzvSL0AZQ94UJoJyq5b4QxW6lPx+uvM8toNk+9SGg2IQbQhlY
         cAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZVKHCQMDGubsjxvR7QQw8597uF+x5S3itSrtX576FvQ=;
        b=RC20BlOQFWOzMLECVZPJMcRW92W0EtgtH2ZqOabtHMErE1TlAp5EmO5Dg8Okjp8/wy
         RLcr8Ih7kSpGfSYAX8Lw3iYser3q2d2nGBC14Z9zeeFJdOKDv4zdYziKsso3ZRpw93q7
         mY4FDY8te/xvcO5ru30+SCPAa4hjJF5wdMV0r2du7D3oe//MJYvSkZiYGFPTiAkfddXi
         CTk16Gi5N7GvfOi3N37yyNnwq3nOGLe0hBa+/XyawOodW9HXaSUmmHShOrXMqsuaqSIP
         4oz5vm5QaOBiFU7bO3vEyBEOooVyhgZB6x14aGTpeRVn6glJSdChvsl8htiA8lxm1AL3
         OKeA==
X-Gm-Message-State: AOAM533hSUYFsDbUiNaqY0ye/73sPC4b8zXxbu9BvODdqrsQ8JKf8K7O
        j/ko6rS2e3BpPkKE7RSJQ7Q=
X-Google-Smtp-Source: ABdhPJw1OC2nbieDDlefedGLmLcSvE8h6gnFryIo0fH3RTyXbMe2/WxS8XdZEI+F/1Uy1cHGzDIdmw==
X-Received: by 2002:a9d:903:: with SMTP id 3mr29494332otp.146.1625847011720;
        Fri, 09 Jul 2021 09:10:11 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id n20sm1225803otj.11.2021.07.09.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 09:10:11 -0700 (PDT)
Date:   Fri, 09 Jul 2021 11:10:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e874e1c6845_215320861@natae.notmuch>
In-Reply-To: <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 09/07/2021 02:45, Felipe Contreras wrote:
> > I believe we have all the semantic tools needed to write something th=
at
> > is understandable by most people regardless of their conception of wh=
at a
> > branch is.

> On 01/07/2021 16:58, Junio C Hamano proposed a patch that had an =

> interesting point.
> The patch was for the docs of "git switch" and "git branch"
> =

> 1)
> =

>       <start-point> versus <commit[-ish]>
> =

> I am not sure that this will help much with the original issue, which i=
s =

> my concern that a (new) user will be aware of why "switch -C" is a forc=
e =

> (i.e. what the dangers are).
> But it is an interesting point.

I don't think it's an improvement. What is that <commitish> used for?
That's what the user wants to know, not to mention that not any commit
works.

>  From the synopsis of various commands (just a sample, I did not check =
all).
>    git switch (-c|-C) <new-branch> [<start-point>]
>    git branch <branchname> [<start-point>]
>    git checkout [--detach] <commit>
>    git checkout [[-b|-B|--orphan] <new_branch>] [<start_point>]
>    git reset [--soft | --mixed | --hard ] [<commit>]
> =

> With the exception for "git reset" they all use <start-point> when it =

> comes to branches.
> =

> The general question here is, should the synopsis say
> a) this parameter should be a "commit".
> And then the doc explains the commit will be used as startpoint

I'd say no. I think it's pretty obvious what these commands accept as
input, what isn't clear is what that input is for.

> b) this parameter should be a "start point"
> And then the doc explains the startpoint has to be given as commit.

I don't see much value in explaining that has to be given as a commit.
How else would it be given as?

> In terms of checkout, this is especially interesting.
> The 2nd form does create a new branch.

You could say both forms create a new branch, except in the first form
the branch doesn't have a name.

> But both forms check-out the commit.
> IMHO it is somewhat strange that you "check out a start-point to your =

> worktree".
> =

> So probably <commit> (or even <commit-ish>) may indeed be the better op=
tion.

But we don't need all the commands to say the same thing, what we need
is something that's easy for the user to understand, and it's accurate.

> This is however an issue that goes well beyond "git switch".

Indeed, but if history is an indication nothing will change (changes in
git's UI rarely do happen), so its better to minimize the possibility
that the patch will be ignored, or straight up rejected.

So it's better to stick with the experimental command and fix that
first.

> This may also affect other words used in synopsises. So this is a =

> general rule that needs to be decided for all of the documentation.
> The issue is, that some commands take several commits.
>     git rebase [--onto <newbase>] [<upstream> [<branch>]]
> In that case some distinguishing is needed.

I'd say it shouldn't matter if it recevies one or several, what that
commit is used for is what matters.

> 2)
> =

>       <branch> versus <branch-name>
> =

>     git switch [--no-guess] <branch>
>     git switch (-c|-C) <new-branch> [<start-point>]
>     git branch <branchname> [<start-point>]
>     git checkout [[-b|-B|--orphan] <new_branch>] [<start_point>]
>     git rebase [--onto <newbase>] [<upstream> [<branch>]]
> =

> First of all "git rebase" is simply wrong. I can give a commit for all =
3 =

> arguments. So the last one does not have to be a branch. (or <branch-na=
me>)

True. Although in most cases the last one would be a branch.

> Then I think <branch-name> (or <branch-ish> /see other mail) should be =

> preferred over <branch>.

I don't think it makes a difference. A branch name is how you refer to a
branch (what else would be there?).

Differentiating the difference between a branch and a branch name was
done to write better sentences in the description of what the commands
do, but in the synopsis I don't see what we gain.

> As for "git switch -C"
> This should IMHO change to (the 2nd arg, actually depends on the point =

> "1" above)
>     git switch (-c|-C) <branch-name> [<base-commit>]
> =

> I suggest to not call it "new-branch-name" because, it might be an =

> existing name.

I think the name is all wrong. As =C3=86var pointed out --new (-n) is muc=
h
better. Also it doesn't make much sense to use "create" or "new" for
something that already exists.

I think you saw a correct issue: `git switch -C` might be used
incorrectly, but changing to the documentation would have limited value
(and only for the ones that read it).

I think if the branch already exists, the user has to be explicit to
what he wants to do and use `git switch --reset <branch> <commit>`

> 3)
> =

>     newbbranch  versus new-branch  versus  new_branch
> =

> That is something that just needs to be decided.
> "new_branch" is in git checkout.

I'd rather have <branch>, but as I already said, the more ground you try
to cover the more impossible it will be to actually land the changes.

> 4)
> =

>     Extend of explanation for why a command is classified as "force".
> =

> This one is the one I still lobby for support.
> This is also on issue across all docs. (or most)
> =

> Currently "git switch -C" is simply stated to be --force-create.
> =

> - There is no mention what is "forced". All it says is:
> >  if <new-branch> already exists, it will be reset to <start-point>.
> I guess this is the English verb reset. Because, if the user goes to =

> "git reset" then the user would not know what kind of reset.
> So the term "reset" is ambiguous, as it could be the verb, or the comma=
nd.
> =

> Of course the "git branch" doc has the same
> > Reset <branchname> to <startpoint>, even if <branchname> exists alrea=
dy. =

> =

> =

> There is also no word, that this does not include overwriting a dirty =

> work tree.
> =

>    git switch --force -c unused-name origin/branch
> means "forcefully overwrite a dirty work tree"
> =

>    git switch --force-create unused-name origin/branch
> fails on the dirty work tree.
> =

> =

> Btw similar on "git checkout"
>    git checkout -B unused-name origin/branch
> Only difference, -B has no misleading long option.
> =

> =

> But my point is less, the not applying danger.
> My point is what danger is there, so that this was made a force command=
?
> =

> Look at
>    git checkout --force
> > --force
> >     When switching branches, proceed even if the index or the working=
 tree differs from HEAD. This is used to throw away local changes.
> =

>    git switch --force
> > --force
> >     An alias for --discard-changes.
> and then eventually
> > This is used to throw away local changes.
> =

> So --force clearly says: You will loose local changes (if you have any)=
.
> =

> The same clarity is missing for "force create branch".
> =

> Yes, sure any commits that where in the branch, may be hold by other =

> branches or the ref-log.
> But neither is guaranteed. A branch does not need to have a reflog.
> =

> Even if we say a user must know about certain concepts (such as a =

> branchname is a reference, and non referenced objects may be lost), eve=
n =

> then the user is left to connect the dots themself.
> =

> I think it should be included in the docs (git switch/checkout/branch =

> and reset)
> =

> The current wording
>     Reset <branchname> to <startpoint>, even if
>     <branchname> exists already.
> =

> should be amended
> Avoid "reset"
>     Create a new branch at <startpoint> with the name
>     <branchname>, even if <branchname> is already used.
> =

> Add clarity
>     Create a new branch at <startpoint> with the name
>     <branchname>.
>     If <branchname> already existed, then the old branch
>     will be removed.
> =

> If the user perceives "the old branch" as container for a "chain of =

> commits", then it is still up to the user to know, that any of those =

> commits can be part of other branches. And that "removing the branch", =

> may or may not include removing the commits.
> =

> However, a user not yet knowing what exactly "removing a branch" means,=
 =

> does at least have the word "remove" to make him wary that they should =

> look up more details.

All these issues go away if we have:

  git switch --reset <branch> <commit>

And instead of -C, we have:

  git switch --new --reset <branch> <commit>

This creates a new branch if it doesn't exist, or if it exists resets
it.

Now the documentation writes itself.

Cheers.

-- =

Felipe Contreras=
