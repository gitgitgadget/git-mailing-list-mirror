Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC9C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B6920792
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLJWl1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHDWx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHDWx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:53:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91967C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:53:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d2so17618376lfj.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5jld3FemBjmCrVAANVvQWf5hjJE6N5ewaTW2pMJyuSs=;
        b=WjLJWl1fuDpMJa6sw+n653E7KVXQQrhGUyYuMysWEKSLCcN//gEjMnBFZKv9Ux9Nk7
         ZDrcFRNl1ulFk8BcdBDgRlOHx43GG8pcuCgGdOQnoI8k1NeNa9yBAzIC8B5BfyFFgxAM
         oo7eT21m8cfZ9LYpr5OXLZhmJs+1SwhE9jK3bFhb6zADjceeLpZyDDzNlRHxTEgxeU7a
         fek4J7/NoAZ76H5mgRtL8DDCc1h/UDhMwtJI7+WZ53WYEX7kjVoUpJ7DSqlizx73cZEm
         /wocfHJi9QqfMH6rfg2km/R/K95ggJ4RTE8jcGI6asO5+w5G7y9gtHuZYI0Xcy1X7qQX
         IDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5jld3FemBjmCrVAANVvQWf5hjJE6N5ewaTW2pMJyuSs=;
        b=rSGh8eWyAtCGUSLTUl7sNNwONK7tCqPj/31ml94T9TWuu0cpqnLQJVRKGramXqrJl0
         5kPWtjtgxle9E1HvAqSAFkFZGMXq7wzaFmwiEpjMbUHRanOAkIJl+oSbz4oTRlXdfSG9
         4SQUmrtECQR6/nj5H9qTK4LmS9a+wTYtRImCfeBaS4zfXoXaf4KyzkGKbHH9pN7olOGR
         PAf7vHdrCVsckZX6nVFiXoCdd9Fmyj5dO7dQOQ2Wd7BnG0V5ug1CczE2D8tWcqJhT61J
         8Slth4vGOmj5KwStPcsUaOkSETO3QOTJbpjPeM7Ju7yJ8wv2bP387pMzTvZ+CLiHGfYi
         rC5w==
X-Gm-Message-State: AOAM530QG40RNwpactt1ZfYUVkT/hg6kED/AtbxpLccE5TyKK5UZc/er
        mZ0NsP4UkJ53Hue3SDGGdiQAVkxv
X-Google-Smtp-Source: ABdhPJzk98yeY6e62dyx5lk3GIjJRWn6z1B5d/gbmYAf8h8dX1prpELySHaduXLdYCEq2QqUj6yqQA==
X-Received: by 2002:ac2:5335:: with SMTP id f21mr192449lfh.114.1596581635132;
        Tue, 04 Aug 2020 15:53:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a27sm22548ljd.41.2020.08.04.15.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:53:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 01:53:53 +0300
In-Reply-To: <20200804221440.GC2022650@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 18:14:40 -0400")
Message-ID: <87d046vx8e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 05, 2020 at 01:06:51AM +0300, Sergey Organov wrote:
>
>> > For now, "off" is OK, but then we'll regret when "all" comes,
>> > because "off" would not exactly sit opposite to "all".
>> 
>> IMHO, "off" does not need to be opposite for "all", as it suppresses
>> diff output altogether. I read --diff-merge=off as "turn /off/ diff
>> output for merge commits".
>> 
>> Besides, "all", that I don't like either, is among "c" and "cc", all 3
>> being different versions of diffs against all the parents, no?
>
> I think "all-parents" is much more descriptive than "all" (which might
> make you think "all merges", but it has nothing to do with that). It
> would make more sense if we later add the building to say "diff against
> parent 1" or "diff against parents 1 and 3".
>
> You might also consider whether "combined" is actually mutually
> exclusive with parent selection. We have focused on which parents you'd
> want to "-m" against. But in the most general case, you could ask for a
> combined-diff between parents 1 and 3 of an octopus merge.
>
> That's just coming from the angle of "what is the most general and
> orthogonal set of features". I think the vast majority of what anyone
> would want to do would be covered by doing a diff against only a single
> parent, and then it would almost always be the first parent. And
> certainly you'd need to add a bunch of code to the combined diff
> machinery to make it support arbitrary sets of parents. So this probably
> isn't that interesting a direction to go, at least for now. I'm just
> raising the issue now because we'll be locked into the semantics of this
> option, which may not be able to express the full set of what's possible
> (so we'd be stuck adding another option later).

Makes sense, and I got an idea.

--diff-merges=<parent> will still give diff against one specific parent.

In case of combined/separate diffs, it will produce diffs against all
the parents that, if happens to be needed, could later be refined by a
new --diff-parents option that defaults to 'all'.

Then, for example,

--diff-merges=1

would finally be just a short-cut for

--diff-merges=separate --diff-parents=1

while

--diff-merges=separate --diff-parents=all

would be the same as

--diff-merges=separate (what we called "all" so far)

and then we may have

--diff-merges=condensed-combined --diff-parents=1-3,8

for the bravest ;-)

This would lead us, currently to:

--diff-merges=(off,separate,combined,condensed-combined,<parent>)

and leave us ability to implement advanced parents selection, in an
unlikely case it's needed, in a separate new option.

Thanks,
-- Sergey
