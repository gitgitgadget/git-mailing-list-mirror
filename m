Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5157FC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2EE6124B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhGJUw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJUw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 16:52:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C04BC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:49:42 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c145so2212393oib.2
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RfWUYkvBdd43Br1oEZwK3zhFMvPGDe6zYrP5sWVPCSI=;
        b=Cwv2nw7n5Wfta4S7/rb/BhmOm/zKYYKO3ZfJ5ZVEBG0KqTcMOYINQrAPs/wmaWI2D/
         qAoR0hIMTs9Dxw9zkhf3aVZHW4mihj0NiX6mZSqBDVwTffMuO25AGVLKY+sxQXt+qYGa
         gsAzCC6MfTa4cOm8FAKaVJeAAJzg62wMdYJLCDbNeEGzujca0Llf5uWYPRjc4RAK0T52
         jHYE0Q5upXtqL6bS9c5pHY7ZK0VLR0VGOVATng5dgizO2aBeVXOUZOUxgf9UvBARRDTj
         i7CwM+3aTqZ8n/w3O24IweOdhzO5ER2vARKJYL7DZNg+6sjwXs96ZxE2xzVyd2C94/Mr
         wiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RfWUYkvBdd43Br1oEZwK3zhFMvPGDe6zYrP5sWVPCSI=;
        b=aZRKg63Kj5Ad+H310isUV+lqu5TQMHdMjjaGEs4ydTqT6QpicrYI0rxjxmXpG4Xy4I
         /g7Fgni+zz5mD4ifDg3RiC5nvlZZ/RLrs8Umd0NmdrIx32y8wPULyWH5o7vr7hH3pztt
         6pqIJpiFr+U19SxXk3lu/GN1NY99JDBIWsnFO2UMUzC2Jssh4tnqvCrFA5vtIhhwwCZL
         oeCvUX18dwN8kdZf0cQYoWa8OIaCJ0DJyV+Xh3q8i/2HSqdOFGAq3pXobsVLgWrAgL1d
         X/iswc3tf9PzbNGkfz7Zw1q84HdwekT2vdJIpl9wJHays0Dzm4zWtdkGrc0KOeHCSWrH
         qVpw==
X-Gm-Message-State: AOAM5305vxYwN4gy8ZtC6U5IzeU8DLKkNSAxUDQaNgdSoqRGVxzDn3si
        FxWfU+RsCGBhCnzDyq0cx/8=
X-Google-Smtp-Source: ABdhPJzBpltlS+PMIJBWcyih4/u84roeT62AE+oSxx7I9eGl/pyBmM7ZHiaHJ44Ov5GAZPudoXc6fA==
X-Received: by 2002:aca:1802:: with SMTP id h2mr4572791oih.146.1625950181182;
        Sat, 10 Jul 2021 13:49:41 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id m1sm1960068otl.0.2021.07.10.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 13:49:40 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:49:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ea07e3495e8_7ef2081d@natae.notmuch>
In-Reply-To: <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 10/07/2021 21:45, Felipe Contreras wrote:
> > Martin wrote:
> > No. You can add all the explanation you want after "Resets the branch to
> > <head>.", but most of that explanation would be redundant, because as we
> > already agreed, there's no way to reset the head of a branch without
> > changing the branch.
> 
> By that logic a lot of explanations are redundant, because on some 
> lever, if every user thinks far enough lots of things can be concluded.

Yes. And that's what a good writer aims for: to minimize the number of
words needed for the vast majority of readers to understand the point.

The more work you as a writer put into a sentence, the less work
hundreds or thousands of readers have to do while reading that sentence.

Rendundancy is only good when you are trying to reach a certain
word count for a university essay.

>  From the docs (and similar on git checkout)
> > --force
> > 
> >     An alias for --discard-changes.
> > --discard-changes
> > 
> >     Proceed even if the index or the working tree differs from HEAD.
> > Both the index and working tree are restored to match the switching 
> > target. If --recurse-submodules is specified, submodule content is 
> > also restored to match the switching target. This is used to throw
> > away local changes.

There's no adjective I can use for the official git documentation that
isn't crass, so let's just say that I find it extremelly lacking.

That paragraph above is a great example: it's a) hard to read, b)
unecessarily verbose, c) is wrongly ordered, d) redundant, and e) not
even correct.

> If the working tree is made to match the target, then it can not retain 
> local changes. That can be concluded.
> Yet, it is explicitly mentioned.
> 
> Does it really hurt to mention it?

Yes it does.

Time is the most precious resource we all have. We should not waste the
most precious resource of our readers.

  Throw away local changes.

That does a much better job.

If you want to be more explicit, you can add a bit more information:

  Throw away local changes either in the staging area or the working
  tree.

Why does the user have to know what HEAD is? And why does it matter that
the staging area is held in a file called "index"?

The current explanation is just bad.


But as I said, if you want to replicate the current style of the
documentation, go ahead, but it would be pretty much a bloated version
of "resets the branch to <head>".

> But anyway.
> I brought forward my idea. I explained my reasoning.
> If it (this part) is downvoted/rejected then that it how it is.

It's not a matter of consensus. There are proposals where literally
everyone is in favor, and yet they are never merged.

There's only one person you need to convince.

So, what I suggest you to do is take into consideration all we have
discussed and send another patch, because that's ultimately all that
matters. Moreover, it usually happens to me that while I write the patch
is when finally the previously-discussed ideas start to click.

> >>>> So, I still ask:
> >>>> - If "--force" to overwrite the work tree can clearly state that change
> >>>> to files will be "thrown away".
> >>>> - Then why can "force" re-using an existing branch name not do the same?
> >>>
> >>> Because we would be forcing two things now.
> >>
> >> Which 2 things?
> >>
> >> The worktree overwriting is *not* forced by -C
> >>
> >>     git switch -C b1 b2
> >>     git checkout -B b1 b2
> >>
> >> both give an error if the worktree has changed files.
> >>
> >> This is only about what happens to the branch.
> >>
> >> I.e we force the branchname to point to our new branch.
> >> And that means the branchname no longe points to the old branch, and the
> >> old branch therefore is removed.
> > 
> > It seems your proposal is to make `git switch -c --force b1 b2` be the same as
> > `git switch -C b1 b2`, but that would also make it the same as
> > `git switch -C --force b1 b2`. Therefore it would be forcing two things.
> > 
> > Or is your proposal something else?
> > 
> 
> No. I definitely want to keep those 2 apart from each other.
> 
> For each force-needing action, you should have to specify it's own force 
> flag.

OK, but I don't see the concrete proposal. What would be the flag that
makes -c "forceful"?

Cheers.

-- 
Felipe Contreras
