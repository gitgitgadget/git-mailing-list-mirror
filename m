Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A847EC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDA22067B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BUOaSDYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFCT2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:28:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51499 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCT2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 15:28:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D321DE431;
        Wed,  3 Jun 2020 15:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sZ1WfqB0vqSjQeIzi/+STTuERes=; b=BUOaSD
        YTKdvKVE2zJSreI8x0Tjt9fYwPK0nNO5+z7tmjDUfkczY44RXvtaiZRYJlt9eIho
        cXV38yTEAyrL63ELkpRtbxthKnHYLWl3F4aVaew2XWyt/Wm6rZh5QIfXEdEEiQ2b
        GAn/bzuz+2oBwPRH+HSEhudeS6AG+sZIHBDQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BOSr6SEot9MUiGL9lIm3InPiCrVB7KG2
        6IUuGCitKSCJhhh/Vu11+zsjSgV1k2IQoS/Nr8DflGgSi0DvI3iwHKaX4F5DRk+m
        urpmnq2oVJOITDmRD8nVVWucLYj5OGWUoU0jalDiIc6uCTqchJSjSIxc2kTD0uC8
        8WAz+T+H7vI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 351C3DE430;
        Wed,  3 Jun 2020 15:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73253DE42D;
        Wed,  3 Jun 2020 15:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kalle Kromann <kalle.kromann@man-es.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: The commit-msg hook is not invoked by git-merge as specified in documentation
References: <AM0PR08MB55379DD182941E93F3BD3D37D7880@AM0PR08MB5537.eurprd08.prod.outlook.com>
Date:   Wed, 03 Jun 2020 12:28:09 -0700
In-Reply-To: <AM0PR08MB55379DD182941E93F3BD3D37D7880@AM0PR08MB5537.eurprd08.prod.outlook.com>
        (Kalle Kromann's message of "Wed, 3 Jun 2020 12:46:27 +0000")
Message-ID: <xmqq367crlti.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CAD2D52-A5D0-11EA-BFAC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kalle Kromann <kalle.kromann@man-es.com> writes:

> For reference, the prepare-commit-msg hook works with both commands as expected.
>
> Is there something subtle I'm overlooking?

On what platform, and which version of Git are we talking about?
What is the difference between these two hooks?  I.e. perhaps

    $ ls -l .git/hooks/prepare-commit-msg .git/hooks/commit-msg

tells you some subtle differences between the two?

> Of course a fast forward merge should not invoke the commit-msg
> hook, because no commit is made.  But in my tests with non
> FF-merges the hook is still not invoked.

Other than the last one, nothing comes to my mind.  And it does not
reproduce for me.

I just did this:

    $ echo exit 1 >.git/hooks/commit-msg
    $ chmod +x .git/hooks/commit-msg
    $ git checkout master^0
    $ git merge ds/line-log-on-bloom
	    ... editor launches and I save the message ...
    Auto-merging revision.c
    Auto-merging line-log.c
    Auto-merging bloom.h
    Auto-merging bloom.c
    Not committing merge; use 'git commit' to complete the merge.

The last line comes from builtin/merge.c::abort_commit(), which is
called from this piece of code in builtin/merge.c::prepare_to_commit()

	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
			    git_path_merge_msg(the_repository), "merge", NULL))
		abort_commit(remoteheads, NULL);
	if (0 < option_edit) {
		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
			abort_commit(remoteheads, NULL);
	}

	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
					  "commit-msg",
					  git_path_merge_msg(the_repository), NULL))
		abort_commit(remoteheads, NULL);

I do not have prepare-commit-msg, and my launch_editor() thing
successfully returned, and the call to abort_commit() is cleraly
coming from the last line, where run_commit_hook() noticed that the
commit-msg hook ran and reported a failure.

After this, I did this to just confirm:

    $ echo exit 0 >.git/hooks/commit-msg
    $ git reset --hard
    $ git merge ds/line-log-on-bloom

This time, instead of "Not committing...", I got

    Merge made by the 'recursive' strategy.

followed by the usual diffstat.

The above demonstrates that commit-msg does run well enough to cause
its exit status affects the outcome in both cases.

For fun, I tried another.

    $ echo exit 1 >.git/hooks/commit-msg
    $ chmod -x .git/hooks/commit-msg
    $ git reset --hard master
    $ GIT_EDITOR=: git merge ds/line-log-on-bloom
    Auto-merging revision.c
    Auto-merging line-log.c
    Auto-merging bloom.h
    Auto-merging bloom.c
    hint: The '.git/hooks/commit-msg' hook was ignored because it's not set as executable.
    hint: You can disable this warning with `git config advice.ignoredHook false`.
    Merge made by the 'recursive' strategy.
    ... diffstat follows ...

So...

