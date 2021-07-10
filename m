Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB1C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA91A6128D
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhGJUPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJUPk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 16:15:40 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E17C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:12:54 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id w17-20020a4aca110000b029025dba2185a4so618685ooq.11
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xLsDR+eon1JDvdYLq8WgUQhkp2iqbR0BBfuZRFT5+aE=;
        b=BQXAAL5CHwTog3W6JZnKlK4t1nWoJOaBnSDguQwUzpZecIfiWFBecL1qEdjogGpq64
         WVfFS2NI0Xd7XN2xkdgAHRvnDiIojVdUAL/XYko6ma6048L1LpDetBYCx2bJBS3O0G7p
         tu9xXni+sZRbV6t909+0/Bey/dKlD41o+xJ1Ryx1A+rAAZOqnu1F5vv3l2PAiIgmA/Iy
         efdBEXKgGJU5Z8kqwBGY1l/s9wCzkomHE1R1diLWbET/1xGAZiQIdQZKnYjx2Szi2mZ5
         q+oYoGUo9hqd4EIsNd02tZNoE04cSNoA307ChvkllX6Q6PmpeVY/H4tBSmaU+LCed2Ov
         bnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xLsDR+eon1JDvdYLq8WgUQhkp2iqbR0BBfuZRFT5+aE=;
        b=reXbu+4/kvjfF0aQrKUimNu/Co/8YE7sfAtKfq1w3OiAUpeaex0dmIJu7c/rsQyl8a
         hRNmi4X9iSM8h0HOA3E810ClI9+ken/qk9SVeTJaAsGSg5yoe7Wq1YbrYKxmuPlsbFAX
         2qImK+wWF1tJfjT490+HBCfuuQR6WGMe2+/e53SgE+Yd9ceUznpt3S85/qeg7yanwiGy
         PUJcxhD+206QCPZlT8ceiKKbjT5bpwtcOV4y5v9oL30bbYJor3NpMSeqLqY7azkILVkM
         k4ZPtdvqwkxz4OFrkIx5XzOWDuiGYFzaWgtQMLSGCEsdgUTglSZJAiHPUYO9m0CgThwv
         SXlQ==
X-Gm-Message-State: AOAM532xKncUd51/vs/hkTrNsGSEkgyX5aJA7frULEgnVSInK/HF/KDh
        GiAvDtCQlT3F1f741zxRqsQ=
X-Google-Smtp-Source: ABdhPJwZrzaxDlhYryEO9URU4mqQlYmhXvurlMKwNSSTpS4R04hQTu+Cm9EiqRu7Bpq3/ngrgmWMZQ==
X-Received: by 2002:a4a:e8cd:: with SMTP id h13mr26712909ooe.26.1625947973837;
        Sat, 10 Jul 2021 13:12:53 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id t10sm1703329oor.48.2021.07.10.13.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 13:12:53 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:12:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>, Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e9ff4430c57_7ef20815@natae.notmuch>
In-Reply-To: <87a6mudt9b.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
> 
> > On 10/07/2021 12:24, Sergey Organov wrote:
> >> Martin <git@mfriebe.de> writes:
> >>> Actually, "new" or "create" would make sense in "git branch". But in
> >>> git switch, they actually raise the question "create what?" / "new
> >>> what?".
> >> I believe that's because "git switch" tries to do too much. "git switch"
> >> should rather switch between existing branches, and do nothing else. As
> >> I said once in this discussion already: trouble writing good
> >> documentation is often indication of some flaws in the design.
> >> Creating (a branch) is fundamentally different operation than switching
> >> to (a branch), and that's why the former doesn't fit into "git switch".
> >> 
> >
> > Right, yes. But creating a branch is often followed by switching to it.
> 
> Yep, but here the creation is the primary operation, not switching, so
> putting this into "git switch" looks like design flaw. These 2 actions
> are fine to co-exist in "git branch" = "whatever you want to do to
> branches", but not in "git switch" == "wherever you want to switch".

I don't see the logic in here.

  git branch topic # here 'branch' is the verb
  git switch topic # here 'switch' is the verb

Now, if you want to do both at the same time the logical options are:

  git branch --switch topic # here '--switch' is an adverb
  git switch --new topic # here '--new' is an adverb

The former reads like gibberish to me: "git, branch off in a 'switch'
way".

The latter makes perfect sense: "git, switch to a branch in a 'new' way".

> Logically, there could be something like "git new" that does create a
> branch and then switches there by default, or something like that, say:
> 
>    git new feature3 --at origin/rc-2 --track

Here the the verb is clear, but not the direct object, a "new" what?
Couldn't it be a tag? Or a commit? Or a remote? Or a worktree? Or a
bisect? Or a submodule?

It's too ambigous.

> And while we are at it, do you guys notice how 2 concepts are mixed in
> Git commands? I mean, the interface seems to mix object-oriented and
> action-oriented commands, most of commands being action-oriented with
> only a few unfortunate exceptions.
> 
> Let me try a short survey:
> 
> 1. In
> 
>   git branch ...
> 
> is "branch" a noun or a verb?

Both.

> 2. In
> 
>   git merge ...
> 
> is "merge" a noun or a verb?

Verb.

> To me, while the latter is obvious, it's verb and specifies the action
> to be performed, the former looks more like "whatever you want to do
> with branches", and thus the "branch" is a noun there and the command
> thus is object-oriented.

I agree, and I did have indeed noticed the inconsistency. But there's
another category of commands that receive subcommands, like:

  git remote $subcommand
  git worktree $subcommand
  git bisect $subcommand

In my opinion `git branch` fits more these subcommand commands, and it
was a mistake to make the subcommands options, it should be:

  git branch list
  git branch new
  git branch set-upstream
  git branch move
  ...

Now the verb is crystal-clear.

-- 
Felipe Contreras
