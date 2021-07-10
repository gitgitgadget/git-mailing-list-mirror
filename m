Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47C7C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7725D61241
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhGJTsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJTsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 15:48:12 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AFC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:45:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so13457416otp.8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=iMT3qDdK0sPT0sfB43tgofRQNqJmHhAqrZ6SSViOFu0=;
        b=ZjYrVqUgGbK9qqTlab6rL8NKv90wT8PXzcm+jXT72LQ1fMZPFvQr5PLdy/T2dBVgZX
         tNAPSssCJBskmJHZ4US9V1cLtyPT3AtE8neAzl7oDNOoWoFIxWYOZ9iDH+A7dpQsLBmn
         1K10uyFSepBY0kDi9zvuIWT27v373pwErHs5cMpUqe/1lJH2O/5N6g41ptODDbOBL2LF
         oet2cerDg2c+YHwoYcXRaQI0shxpP+QOtT67hiGWEe6vZZ0MI1BiGvZ4EXM33QOr+e4V
         wFISyQ5pC79MKTOmzv6h0msFQDSksqhcquk9SiAuFw3bk0u++H6VJ3CAd94khd22O9z3
         jGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=iMT3qDdK0sPT0sfB43tgofRQNqJmHhAqrZ6SSViOFu0=;
        b=p+R4sZMti8715N2rZFfVTd81NJHYGRLH3bozdBGxfzX1ZgzEUQKznmYrlvJ2IffHWi
         5ywcsTGY8hlFW2rwTJk2XaWvGYeU9+h9ZHCLmgvtu60PMFuPG9KgSYvAFUakdYsZHSq3
         eV2D4il1UlLBAVU2z8hzSDP8y0w6zXwlaauAWRAus5Ahi7XskaeeqrTy8sx+5vT5rdc1
         KBl40aKHBjxP/fgrXgCmg2+xgTEIx3OJVn5/NsyIqacKu+TTp3ZGIto05MnEjMyNjyp+
         +tvT1pZFjBHudFVKT1+JS1QUyYpFmAc6HVJokLbNvl6/O/mXi1Qa7wDqMElL2h5L7qcR
         PhpA==
X-Gm-Message-State: AOAM533O8/BtgN5HxoOtJHOGJXC7OPnLodR6dTJgsoP7PrEDHO13BlET
        5S2pci3PF6vxU1Sqyl6VADU=
X-Google-Smtp-Source: ABdhPJxc/i2P9bwhxuGozOYHdpC/YyLc+J9VAq3RtYUhpHcve2lwZzXTvXDeY3sQJbudp3i0rey5AA==
X-Received: by 2002:a05:6830:2309:: with SMTP id u9mr24810069ote.327.1625946326358;
        Sat, 10 Jul 2021 12:45:26 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id c63sm1595829otb.55.2021.07.10.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:45:25 -0700 (PDT)
Date:   Sat, 10 Jul 2021 14:45:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e9f8d462bd9_7ef20898@natae.notmuch>
In-Reply-To: <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 09/07/2021 19:41, Felipe Contreras wrote:
> > Martin wrote:
> >> Well, that is the question as what the action is perceived.
> >> I think the example is wrong, rather than the command.
> >>
> >> -c / -C /-n / -N always *c*reate an *n*ew branch. (create and new really
> >> are the same thing here)
> >>
> >> But if the branch name Foo, is already used?
> >> Well, it will still be a *new* branch being *created*.
> >> To do that it has to remove the name from the old branch. (effectively
> >> removing the old branch).
> > 
> > But it's not removing the name, it's merely changing the head.
> > 
> > I don't particularly mind having -C or -N, I just would not use them
> > because I like to be explicit. I don't use --new for something that
> > already exists.
> 
> But that comes down to the "what is a branch" discussion.
> 
> It is not creating a new branchname. But it is creating a new branch. 
> And then the branchname refers to that new branch.
> 
> It changes head, base, and the entire content. That effectively makes it 
> new.

Yes, it is a new branch, but the name doesn't change.

> If you have a 10 year old car that you nicknamed "speedy", and I come 
> along and I replace every part (every screw, every whatever...) with a 
> brand new part, would you still call the result a 10 year old car (even 
> if (or just because) you still use the nickname) ?

Yeah but you are entering into metaphysics of identity, see the Ship of
Theseus [1]. By that same logic why are you still called Martin if every
cell in your body wasn't there when you were originally born?

These thought experiments are interesting, but philosphers have discused
about this for thousands of years and the conclussion is still
undecided, so I don't think we'll come to a conclussion here.

Moreover, I don't even think it's relevant. We agree that the branch is
a different branch, we agree that the name doesn't change, and we agree
that the user doesn't want the name to change. We don't need to enter
into a philosophical discussion to see if the name *should* change.

> Using "reset", it's similar. Except that human language is slopy.
> If I play WOW, and I reset the game. Actually that is already wrong. I 
> do not reset the game. It is still the same code, the same images.... I 
> do reset my session or status. And after that, I will be in a new 
> session, or have a new status.

Words mean whatever humans using those words intend them to mean. If
most people use the word "reset" in a certin way, that's what the word
means. Even if you have a good ontological reason why reset shouldn't be
used like that, it's used like that.

> - "creating" the branch is "setting (up) the branch"
> - "re-setting" is doing doing this (creation) again.

Resetting is not necesarilly creating again, it can mean setting up
again.

> >> Nope it does not go away.
> >>
> >> All this has done, is that it no longer is a "force" command.
> >> So the last bit of warning has just gone.
> >>
> >> And it still needs to be documented inside the "git switch" doc, rather
> >> than forwarding the user do yet another doc.
> > 
> > Yes, but as I said: the documentation writes itself.
> > 
> >    -n <branch>, --new <branch>
> > 
> >      Creates a new branch.
> > 
> >    --reset <branch>
> > 
> >      Resets the branch to <head>.
> 
> And that still leaves it to the user to connect the dots, and come to 
> the conclusion that the old branch is no longer holding his valued commits.

No. You can add all the explanation you want after "Resets the branch to
<head>.", but most of that explanation would be redundant, because as we
already agreed, there's no way to reset the head of a branch without
changing the branch.

> >> So, I still ask:
> >> - If "--force" to overwrite the work tree can clearly state that change
> >> to files will be "thrown away".
> >> - Then why can "force" re-using an existing branch name not do the same?
> > 
> > Because we would be forcing two things now. 
> 
> Which 2 things?
> 
> The worktree overwriting is *not* forced by -C
> 
>    git switch -C b1 b2
>    git checkout -B b1 b2
> 
> both give an error if the worktree has changed files.
> 
> This is only about what happens to the branch.
> 
> I.e we force the branchname to point to our new branch.
> And that means the branchname no longe points to the old branch, and the 
> old branch therefore is removed.

It seems your proposal is to make `git switch -c --force b1 b2` be the same as
`git switch -C b1 b2`, but that would also make it the same as
`git switch -C --force b1 b2`. Therefore it would be forcing two things.

Or is your proposal something else?

[1] https://en.wikipedia.org/wiki/Ship_of_Theseus

-- 
Felipe Contreras
