Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FAAC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhLTWMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:12:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64990 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhLTWMk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:12:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 160D4F03F2;
        Mon, 20 Dec 2021 17:12:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s0e94If1KDBmMLsN5IZKFk4EiKl1jOUjYhXXva
        5QS/E=; b=D5L9aB5VO8iZwT1Gcl38E9cRRtjNglFsIVvymI6gHeymLtBxSilc5v
        eYFzSA07lZbiCosq/cakGPfJ/6q8ciXGJCAoz8usZbMJ/qb2XF8G7FInf4uC6ep6
        WzVw4r/XHcmxZ6aR4c5YHGDSOkioR8UXFHb3DDm3ycFc6LPojVdhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D568F03F0;
        Mon, 20 Dec 2021 17:12:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65B67F03ED;
        Mon, 20 Dec 2021 17:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using
 --negotiate-only
References: <20211207192925.67680-1-chooglen@google.com>
        <20211217000235.68996-1-chooglen@google.com>
        <xmqqilvm24bb.fsf@gitster.g>
        <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k73vymp.fsf@gitster.g>
        <kl6lo85byp3b.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 20 Dec 2021 14:12:37 -0800
In-Reply-To: <kl6lo85byp3b.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 20 Dec 2021 12:54:16 -0800")
Message-ID: <xmqqmtkvsz6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F13B04AC-61E1-11EC-A421-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> But maybe I am misunderstanding how Git treats CLI options in general?
> We don't ever really hide CLI options, even if they are only
> internal. There is PARSE_OPT_HIDDEN, but those still show up in usage
> and documentation [1]. So we actually do want users to know about these
> implementation details?

At least they should be told not to use from the command line when
they have no business triggering whatever feature these options
trigger.  

> Presumably, the thought process goes something like this: if we add an
> option, a user *could* find a use for it (or it might accidentally
> conflict with a user's flags), even if we never intended it for end user
> consumption. Thus we need to treat all CLI options with care.

Rather, they can keep both halves ;-)
