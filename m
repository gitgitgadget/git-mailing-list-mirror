Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BCBC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB7864E35
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhBJUKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:10:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50370 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhBJUKv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:10:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6371993AD;
        Wed, 10 Feb 2021 15:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nrD4sYxpx5XOpHrT5ukaamAdjF4=; b=dvJ8qM
        weUxj0fnLnibYTQ9Slew3H9hqPTu5Stfb/+0gF/f8LAS6IMLzIN663FjYWnOwYSR
        mCLP8cCRWveabWT6qx1TZUATycierp9nqg19dz7Gm+QVdEaCjGJS6ETtvQb0JQhQ
        RjScYCDA4t+5oAzZz1Etom1sqqslUod9hawys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w3RAGWagGkaYTq+BL+nLhFtVLA14qHL2
        byJ6WWlcabs7YawwpY9unjAzbw6UNTDNdNtKYL6ylTeGxNTR9GJ8SjDRz7px43uX
        vpXP5kBeWsn0mhWAIdF+/X3u2cwaNt5YzqtK3FAukkrqgieNeeXyVFaCMknlNx0z
        nWT/U5jz3NA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95975993AC;
        Wed, 10 Feb 2021 15:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A175993A6;
        Wed, 10 Feb 2021 15:10:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
        <YB148VZJqKIPC8P2@coredump.intra.peff.net>
        <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
        <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
        <xmqqv9b1ylyj.fsf@gitster.c.googlers.com>
        <YCQGqeHB4rXi6dG0@coredump.intra.peff.net>
Date:   Wed, 10 Feb 2021 12:10:02 -0800
In-Reply-To: <YCQGqeHB4rXi6dG0@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Feb 2021 11:15:37 -0500")
Message-ID: <xmqqblcr3crp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7116BCA-6BDB-11EB-92DB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 09, 2021 at 01:23:32PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >   If the file `.mailmap` exists at the toplevel of the repository[...]
>> >
>> > which likewise reinforces the notion that we are looking in the working
>> > tree.
>> 
>> > diff --git a/mailmap.c b/mailmap.c
>> > index eb77c6e77c..9bb9cf8b30 100644
>> > --- a/mailmap.c
>> > +++ b/mailmap.c
>> > @@ -225,7 +225,8 @@ int read_mailmap(struct string_list *map)
>> >  	if (!git_mailmap_blob && is_bare_repository())
>> >  		git_mailmap_blob = "HEAD:.mailmap";
>> >  
>> > -	err |= read_mailmap_file(map, ".mailmap");
>> > +	if (!startup_info->have_repository || !is_bare_repository())
>> > +		err |= read_mailmap_file(map, ".mailmap");
>> 
>> OK.  Do we know at this point that cwd is always/already at the root
>> level of the working tree?
>
> I think so. If we're in a non-bare repository, we'd have chdir'd during
> the setup/discovery steps. At any rate, this patch could not possibly be
> making such a situation _worse_, as we were previously reading it
> unconditionally.

But the point of the patch is to ensure that we only read from the
top of the working tree---I wanted to make sure that we previously
weren't reading it from any subdirectory the command started.

> If you are proposing that this become:
> ...

Not really.  As long as we know we would already have moved to the
top, then what we have above is perfectly fine.

> .... I suspect it may even be necessary to use a mailmap in
> an in-process submodule repository (in which case we should be taking a
> "struct repository" argument and checking it in the first two branches
> of the conditional). But this is orthogonal to what my patch is doing, I
> think. And I'd rather punt on it until there is a known upside (probably
> as part of a larger effort to allow mailmaps outside of the_repository).

Yeah, I was not interested in what happens with in-process
submodule, and I'd rather leave the code as close to as-is, until it
becomes necessary to update it.

Thanks.
