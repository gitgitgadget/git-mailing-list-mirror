Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC23C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C127F2074D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K0r9sFMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgCKUiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:38:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56034 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgCKUiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 16:38:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C85AE637D3;
        Wed, 11 Mar 2020 16:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WlZdZlxR6j5vE5qsLZ61ZDcGkDo=; b=K0r9sF
        MYvJe4OKOhsVxBALBDed8lp8ioJbqjOLrlWpy9VTTS+q3+y29qQMNl5ML4w3jYHP
        yKGdK8++P+FsWOSouawEomBUzwM1NaUvFRicJZ7J5nDCSwXifLozZb9/wHqEwgZZ
        VwF8rzJElzTyI2la/Uj2l8tU6o1kIQgiHAlOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w/C3236CGfFXq7IWo4ePxBfq4x4wXyPa
        LolW8ysf88GR0IWB9wFXfJLBy5j06dIPQ5gxceXpDy7biUQex+GhcUY/tOtetrku
        S6gomPzLCpZwvloSP93DgUPS2mKBZCQ39pYh4STFknl9w4sbiib69Jhs9r1K0Gv/
        Ned7zNDiNuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C00CA637D2;
        Wed, 11 Mar 2020 16:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A7B6637D1;
        Wed, 11 Mar 2020 16:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/8] convert: permit passing additional metadata to filter processes
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
        <20200310182046.748959-3-sandals@crustytoothpaste.net>
Date:   Wed, 11 Mar 2020 13:38:46 -0700
In-Reply-To: <20200310182046.748959-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 10 Mar 2020 18:20:40 +0000")
Message-ID: <xmqq1rpyhbjd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EBB2058-63D8-11EA-9701-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: "brian m. carlson" <bk2204@github.com>

Do you want this name/address associated to your contributions?  I
am asking because to me you have always been "that toothpaste guy" ;-)

> There are a variety of situations where a filter process can make use of
> some additional metadata.  For example, some people find the ident
> filter too limiting and would like to include the commit or the branch
> in their smudged files.  This information isn't available during
> checkout as HEAD hasn't been updated at that point, and it wouldn't be
> available in archives either.
>
> Let's add a way to pass this metadata down to the filter.  We pass the
> blob we're operating on, the treeish (preferring the commit over the
> tree if one exists), and the ref we're operating on.  Note that we won't
> pass this information in all cases, such as when renormalizing or when
> we're performing diffs, since it doesn't make sense in those cases.
>
> This series wires up the code to print this information, but doesn't
> pass any of it at this point.  In a future commit, we'll have various
> code paths pass the actual useful data down.
> ...
> +struct checkout_metadata {
> +	const char *refname;
> +	struct object_id treeish;
> +	struct object_id blob;
> +};

The "filter" you talk about is the clean/smudge kind of thing that
works on individual blobs, and the series is about giving a bit more
information than the raw contents to be filtered.  I am assuming
that I got at least that part correctly.

Now, a few questions.

Is "refname" "refs/heads/branch? when I run "git checkout branch" or
"git checkout branch -- Makefile"?  Is "treeish" the same as the
output from "rev-parse branch^{commit}" in such a case?

Assuming they are, what refname and treeish does my filter see, when
the user did these things?

    git checkout origin/master
    git checkout v1.2.3
    git checkout v1.2.3~4

As a writer of a filter, do I get different clues when I am munging
Documentation/Makefile and t/Makefile, when the user does

    git checkout master -- Makefile Documentation/Makefile

i.e. grab these two files out of the tree of the commit at the tip
of the master branch?

Or do I just learn what the "refname" (presumably "refs/heads/master"?)
and treeish (presumably "rev-parse master^{commit}") and I cannot
tell where in that tree hierarchy the contents come from?

Thanks.

