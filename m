Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E83C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5120E21707
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t0Zp6FLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRRsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:48:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56245 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRRsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:48:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54E4FF7C76;
        Fri, 18 Sep 2020 13:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6r8Cyu7FSXzCF75o93hEGngp5vI=; b=t0Zp6F
        Lza4yL4Mx6ozjt9UD/HaKGU5+3aOcjdoVXR8E7smZQNemoQ49PS887job/VwTk1U
        I8BhliMn+wC+ZHX/73tGElLCaolMB9+0ESxOxAOUeHPIMu3OXCcGTf6gnb6djH/2
        25GSz7GIS/N/JYudSQEBIXGVKgPsGNA/GcEA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GsZ7kXcxktjzrBwU6pPjKAJanio5uq6F
        bVJjgTY3BfVE0TwYylV13pxyWmvhSEdkXYi4AGADrrAn8uwAxnWJaC3AcW5z7nys
        kltw9rOCHwaW7D2lL0GQ+sRfo0dhXD98PrnD5gp5MWw4/iv6OM+sW4TswyW1LcyU
        TPJu+H5jZgg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D80FF7C75;
        Fri, 18 Sep 2020 13:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93CA0F7C73;
        Fri, 18 Sep 2020 13:48:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff --no-index
References: <20200918113256.8699-1-tguyot@gmail.com>
        <20200918113256.8699-3-tguyot@gmail.com>
        <20200918143647.GB1606445@nand.local>
        <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
        <20200918171950.GA183026@coredump.intra.peff.net>
Date:   Fri, 18 Sep 2020 10:48:41 -0700
In-Reply-To: <20200918171950.GA183026@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 18 Sep 2020 13:19:50 -0400")
Message-ID: <xmqqbli3m0w6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3128557A-F9D7-11EA-AE07-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Getting back to the overall feature, this is definitely something that
> has come up before. The last I know of is:
>
>   https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/
>
> which everybody seemed to like the direction of; I suspect the original
> author (cc'd) just never got around to it again. Compared to this
> approach, it uses a command-line option to avoid dereferencing symlinks.
> That puts an extra burden on the caller to pass the option, but it's way
> less magical; you could drop all of the "does this look like a symlink
> to a pipe" heuristics. It would also be much easier to test. ;)

Yes, I do remember liking the approach very much and wanted to take
it once the "do not dereference symlinks everywhere---just limit it
to what was given from the command line" was done.

To be quite honest, I think "git diff --no-index A B" should
unconditionally dereference A and/or B if they are symlinks, whether
they are symlinks to pipes, regular files or directories, and
otherwise treat symlinks in A and B the same way as "git diff" if A
and B are directories.  But that is a design guideline that becomes
needed only after we start resurrecting Brian's effort, not with
these patches that started this thread.

Thanks.

