Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7667C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469F62084C
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fX7smcjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRPlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:41:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56639 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRPlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:41:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEA07710B8;
        Fri, 18 Sep 2020 11:41:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9NX9hsw3hjT2
        MWRVj1JmL+S0Jkc=; b=fX7smcjtHUkYaKiS8EMeyU/IeVOJ2p0HG7nPAZFlDZJo
        CYMdzkiZbMfoUn1N70nIYvKovs4BoftMMCMgOl540a/XrRc1nc+o/QQ3pTpTHdqa
        kLJO/ymf7hET0DkU1mNytnzagyK9XWBG/T/DagU1M+HRbt5/4xj5SUxULTHlyrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K6Vng5
        rjfvui6fMZa5TJp585REjQ/vV724pddD1SvZHdrlXfXqRcVkQRCEHnb35Nkg6aHi
        43X4v4uFQkrwaIcdptjn297Q2OOaLDcjIiRwLlduN95Hvkv+SWijZyqkv96bUlnr
        IcrZcSPDk4v0acxh31sGn97ra0NwAPW2RlhIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BA66710B7;
        Fri, 18 Sep 2020 11:41:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BA90710B1;
        Fri, 18 Sep 2020 11:41:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Apply git bundle to source tree?
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
Date:   Fri, 18 Sep 2020 08:41:05 -0700
In-Reply-To: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
        ("Andreas =?utf-8?Q?Gr=C3=BCnbacher=22's?= message of "Fri, 18 Sep 2020
 13:13:52 +0200")
Message-ID: <xmqqbli3nlda.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5E37DBB0-F9C5-11EA-9B42-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com> writes:

> I'm wondering if there's a way to apply a particular head in a bundle
> to a source tree, for example:
>
>   $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
>   $ cd linux-5.8
>   $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1
>
> That would allow to reconstruct either the original repository or just
> the underlying source tree, so the bundle could be used as a kind of
> super diff.

There seem to be a bit of misconception.

Do not think that a bundle is like a patch.  When you created the
bundle in the above example, you did not create a "super diff"
between v5.8 and v5.9-rc1 that you can apply to a working tree files
that correspond to v5.8 release.  That is not what you did.

What you created is an equivalent of a (shallow) repository, that
contains everything needed to get v5.9-rc1 by those who have a Git
repository that has v5.8 to fetch/pull from.  It is OK to have more,
but you MUST have v5.8 for the bundle in the example to be usable.

So assuming that your 'linux-5.8' is not just a tarball extract but
a Linux repository with v5.8 tag in it (i.e. "git log v5.8" gives
you sensible output) then the command to use is not apply but fetch,
e.g.

    $ git bundle fetch ../5.9-rc1.bundle v5.9-rc1

which will give you v5.9-rc1 tag.  What you can fetch from the bundle
can be listed by using the list-heads subcommand on the bundle.

And starting from that point, you would be able to do things like

    $ git checkout -b my-fork-of-5.9-rc1 v5.9-rc1

Now, assuming that your original question indeed came from thinking
of a bundle like a patch and not like a repository, we have a
question for you.  What in

    $ git bundle --help

gave such an incorrect impression?  The documentation must be at
fault here, and we need to clarify so that future readers of it will
not be confused into the same misconception.

Thanks.
