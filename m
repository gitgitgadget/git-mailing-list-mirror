Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539FC2BBCA
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC3F23AFE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgLIESx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 23:18:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54600 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLIESv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 23:18:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C0AEFA473;
        Tue,  8 Dec 2020 23:18:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IIsuOrPqUcYv+CZb+R4jmFZVXvc=; b=jLCPhd
        r8qBG/35KCSlETdq8Gg5fkQusri/A0dZ7ovOcfvZcMQRpADF1KgzpJtMa+6BVwjc
        7JncULvByxm3MGZLFIrQ54Md90hHAP+4Ky4VyrkkrUYPzPiAr2ni87dljtvokmwc
        Q1AJ62MBuvJ3i+HlTQskaZc0iYqnt6iOmCMjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jSVh/lYzBQz/UaKPkpBBZCx6AAOOeQnb
        lTX0SniCCvBBJvnbpXVUN3eee21Uf1tUULR3QzVGw8oTqJ2X9ok9mmJXlezmEFlZ
        waPQoQLP+O1htBvpzMWwlCoyl/Uog9BOoI52uH1QfUeDLtpqwDmvf3WOSVD0gD2b
        lsn0AoOOHCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBBF3FA470;
        Tue,  8 Dec 2020 23:18:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B231FA46F;
        Tue,  8 Dec 2020 23:18:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
Date:   Tue, 08 Dec 2020 20:18:03 -0800
In-Reply-To: <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 19:31:04 -0800")
Message-ID: <xmqq360f4npg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88D2F616-39D5-11EB-8EB4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> If I can run "git log --some-options master..next" (or more
>> realistically, over the range ko/next..next) to get individual
>> commits (without patch) and merges (only when --cc gives some
>> interesting nearby-changes), I would be very happy.  But is there a
>> set of options that lets me do so?
>
> So, you're saying you changed your mind since five years ago?[1]  Or
> that what you said five years ago is still valid, but you'd appreciate
> more/different options that allow this new thing?
>
> [1] https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/

Sorry, but I am not seeing in [1] anything that relates to the above
"want to see --cc patch for merge but just log message for single
parent commit". 5 years is a long time even in Git timescale, so I
would not be surprised if I changed my mind over time, but I am not
sure what opinion on the matter you think I expressed back then.

"git log --cc master..next" shows all commits' log messages, patch
for each single-parent commit, and combined-dense patch for each
merge.  There is no option to squelch the patch for only single
parent commits.  It may not be such a bad thing to have as an extra
option.

So, I think what I am saying is that ...

> > ...  As I said, I'm not sure why
> > anyone would ever want to see diffs for merges and not for normal
> > commits, the closest useful thing I can imagine is commit messages +
> > diffs for just merges, stripping the normal commits.

... I see use for such a feature (assuming that you didn't mean by
"diffs for merges" a regular "--first-parent -p" patch, but meant to
say "--cc" patch) in my workflow.  I'd review "log ko/next..next"
before deciding to push out the day's integration of 'next', and at
that point, I trust individual commits that came from contributors
well enough (otherwise I wouldn't be merging them to 'next'), but I
would appreciate the last chance to re-examine conflict resolutions
in merges.

It does not mean that I do not like the current behaviour that
"--cc" always implies "-p"; it is convenient.  It's just I find the
lack of feature slightly less than ideal, but I do not care deeply
enough to design how to express such a feature from the command
line.
