Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EDC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C18D2076E
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aRdD9eQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRT42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:56:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58876 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRT4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 15:56:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C3FE8EC06;
        Tue, 18 Aug 2020 15:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PRzVYLXSUSwhKgiXCvcPNX0Y0JI=; b=aRdD9e
        QZOjNA9Y9b2WuwGA3w26Hjtd0uApxa5MxWBcAZfbo4K24dTEYSIDMw8HgmxabwU2
        pPthyD8aHBRSaRS6Wcv39qx+dr8gx0uJW0kD7OxQ+Td4GhP4Kvq0xV6rGHdaYRPM
        FlILlocCLmdQz/Y/Yum8NFHXnVeHHbpeZwAeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XQR6syNuNTZ6mFyVsbge88a5qq0tFIO+
        itUsipnfNwMJPPP87XaN4xiKPfueIJgXcsA3LGn61SSW0tVR337cOSg9/VQy/FmA
        0pg53sR1fgdD+osrQPHLhKcTkyBZXVYJuE+iIE7Ur3jF02ZTAZYAg1gyuGbrDJDQ
        LIP1Kej6gg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53E5D8EC05;
        Tue, 18 Aug 2020 15:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA9818EC04;
        Tue, 18 Aug 2020 15:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 0/7] Lazy fetch with subprocess
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597722941.git.jonathantanmy@google.com>
Date:   Tue, 18 Aug 2020 12:56:22 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 17 Aug 2020 21:01:30 -0700")
Message-ID: <xmqqimdfybh5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E43368C0-E18C-11EA-B355-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> These patches are based on jc/no-update-fetch-head, once again.

FWIW, that topic no longer exists (it has been swallowed by
Derrick's maintenance topics).  As that topic is not near 'next'
yet, we might want to kick the patch out of it into a separate
jc/no-update-fetch-head topic again, base this series and also
maintenance topics on top of it.

> 2:  00ad7dd875 = 2:  9f277f1631 fetch: allow refspecs specified through stdin
> 3:  8b4a522a13 ! 3:  fda9f834f6 fetch: avoid reading submodule config until needed
>     @@ Metadata
>       ## Commit message ##
>          fetch: avoid reading submodule config until needed
>      
>     -    Teach "git fetch" to avoid reading the submodule config until necessary.
>     -    This allows users to avoid the lazy-fetching of this potentially missing
>     -    config file by specifying the --recurse-submodules=no command line
>     -    option.
>     +    In "fetch", there are two parameters submodule_fetch_jobs_config and
>     +    recurse_submodules that can be set in a variety of ways: through
>     +    .gitmodules, through .git/config, and through the command line.
>     +    Currently "fetch" handles this by first reading .gitmodules, then
>     +    reading .git/config (allowing it to overwrite existing values), then
>     +    reading the command line (allowing it to overwrite existing values).
>     +
>     +    Notice that we can avoid reading .gitmodules if .git/config and/or the
>     +    command line already provides us with what we need. In addition, if
>     +    recurse_submodules is found to be "no", we do not need the value of
>     +    submodule_fetch_jobs_config.
>     +
>     +    Avoiding reading .gitmodules is especially important when we use "git
>     +    fetch" to perform lazy fetches in a partial clone because the
>     +    .gitmodules file itself might need to be lazy fetched (and otherwise
>     +    causing an infinite loop).
>     +
>     +    In light of all this, avoid reading .gitmodules until necessary. When
>     +    reading it, we may only need one of the two parameters it provides, so
>     +    teach fetch_config_from_gitmodules() to support NULL arguments. With
>     +    this patch, users (including Git itself when invoking "git fetch" to
>     +    lazy-fetch) will be able to guarantee avoiding reading .gitmodules by
>     +    passing --recurse-submodules=no.

Quite sensible.

> 4:  77bc83e7f2 ! 4:  a5554cd27f fetch: only populate existing_refs if needed
>     @@ Metadata
>       ## Commit message ##
>          fetch: only populate existing_refs if needed
>      
>     -    When fetching tags, Git only writes tags that do not already exist in
>     -    the client repository. This necessitates an iteration over all the refs,
>     -    but fetch performs this iteration even if no tags are fetched.
>     +    In "fetch", get_ref_map() iterates over all refs to populate
>     +    "existing_refs" in order to populate peer_ref->old_oid in the returned
>     +    refmap, even if the refmap has no peer_ref set - which is the case when
>     +    only literal hashes (i.e. no refs by name) are fetched.

Much better---the previous round gave us a wrong impression that
the change is about the behaviour when fetching tags, but the
updated explanation makes it clear that the primary use case is to
avoid tag-following while directly fetching objects by names, not
via refs.
