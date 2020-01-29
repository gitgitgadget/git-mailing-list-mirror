Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F1BC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9367C20661
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mlq+tEoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgA2SnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:43:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50361 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgA2SnP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:43:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A5324B16D;
        Wed, 29 Jan 2020 13:43:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bkamMSfwq/+7HWX35YZzaV/8CtA=; b=mlq+tE
        oXw8dGdJwTDqB5xBFiXub69KQDiv+7OnTrjOJKU+DpG2bqrSlB3A1IfYceJRALr2
        4+dbQ6x/Ou1lA1UXlopikNlZTU7HUcM7wT+qruoH/3ILVg1LHYS3IP1sxd4Q7fsD
        p0p07DZv3bFqhr0ucnfObWGQH8zmJxJbjDBlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uZ1CY1jVLavt1LdM64vb/lRb35wNKe7d
        yZp9zKiWfSL58iDxK3jd9OrLoJkODXmJKQvQsTFBi1Zv0eFJiKgvdcwNzFEp5rfO
        LU7OT/+Sg6IRoyShaIxaoEwG9vTdIyAh85GNGGhrkmJUVdJqrmSwJGYJYQzeU1BW
        +wJS5jDkjPo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 118EE4B16C;
        Wed, 29 Jan 2020 13:43:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 655394B16B;
        Wed, 29 Jan 2020 13:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
        <20200128073100.GA563058@coredump.intra.peff.net>
        <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
        <20200129104754.GE4218@coredump.intra.peff.net>
Date:   Wed, 29 Jan 2020 10:43:11 -0800
In-Reply-To: <20200129104754.GE4218@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jan 2020 05:47:54 -0500")
Message-ID: <xmqqh80e5cjk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33DDB4DA-42C7-11EA-9609-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Making "refs" a file instead of a directory does work nicely, as any
> attempts to read or write would get ENOTDIR. And we can fool
> is_git_directory() as long as it's marked executable. That's OK on POSIX
> systems, but I'm not sure how it would work on Windows (or maybe it
> would work just fine, since we presumably just say "yep, everything is
> executable").
>
> So perhaps that's enough, and what we put in HEAD won't matter (since
> nobody will be able to write into refs/ anyway).

I wonder if it would help to take the "looser repository detection"
code alone and have it in a release, way before the rest of the
reftable topic is ready.  Then by the time a repository created by a
reftable-enabled Git appears on people's disks, all the older
versions of Git that are still in people's hands would at least know
that it is a repository supported by future Git that they themselves
do not know how to handle, stop repository discovery correctly and
refrain from damaging the repository with an extension unknown to
them?

