Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D48CCA485
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGURaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiGUR3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:29:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF728C145
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:29:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41025135C61;
        Thu, 21 Jul 2022 13:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Md6y0txCI9RG
        56LG0zdLsS2q2jRSKU/hws4vMgenp2E=; b=m9XJoj3Re2tPFBEMksU8+vtS97G8
        DtUOVd8up4vq0x/mM+0pcPzcd5m05I5Hljfs/Ve4oL6b/s/kYkrcg7iwxKSoijhP
        r4uN6AWiq1fRhSIhS1BFsOTiOHHHJRms6hv6k/DcOSGOHW+qPKeTkDJvvygNw8Ws
        ey2Bv/Vr6HqEueM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 344E5135C60;
        Thu, 21 Jul 2022 13:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8018A135C5F;
        Thu, 21 Jul 2022 13:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
        <d58f468d-3826-1aa7-9203-5e1f473159e1@iee.email>
Date:   Thu, 21 Jul 2022 10:29:23 -0700
In-Reply-To: <d58f468d-3826-1aa7-9203-5e1f473159e1@iee.email> (Philip Oakley's
        message of "Thu, 21 Jul 2022 17:06:10 +0100")
Message-ID: <xmqqo7xiidcc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA1213FA-091A-11ED-8BA7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> If one has a plan in place for a series in preparation, I'd want to
> prepare the outline of the cover letter first, and then later let it
> float to the tip of the series after a rebase, and incorporate (meld)
> additional notelets recorded as additional empty commits.
>
> On thought is to marry this with the `rebase --autosquash` mechanism
> that will rearrange commits (when enabled) so that we could have a
> "branchtip! " subject line, similar to the `fixup! / squash!` subject
> lines to assist in that rearrangement=C2=A0 of the series for transmiss=
ion.

Yeah, people have different preferences, and "rebase -i" is probably
a key ingredient to make it work.  As long as the convention to have
topic description at a fixed known place on the topic branch, be it
at the top or at the bottom, is followed in the end result, other
tools like format-patch, am and merge can be written to follow and
take advantage that known structure/topology of the topic branch.

> I'm not yet sure how the "branchtip" method would work with Pull
> Requests and the idea of actually having a push/pull exchangeable branc=
h
> description

I think what I described for "merge" would work well for pull
requests (not the traditional e-mail kind of "please pull" we see on
the kernel mailing list, but the GitHub kind).  Merge the topic
proper, excluding the tip "empty" commit that is there only to hold
the description of the topic, into the history, and use the log
message from the empty commit the procedure discards as the log
message for the resulting merge.
