Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F65C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028872076E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iwvTaO/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgDGUIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:08:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51296 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGUIX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:08:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CB9CC91DD;
        Tue,  7 Apr 2020 16:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V4UwT+AMPfNl8eKY+TpolBAAXgA=; b=iwvTaO
        /v2fQVdCrFGiCugznF2KItapEZ2gNF4aphCK3QlrTR3wODO40mUEWsPYdmdF8B/S
        2t6sUzEnjJUeZKMBpYuwzkYU87rgHYDeYZEfdkJlSoTzmRvvmmiMksnjV0IwZGYe
        wJ1Jn5LoECLO6CIZ9k2vAJnNqzwk4iCqu4ETc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZmwutIPVA28eUtsL0R/PPBlqDgrQMA0
        u9n6UyX/f80PQa96QaTg5s4RuPDnfGdFaMOjG5DHenuti0wBthYPLoGzpNu6dWYw
        lgJRDC2YogLV4oIQAWVEpTZrKKnW8he37/i/KqcetECTws9hVBxI1R1S2tkDLUqh
        Wr0IS7I31cg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03C8FC91DC;
        Tue,  7 Apr 2020 16:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BE1CC91DA;
        Tue,  7 Apr 2020 16:08:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
        <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
        <20200407014829.GL6369@camp.crustytoothpaste.net>
Date:   Tue, 07 Apr 2020 13:08:16 -0700
In-Reply-To: <20200407014829.GL6369@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 7 Apr 2020 01:48:29 +0000")
Message-ID: <xmqqzhbnrrdb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85B8835A-790B-11EA-971B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If there are periodic tasks that should be done, even if only on large
> repos, then let's have a git gc --periodic that does them.  I'm not sure
> that fetch should be in that set, but nothing prevents users from doing
> "git fetch origin && git gc --periodic".  Let's make it as simple and
> straightforward as possible.

Yeah, thanks for bringing up "git gc" here.  Earlier I mumbled
sometrhing about "git repack", which seemed to have needlessly
muddied the discussion, but "gc" is exactly the "we already have a
wrapper the users are familiar with---why not extend it" thing.

> I'm not opposed to seeing a tool that can schedule periodic maintenance
> jobs, perhaps in contrib, depending on whether other people think it
> should go.  However, I think running periodic jobs is best handled on
> Unix with cron or anacron and not a custom tool or a command in Git.
>
> I've dealt with systems that implemented periodic tasks without using
> the existing tools for doing that, and I've found that usually that's a
> mistake.  Despite seeming straightforward, there are a lot of tricky
> edge cases to deal with and it's easy to get wrong.
>
> We also don't have to reimplement all the features in the system
> scheduler and can let expert users use a different tool of their choice
> instead if cron (or the Windows equivalent) is not to their liking.

;-)  You said it much better than I would have myself.  Thanks.
