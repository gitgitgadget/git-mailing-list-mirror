Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF87C433DF
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 22:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7361D206F6
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 22:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiV5IqjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXWMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXWMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 18:12:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A777C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 15:12:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h8so5970456lfp.9
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I/88dBs329sW+Uc4C+fsxHgVnMrvgyfjwlwPHy/L4n4=;
        b=TiV5IqjA5hzb1XfpmDJmKOwkrSAabe+oegMZ/MFFvGr/KzcSzk4I//6dMT58E7b8rX
         2o7G757jxxEB3VXPCLlWG6/uBExZepmjea5yf6F/O0ByjEuxS5BPqrHCyLyOeZtuEVy5
         nDf4SQuP0/fdPMAAZJOIX7Sb9tPmfj+lZGdas+roQrv+yQANz+SGSmwiqHwZ6KpVJA1I
         EPuSGU7oySkSk1QhQ9eAOxWuMWXiCTFY3hgNKXDMChN9+m6tI4USp9+u0pX4enQwvNUh
         GlcfVYM1d8ZOIqZCdJznjNBFS8hXPWSM3bJILo6wMID4EUCfQPK4ERDGbsOLzQjxU1Uv
         SObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=I/88dBs329sW+Uc4C+fsxHgVnMrvgyfjwlwPHy/L4n4=;
        b=K+cGu6fzDjscDdzL1lztEXDKUxCkC+ezzgWA8nZ0zSD2/LXzeMLrcTRf5egw/u6XuA
         oPhjdqyFxF4kfkeDGpLB1FDUsAgg4rcwsbG+w2/ebxYuTqSP9m145qv1hJrfSI24mF/5
         Q08a2heXh11wcVKgWEoijJXlxexOkflp2fA4DPH1Uom3otNZ+00ARYwAGXEVmNe1dq/C
         hohpRzHmpXiHEntyq9h+tV0g9gNAaFtcYi0ENDy3h1rgwQ+Yqv0z19ygbFnDgGWBjLLs
         FHoO7OC0QvpzI5dzmZ6RRQiLX7Xgoos562kaQPJDyzR+mAVuJXxtr2nxpMxFNpeyXK9C
         THTw==
X-Gm-Message-State: AOAM532kSUXY9BgNqmws7X+KC7gTH5irFuqhdcsAJl1VdU1/10UGk7Gm
        j9Dh6EvFGFlxvk7bCY/afgU3qTKp
X-Google-Smtp-Source: ABdhPJyYMxrdT7kLhVEXJlOP7T79LyBJK0/v21ghNs2w3tbO7GEG836GZlv9yDXRP7Rx8Jc5AI/GOw==
X-Received: by 2002:a19:e61a:: with SMTP id d26mr6062516lfh.96.1595628719304;
        Fri, 24 Jul 2020 15:11:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v5sm522372lji.75.2020.07.24.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 15:11:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
        <87blk6yrlc.fsf@osv.gnss.ru> <xmqqimedq5c8.fsf@gitster.c.googlers.com>
        <874kpxwghu.fsf@osv.gnss.ru> <xmqq7duslkp0.fsf@gitster.c.googlers.com>
Date:   Sat, 25 Jul 2020 01:11:57 +0300
In-Reply-To: <xmqq7duslkp0.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 24 Jul 2020 13:30:51 -0700")
Message-ID: <87tuxwimvm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> If your merge used the merge (as opposed to diff3) style, and seeing
>>> that the resulting conflict is not easy to review and you wish you
>>> used diff3 style instead, it is way too late for any option to "git
>>> merge" to help you.
>>
>>   $ git merge --abort
>>   $ git merge --conflict=diff3 side-branch
>>
>> or, say, entirely imaginary:
>>
>>   $ git merge --redo --conflict=diff3 side-branch -- my-file
>>
>> if merge had --redo option and path limiting support, that could be
>> handy for other reasons as well, as I have already pointed elsewhere and
>> you disagreed, but still.
>
> You are ignoring the case where you may have successfully resolved
> conflicts in some paths before you noticed conflicts in some
> particular files are hard to see in one style and wish if you used
> the other style, I think.

I believe I'm not, or if I do, then you are ignoring the opposite case
that you may need to redo entire merge with different merge style
output.

In other words, I only aimed at decreasing 100% down to at most 80% in
your claim:

>>> so configuration variable makes 100% more sense than an option
>>> to "git merge".

because you can only claim 100% if nobody ever needs to redo the merge
from scratch, that is obviously not the case.

> Surely, you can reset everything away and redo it from scratch,
> which is what all of the above is,

No, only first two commands are reset and redo everything from scratch,
whereas the third command supposedly only affects 'my-file' path:

  $ git merge --redo --conflict=diff3 side-branch -- my-file

Anyway, my primary point was that I still might wish to do exactly reset
and start from scratch, and then I miss --conflict option, that in turn
makes its existence less than 100% less sense than configuration
variable, my estimation being about 80%.

> but then you would need a way to stash away the successful half
> resolution so far before discarding them. Compared to that, "ouch, I
> screwed up and want a freshly conflicted state back for these paths"
> would allow you revert only the botched paths without discarding the
> work you have already done.
>
>> Actually, "git checkout" is not the place where I'd expect to find this
>> feature in the first place, so to me it's rather already 99%
>> illogical.
>
> One half of the "checkout" (which now exists as a synonym "restore")
> is to update the working tree files out of various sources, and
> "conflicted stages in the index" is one of them, so it entirely is
> natural and logical home for the feature.

I believe I already agreed it makes sense the feature ends up being
there, and I perfectly understand this /after/ I learned it's there, but
I'm still afraid I'd not figure out to look for it there in the first
place.

> The documentation needs updating to help you and others feel it
> natural, I would think.  This seems to be mostly the matter of
> better education.

Yeah, it's education that helps most when things get unintuitive enough.

Better documentation always helps indeed, and description of --conflict
option in "man git-merge" would be the best place to put a reference to
"git checkout -m" (or should it rather be "git restore -m" nowadays?)
that you've suggested elsewhere in this thread ;-)

Thanks,
-- Sergey
