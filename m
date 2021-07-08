Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A4C07E95
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 03:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B93161CDA
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 03:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGHDmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 23:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhGHDmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 23:42:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD73C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 20:39:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s24so6229756oiw.2
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 20:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VSe1svh+Mb8Gw65DRKcKyv4dnoHQgXo+zYmd2HJkk4I=;
        b=AtTIqSNvZHW0xxL15Acj99wL1tSTrO4rfluOtJjl7O/loU2B3El4qVoGzxu+N3+bsf
         AgmwSSOlI1cYrA8hmabyRmZzos14c6cA8zI2RfTy3zpX6n1ch1Sw/mD21Rg19srb20m7
         YJYPOBG+Lr/LDTIm2CJgK0HEDlV8Dcf79a002ehOVISEH7XAbl7niZeAnk3SRFKOtAKs
         yMzJZWRbknpbXUrl593aL2rF1JZVeL9s0RggsSn00DUBbndckKCf3mAeFYJ0pxrEU9Ss
         wkFXo3i/r5msjvs6jRH/bts74jwNQ2YG5NbXoEIgUkx1uBMd3bagFXuen2tGXOfI7l+E
         QW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VSe1svh+Mb8Gw65DRKcKyv4dnoHQgXo+zYmd2HJkk4I=;
        b=RpbGvpdFDlPcTJ/KmZlbI+cW0hz7E4ma4KMk1x3Ywua9O0353nn+wqzTWhMps1WMqo
         A+MSeXWk0tNnzxU35Ny6JHtrkmPzxDBRxkqRjcJiCdN199+kxU8j6fU+YAR7gkz2xZ6h
         vobBJeoFG4+w+EHUKIGydGEE5byrd/JzRJ3yP/yPX7n/2brSiY/wlEC65IXhYlVk+ttw
         5fhPiLA5TgN2dZ7TYXtqKawq0OC2xdEHllRiqYIAzlhR38PHsUIG8t8BajBjTWOJij9E
         2wO1ADStc/T9VtfcRS5/OdhiI400lUeIkSDJxInk/+X+r2owMpfuorF8iXBHqIVG2U/8
         YE3Q==
X-Gm-Message-State: AOAM530y2Rc78RN12sI6EPXNAX88gQz+R8Gp/tCZPe8niyrZ2zfKmOT7
        FvlP3+cU9XIp2L6O3cClWbE=
X-Google-Smtp-Source: ABdhPJxzqNOufhbELV2X0FH68FF4tRE/jHvvCiREGUl0HVnLN8NZGUffZotrEoH3t8jlohqe8KEmMA==
X-Received: by 2002:aca:43c6:: with SMTP id q189mr1943838oia.81.1625715596222;
        Wed, 07 Jul 2021 20:39:56 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 37sm245207otq.72.2021.07.07.20.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 20:39:55 -0700 (PDT)
Date:   Wed, 07 Jul 2021 22:39:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>, Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e67389a4adc_306ac1208fd@natae.notmuch>
In-Reply-To: <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
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
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 08/07/2021 00:07, Sergey Organov wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>
> >> This is works if your base (or tail, or whatever) is static, but many
> >> branches jump around, and that's where @{tail} comes in handy.
> > 
> > Yeah, I see. When I need to make a branch jump around, I do need to
> > manually move my references, but that's fortunately very rare use-case
> > for me. Having direct support for that is still a win.
> > 
> >>
> >> You can do this:
> >>
> >>    git rebase --onto foo@{upstream} foo@{tail}
> >>
> >> This will always rebase the right commits (no need to look into the
> >> reflog). So you can say that the branch is foo@{tail}..foo.
> > 
> 
> Maybe I am missing something, is tail for tracking branches only, or for 
> just any branch?

Any branch.

> If for any branch, looking at
> 
>    A => B => C => D  master
>         |
>          \          / => G => H  branch_1
>           => E => F
>                     \ => I => J  branch_2
> 
> Where is the base of branch_1 and branch_2?

It depends where the corresponding `git switch --create` command was
issued.

If you did `git switch --create branch_1 B`, then @{tail} is B.
If you did `git switch --create branch_1 F`, then @{tail} is F.

> (and does it matter if they have an upstream)

No. That's completely independent.

> Maybe branch_1 diverged from Master, and then branch_2 from branch_1?
> 
> Maybe the other way round.
> 
> Maybe there was a branch_0 (that got removed),
> and branch_0 diverged from master, and branch_1 and branch_2 both from 
> branch_0?

Yeap, the tails of branch_1 and branch_2 could be literally anywhere.

That information is not recoverable from the current data structures of
git, thus the proposal to add a new one.

> ---
> Also base may be misleading.
> 
> If head is the one end of the commit chains, then base should be the other.
> But all branches contain commits A (and B). So the base would be A.

All branches contain A, but only one branch could have A as a
base/tail (under normal operations), and likely none do.

Suppose branch_2 was created this way:

  git switch --create branch_2 A

Then commit B was created under branch_2. Then master was fast-forwarded
to branch_2, so you have:

                 A => B master
                 ^    ^
  tail/branch_2 -+    +- head/branch_2

Both branches have A, but only branch_2 has A as tail.

As both branches move forward they diverge, and the "fork-point" is B,
but B is not the tail of *any* branch.

Naturally then branch_1 would be created with F as a starting point, so
that would be the tail of branch_1.

And once again, even though F is part of both branch_1 and branch_2,
it's the tail of branch_1 *only*.


This is a convoluted way of saying: the tail of a branch is the point
where that branch was created.

> "fork" would be more descriptive IMHO?

As you can see from the example above, the tail doesn't necessarily have
to be a fork-point.

Not to mention that there can be multiple forks after the tail (e.g. B
and F).

> Also, if that is to save the user from looking up fork points, maybe 
> extend the syntax
>    branch_1@{fork:branch_2}
>    branch_1@{fork:master}
> 
> Depending on some of the answers to the above
>    branch_1@{fork}
> nearest fork, or upstream fork?

Except it's not necessarily a fork, nor the nearest, nor related to
upstream...

So it's not a fork.

It can be literally any commit.

Cheers.

-- 
Felipe Contreras
