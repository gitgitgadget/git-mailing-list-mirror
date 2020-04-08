Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C950EC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 21:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EC0206BE
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 21:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIqA1rCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDHVvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:51:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57056 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDHVvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 17:51:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70827B2EE6;
        Wed,  8 Apr 2020 17:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZPBsxzmafplLbBgBCMXcWCrtpms=; b=iIqA1r
        CynD9lVX7bkvp8o9lTnEIliaMtXPqJChu2Zy8SGirCQkLK0pdek8HBgm3vH5r42a
        vns4OxPHXR6ByIrXEqZL54h09JDpaNqT5Eqkc63aHhHIxv/NTlORXT7uZ2OVnmmC
        MJh/0YkCb50wGcpCsZB4frDqukD+G0gRnlwKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QHlrKu7ekzC/pf2LTf9LA9QVclf6rOz0
        yEy0YFDr4VqbNh+yra/R/8oQGCg3HPwNzGcJzNdNlusck8YLp9qohI0Y1CcGerUE
        UsNnA1UdVfAO9ZJo0g71p2cnyIrNH3xLAHAKSfGJLHakGTGGi+Q/m0EGekQy5LDx
        jORVzYyzoZg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C599B2EE4;
        Wed,  8 Apr 2020 17:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8336EB2EE3;
        Wed,  8 Apr 2020 17:51:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH] clean: explicitly `fflush` stdout
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
        <20200408201454.GB2270445@coredump.intra.peff.net>
Date:   Wed, 08 Apr 2020 14:51:11 -0700
In-Reply-To: <20200408201454.GB2270445@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 8 Apr 2020 16:14:54 -0400")
Message-ID: <xmqqr1wxoddc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10DA9126-79E3-11EA-A9AA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This (and the patch) make sense to me. It might be worth factoring out a
> "read input from user" function and putting the flush there, but with
> only three affected call sites, I'm OK with it either way.
>
>>     This is yet another patch that was funneled through a Git for Windows
>>     PR. It has served us well for almost five years now, and it is beyond
>>     time that it find its final home in core Git.
>
> Agreed. I guess it didn't affect people on other platforms much because
> stdout to a terminal is generally line-buffered on POSIX systems. But
> it's better not to rely on that, plus it could create confusion if
> somebody tried to manipulate the interactive operation through a pipe
> (e.g., driving it from a GUI or something).

Hmph, I thought it was more common to do prompts etc. on the
standard error stream, which tends to make the buffering of the
output less of a problem, but apparently these prompts are given to
the standard output.  I am also OK to sprinkle fflush(stdout) but in
the longer term, it would probably be a good idea to introduce a
helper to "prompt then grab input" or "read user input" (if the
former, we'd be able to bring consistency into "which between the
standard output or the standard error does a prompt come?", and if
the latter we'd do fflush(NULL) before reading), especially if there
are many git subcommands that go interactive.

Thanks.
