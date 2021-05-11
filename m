Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B489FC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82307611C9
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhEKTBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKTBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:01:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17CBC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:00:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z13so30179030lft.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c7Lkf/4N+fk9/dXHJcAnwQlzqWthYW495uNJ9f6bsII=;
        b=SnbLVcR1BPlMpXM5LvBGPJIpxnw3nQUZ5fl7gq7fa8GBiDdO8KZAUynuETqzdIHWTa
         P94rRWBbj8qbdrwjYIowM5PXOYqY6YK2V/TK5v+efXO1da6+qXdC9PGAZHjB4nlrNkgK
         RromnwWyqgq7hzTELWd8BetVdMlhlQa6BTdu1CpnrwALnUqrJHUWMntfZ/0SKzG7a3t0
         sULcXAZlj8LWJ76ceYdTfxotAvtpVq8NQJqwtWkUzF9oNCd6r1nZzZerZB/9PuZk9oWK
         GvsMvSqfSAP0MFPyAR/BMSj1VcWhaFr3kGco61OA6W1gGOTq5D+dX9NqZcUUzZ5i1ErH
         GiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=c7Lkf/4N+fk9/dXHJcAnwQlzqWthYW495uNJ9f6bsII=;
        b=Z9AyOgehgdiBBDPRGfGErbUEmsZR7ijxn/AkTvr05qokonWRPUwrhgSNl6V/ugZ5/i
         OFKbkomFbsjqKrUSzng8n0pHeE6bKJAYyWhWtvEiKmQ3qL41sGuCmoyaq52e7W/VeNRO
         4iS2BL2HkJlvwYsJ7/Rlg1/nXyREyLiaxnkkNNY+pWFOEtsoX12Q5r4YJ6pqLIlpiDs0
         4J88/St1Q9KHQURMkmWxj4oXty3AMd6XAiEWPEW1PhnpxcxROdBfPOuFVJKOwKKk2pEC
         0RhI+NE4LZ9brsbn0+lCdk2AOonVY0vkd4UqZvIcDpsX2+BhtAm+DEMK0Sxwspu3NOzC
         amZg==
X-Gm-Message-State: AOAM533XuwDOacK/l6PYUqchTpHhKn+qhnAweqXRlPmtKNP0nBQGOC1H
        UY3JLgkovPzIQ5TYwonjpZeSkwT9+Uk=
X-Google-Smtp-Source: ABdhPJySS9VG1ZLTFdJGQqMKWQ40ocbAQ3h8JBKSlzxdd4x4ChDhuEhOQKt99s3nCLdnQ1bWkA81Pw==
X-Received: by 2002:a05:6512:b04:: with SMTP id w4mr3954780lfu.636.1620759602895;
        Tue, 11 May 2021 12:00:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n10sm3833908ljj.42.2021.05.11.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:00:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
Date:   Tue, 11 May 2021 22:00:00 +0300
In-Reply-To: <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 May 2021 11:31:03 -0700")
Message-ID: <874kf9qeof.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, May 11, 2021 at 7:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Junio C Hamano <gitster@pobox.com> writes:
>>
>> [...]
>>
>> > If we enable "some kind of diff" for "-m", I actually think that by
>> > default "git log -m" should be turned into "log --cc".  As you told
>> > Alex in your response, "log -m -p" is a quite unpleasant format to
>> > read---it is there only because it was the only thing we had before
>> > we invented "-c/--cc".
>>
>> Please, no! --cc has unfortunate feature of outputting exactly nothing
>> for a lot of merge commits, causing even more confusion than historical
>> "-m -p" format.
>>
>> The best default for -m output is --diff-merges=first-parent. Everybody
>> is familiar with it, and it's useful.
>>
>> > But that might be outside the scope of this series.  I dunno, but if
>> > there is no other constraints (like backward compatibility issues),
>> > I have a moderately strong preference to use "--cc" over "-m -p"
>> > from the get go for unconfigured people, rather than forcing
>> > everybody to configure
>>
>> I rather have strong preference for --diff-merges=first-parent. --cc is
>> only suitable for Git experts, and they know how to get what they want
>> anyway. Yep, by using --cc. Why spare yet another short option for that?
>
> Interesting.  I have a strong preference for --diff-merges=remerge
> (yeah, I know it's not upstream, but it's been ready to submit for
> months, but just backed up behind the other ort changes.  Sorry, I
> can't push those through any faster).  I've had others using it for
> about 9 months now.

Once somebody uses it for 9 months and starts to understand what it is
and really loves it, she can still set log.diffMerges=remerge (new
feature) and have fun.

>
> I think --cc is a lot better than -m for helping you find what users
> changed when they did the merge,

Yes, but it doesn't mean it should be the default.

In my workflows, the first thing that matters is what commit did what
changes on the current branch. I don't typically care what the user
changed during the merge operation, only about the result. If I do care,
then only after I find the merge commit is responsible, and I can then
use --cc if I want to.

> but I agree the format is somewhat difficult for many users to
> understand. (--diff-merges=remerge, or --remerge-diff, fixes these
> problems, IMO.) I think --diff-merges=first-parent, while fine when
> explicitly requested on the command line, would be wildly misleading
> as a default because it would attribute changes to a merge commit that
> were made elsewhere.

No, it's exactly this merge commit that made these changes to the
current branch. The changes you refer to have been made on another
branch, and not by this particular merge commit, and we fortunately have
the reference to those commits through the second parent of this one.

>
>> Overall, let's rather make -m give diff to the first parent by default.
>> Simple. Useful. Not confusing.
>
> I think it's confusing.

I think it isn't, once you accept that merge commit does introduce
changes to the branch, by itself.

Thanks,
-- Sergey Organov
