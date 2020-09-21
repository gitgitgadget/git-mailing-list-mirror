Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41EC4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75E821789
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bC8SdzNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgIUUOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:14:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60161 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgIUUOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 16:14:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0B8FF5772;
        Mon, 21 Sep 2020 16:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TnrN5p0WEL1RPoihqU48tqePj0M=; b=bC8Sdz
        NkCeICg7lUdMpi6REiCFgCxsVTw92eJx4sX0LyOks024+Q5ktS3K225FAt1gl5an
        D1DutpdnvdcYE4lJOe7dg7qNrAUKcYoR17TbxixigGwdiJIH3jYNrsHUgd5di28g
        MQJ0f/pVsyxoRzofHynz7Ij1W+GrTbo0i4Sew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S7T1HA2ovEjuHNUpNJCNd8XhxuBlQVuG
        iw+Dd8r/5Zi0yjb/dJCKB6GG0BbdJLSuXX/MTAuuZ1/n3kQRSyzBgw33iMLeVA7r
        q65RDHd+UExLRSWOVkVdob3LKNurWN3R2In6TA0sm802vhVBTCFxZPqYOs4dME5Y
        MbMmyYQnIpA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9879CF5770;
        Mon, 21 Sep 2020 16:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3E06F576E;
        Mon, 21 Sep 2020 16:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Guyot <tguyot@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff --no-index
References: <20200918113256.8699-1-tguyot@gmail.com>
        <20200918113256.8699-3-tguyot@gmail.com>
        <20200918143647.GB1606445@nand.local>
        <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
        <20200918171950.GA183026@coredump.intra.peff.net>
        <xmqqbli3m0w6.fsf@gitster.c.googlers.com>
        <20200918180239.GA186717@coredump.intra.peff.net>
        <f338b63f-fd89-095c-b036-8d548fd2470c@gmail.com>
        <20200921193120.GB2399334@coredump.intra.peff.net>
Date:   Mon, 21 Sep 2020 13:14:13 -0700
In-Reply-To: <20200921193120.GB2399334@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Sep 2020 15:31:20 -0400")
Message-ID: <xmqq1riuga5m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0544EBA4-FC47-11EA-9860-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We'd sometimes wait several versions before that last step to give
> people time to adjust scripts, etc. But in this case, I suspect it would
> be OK to just flip it immediately. We don't consider "git diff" itself
> part of the stable plumbing, and the --no-index part of it I would
> consider even less stable. And AFAICT most people consider the current
> behavior a bug because it doesn't behave like other diff tools.

The "git diff" proper gets no filenames from the command line and
the above strictly applies only to the no-index mode, with or
without the explicit "--no-index" option.

It was a way to give Git niceties like colored diffs, renames,
etc. to non-Git managed two sets of paths, and the primary reason
why we have it as a mode of "git diff" is because we chose not to
bother with interacting with upstream maintainers of "diff".  In an
ideal world, "GNU diff" and others would have learned things like
renames, word diffs, etc., instead of "git diff" adding "--no-index"
mode.

And that makes me agree that users expect "git diff --no-index" to
behave like other people's diff and that is more important than
behaving like "git diff" for that mode.
