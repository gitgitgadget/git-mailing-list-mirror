Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4040FC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA5E20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rdnZb62D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbgKJXOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:14:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51416 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJXOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:14:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ECDF10815A;
        Tue, 10 Nov 2020 18:13:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V2dDT4FRyBybZ+sZ+a5RxvMTkh8=; b=rdnZb6
        2DU0MLs6NJcve5gw4FGvjvF3jdiFsyffzyaECKOZ4O3J5aXWkUeZOSxLS58tduol
        XWX4WuTFbhsZsy9iQy9EFblPu1jalkfPEBtrL7ZsFABx355h/v74BYDzPvBthfXH
        N3ERX5Y3Xa1/e/aLtldvlWukx+WSKX3oRjaTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sAf1CkAM9rFsb7ii3vQNq0wUzxr8FI4W
        +K/RJJbJTZev8OvYaWdkDMuTnqEZULvU4yiFqE1HmzAs4C0aPoC+JAtH5syOkU2h
        i43jnu0fKLDnSRQp4HXUAAGU2psuwWPlJr+woo/S1iOs9P/cR/GbFgeaYuCLowwn
        N57cMbteT+E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7799E108159;
        Tue, 10 Nov 2020 18:13:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C157E108158;
        Tue, 10 Nov 2020 18:13:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Johannes.Schindelin@gmx.de
Subject: Re: format-patch: "magic" mbox timestamp
References: <CAETBDP6d8UwiJEF_pX0p=xLG79pwHeEtectmOnjPiUpjUCPaqw@mail.gmail.com>
Date:   Tue, 10 Nov 2020 15:13:54 -0800
In-Reply-To: <CAETBDP6d8UwiJEF_pX0p=xLG79pwHeEtectmOnjPiUpjUCPaqw@mail.gmail.com>
        (Brandon Richardson's message of "Tue, 10 Nov 2020 17:54:47 -0400")
Message-ID: <xmqqmtzo6c0d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6868FA06-23AA-11EB-A18A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Richardson <brandon1024.br@gmail.com> writes:

> Please correct me if I'm wrong, but I'm assuming the "UNIX mailbox
> format" referenced in the docs refers to the mbox database format
> described in appendix A of RFC-4155. If so, since we use a commit id
> in place of the sender email address, would that itself be sufficient
> to indicate that the output isn't from a real mailbox? A commit id
> will never match the addr-spec in RFC-2822, so I figure that anyone
> looking at `format-patch` output could safely assume that it did not
> originate from a mailbox.

I vaguely recall that it was possible for the "From" line that
begins each message in a UNIX mbox had a local sender without "@",
so it would be a bit wider than addr-spec and a string of raw
hexadecimal digits would not sufficiently "strange" enough to serve
as a "magic" identifier.

