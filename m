Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE82C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854BC613CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEEAV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:21:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59886 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEAV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 20:21:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB8931264FD;
        Tue,  4 May 2021 20:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k6Vd/ImRn+Y9ue3yR61MwQS1NeCmHgSorqzz2v
        i/v2A=; b=Z7yCWwYs3t/yfhvdACRULi1XojIrByr+pWJTNFNAsLaNYy1aUmo3KL
        cBeyBLBSaCjoPdMxNvKPu9l+KXNYPHwCTl/0yU6X4q1myiPYmXsxzs+a0CTyFfo7
        UeZmI/IK1d0Lf0Jig7VXAAMCPC6YsJxo3kqnbB3BAm/cziYKKy7tA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B02BB1264FC;
        Tue,  4 May 2021 20:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0816B1264FB;
        Tue,  4 May 2021 20:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru> <xmqqbl9q7jxf.fsf@gitster.g>
        <87r1imbmzz.fsf@osv.gnss.ru>
Date:   Wed, 05 May 2021 09:20:27 +0900
In-Reply-To: <87r1imbmzz.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        04 May 2021 17:18:56 +0300")
Message-ID: <xmqqy2cu58vo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2435056-AD37-11EB-88F9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> I thought I already said this, but in case I didn't, I think
>> "--diff-merges=separate" should imply "some kind of diff", and not
>> necessarily "-p".
>
> Is this a more polite way to say "no"? If not, how is it relevant for
> -m, now being a synonym for --diff-merges=on?

Sorry, I didn't mean to say "no" to anything.  

I wrote 'separate' not because I wanted to special case that (and
treat others like 'on' differently), but simply because I didn't
want to write "--diff-merges=<anything>" as "off/no" should not
imply "show some kind of diff".

> As for particular idea, I'll repeat myself as well and say that I'm
> still against implying anything by any off --diff-merges, and even more
> against implying something that affects non-merge commits. --diff-merges
> are not convenience options that need to be short yet give specific
> functionality, so there is no place for additional implications.

So -m (a shorthand for --diff-merges=on) should not imply any patch
generation, you mean?  It matches what we seem to have agreed on to
be the purist view in a few messages ago.  --diff-merges controls
which parent(s) comparison is made against in a merge,
-p/--cc/--raw/--stat etc. control how the result of that comparison
is expressed.

But I also remember that we agreed that the purist view design was
cumbersome to use, so --diff-merges=<anything but no> implying "show
some kind of diff" is OK, plus if nobody says "what kind" via the
command line with -p/--cc/--raw/--stat etc., it is OK to default to
'-p'.

One thing I think our unnecessary "disagreement" comes from is that
among "-m", "--cc", "-c", you say "-m" is the only thing that does
not imply "-p", but I do not view "--cc" and "-c" as sitting next to
"-m" at all in the first place.

"-m" is on the "which parent(s) to compare with" side, while "--cc"
and "-c" are "now you decided which parent(s) to compare with, how
does the result of comparison presented?" side.  And because
"--cc"/"-c" explicitly wants to work on merge commits (because it
naturally degenerates to simple "--patch" for non merges), THEY are
made to imply "-m" (i.e. compare with all parents).

So from my point of view, "--cc/-c" implying "-m" has no relevance
to whether "-m" should or should not imply "some kind of comparison
should be shown".

But because we agreed that we want to bend the purist view for
usability and included cc/c among the choices diff-merges=<choice>
can take, I think -m (but not log.diffMerges=no case) should imply
"we should show some kind of patch".

Which would mean that unless when log.diffMerges or --diff-merges
say off/no, and unless there is any option to specify how the result
of comparison should bepresented on the command line:

 - when log.diffMerges or --diff-merges say cc or c, default to --cc
   or -c.

 - otherwise,default to --patch.

is what I think should happen.  But the reason I think so is not
because "--cc" and "-c" gives output without "-m" (i.e. "-p" does
not imply "-m" and it should not).
