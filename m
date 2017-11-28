Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E65A20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 04:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdK1EEJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 23:04:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55452 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751658AbdK1EEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 23:04:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2387C1E28;
        Mon, 27 Nov 2017 23:04:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q9+IO77JpdHGbuDzLyXYxE7eOk0=; b=l5AJWT
        3PgW58sGC/LnAQCD6Q9vsM0K1c2xXg8wZwihtPegLZRJ9iUDoyqmzNyWE+VJk7KL
        qI3Hbi14QA+N5V13KTzv5bA1X9wggDLFZTIz6yA1Zp5bm+d54lwPXQWrOxZf8Wva
        44ztIOl8g6vsMUm1IkfLy2nHqcN94OqCIi/3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kwlz4BKE86ZV+Wfp2KVmSA7NDxRxAkjI
        97PE2FcUNC6sF7G68Pn10fw7wtYOxzV2GS9O695qE9dxGzk6bz8wGWmTCNnkpkVv
        Do1IDoRaPt8jy6OwnLRo3rYKq3y+/Bmml9EFL5oTu5nQ6uVJ9V42nHn9xJkyAm3H
        jPi7Ns9cvOo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA9C4C1E27;
        Mon, 27 Nov 2017 23:04:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52D04C1E24;
        Mon, 27 Nov 2017 23:04:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2] builtin/worktree: enhance worktree removal
References: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
        <20171127173621.6707-1-kaartic.sivaraam@gmail.com>
        <xmqq7eub85rz.fsf@gitster.mtv.corp.google.com>
        <CAPig+cT3jbZ=VRWpggw_tvegAGnjGQ0Mxp8m2DdKKPhfKTVEWA@mail.gmail.com>
Date:   Tue, 28 Nov 2017 13:04:06 +0900
In-Reply-To: <CAPig+cT3jbZ=VRWpggw_tvegAGnjGQ0Mxp8m2DdKKPhfKTVEWA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 27 Nov 2017 22:48:43 -0500")
Message-ID: <xmqqy3mr6ocp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E2FF5F8-D3F1-11E7-8C0A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> With this approach, validate_worktree() will print an error message
> saying that the worktree directory is missing before the control info
> is actually removed. Kaartic's original patch silenced the message
> (and _all_ error messages from validate_worktree()) by passing 1 as
> the second argument. That seemed heavy-handed, so I suggested keeping
> the validate_worktree() call as-is but doing the directory-missing
> check first as a special case.
>
> But perhaps that special case isn't necessary.

I do not think the user minds to see "there is no such directory
there"; actually that would be beneficial, even.

But you are right; validate_worktree() would need to become aware of
the possibility that it can be passed such a "corrupt" worktree to
handle if that approach is followed.

The case we are discussing, i.e. the user removed the directory
without telling Git to give it a chance to remove control
information, may be common enough that it becomes a worthwhile
addition to make the "quiet" boolean that occupies a whole int to an
unsigned that is a collection of bits, and pass "missing_ok" bit in
that flag word to the validate_worktree() to tell that the caller
can tolerate the "user removed it while we were looking the other
way" case and can handle it gracefully.  But that would be a lot
larger change, and "the caller checks before calling validate" as
done with this [RFC v2] may be a good way to add the feature with
the least impact to the codebase.

> I had envisioned a simple 'goto remove_control_info' rather than extra
> nesting or refactoring, but that's a minor point.

Yes, use of goto is also a good way to avoid having to worry about
the future evolution of the codeflow in this function.

So perhaps

	if (the directory is no longer there)
		goto cleanup;
	if (the worktree does not validate)
		return -1;
	... the original code to (carefully) remove the 
	... worktree itself

	cleanup:

	... remove control info
	... free resources held in variables
	... return from the function

is what we want?

In any case, I think this needs thawing nd/worktree-move topic
before it can move forward, as all the functions we discussed in
this thread are the ones that were introduced in that topic and do
not exist in the mainline.

