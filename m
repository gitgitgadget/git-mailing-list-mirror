Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9996C33CB3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 16:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D55222C3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 16:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0lIVdAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAOQUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:20:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43574 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOQUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 11:20:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so16139014qke.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VQJcqfY8EVpaIi9SW1817bzLUv86N8QXzMWvvCSozmg=;
        b=q0lIVdAn1inVKYWVJWijFH540lAFebmsnKLQnkQbjUhRB6oBYfBqo5Vqq5PcCUrQJp
         I0DejS2jYVOZ6ocTrwEjg+MHRfvuuAuOjCrD0qD7aPZgG4MxMQB6juHKsbDWx45PW71D
         PhjzzCdB3Ss9sb9FC70+liL28DpkyL15USJoEMvC8IsmFyBlb1m5YB0dMceO8GC4GoS5
         acHtPvpyZtUwgiPw4HGkzBetZIrOv+V1GZ98RnCJfAnEMBqNM5bQiOJH4vDr6F3qBH2n
         kYMRWtezyuP7hjIV85Bokk8eFA/o6NRIlTKWiZdsWd2MuOrydIfPieF9iyssGDdcb+5w
         07Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQJcqfY8EVpaIi9SW1817bzLUv86N8QXzMWvvCSozmg=;
        b=HVd6dgVg+14FYMVgo6PLR1eSKYr9qaImAAslVYEMy7kG6j27Csx6TL0bK3QaBc2tAm
         SKEsaONnsGWSP/Vnz2eAbnFHAea6CEe9sQtdFsS0Qnpz9pN8jqAUNADAE1b1c4P6TMJS
         a6mlWG2WZwmJ+n9wTl+AbbdDZzmKfCMCu/wNR7ed/tWmVMLC2FEi0h5Q29PeBT808J4B
         GwUheS7Z7dIf9ehN+IXxLg1NcuSwNRI52VIVJ0e/lagzyIjK1X5HZAx2BNExfVhJknUH
         P7q+GagOi5rGC8SjQe4REaJHYfUTq0RhesElPWvydBXRMut/IdJbHBzdOVrunD3haN3O
         ZAzA==
X-Gm-Message-State: APjAAAUT44w9i0JcXNr3NbNjWXVKIbPFo6Mh5nhrKL+QoR3tG0YCNq2Y
        /wZvcbY+nJGJ5EZhIEU57vrJY04E
X-Google-Smtp-Source: APXvYqwqNBQcYGRUwjUJKPWheQsSXkTw6m4r39AiZbpWybIzStLETaFk4vEgC5l3bGTY6tRUy1HAsg==
X-Received: by 2002:a37:ef07:: with SMTP id j7mr28426679qkk.354.1579105217092;
        Wed, 15 Jan 2020 08:20:17 -0800 (PST)
Received: from generichostname (wn-campus-nat-129-97-124-75.dynamic.uwaterloo.ca. [129.97.124.75])
        by smtp.gmail.com with ESMTPSA id t3sm9769345qtc.8.2020.01.15.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:20:16 -0800 (PST)
Date:   Wed, 15 Jan 2020 11:20:14 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/17] merge: learn --autostash
Message-ID: <20200115162014.GA51221@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <cover.1577185374.git.liu.denton@gmail.com>
 <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
 <4032e4bd-fa3d-54eb-fe95-38549dff3aaa@gmail.com>
 <20200108060842.GA51465@generichostname>
 <f545a13f-4b3c-9603-7511-ff80ad950ee9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f545a13f-4b3c-9603-7511-ff80ad950ee9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 02:44:30PM +0000, Phillip Wood wrote:
> Hi Denton
> 
> On 08/01/2020 06:08, Denton Liu wrote:
> > Hi Phillip,
> > 
> > Sorry for the late reply. I'm back in school so I've been pretty busy
> > lately.
> > 
> > On Tue, Dec 31, 2019 at 10:34:30AM +0000, Phillip Wood wrote:
> > > For `merge --autostash` I think we need to consider the interaction of
> > > `--no-commit` with `--autostash` as `stash pop` will refuse to run if the
> > > merge modified any of the stashed paths.
> > 
> > The only time when we run the `stash pop` is when we either commit the
> > merge or abort it. With this in mind, what do you think of the following
> > test cases? If they look good, I can squash them into the appropriate
> > patch and send in a reroll.
> 
> Ah I misunderstood what happened with --autostash and --no-commit, the tests
> basically look fine (I've got one comment below).
> 
> One other thing - if the user runs `git reset` or `git checkout <branch>`
> then cleanup_branch_state() removes MERGE_HEAD, MERGE_MSG etc. If we're not
> already doing so then I think we should remove MERGE_AUTOSTASH as well or
> you can get into a situation where the user does something like

In cleanup_branch_state(), I insert `apply_autostash()` at the very end
of the function so that the stash is popped whenever this is called.

>   git merge --autostash <something> # results in conflicts
>   git reset --hard <somewhere else>
>   git merge <something> # succeeds and confusingly pops previous stash
> 
> Running `git reset` doesn't make sense unless they want to discard the
> stashed changes as well. This is a difference with rebase where you cannot
> lose the stashed changes by running `git reset`, the only way they can get
> lost is by running `rebase --quit`.  We could always add a warning about it
> throwing away the stashed changes in the future.

Currently, in rebase, if the stash cannot be popped cleanly, it is
automatically pushed onto the stash stack so that the user can deal with
it later. Do we want to do a similar thing where if we `reset --hard`
with an autostash present, we store the stash and then leave the users
with a clean worktree (as they'd expect)?

> I still not keen on the name `--autostash` as it's not automatic. `--stash`
> would make more sense to me. We'd have to deprecate `rebase --autostash` in
> favor of `rebase --stash` to change it but it if we want to change the name
> it would be better now before adding `--autostash` to merge and pull - what
> do you think?

Even though I agree with you that `--autostash` would be better named as
`--stash`, I feel that it's worse than having argument names that
perform the same functionality but with different names. So I'd be
inclined to keep `--autostash`.

> 
> > 	diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> > 	index e0c8a0bad4..af5db58e16 100755
> > 	--- a/t/t7600-merge.sh
> > 	+++ b/t/t7600-merge.sh
> > 	@@ -727,6 +727,33 @@ test_expect_success 'conflicted merge with --autostash, --abort restores stash'
> > 		test_cmp file.1 file
> > 	 '
> > 	
> > 	+test_expect_success 'completed merge with --no-commit and --autostash' '
> > 	+	git reset --hard c1 &&
> > 	+	git merge-file file file.orig file.9 &&
> 
> Is this a complicated way of getting some unstaged changes so we can stash
> them or have I missed something?

Yes, that's exactly what this does.

> 
> Best Wishes
> 
> Phillip
> 
> > 	+	git diff >expect &&
> > 	+	git merge --no-commit --autostash c2 &&
> > 	+	git stash show -p MERGE_AUTOSTASH >actual &&
> > 	+	test_cmp expect actual &&
> > 	+	git commit 2>err &&
> > 	+	test_i18ngrep "Applied autostash." err &&
> > 	+	git show HEAD:file >merge-result &&
> > 	+	test_cmp result.1-5 merge-result &&
> > 	+	test_cmp result.1-5-9 file
> > 	+'
> > 	+
> > 	+test_expect_success 'aborted merge with --no-commit and --autostash' '
> > 	+	git reset --hard c1 &&
> > 	+	git merge-file file file.orig file.9 &&
> > 	+	git diff >expect &&
> > 	+	git merge --no-commit --autostash c2 &&
> > 	+	git stash show -p MERGE_AUTOSTASH >actual &&
> > 	+	test_cmp expect actual &&
> > 	+	git merge --abort 2>err &&
> > 	+	test_i18ngrep "Applied autostash." err &&
> > 	+	git diff >actual &&
> > 	+	test_cmp expect actual
> > 	+'
> > 	+
> > 	 test_expect_success 'merge with conflicted --autostash changes' '
> > 		git reset --hard c1 &&
> > 		git merge-file file file.orig file.9y &&
> > 
> > Thanks,
> > 
> > Denton
> > 
> > > 
> > > Best Wishes
> > > 
> > > Phillip
