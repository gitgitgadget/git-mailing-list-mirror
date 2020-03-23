Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049DC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83718206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MbR3PAOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgCWVxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:53:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64005 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWVxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:53:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90BF6BAD72;
        Mon, 23 Mar 2020 17:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pPZI24OJhj6epQuV7sRSau6eABE=; b=MbR3PA
        OIFuRvkk2p887Px+G1j5GKjVQ8xEPlc1uO5n0vvz9ZP+6eK66ASPlMqyTXo0edai
        IP7rbZQYoESjhWC510gVwn7XziYNeOWdxZmhhnzk1UAbP+LjnhdHEgYPHcySW3Td
        s6vrWXa0dX5bOI/WRb5Q8l7/JhrF+Q/Jyp8+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KNP7wz71AHWql2ieybBsRVOqtA4Ht4KD
        BpKyJpD4oS1batZBfHOQbeBn3vvY9mu809Fko6EKxcnfLQ9c59JHThNpH3fw3aXf
        /xtI/RGzXqPmcZ6yxK0s2pVx1wCNjQV4l2s8yHaB4MqlVMoVM/DFYEtDoNIep2vk
        c+3TF6v5QH0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8829EBAD70;
        Mon, 23 Mar 2020 17:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C637ABAD6D;
        Mon, 23 Mar 2020 17:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] import-tars: ignore the global PAX header
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
        <fce519db-5ad4-270f-abcf-0e26549486cb@web.de>
        <nycvar.QRO.7.76.6.2003232158160.46@tvgsbejvaqbjf.bet>
Date:   Mon, 23 Mar 2020 14:53:31 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003232158160.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 Mar 2020 22:05:28 +0100 (CET)")
Message-ID: <xmqqpnd23fhg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD42110E-6D50-11EA-A9E4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The tar importer in `contrib/fast-import/import-tars.perl` has a very
> convenient feature that I took for public knowledge: if _all_ paths stored
> in the imported `.tar` start with a common prefix, e.g.
> `my-project-1.0.0/` as indicated in the commit message (or `git-2.26.0/`
> in the tar at https://github.com/git/git/archive/v2.26.0.tar.gz), then
> this prefix is stripped.

Ahh, scratch what I said in my recent response.  No, the above is
not public knowledge, and that was missing from the log message that
confused me.

With that spelled out, yes, it makes sense not to allow the phony
"file" at the top level created out of the pax headers.

So, I think with a bit more explanation in the log, the patch would
be OK.   We do not want _any_ header.

Thanks.
