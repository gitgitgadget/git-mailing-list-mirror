Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FFEC433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B4D619CA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 22:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhCWWgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:36:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59091 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhCWWfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 18:35:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D427C12E168;
        Tue, 23 Mar 2021 18:35:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMrQvNbIUtpLZMs3Fgnxviyk1RA=; b=RfyXir
        x39mnnrkdZAHbyVzpa4iR1Je13F0w60ECXx+pFAPjia/5OAoGGxCmWDTSgPWf0fc
        8SmD1SP1FFDFMeNgXu2dPGL5pbWhVomjCl2JQUo55OcdCTWG6CHwJxemIHKd7GiX
        NfaZT3HdRGkHJX2CBsJJcsxZaXA9GK7ql5A3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jihi49IoUEJr3g5eIK6/xOe4Ee4irftq
        AgRxdWNtvmg2U4sM6PTSGx455VoJdaDcUkExFtHe7XvnGmjN1QMNs16wE8bKz7a0
        0xeABBZQ6IEpkwW5NPmRbHbPtUUhWMTNeds0f+FsAGPrnrf1CR5XgsKT/PqLfQC/
        kYH9Va/eD5w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC96812E167;
        Tue, 23 Mar 2021 18:35:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1FDBA12E166;
        Tue, 23 Mar 2021 18:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Pass or not to pass config environment down...
References: <xmqqk0px3dfu.fsf@gitster.g>
        <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
        <xmqqmtut1qyj.fsf@gitster.g>
        <CA+P7+xo9rUYWzCT0YZFU5Nz1ojP1qRt8VfGtK08-LmYV9KK0hw@mail.gmail.com>
Date:   Tue, 23 Mar 2021 15:35:07 -0700
In-Reply-To: <CA+P7+xo9rUYWzCT0YZFU5Nz1ojP1qRt8VfGtK08-LmYV9KK0hw@mail.gmail.com>
        (Jacob Keller's message of "Tue, 23 Mar 2021 14:57:50 -0700")
Message-ID: <xmqqim5h1otg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05F52E6C-8C28-11EB-A6B5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> So, I think this direction is good. I imagine a full patch would
> include also dropping the specialized helper function that is no
> longer needed, and possibly adding new tests for the behavior of
> GIT_CONFIG_COUNT?

Yeah, coding that is the easiest part.  Thinking through
ramifications of making (or not making) such a change is much
harder.

I said "assuming" number of times, because I am not so sure if the
subprocesses spawned from other codepaths do or do not want to see
the one-shot custom configuration settings.  If that assumption
turns out to be wrong and the processes spawned using the helper in
various helper functions in submodule.c are the oddball cases that
want to see the custom configuration, then such a change would break
existing users.

I _think_ the one in connect.c, which runs either the ssh transport
(for which the processes that run on the other side in the other
repository won't be affected by our environment anyway) or the file
transport that runs another process and talks with it over a pipe is
probably OK if the configuration on the "client" side leaks through
to the "server" side, e.g.

    $ git -c advice.ignoredHook=false clone file:///the/repo.git/ here

would probably want the other end (i.e. the one that runs upload-pack
in /the/repo.git/ directory) to see the one-shot configuration, too.

I do not think it makes much difference to the use of local_repo_env
in object-file.c::for_each_alternate_ref() either way; it could be
used (via core.alternateRefsCommand) an arbitrary command in each
alternate repository, but by default it runs for-each-ref in them,
and I do not think of any configuration variables that would be
useful on "the other side".

And I suspect that trailers.c::apply_command() excludes these
environment variables just out of habit without much deep thinking.
It is not going in a different repository to run the command, and
santitizing the environment that pertains to this repository should
not have any meaningful effect [*].

So, I would not be surprised if it were a totally safe change, but I
am not yet sure.

Thanks.



[Footnote]

* Christian CC'ed for 85039fb6 (trailer: execute command from
  'trailer.<name>.command', 2014-10-13) that introduced the code
  together with its use of local_repo_env[].
