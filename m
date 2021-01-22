Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC613C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E5723AAC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAVWqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:46:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58376 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbhAVTnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:43:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6356910F4AF;
        Fri, 22 Jan 2021 14:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eupngIVdIq0shxQHzukvZNejxyM=; b=G91lia
        2oZSS+WCvwzlfKTsu+Y8lXj+AiEH2VmxuhBf/eZW2C7GRtYdTteFBbAoGIn2zLm8
        jSfaCR/7kXSmg/oG2Qf3WJn6IJt2GM2PGMZEhgac7oDeQ4t2PyoRv1Sm5mK+5mxU
        E7WQ51wbDxRQLZ4J1OYig/HDIMgdp0u4RKL/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mv/Nn7ZN7n7ghyvqYequoPvTF+jqvw0Z
        C5ESPtgGx4Mzd5/LbHWIyf8OmCnZ8/8vTVFpshctKVXyAi15dI1OfnaDY5Q7U2C3
        h5fC96yloTNfLciD6ap8ouTmKfQzcTZwoiA44mbdDqKUTT3m1FE8cGf8Z5rH+LXe
        8ln7lbeSBpk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CA4D10F4AE;
        Fri, 22 Jan 2021 14:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 915F710F4AD;
        Fri, 22 Jan 2021 14:42:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 7/8] test-lib: test_region looks for trace2 regions
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <8832ce84623e9c74a88b14a05b1c303ed8aa809b.1611320640.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 11:42:22 -0800
In-Reply-To: <8832ce84623e9c74a88b14a05b1c303ed8aa809b.1611320640.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 22 Jan 2021
        13:03:58 +0000")
Message-ID: <xmqq7do492sh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F36D19C0-5CE9-11EB-A771-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... Note that this
> changes the expectations slightly. The old test (incorrectly) used two
> patterns for the 'grep' invocation, but this performs an OR of the
> patterns, not an AND. This means that as long as one region_enter event
> was logged, the test would succeed, even if it was not due to the
> progress category.

>  	# t0212/parse_events.perl intentionally omits regions and data.
> -	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
> -	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
> +	test_region progress "Working hard" trace.event &&

So we do want "region_enter" and the "category":"progress" on the
same line in the event file, but as long as "category":"progress"
exists, both will pass, regardless of enter/leave.  And ...

> +test_region () {
> +	local expect_exit=0
> +	if test "$1" = "!"
> +	then
> +		expect_exit=1
> +		shift
> +	fi
> +
> +	grep -e "\"region_enter\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"

... this makes sure there is enter/category on a line (and
leave/category on a line with another check).  Makes sense.

But...

	test_region '!' '\(unmatching capture)' 'two' 'three'

would try to use an invalid regexp and cause grep to exit with 2,
which would mean ...

> +	exitcode=$?
> +
> +	if test $exitcode != $expect_exit

... this will not trigger and we return "success" (i.e. "failed as
expected")?

	Clarification.  The point is *NOT* that the grep pattern is
	not robust against funnies in $1 and $2---after all, these
	strings are under our control.  The point is what should
	happen when "grep" exits with an error when asked to ensure
	that there is no region detected.

> +	then
> +		return 1
> +	fi
> +
> +	grep -e "\"region_leave\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"

The same comment on "what about an error from grep" applies to this
one.

It might be easier to read to avoid having to say too many
backslash-quoted double quotes:

	grep -e	'"region_leave".*"category":"'"$1"'","label":"'"$2"\" "$3"

This comment applies to the earlier "grep", too.

> +	exitcode=$?
> +
> +	if test $exitcode != $expect_exit
> +	then
> +		return 1
> +	fi
> +}
