Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303FC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BDC20754
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y39Yd1I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRTzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:55:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58521 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRTzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 15:55:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C681FB98EE;
        Wed, 18 Mar 2020 15:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oj8HSt2uc5VSbFCDZeo8WRjKbGw=; b=Y39Yd1
        I6KQrxrsGFPIRDTt29LQu6aYMOep+KBRVsGEOoTPg+6EMKAB+1upnR5WCjMVDU3k
        m3/lCvppwwEWyoo7BaXFMpGmLfxrTVCNSHIsBNrTMUlfDiY7RBOHtrs1qFn/6g3Z
        BgPvpUyGXK8wSZuGaEHcpZHKudx5VVDd9LXsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iFHoIRRyj5ebalDwlxpElLuN4LHFFkQV
        w0ZOF069f7ODUpvINGtCm9YS2w0P4f6KqyvbqODrLdVb4xiC+y+qCbwZhzAgWS0P
        g+9Mext2L0S77IHH3KsYHb6/qktmpR4O7x2Bq+Ccqs8JT23g8PhtU8A1p5lC6y2Y
        Cn0xRxR/bfA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE7C9B98ED;
        Wed, 18 Mar 2020 15:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA56FB98EB;
        Wed, 18 Mar 2020 15:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        newren@gmail.com
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
References: <xmqqpnd9fql0.fsf@gitster.c.googlers.com>
        <20200318192821.43808-1-jonathantanmy@google.com>
Date:   Wed, 18 Mar 2020 12:55:09 -0700
In-Reply-To: <20200318192821.43808-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 18 Mar 2020 12:28:21 -0700")
Message-ID: <xmqqd099fnfm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6028F4BC-6952-11EA-BF65-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Hmph, what was it called earlier?  My gut reaction without much
>> thinking finds --no-skip-* a bit confusing double-negation and
>> suspect "--[no-]detect-cherry-pick" (which defaults to true for
>> backward compatibility) may feel more natural, but I suspect (I do
>> not recall details of the discussion on v1) it has been already
>> discussed and people found --no-skip-* is OK (in which case I won't
>> object)?
>
> It was earlier called "--{,no-}skip-already-present" (with the opposite
> meaning, and thus, --skip-already-present is the default), so the double
> negative has always existed. "--detect-cherry-pick" might be a better
> idea...I'll wait to see if anybody else has an opinion.

While "--[no-]detect-cherry-pick" is much better in avoiding double
negation, it is a horrible name---we do not tell the users what we
do after we detect cherry pick ("--[no-]skip-cherry-pick-detection"
does not tell us, either).  

Compared to them, "--[no-]skip-already-present" is much better, even
though there is double negation.  

How about a name along the lines of "--[no-]keep-duplicate", then?

>> I also wonder if --detect-cherry-pick=(yes|no|auto) may give a
>> better end-user experience, with "auto" meaning "do run patch-ID
>> based filtering, but if we know it will be expensive (e.g. the
>> repository is sparsely cloned), please skip it".  That way, there
>> may appear other reasons that makes patch-ID computation expensive
>> now or in the fiture, and the users are automatically covered.
>
> It might be better to have predictability, and for "auto", I don't know
> if we can have a simple and explainable set of rules as to when to use
> patch-ID-based filtering - for example, in a partial clone with no
> blobs, I would normally want no patch-ID-based filtering, but in a
> partial clone with only a blob size limit, I probably will still want
> patch-ID-based filtering.

Perhaps.  You could have something more specific than "auto".  The
main point was instead of "--[no-]$knob", "--$knob=(yes|no|...)" is
much easier to extend.  I simply do not know if we will see need to
extend the vocabulary in the near future (to which you guys who are
more interested in sparse clones would have much better insight than
I do).

Thanks.
