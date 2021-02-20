Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E82C433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E77464ECA
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 21:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBTVfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 16:35:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63299 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBTVfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 16:35:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70FFC11BE53;
        Sat, 20 Feb 2021 16:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZZ3Pz86PD7+KgkzS6vomK83bbvI=; b=XLPWNC
        lrSc4gbldL4R7/EPYVPr9dVLgHBDoHYF/ppCcfGrmMxTIDrgJ7pHxgS1sca2sHHT
        fTcPIWh9vfxVFJPo6CapYz3e5UHwoIUoW0z/XvDOJauMtOUgM/fBB6Jy5Bdc9dgj
        hnZ2sLkRNJc4+8n3wQ+60Pp2pJUfJx90vxyRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wTJFjaOthIITMNEH2wyGwoZaUtzAMy2w
        R9Pl8ANtyL1mVk5bMUzDcaZwX9JJj7EYRoueYn8zXTNS/KSYg1xzM1b9VfRnY1yO
        RDVHrkVsPibFm8F/XF0k5lpRrmp5WpRWdO9+6V25WYSiv5kWhl45DzW28bNC5F4A
        IbkIB876qgs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A3CC11BE51;
        Sat, 20 Feb 2021 16:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B48B211BE4C;
        Sat, 20 Feb 2021 16:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH v2 0/2] Add --no-filters option to git-add
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
        <pull.880.v2.git.1613840865.gitgitgadget@gmail.com>
Date:   Sat, 20 Feb 2021 13:34:30 -0800
In-Reply-To: <pull.880.v2.git.1613840865.gitgitgadget@gmail.com> (Andrej
        Shadura via GitGitGadget's message of "Sat, 20 Feb 2021 17:07:43
        +0000")
Message-ID: <xmqq4ki6a0ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BB13EC6-73C3-11EB-AFA5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com> writes:

> It is possible for a user to disable attribute-based filtering when
> committing by doing one of the following:
>
>  * Create .git/info/attributes unapplying all possible transforming
>    attributes.
>  * Use git hash-object and git update-index to stage files manually.
>
> Doing the former requires keeping an up-to-date list of all attributes which
> can transform files when committing or checking out. Doing the latter is
> difficult, error-prone and slow when done from scripts.
>
> Instead, similarly to git hash-object, --no-filter can be added to git add
> to enable temporarily disabling filtering in an easy to use way.

I think brian's review covered if such a feature is desirable to
sufficient level, and I do not have anything to add in that area,
so I'll limit my comment to the general design and implementation.

In general, think three times before introducing --no-something
option.  It often is much cleaner and futureproof if you instead
introduced --something option whose value defaults to true instead,
so that the end-user can say --no-something from the command line.


>       -		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
>      -+		OPT_BIT(0 , "no-filters", &flags, N_("store file as is without filters"),
>      ++		OPT_BIT(0, "no-filters", &flags, N_("store file as is without filters"),
>       +			HASH_RAW),

In other words, these should give "filters" option, and the code
should initialize the flags word with USE_CLEAN_FILTER bit on by
default (the use of "clean" here comes from "clean vs smudge", one
of the pair of filters end-user can customize the path the data
takes going into Git from the outside world; and the "clean" and
"smudge" datapaths also trigger non-custom standard ones like crlf
munging).

That way when a configuration variable support is introduced to
allow the users to say "I by default refuse to use the clean filters
when running 'git add'" by setting say "[add] cleanfilter = false",
the user can override that with "--filters" from the command line
"for just this time".  The same goes for an alias that hardcodes
"--no-filters" on the command line, where allowing "--filters" lets
the users override it.

Thanks.
