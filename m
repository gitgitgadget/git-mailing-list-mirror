Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2695E1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 03:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfJ1DhN (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 23:37:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57422 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfJ1DhN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 23:37:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44E6F97A5E;
        Sun, 27 Oct 2019 23:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dRgpe8f+tgBCAa7kVuaP32gCrlc=; b=v5HCgU
        fa/In3FsYHYMCSVQZp2L7p3kXAEg9h7au1rqwZqSK4wu4qmHZzIdifviaLKxvdVo
        O82MXXNf7eFA0TjC4EPokWOzwcF/0A/kYQM1fS9Q5IT8Gg6DQM4x5+AN/cCkZEPI
        udl9c9YS+UqKCkA8brxzfNyKHAsJxVFrimBP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YmHgIY6VcqKfAlqkvBU6tO3zJ119SChG
        iVi9LTpj419cPY0KDLRJJIEuaWYzq/rAPpQmc23CnJxaFIx+Ju525r1D1yerkUp0
        5TD6JRe0f1pBP30kjxLPCS42+OtIFH/FtJ01023FMHNjQFXye3QBdGZ1OK/VWauU
        UFuzZjeoeBs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E25397A5D;
        Sun, 27 Oct 2019 23:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E12B97A5C;
        Sun, 27 Oct 2019 23:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>,
        Utsav Shah <utsav@dropbox.com>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
        <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 12:37:06 +0900
In-Reply-To: <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
        (Utsav Shah via GitGitGadget's message of "Fri, 25 Oct 2019 15:23:28
        +0000")
Message-ID: <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37FFBF7C-F934-11E9-8C9A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Utsav Shah <utsav@dropbox.com>
>
> git stash runs git reset --hard as its final step, which can be fairly slow on a large repository.
> This change lets us skip that if fsmonitor thinks those files aren't modified.
>
> git stash goes from ~8s -> 2s on my repository after this change.

Please line-wrap overlong lines.

More importantly, "stash" may be a mere symptom that does not
deserve this much emphasis.  What you improved directly is "git
reset --hard" isn't it?

    The fsmonitor may know that a path hasn't been modified but 
    "git reset --hard" did not pay attention to it and performed
    its own check based on ie_match_stat(), which was inefficient.

or something like that?

>  	if (old && same(old, a)) {
>  		int update = 0;
> -		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
> +		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
> +		    !(old->ce_flags & CE_FSMONITOR_VALID)) {

I wonder if !ce_uptodate(old) should say "this one is up to date and
not modified" when CE_FSMONITOR_VALID bit is set.  Are there other
codepaths that use ce_uptodate(ce) to decide to do X without paying
attention to CE_FSMONITOR_VALID bit?  If there are, are they buggy
in the same way as you found this instance, or do they have legitimate
reason why they only check ce_uptodate(ce) and ignore fsmonitor?

If there isn't, would it make sense to get rid of CE_FSMONITOR_VALID
bit and have fsmonitor directly set CE_UPTODATE bit instead?  That
would make this fix unnecessary and fix other codepaths that check
only ce_uptodate() without checking fsmonitor.

