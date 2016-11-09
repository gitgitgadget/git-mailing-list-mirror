Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D802021E
	for <e@80x24.org>; Wed,  9 Nov 2016 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbcKIUl0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 15:41:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56159 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752167AbcKIUlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 15:41:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C8194E1E6;
        Wed,  9 Nov 2016 15:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EgrFaAKGyXSE02El73odVM4XubA=; b=GYu9Dq
        CQepcODg8j4vm+wEigINfvgMyTcWfcRyZjDYAzMaw5ZNvBaOKf1J6Msd0d6EoP4p
        QCzof7vFi2NTVjET/cl2imjuJakwRJHTKZTKlMhdGzEnSDsxFQEqMyUkvBv901X9
        Iaj/DtCJLI9ZqncFOfpwcwlh1PZFk39FdGpfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OPf2LXs0gxP98xnKOP9WvBz4xAbhSBs8
        P2KVVjShJuZdToiqfZByAknohF+WpgOrOQi1r03UgsvkWQ1RJpNCSkpgvp3grTK4
        X6iMfX7Il9wnlUyVkIYOT3zKqxT8Zfr/xwO/DQsDp1NrEmxi9L+geSkH+oCfGZKK
        qdwIq9VmwKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 033A14E1E5;
        Wed,  9 Nov 2016 15:41:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78C6D4E1E4;
        Wed,  9 Nov 2016 15:41:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
        <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
        <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
        <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
        <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
        <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
        <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net>
Date:   Wed, 09 Nov 2016 12:41:22 -0800
In-Reply-To: <20161108222127.mejb74maewzhn3qg@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 8 Nov 2016 17:21:27 -0500")
Message-ID: <xmqqd1i49yj1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0B0274C-A6BC-11E6-9ED3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For matching specific names, we have to deal with case-folding.  It's
> easy to hit the common ones like ".GITIGNORE" with fspathcmp(). But if
> this is actually protection against malicious repositories, we have to
> match all of the horrible filesystem-specific junk that we did for
> ".git".
>
> Symlinks are likewise tricky.

Wouldn't it be the simplest to say these:

 (1) The code attempts to read ".gitignore" (or ".git<something>")
     in general from the filesystem, or the index, or a tree. No
     case permutations are attempted.

 (2) When the code tries to do the above, we open with nofollow (or
     protect racily with lstat(2) which may be the best we could do)
     when reading from the filesystem, or check the ce_mode type
     when reading from the index or from a tree, and ignore if the
     path we are using is a symbolic link.

That way, case funny filesystems that cause trouble like the ".git"
thing would not have a chance to interfere and fool us, no?
