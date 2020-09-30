Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E0C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F52421481
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LcYa0s9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgI3Xxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:53:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51672 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3Xx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 19:53:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8786489880;
        Wed, 30 Sep 2020 19:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iihezpln/nflNu4zHMZ+IxmRG1s=; b=LcYa0s
        9WfOtRyhxGWE0B3LAC4AN/0j2zmUi+/IPsnoWU8YvL6hqjMsaCxQ20IavN40eS0w
        +8NpBu3qRHf7i1KqyvUj7XxDp9LKALGffrIybQnPTpqnivc31hc8RkkeRrXkz50l
        f1R9wlrJAtCF7EZ/5zLdfYuDipMoa959YgNLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G4wiPTw6vrj2dS7/Oa9U7BXZv72mYsJa
        0gWyLI712rM1Nt3vXvrJyNisbLQp2Lk/CJVksw/0Ys2UV714C/8fNVxuJ8U8a2U5
        GWxpH0s/bFMygyWL5JVsTmmXE+TswmfF3VXU7b9vJ7xuPAo8BZ3YVRI0maFcZsEZ
        6mSKyW/P2tI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 791428987F;
        Wed, 30 Sep 2020 19:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE7ED8987E;
        Wed, 30 Sep 2020 19:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
Date:   Wed, 30 Sep 2020 16:53:26 -0700
In-Reply-To: <20200930232138.3656304-1-shengfa@google.com> (Shengfa Lin's
        message of "Wed, 30 Sep 2020 23:21:37 +0000")
Message-ID: <xmqqlfgqes95.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 223783F6-0378-11EB-89A3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

> Discussed with Jonathan and Junio regarding whether we should support
> letting user specify timezone or restricted to UTC only. There was no
> defnite conclusion.

I do not think was involved in that part of the discussion to
consider UTC vs custom zone, though.

What I said is that git () { TZ=UTC command git "$@" } is simple
enough that I doubt it is worth the engineering effort to either
read configuration file early (which is tricky) so that setenv() can
be done early in cmd_main() and/or audit the codebase widely enough
(which is time consuming) to make sure that we pay attention to the
configuration variable in all codepaths that matter to do the
setenv().

