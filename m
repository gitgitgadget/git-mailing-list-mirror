Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAABC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C112075D
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xs81ccHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgFZQDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:03:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58844 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFZQDr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:03:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C281C27BC;
        Fri, 26 Jun 2020 12:03:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jHZGSuvKHJMg3fWdifsdnl9mO0o=; b=xs81cc
        HaKxVxkVtw2w7TVgbVjlQFxdyTw8X+tx+SW1wxxH60+eex+buhLWySOjvAlkOiBG
        uL0hBvEoZRJ5TNiR5jvv/EF451WcWZexccqEt5Rf/6beSNSeIdReLJa58r9wgaq7
        W4VzXQ1ROA0AtAJSZjR12XMuRWiGQmTt5/ZR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XUxFQ8Q1idxYhSIjUSph0CtnByamQB+y
        /KnKiyjmdERCZ5M1kBDtwG7z1x85J1mXu1wCP6fuhNoqgwudUrM8o4UuWPk9MHOI
        1BpRmZjCrnMjbuer8wk9es7h6bywrjaFRSyaDVFG0dVlVlSQ50AVxJQtPhLa1/ua
        OUJTvpO4CD0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53050C27BB;
        Fri, 26 Jun 2020 12:03:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8644AC27B7;
        Fri, 26 Jun 2020 12:03:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] rebase -i: add --ignore-whitespace flag
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200626095528.117524-1-phillip.wood123@gmail.com>
        <20200626095528.117524-2-phillip.wood123@gmail.com>
        <20200626133714.GB12504@danh.dev>
        <78c32f2d-3af6-1514-51a3-1110531cbb88@gmail.com>
Date:   Fri, 26 Jun 2020 09:03:40 -0700
In-Reply-To: <78c32f2d-3af6-1514-51a3-1110531cbb88@gmail.com> (Phillip Wood's
        message of "Fri, 26 Jun 2020 15:43:00 +0100")
Message-ID: <xmqqk0zthl0j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B550716-B7C6-11EA-AA1A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>>   +	if (options.type == REBASE_APPLY) {
>>> +		if (ignore_whitespace)
>>> +			argv_array_push (&options.git_am_opts,
>>> +					 "--ignore-whitespace");
>>> +	} else if (ignore_whitespace) {
>>> +			string_list_append (&strategy_options,
>>> +					    "ignore-space-change");
>>> +	}
>>> +
>> ...
> I wanted to keep the subsequent patches as simple as possible. Having
> to rewrite the if statement in the next patch just clutters it up and
> makes the real changes introduced by that patch less obvious

A set of different behaviour depending on .type is OK, but then at
least the above should be more like this:

	if (options.type == REBASE_APPLY) {
		if (ignore_whitespace)
			argv_array_push(...);
	} else {
		/* REBASE_MERGE and PRESERVE_MERGES */
		if (ignore_whitespace)
			string_list_append(...);
	}

or even

	switch (options.type) {
	case REBASE_APPLY:
		...
		break;
	case REBASE_MERGE:
	case REBASE_PRESERVE_MERGES:
		...
		break;
	default:
		BUG("unhandled rebase type %d", options.type);
	}

That would clarify the flow of the logic better.

Thanks.
