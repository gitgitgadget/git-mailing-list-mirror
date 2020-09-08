Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06BDC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1122075A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2H87O3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIHWxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:53:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53052 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgIHWxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 18:53:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A1E6EFC63;
        Tue,  8 Sep 2020 18:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kI8q36gbIB3o6C8e8OCuAvyOgPI=; b=F2H87O
        3AHIDZcTPIk+FDw5qTl2zZBIRXWbiL/cBE1mPokMWi5O8nvcPMjuFrdVs8OSJaJf
        y9E7nomBYjSh3sYY8EBBwMS+Rqmctm/2lh+Xtdqvnt+nzC1HO4S+v7ZjbqGbrXR7
        66C3tdyGrQcRXIkIrZIP5RH4HndYH/uFcoMIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lDhOexHtimdcoE73VdicSWwgpbRuYNRI
        NA5nHslmJk0gPiuS6VTXzv/EhAaGhgn07DlK8kJZ3v3W1jvJ6Ev/3WoC4U4FGs5q
        bNsiEIGK4pevS7JQ71oAJAwa3VOUZ3TmMbzvu0QV5dLDRHPHIR0Fleyw3353lzF7
        KXYvpTtC9G4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0327FEFC62;
        Tue,  8 Sep 2020 18:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48CF6EFC61;
        Tue,  8 Sep 2020 18:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Better threaded delta resolution in index-pack (another try)
References: <cover.1598296530.git.jonathantanmy@google.com>
        <cover.1599594441.git.jonathantanmy@google.com>
Date:   Tue, 08 Sep 2020 15:53:34 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 8 Sep 2020 12:48:28 -0700")
Message-ID: <xmqqk0x3x4lt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20EA686E-F226-11EA-95F3-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Here's the reroll.
>
> [1] https://lore.kernel.org/git/xmqqk0xa8rvn.fsf@gitster.c.googlers.com/

It seems that the only changes (as expected) are squashing in the
follow-up "oops" fixes into the right place in the series?

Will replace; thanks.


>
> Jonathan Tan (7):
>   Documentation: deltaBaseCacheLimit is per-thread
>   index-pack: remove redundant parameter
>   index-pack: unify threaded and unthreaded code
>   index-pack: remove redundant child field
>   index-pack: calculate {ref,ofs}_{first,last} early
>   index-pack: make resolve_delta() assume base data
>   index-pack: make quantum of work smaller
>
>  Documentation/config/core.txt |   2 +-
>  builtin/index-pack.c          | 456 +++++++++++++++++++---------------
>  2 files changed, 251 insertions(+), 207 deletions(-)
