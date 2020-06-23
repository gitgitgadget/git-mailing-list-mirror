Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E0C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F2B2098B
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YO2u6cut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbgFWTey (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:34:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733270AbgFWTey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:34:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57FD9CFBC1;
        Tue, 23 Jun 2020 15:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l54nD/masMFKpKUyonAE1bO7uYs=; b=YO2u6c
        utamlJ3Rvp4yw/fKR28rLzdp3cbcu6PfXhBMBwOtwg5fht0YSU5ZLPOzNqNFsUzK
        4yVJcHH4TIclMstETm897wV6e/oGUAiiA7ZdX4TbXAt2ku+xASQj8aiM8BUpu8BJ
        RKL2vc64J4nDsYiVQ+eQCEMSIVN5oo4bSrzII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u+dRxwtGNNgoEKNza1Hp9+bnYcR+eT0I
        xbqf0n5PgmDQuE+Rl7STmuxx2wirMj6yLD2gxu9tGwxEwDkKSscRFhy504tnOijq
        c/cU+TWHeQmr8Jy/N8Fc5v+58hTd6NxiGhjieI35P2ipZH6MI8qMY92kierl98WD
        vzK6VbYznBw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FCC7CFBC0;
        Tue, 23 Jun 2020 15:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96CA5CFBBF;
        Tue, 23 Jun 2020 15:34:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [alternative 0/10] fast-export: allow seeding the anonymized mapping
References: <20200619132304.GA2540657@coredump.intra.peff.net>
        <20200622214745.GA3302779@coredump.intra.peff.net>
        <20200623152436.GA50925@coredump.intra.peff.net>
Date:   Tue, 23 Jun 2020 12:34:47 -0700
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jun 2020 11:24:36 -0400")
Message-ID: <xmqq1rm5d19k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A40B536-B588-11EA-8505-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 22, 2020 at 05:47:46PM -0400, Jeff King wrote:
>
>> Here's a v2 which I think addresses all of the comments. I have to admit
>> that after writing my last email to Junio, I am wondering whether it
>> would be sufficient and simpler to let the user specify a static mapping
>> of tokens (that could just be applied anywhere).

Yeah, dumping the random mapping created and telling the user to
figure out what the tool did is less nice than allowing the user
to enumerate what tokens are sensitible and need to be replaced.

> Both of these techniques _could_ live side-by-side within fast-export,
> as they have slightly different strengths and weaknesses. But I'd prefer
> to just go with one (this one) in the name of simplicity, and I strongly
> suspect nobody will ever ask for the other.

OK.  So should we revert the merge of the other one into 'next'?
That is easy enough ;-)

Thanks.

>   [01/10]: t9351: derive anonymized tree checks from original repo
>   [02/10]: fast-export: use xmemdupz() for anonymizing oids
>
>     These first two are actually a bug-fix that I noticed while writing
>     it.
>
>   [03/10]: fast-export: store anonymized oids as hex strings
>   [04/10]: fast-export: tighten anonymize_mem() interface to handle only strings
>   [05/10]: fast-export: stop storing lengths in anonymized hashmaps
>   [06/10]: fast-export: use a flex array to store anonymized entries
>   [07/10]: fast-export: move global "idents" anonymize hashmap into function
>   [08/10]: fast-export: add a "data" callback parameter to anonymize_str()
>
>     This is all cleanup and prep. More than is strictly necessary for
>     this series, but it does simplify things and reduce the memory
>     footprint (only a few megabytes in git.git, but more in larger
>     repos).
>
>   [09/10]: fast-export: allow seeding the anonymized mapping
>
>     And then this is the actual feature...
>
>   [10/10]: fast-export: anonymize "master" refname
>
>     ...which finally lets us drop the special name rule.
>
>  Documentation/git-fast-export.txt |  24 +++++
>  builtin/fast-export.c             | 161 +++++++++++++++++++-----------
>  t/t9351-fast-export-anonymize.sh  |  54 +++++++---
>  3 files changed, 167 insertions(+), 72 deletions(-)
