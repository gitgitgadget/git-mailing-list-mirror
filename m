Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DED1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 13:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfG2Ndk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 09:33:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53282 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfG2Ndk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 09:33:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED56582DB0;
        Mon, 29 Jul 2019 09:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CHhLqKMtUFMbJ0Mh/dM+yDp7nYw=; b=cHeo8j
        wwVVd7jRVVq6ULcbI8OXDA0yVPqfYosk6j5TZvqtFnFli6D7TLOVqebffILekbli
        P8MNcCfeBBc0e8f0CGiwNtkfrJlr0fMyp/sP16oAnVHWQFv34gXFpcfM2WAe+QqM
        02un9VRTlDGIPRc+EBQeM4UXlsKSQpNJlZ+Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qde4AM2TJcZ0JThYCxXSfCnVkgcReX+I
        7lwiGS6KsJgdzcqCm8n43BY2vqYhxYGOQ5EvmS1cjkqPH+XGUuU1h39QPUZaQLfL
        QxTvEyqXxP2bgNLuXn0yu2l/OjqsOVVWLkRvjcSshMbN7S3voKrL9o0tGv1CNjKS
        Vvv0KBmwaf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4D2382DAF;
        Mon, 29 Jul 2019 09:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0203182DAD;
        Mon, 29 Jul 2019 09:33:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Head <bugs@chead.ca>, git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
        <20190729102009.GC2755@sigill.intra.peff.net>
Date:   Mon, 29 Jul 2019 06:33:32 -0700
In-Reply-To: <20190729102009.GC2755@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 29 Jul 2019 06:20:10 -0400")
Message-ID: <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76DC272E-B205-11E9-AAA3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My general feeling is that having multiple push URLs for a remote is a
> poorly designed feature in Git (and I think the discussion elsewhere in
> this thread went there, as well).

That's being generous.  I do not think it was even designed---at
least, the interaction with remote-tracking is ill thought out,
but I think the updating of remote-tracking by pretending to have
turned around and fetched immediately after it has done its thing
came much later than multiple URLs for push.  A remote with multiple
URLs without any remote-tracking (i.e. "push only remote") behaves
semi-sensibly.

> But since we do have it, and if we are not going to deprecate it[1], it
> seems like this case should pick the X value of myremote/mybranch ahead
> of time, and then use it consistently for each push.

I agree but only if the listed ones are separate ones.  If the URLs
are separate paths to reach the same remote (e.g. https:// and ssh://
going to the same place), the current definition would make more sense.
