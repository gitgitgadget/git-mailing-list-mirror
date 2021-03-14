Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA840C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAF964EC9
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNCZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 21:25:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58916 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhCNCZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 21:25:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19808114A77;
        Sat, 13 Mar 2021 21:25:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i7PwYb7Bqdae2vtXsdxh8YAHgcI=; b=GlD75E
        iPR1pmAMFoQY+zUEu9lPD9oQRwWr9iO87HZe6Xn9taWMJRYk6v1jccEfSi/Gy2/Y
        24vK4EwHf8FeiuXXGx5xrFeLuitFTj4IIBzleviWW4IHs9F8rVN/gcR5l+sKOeQj
        uY9M2uvM6BhukGSSlWZzUzuVqttWetunO+Yhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eHyqI+Yh3LKcbIOXS2Sz1NQ9EySGHXQ6
        r7zgWtRpugAUQIaaP6QMadFyRBB7l4oMso+tk1KK/U+y4TcTVntBnjGqSBbKV8Mg
        y7GjI8uKz5WxG4+0+QOPBe3CezxWmOL3/CYy1MZs7rwInwNuNFqYsgm5P055surQ
        xix4+b3zO4E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1061B114A74;
        Sat, 13 Mar 2021 21:25:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57370114A73;
        Sat, 13 Mar 2021 21:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210310194306.32565-3-charvi077@gmail.com>
        <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
        <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
        <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
Date:   Sat, 13 Mar 2021 18:25:10 -0800
In-Reply-To: <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 11 Mar 2021 12:07:53 -0500")
Message-ID: <xmqqft0y4gl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 813112BC-846C-11EB-85FB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The one thing that does bother me, however, is the name of the
> function, get_alpha_len(), which tells you (somewhat) literally what
> it does but doesn't convey to the reader its actual purpose (which is
> something we should strive for when naming functions and variables).

I actually think the helper function that is used as a building
block the "subcommand parser" uses should be named more directly
to represent what it does (i.e. look for a run of alphas) than
what it means (i.e. look for a run of letters allowed in a
subcommand name).  IOW

	char *end = skip_alphas(ptr);
	if (*end == ':' && ptr != end) {
		/* 
		 * ptr..end could be a subcommand in 
	         * "--fixup=<subcommand>:"; see if it is a known one
		 */
		*end = '\0';
		if (!strcmp(ptr, "amend"))
			... do the amend thing ...
		else if (!strcmp(ptr, "reword"))
			... do the reword thing ...
		else
			... we do not know such a subcommand yet ...
	} else {
		/* assume it is --fixup=<command> form */
		...
	}

conveys more information to readers than a variant where you replace
"skip_alphas" with "skip_subcommand_chars" without losing any
information.

Yes, in different contexts, where a helpers are designed to be used
by multiple callers that may not even be aware of each other, we do
encourage naming them after what they do _means_.  But in this
codepath, I do not think it applies.

Thanks.
