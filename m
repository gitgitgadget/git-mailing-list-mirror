Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D2C47082
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ECB610A0
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhFABez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 21:34:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55302 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhFABez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 21:34:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4359144704;
        Mon, 31 May 2021 21:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=czc4TpXc2MCcSXkvvMMND3M8leOAoXc7wKZEL+
        1AwUs=; b=m62dIy3E3UJXCkU+JCc24vwvicwYq0H16tvNb2dQyBQtpwMxhjFGSQ
        A+bNRaDmrlZuOplSbg7WC8svyYYnbfpY1Vp8m9WW1n7cyG5aqdvnzmNtSEGTL+sV
        ScxrTTEtSHuziNoGu4z5db662PMkvrDIHG76hpEdnod+FCNl4gm5c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D33D144703;
        Mon, 31 May 2021 21:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8992144702;
        Mon, 31 May 2021 21:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     AndyAo <zen96285@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to disable Git from automatically identifying and managing
 embedded git repositories?
References: <c4d32a7b-94c5-b613-ae5e-9c18b1ffa627@gmail.com>
Date:   Tue, 01 Jun 2021 10:33:10 +0900
In-Reply-To: <c4d32a7b-94c5-b613-ae5e-9c18b1ffa627@gmail.com> (AndyAo's
        message of "Tue, 1 Jun 2021 08:26:54 +0800")
Message-ID: <xmqqczt6v06h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53EB095C-C279-11EB-81B6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AndyAo <zen96285@gmail.com> writes:

> When I upgraded Git from 2.24.1.windows.2 to 2.29.2.windows.2, I
> noticed that the embedded git repository is recognized in `git
> status`, and if I use `git add .` will manage the embedded git
> repository directly as a submodule, instead of just ignoring them,
> which is the behavior I want.
>
> How do I turn this off?

You can use the ignore mechanism to exclude it and "git add ." would
not touch it.

In my checkout of the git repository, I have a separate copy of the
same git repository and checked out at the path "Meta/".  In the
upper-level repository, I have "/Meta" in .git/info/exclude (among
other private-ignore patterns), and that would keep it out of the
main repository's index even with "git add ." (not that I'd ever use
"add everything", which I do not think have any place in my
workflow).  This is done without using .gitignore because it is
nobody else's business that I use such a "strange" setup and use the
pathname "Meta/" for it (hence project participants do not have to
know about it).
