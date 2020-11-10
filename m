Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D7C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EDB20809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKy4+v7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKJTmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:42:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55316 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJTmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 14:42:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79F25106BB6;
        Tue, 10 Nov 2020 14:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oITn5wJ5JMj/swRoLmhQaXPzFVI=; b=FKy4+v
        7LkQLU3idNSihqdIJqnBxfqrceocHtV4DeZpTcQQMvx+Qdgmb1MsLE+0QSP7wNjd
        GVFwcNopVFgm14CgTPfgngj7Suxl3YDzYHaXRE/ZFN99/stC089Od9lpyDi0UUkV
        33dCnZL7YNk9rC0jTRxXw17LyWdw3PeVFvJfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gAPoqfnzvK4+oV3Om5UvFs4SKad+/xXd
        EOFh3aHF/JLpySdKKfXKtykWZtE+c9MK204zwjeZ8GRSDT+tq9XNU9aB6CuZ8hMb
        rWtSwhnEQcmrIbJIESss1QRhcI0KHdfyL5k+q6PwT5aFcqUoVNerjEVBWXgAMSEq
        zHbWKf+Y8RQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72593106BB5;
        Tue, 10 Nov 2020 14:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B55B1106BB1;
        Tue, 10 Nov 2020 14:42:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jinoh Kang <luke1337@theori.io>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] diff: make diff_free_filespec_data accept NULL
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
        <xmqq4km4lppy.fsf@gitster.c.googlers.com>
        <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
        <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
        <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
Date:   Tue, 10 Nov 2020 11:41:59 -0800
In-Reply-To: <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io> (Jinoh Kang's
        message of "Tue, 10 Nov 2020 14:06:56 +0000")
Message-ID: <xmqqpn4l6ltk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD0DBF28-238C-11EB-968A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jinoh Kang <luke1337@theori.io> writes:

> Today, diff_free_filespec_data crashes when passed a NULL pointer.

No need to say "Today".  We state how things are in the current
codebase in the present tense, make observations on the way things
can break (i.e. identify a bug), and outline an approach to correct
it.

> Commit 3aef54e8b8 ("diff: munmap() file contents before running external
> diff") introduced calls to diff_free_filespec_data in run_external_diff,
> which may pass NULL pointers.
>
> Git uses NULL filespecs to indicate unmerged files when merge conflict
> resolution is in progress.  Fortunately, other code paths bail out early
> even before NULL can reach diff_free_filespec_data(); however, difftool
> is expected to do a full-blown diff anyway regardless of conflict
> status.
>
> Fix this and prevent any similar bugs in the future by making
> `diff_free_filespec_data(NULL)` a no-op.

Nicely described.

> Also, add a test case that confirms that running difftool --cached with
> unmerged files does not SIGSEGV.

> +test_expect_success 'difftool --cached with unmerged files' '
> +	test_when_finished git reset --hard &&
> +	echo base >file &&
> +	git add file &&
> +	git commit -m base &&
> +	git checkout -B conflict-a &&
> +	git checkout -B conflict-b &&

The above two are not wrong per-se, but would conceptually be
cleaner to use "git branch -f", because the next thing you do
immediately after preparing two branches is to start working on the
'A' side, below.

You could alternatively drop the above two lines and then instead
turn this

> +	git checkout conflict-a &&

into "git checkout -B conflict-a master" (and similarly on the 'B'
side below), which would reduce the test by two lines.  That would
be what I would recommend to do under normal circumstances, but
since there is a separate topic that wages war on the 'master'
branch, I wouldn't recommend it.

> +	echo conflict-a >>file &&
> +	git add file &&
> +	git commit -m conflict-a &&

> +	git checkout conflict-b &&
> +	echo conflict-b >>file &&
> +	git add file &&
> +	git commit -m conflict-b &&

> +	git checkout master &&
> +	git merge conflict-a &&
> +	test_must_fail git merge conflict-b &&

> +	: >expect &&
> +	git difftool --cached --no-prompt >actual &&
> +	test_cmp expect actual

Shouldn't we omit 'expect' and use test_must_be_empty helper
instead?

	git difftool --cached --no-prompt >actual &&
	test_must_be_empty actual

> +'
> +
>  test_expect_success 'outside worktree' '
>  	echo 1 >1 &&
>  	echo 2 >2 &&
