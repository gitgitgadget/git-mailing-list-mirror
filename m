Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388ADC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A282072C
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X8+n2ViI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgCMR5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:57:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51577 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMR5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:57:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DACB258871;
        Fri, 13 Mar 2020 13:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMaCGaBm95oJPTnBrjfEeilAP7E=; b=X8+n2V
        iI2a/waZn1YR9XDNzwfvZ9mJy0PjU8r3FNcOPSBfwDMgThJQTkD3tn80PAY24RWn
        w2PeuLRgyZp1Qznn0pagg5Oy2gAiciIyEa5SnGVxpqJdXT56CsU8rgCQ9hNwPYVv
        gqMsWki6+VTQbtEp/o/qFtFt0xYBceEwKOYmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CL6icxplo/Qy6gVmbNKHouk2BqtkHdWF
        x4JilgxOSx9BLq9jD07yncBVZOAGWf1JBP2TtJwisRIIZqKCupnHcD7ZfWttMCfA
        T1aflujax54NFoa1NG1EfGsivjvcEg5Bok7p9e7xxVqKgu1+NaSJ+qqLmtKVwusC
        6U+vOxO87T8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C879B58870;
        Fri, 13 Mar 2020 13:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 304855886F;
        Fri, 13 Mar 2020 13:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
        <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
        <20200312141628.GL212281@google.com>
Date:   Fri, 13 Mar 2020 10:56:59 -0700
In-Reply-To: <20200312141628.GL212281@google.com> (Emily Shaffer's message of
        "Thu, 12 Mar 2020 07:16:28 -0700")
Message-ID: <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09AC2D40-6554-11EA-BC28-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> This means that we could do something like this:
>
> [hook "/path/to/executable.sh"]
> 	event = pre-commit
> 	order = 123
> 	mustSucceed = false
> 	parallelizable = true
>
> etc, etc as needed.

You can do

    [hook "pre-commit"]
	order = 123
	path = "/path/to/executable.sh"

    [hook "pre-commit"]
	order = 234
	path = "/path/to/another-executable.sh"

as well, and using the second level for what hook the (sub)section
is about, instead of "we have this path that is used for a hook.
What hook is it?", feels (at least to me) more natural.

> But I wonder if we also want to be able to do something like this:
>
> [hook "/etc/git-secrets/git-secrets"]
> 	event = pre-commit
> 	event = prepare-commit-msg

Once you start going this route, it no longer makes sense to give
priority (you called it "order") to a path and have that same number
used in contexts of different hooks.  Your git-secrets script may
want to be called early among pre-commit hooks but late among the
prepare-commit-msg hooks, for example.

> I think, though, that something like
> hook.pre-commit."path/to/executable.sh" won't work.

That is why Peff already suggested in the TOPIC notes to use
"command" in the message you are responding to (I used "path" in the
above description).
