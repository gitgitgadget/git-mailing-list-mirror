Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8877AC433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A48E60F43
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJWVLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhJWVLI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:11:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7CC061714
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 14:08:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ec8so5327975edb.6
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bFfO7Qjz5Y+vU48sbS1tsDJX2VtN6MyU+J1gQzsRX2w=;
        b=DXCC0JsO3wCqhsO52xM2BdYBzqYqOt//jSw/+4mRrd+Aim2gGiwSi/bLj5ihpAEMgI
         9/JfZ1ZQwKKXdlVUgI2/zAZ6kv62Eg8t2v2/4mkx98nCQJCj+i3DDUNwcdO/w8dsdocI
         xFFMN/6Zfif8h7/OzZAK78DSnU8VCK/9D1GeCT34qIvRx9x0y7vUJjGSsQ6pBEyqt5C4
         zeCftTi4tYBPcMqOlsPI991zSzx9x2oPqch5spLiytTanqwOiF191IJ3dYOCCOR6QdvE
         b7YkqQSIiMDIl1O8o6ubaO1/K4USOzKFKslTgzyJe48QPR57dssK+Jbb2Ningb3Gsllv
         0bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bFfO7Qjz5Y+vU48sbS1tsDJX2VtN6MyU+J1gQzsRX2w=;
        b=fSMoZuw4muJa3dSE6TMdRcY0JcXomcyDf80Rgyj0GAPbjCCDYYlscQWcVBldz41GsJ
         9dbvF+Njo04GZcToO5vDU+SBR5X9p476X2Jk+go+dqJ8HOry+8phO04Jzva+YkSkCl06
         kbJpIK1iq+BbcRR1xRY2sblJPxNJhmuVn+mloGFiaJoMhRKNHVQFFACNpm/PwArBb+uN
         cnYNB48IZqpn7iWKzGeJGE70WJkHT+4OzOKDEBgiMHEr01neHwQy2Ogql459AI+cIHb6
         SUzAJGy8Nk2MOLDOyM1MbpMVbnpbA89bfGv0l+80mgYrLTpl6eYeALMDJF81i722X+tD
         hjHw==
X-Gm-Message-State: AOAM532leT6cNbjIBp7HcucH1smxnkRKVRDkPQHAsoZuVFoe+PWWTb3T
        LkcA8XmSC9SrRyBDdX0Fl7Q=
X-Google-Smtp-Source: ABdhPJwMLdihw9aYXtvCY4JgBeO676y+/lPUoNW8uZ2qX758IHii2grcaKEOX3loSHby54joCFsRVA==
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr9998186ejc.484.1635023326891;
        Sat, 23 Oct 2021 14:08:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f9sm996664edt.7.2021.10.23.14.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 14:08:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1meOFy-001SrA-02;
        Sat, 23 Oct 2021 23:08:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: SubmittingPatchs: clarify choice of base and testing
Date:   Sat, 23 Oct 2021 22:59:00 +0200
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
        <xmqqa6izcwio.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqa6izcwio.fsf_-_@gitster.g>
Message-ID: <211023.86bl3fih42.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 23 2021, Junio C Hamano wrote:

>  Documentation/SubmittingPatches | 50 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 13 deletions(-)
>
> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
> index e409022d93..2de8f80dc5 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -19,8 +19,11 @@ change is relevant to.
>    base your work on the tip of the topic.
>  
>  * A new feature should be based on `master` in general. If the new
> -  feature depends on a topic that is in `seen`, but not in `master`,
> -  base your work on the tip of that topic.
> +  feature depends on other topics that are in `next`, but not in
> +  `master`, fork a branch from the tip of `master`, merge these topics
> +  to the branch, and work on that branch.  You can remind yourself of
> +  how you prepared the base with `git log --first-parent master..`
> +  easily by doing so.

For what it's worth when I do this I base things on one either your
gitster/* branches, what I've applied from the ML, or grabbed from the
author's own repo, and then usually rebase it on the latest "master" or
<topic> as appropriate so I don't have on old base, particularly in the
case of gitster/*, you don't rebase those unless needed.

Anyway, I can see why you suggest the "base on master and merge", it has
its benefits, but it is in apparent conflict with existing advice added
in 76644e3268b (documentation: add tutorial for first contribution,
2019-05-17).

I.e. the "After Review Approval" section (of all places) discusses what
to do in that situation. It is narrowly talking about submitting
something on top of your own topic, but the advice should be the same in
either case I'd think.

>  * Corrections and enhancements to a topic not yet in `master` should
>    be based on the tip of that topic. If the topic has not been merged
> @@ -28,10 +31,10 @@ change is relevant to.
>    into the series.
>  
>  * In the exceptional case that a new feature depends on several topics
> -  not in `master`, start working on `next` or `seen` privately and send
> -  out patches for discussion. Before the final merge, you may have to
> -  wait until some of the dependent topics graduate to `master`, and
> -  rebase your work.
> +  not in `master`, start working on `next` or `seen` privately and
> +  send out patches only for discussion. Once your new feature starts
> +  to stabilize, you would have to rebase it (see the "depends on other
> +  topics" above).
>  
>  * Some parts of the system have dedicated maintainers with their own
>    repositories (see the section "Subsystems" below).  Changes to
> @@ -71,8 +74,13 @@ Make sure that you have tests for the bug you are fixing.  See
>  [[tests]]
>  When adding a new feature, make sure that you have new tests to show
>  the feature triggers the new behavior when it should, and to show the
> -feature does not trigger when it shouldn't.  After any code change, make
> -sure that the entire test suite passes.
> +feature does not trigger when it shouldn't.  After any code change,
> +make sure that the entire test suite passes.  When fixing a bug, make
> +sure you have new tests that breaks if somebody else breaks what you
> +fixed by accident to avoid regression.  Also, try merging your work to
> +'next' and 'seen' and make sure the tests still pass; topics by others
> +that are still in flight may have unexpected interactions with what
> +you are trying to do in your topic.

Maybe it would be useful to have a CI target that merged to next/master
and reported how that went? It would have to be a soft failure, as we
might have an easy merge conflict, or someone's pushing a revision to a
topic that's already in "next" or "seen" (and might conflict). But
having it as an FYI might be helpful.

>  Pushing to a fork of https://github.com/git/git will use their CI
>  integration to test your changes on Linux, Mac and Windows. See the
> @@ -144,8 +152,21 @@ without external resources. Instead of giving a URL to a mailing list
>  archive, summarize the relevant points of the discussion.
>  
>  [[commit-reference]]
> -If you want to reference a previous commit in the history of a stable
> -branch, use the format "abbreviated hash (subject, date)", like this:
> +
> +There are a few reasons why you may want to refer to another commit in
> +the "more stable" part of the history (i.e. on branches like `maint`,
> +`master`, and `next`):
> +
> +. A commit that introduced the root cause of a bug you are fixing.
> +
> +. A commit that introduced a feature that is what you are enhancing.
> +
> +. A commit that conflicts with your work when you made a trial merge
> +  of your work into `next` and `seen` for testing.
> +
> +When you reference a commit on a more stable branch (like `master`,
> +`maint` and `next`), use the format "abbreviated hash (subject,
> +date)", like this:

This seems like a good clarification, but partially unrelated to the
$subject, i.e. just the last bullet point is directly relevant, the
first two are new general advice. Perhaps split those out into another
commit?
