Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1639FC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 04:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D8961164
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 04:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhFVE2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 00:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVE2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 00:28:50 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83463C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 21:26:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20053674otl.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 21:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Tvo4FeX0msgPit9n6xMt/50wEhOijsCs/jKyDOZpYY8=;
        b=VNbkzJvAKna5w3b0W9p7DJEcxoEQLcGFnrWDkXXXFMnY5ZuZ3BhEdYeqRaBrPEd9mY
         YSr/h6VasyKEk/3QthSbBT+2Sl83DClI2UvGs8dnZUCM2u3HXLu9ZW4KO6sqz5F7jYoB
         ZqLcEBhEIoLBwYXGOVh10M9hlh2MMjEMT3rPr0RuLbEp11tW8Mkqjxv7OzS8gfxXZFJl
         cC0z6iGwKafTWiGMzMqRz1V8UxxKc948hZUVoBfHMBRa4Gj2PS+lvwqPGlyQSLMK39Zf
         3/BQIX4yOfg9iQ/STbegcP2a9jMo3ZMF6Scl2kKbnOW2S7km40jw9v4Ey2fLpUYDEmSj
         35yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Tvo4FeX0msgPit9n6xMt/50wEhOijsCs/jKyDOZpYY8=;
        b=ujoELAewgnFiUwMxh0qy/21XEOMqgw5AhCV7VBFAkJJ0rFb5DYIaSpYxNtBayduGoh
         zW9obOd3iB9IcP+rSri/p4qUb991qwd9eBRsRTUBMrgxNbcuuI2rgEiAraJVzDYNpOkr
         y8HtXVEqeTZpheOWdPp4dLiGXOfp+tZ+W2ybZqgh/4JEcLQ+1TsUWPAnS1V6wsT9wSz1
         QQz7/ZBnRUl5SySjtvdTl98G3wrE+JU8yrqQjioLC1T1yY570ZGPWhbWrOKu56aPF0ki
         TEZiivv7t99VkF9VwUI6p4u9P27l+GSN4hFBfPN//ugxBe3TDY/0HqF2gHUWnYRePrRr
         XcYg==
X-Gm-Message-State: AOAM530QVSMh1qxRK1EhOUzc37ra9LPR8rJnMfaeYIRrPLjA7g2r1CpP
        QBBWF6dIafxGpm0WGcb2t7c=
X-Google-Smtp-Source: ABdhPJw1Miit1GCkdgPza+bxZHup50qegLR1IG8QqGA2JPBRetapmigKTmjP2rKrHmKIKDhrZpgW+w==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr1351586otf.214.1624335993883;
        Mon, 21 Jun 2021 21:26:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r7sm2180789ota.59.2021.06.21.21.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 21:26:33 -0700 (PDT)
Date:   Mon, 21 Jun 2021 23:26:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d1667797fb1_1a4aad20825@natae.notmuch>
In-Reply-To: <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Mon, Jun 21, 2021 at 4:12 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Alex Henrie wrote:

> > > Although what needs to be done had been envisioned by some as early as
> > > 2013, the warning has only been around since Git 2.27 (released in
> > > June 2020), and it was only restricted to pulls where fast-forwarding
> > > is impossible in Git 2.31 (released in March 2021). The good news is
> > > that (unless I'm mistaken) there are no more changes that need to be
> > > made prior to changing the message from from "advise" to "die".
> >
> > There is *a lot* that needs to be done.
> >
> >  1. Update the documentation
> >  2. Add a --merge option (instead of the ackward --no-rebase)
> >  3. Fix all the wrong behavior with --ff, --no-ff, and -ff-only
> >  4. Add a pull.mode configuration
> >  5. Add a configuration for the mode in which we want to die
> >  6. Fix inconsistencies in the UI
> 
> I agree with you that the documentation should be updated when the
> change is made (#1),

I'm saying the documentation needs to be updated _before_ the change is
made. There's no reason not to have the fast-forward example in the
documentation.

> and maybe there should be a config option to go back to the behavior
> of warning but doing the merge anyway (#5).

Before that we need a configuration to turn the behavior on.

> The rest I think are things that would be nice to have but don't
> preclude making the switch because aborting instead of merging would
> not introduce any new UI limitations or inconsistencies.

They don't preclude the switch, but the switch should be precluded by a
warning, and the warning would be something like:

  The pull was not fast-forward, in the future you will have to choose a
  merge, or a rebase.

  To quell this message you have two main options:

  1. Adopt the new behavior:

    git config --global pull.mode ff-only

  2. Maintain the current behavior:

    git config --global pull.mode merge

  For now we will fall back to the traditional behavior (merge).

  Read "git pull --help" for more information.

Without having the changes I listed this warning can't be as useful.

> Of course, it's ultimately up to Junio and the wider Git community,
> and I would love to hear their thoughts about it.

I would not hold my breath.

> > In the meantime there's no reason to have subpar documentation.
> 
> My only serious objection to this patch is the instruction to merge if
> you don't know what to do instead of asking the repository maintainer
> what to do or reading the Git documentation. I don't have a strong
> opinion on the rest of the patch.

I would be fine if the patch is merged without that line, but I believe
the patch is better with that line.

The line doesn't say "do this this if you don't know what to do", it
says if you are *unsure*. That is not the same thing.

And the user *already* did a merge, as that's what 'git pull' does by
default. The advice throws a warning, but proceeds with the merge.

The only thing the line is telling the user is how to muffle the message
if she is unsure of the previous muffling options.

Would you be happier with this?

  The simplest way to maintain the current behavior is to just do
  "git pull --no-rebase".

Cheers.

-- 
Felipe Contreras
