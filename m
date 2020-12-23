Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A6C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF44224BE
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgLWX6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:58:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52426 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLWX6C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:58:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6571AB78A;
        Wed, 23 Dec 2020 18:57:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8tervf0q5ayEr2zsOb8edH28K6E=; b=TGs1xs
        YqKckmLUxA+Lr/Tv6bp0mtr24KUF2jNgsJxLuEvfkpAYB5gCq9zqKXGOiuFwgJ8d
        RoifkROrirVsZpvUF2rYlVDmX18dLrGe1DsWM2bdKxY2YVgTE7hfDxd7LJAmjVgl
        jpsiKLcRyj6gxID9ydsN2ugFSCLXXYW7zLdbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LYw/m0/ykTdm+2VDOA6/+8k0VSN3GL2l
        j910eu5Gh5L4M7TWY1AkpZj6BwAWpmLilAlFCtnao8Zz3FRq9GHyBHU43sQz8g4W
        VXFnUlW57PPgJPGhKqKrtdv/5pMiakgaQ3Pm/4JsTOmvWeMsLk88KhBaavMz6aq1
        TY0+V82siVc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A461AB789;
        Wed, 23 Dec 2020 18:57:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D47E6AB788;
        Wed, 23 Dec 2020 18:57:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
        <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
Date:   Wed, 23 Dec 2020 15:57:18 -0800
In-Reply-To: <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
        (Mike McLean's message of "Wed, 23 Dec 2020 23:08:58 +0000")
Message-ID: <xmqqczz05b4x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97229356-457A-11EB-846A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike McLean <stixmclean@googlemail.com> writes:

> Can we have a similar convenience-command that squashes, and retains
> the second commit's message? Purpose is the same as the fixup command
> - saving a bit of time and unnecessary typing during a common
> operation.

We can view "fixup" as a slight variant of "squash" that gives us
the right tree by applying the change in the second commit while
reusing the message from the first commit, and the reason why its
existence makes sense is because it often happens that users find
small mistakes in the committed content that needs "fixing up" but
the small mistakes do not change the intent of the original change
so the message does not need any "fixing up".

It also often happens that users find small mistakes in the log
message text that needs "fixing up", but there is no need to change
the committed content (iow the recorded tree object), and that is
why "reword" is a useful command to have.

You are bringing up another variant of "squash" that gives us the
right tree by applying the change in the second commit while
discarding the message from the first commit and replacing it with
the message from the second commit.  Can we justify existence of
such a mode in a similar way (like I showed above to justify why
"fixup" and "reword" make sense)?  

What is the most unclear to me is where the log message in the
second commit comes from.  Was it first copied from the first commit
and then edited?  IOW, did the user do something like this?

	$ work work work
	$ git commit -e
	... record and explain the work of the first commit
	... with sufficient detail
	$ work a bit more to fix things
	$ git commit -c HEAD
	... record and explain the work of both the first and
	... the second by copying the existing first commit's log
	... and expanding to cover what the user further did

Or did the user do something more like this, in which case the log
message of the second was written pretty much from scratch to cover
work done by both commits?

	$ work work work
	$ git commit -m snapshot
	... record but give it a meaningless and expendable log
	... message
	$ work a lot more to advance
	$ git commit -e
	... record and explain what was done on the branch as
	... a whole; the log message of this commit fully describes
	... what the both commit did

Both workflows may benefit from such a feature, but at the same
time, it is unclear how realistic they are.

If two commits did comparable amount of work with similar
complexity, it would be more realistic for them to have their own
explanation that is usable as a part of the final, squashed commit,
and that is why "squash" exists.  It just is not obvious when the
new variant would be useful.  Especially if the workflow it expects
to support is the latter kind I gave (i.e. the user delays writing
meaningful log message until the last commit in the series and then
squashes everything down to one), it smells good enough to use
"squash" and get rid of a few lines at the beginning.  So there must
be some realistic workflow that benefits from the new variant, but I
do not think of one myself.

When such an explanation is given, I may agree that such a mode is a
good thing to add, but "similar to fixup" does not look like a good
enough reason.

Thanks.
