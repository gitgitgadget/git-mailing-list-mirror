Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F883C2BB55
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D524A20692
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 04:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pyQam4Bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgDJE5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:57:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58817 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgDJE5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 00:57:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CC30BF382;
        Fri, 10 Apr 2020 00:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pa4OOgK/hbD3e8VVhpGBzml8thc=; b=pyQam4
        BzyjYzCb3eY0peCgG6jBGS4idevGDrOkrYlBe6MerIn1OGBg5Nb+fh1QqQ+GgDuM
        PhGqbHNGe3nWldtjLnVZnc68wzXfYnGR8xrR2j9MIbEBCAWxPhVIA8o1cG3KFDPu
        VKSrBvEIBExbejcyCjwV9bAi2Mzo7h3ZNZoNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DY5OytXIz85VmN4mAEZWaBIcUe6cLzDc
        PlOzYEHwQPjc9DLM/bDjmffJ2PujFnMZtuVK5E1zaP4NfFLyqmL2ndlZEkAku8nQ
        D5mCOD3+jXJqq58SV+2ePBkbXNioeUgvMbBys6J6ZGnTFhvkpdC23NtvF6XDLYiX
        zb4gQ4oW1To=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08216BF381;
        Fri, 10 Apr 2020 00:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 424B4BF380;
        Fri, 10 Apr 2020 00:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>, phillip.wood123@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <xmqqimi8kvue.fsf@gitster.c.googlers.com>
        <CAGyf7-H4jtnVjgZ20qC-mzJHRd7Ffqm=Vh18wJPiiSS4NPnhyQ@mail.gmail.com>
Date:   Thu, 09 Apr 2020 21:57:08 -0700
In-Reply-To: <CAGyf7-H4jtnVjgZ20qC-mzJHRd7Ffqm=Vh18wJPiiSS4NPnhyQ@mail.gmail.com>
        (Bryan Turner's message of "Thu, 9 Apr 2020 19:06:42 -0700")
Message-ID: <xmqqeeswkkez.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC44C108-7AE7-11EA-9454-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

>> So, from that point of view, this may not be enough, but a "throw
>> away all" option is not enough, either.  We'd want to have both to
>> serve such users better.
>
> This was why I wondered whether it might be worth extending the
> --empty option to add another possible value, like "drop-all", that
> would allow the caller to say they want to drop all empty
> commits--both those that started out empty and those that became
> empty.

You are talking about "empty from the beginning" and "has become
empty due to rebasing", but the use case you quoted and responding
to is not about the distinction between those two.

The original scenario that triggered this thread was to clean a
history the user created with git-imerge.  Part of using the tool,
apparently, you can choose to leave empty commits the tool
internally needs to create.  To the "git rebase" command that is
tasked to clean up the history, an empty commit that was left due to
what imerge did, and an empty commit that was originally created by
the end user (perhaps deliberately in order to server as some sort
of a marker) look the same---they both are "empty from the
beginning", not "commits that became no-op as the result of
rebasing".

And in order to help manually sift these two apart, " # empty"
marker would help, as there are three kinds of "pick" in the
instruction stream.  Commits that are not no-op (i.e. without the 
" # empty" mark), commits that imerge made no-op (the user wants
to get rid of) and commits that are no-op because the user wanted
them to be.  The latter two classes would be marked with " # empty"
and the user can selectively apply s/pick/drop/ to them.
