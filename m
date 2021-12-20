Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EAEC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhLTQU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:20:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63025 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhLTQU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:20:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D449710E0AA;
        Mon, 20 Dec 2021 11:20:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=doAPGMmMNMhW/LBssK7vQpArU8XBTFHlH1vBwX
        S2yaM=; b=lj8ldqnShJQ+/Z08vGmXz2C1WpNgdsRNp+377wrDMOFgM52LN86SRM
        7P4pgW0b6DHIpgYcYNOHcrHaMbfjY0x1Z7JVVlJnftn0et809JSBDWF3nem8OX07
        rVH4ftawxlP0Z9QXVRxR/PPu1R55aJQ4pFssqwShxUFp4WgKSBYSQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB9FD10E0A9;
        Mon, 20 Dec 2021 11:20:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CB3410E0A7;
        Mon, 20 Dec 2021 11:20:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <ttaylorr@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such
 worktrees can fool is_bare_repository()
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
        <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com>
        <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
        <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com>
        <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com>
Date:   Mon, 20 Dec 2021 08:20:26 -0800
In-Reply-To: <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com> (Derrick
        Stolee's message of "Mon, 20 Dec 2021 09:11:38 -0500")
Message-ID: <xmqq5yrjxn79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE12BDDA-61B0-11EC-AEE3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Thanks for this context of added responsibility. It seems a bit strange
> to require this, since it doesn't make any sense to have a bare worktree
> (at least not to me, feel free to elaborate on the need of such a
> situation).

Stepping back a bit, those who want to have two new worktrees
attached to a single bare repository justify the wish by saying that
neither of these two new worktrees should be the primary thing that
they can lose to make the other inoperable, and having a dedicated
"shared object and ref store" repository makes it more symmetric and
safer by making it obvious which one is the precious thing to keep.

Wanting to create two new "bare repository lookalike" attached to a
single bare repository might be defensible the same way.

Not that the current "git worktree" has readily-available features
to create such a layout.  If people who have worked on "worktree"
did not see the possibility of needing such a layout, it is
understandable that such features wouldn't have been designed yet.

Also not that I think that such a layout necessarily makes sense.
