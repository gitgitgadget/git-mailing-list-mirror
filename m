Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665BEC433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 00:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18701207BC
	for <git@archiver.kernel.org>; Sat, 30 May 2020 00:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOpHGJ3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgE3AW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 20:22:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57246 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3AW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 20:22:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2C1E654BF;
        Fri, 29 May 2020 20:22:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UzoryqD6X3TGaQEx6RyKwG7mmJo=; b=HOpHGJ
        3tjeeTb/qrDyyd8eb/w/09mg6k1Jowo4WmtGSRhXrjrrwoq+xvYUyvtwbzvolGvY
        p4MrnZuvJeMHVqqJjWR/6dWmpjDVC9teAtL+ofsLJ+rZ87wn57tH1Nyp0yTRi7Oo
        SCQ8NnL2gKNmz/84HwyoyC/ajwYwDL1QYXeIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AGpBXv2EnAwVFPtvZtJHAFveiKsVOTuw
        pUGdoqj//ByrM9h/JnUEiTrn0+qssTcP2lV1meMBjifWJOuCtckqmzrlsMM1e0X5
        8W/jDseNVmDyIGfhuAw9vBU6EH8YcvWDLWSQUWBv9xJjbFHVJv/yaCbuMmLTDNCx
        nx+hKpgMQS8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA92B654BE;
        Fri, 29 May 2020 20:22:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23790654BB;
        Fri, 29 May 2020 20:22:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
References: <cover.1590789428.git.jonathantanmy@google.com>
        <4eea9d927af1df11cdb0342e969b293a6e317d46.1590789428.git.jonathantanmy@google.com>
        <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
Date:   Fri, 29 May 2020 17:22:23 -0700
In-Reply-To: <xmqq5zcexoqi.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 29 May 2020 17:15:01 -0700")
Message-ID: <xmqq1rn2xoe8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A26DB8DE-A20B-11EA-9716-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In practice, I suspect that these fetches would go in parallel with
> the processing of the in-protocol packfile, but spelling it out as
> if these are done sequencially would help establishing the right
> mental model.  
>
> "(1) Process in-protocol packfiles first, and then (2) fetch CDN
> URIs, and after all is done, (3) update the tips of refs" would
> serve as a base to establish a good mental model.  It would be even
> better to throw in another step before all that: (0) record the
> wanted-refs and CDN URIs to the safe place.  If you get disconnected
> before finishing (1), you have to redo from the scratch, but once
> you finished (0) and (1), then (2) and (3) can be done at your
> leisure using the information you saved in step (0), and (1) can be
> retried if your connection is lousy.

We need to be a bit careful here.  After finishing (0) and (1), the
most recent history near the requested tips is not anchored by any
ref.  We of course cannot point these "most recent" objects with
refs because it is very likely that they are not connected to the
parts of the history we already have in the receiving repository.
The huge gap exists to be filled by the bulk download from CDN.

So a GC that happens before (3) completes can discard object data
obtained in step (1).  One way to protect it may be to use a .keep
file but then some procedure needs to be there to remove it once we
are done.  Perhaps at the end of (1), the name of that .keep file is
added to the set of information we keep until (3) happens (the
remainder of the set of information was obtained in step (0)).

