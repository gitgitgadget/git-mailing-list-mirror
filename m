Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF98C433DF
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67BF2074A
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZmLoOovb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEaQCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 12:02:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52464 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQCM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 12:02:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49760CCE38;
        Sun, 31 May 2020 12:02:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c/ImQUyY9Pza7ayeLKzXGY2o7+0=; b=ZmLoOo
        vbADsr8a2Q3s2ejti7frj476iND+ZKzi3vI4gDFP3+VzzT/jNPULe16zpF/+pjRT
        NkHWoLN26MyRfNsu/bQtf4E8wv8viFOKlTlaIqpP2PvWrlB9qyUNUJPmKDn+DdDY
        LRBHZ9QLDXqp5l2GUtErN7UuCDRXuG5IZPJ8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Skm+8Xsbmx0mABGkPQfcw4gY8gkfcVob
        PSDUzsWhFx5SDWYB1+Q80RazsZGExbgol57j5tXcdRenRcmpD/0LMZYzDmMQrazv
        hXe8VpxZ/GaoOSfd3VrkxpYNhJ41DVbGzURTKIKePS3/jZrbr6v+G26gDrGesYRi
        0QM5vCbBcX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41DB3CCE37;
        Sun, 31 May 2020 12:02:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82810CCE35;
        Sun, 31 May 2020 12:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
References: <20200525215751.1735-1-philipoakley@iee.email>
        <20200527072318.GA4006199@coredump.intra.peff.net>
        <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
        <20200528164533.GA1223132@coredump.intra.peff.net>
Date:   Sun, 31 May 2020 09:02:05 -0700
In-Reply-To: <20200528164533.GA1223132@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 28 May 2020 12:45:33 -0400")
Message-ID: <xmqqtuzww0si.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13F52184-A358-11EA-B894-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think:
>
>   git blame -b --since=1.year.ago ... | less "+/^[^ ]"
>
> works pretty well to get you to the right spot, with context (and then
> "/<enter>" within less takes you to the next line).
>
> But that's also pretty magical.

Instead of teaching each and every tool (like "git blame", "diff",
"grep", etc.) a special trick to remove the lines from its output,
it may make a lot more sense to add a feature to pagers that lets
the users selectively "hide" the matching lines given a pattern.
Then when viewing "git blame -b" output, you can first declare
"lines that begin with a whitespace are sometimes uninteresting" and
then tell your pager "now unshow uninteresting lines", "the same, but
show 3 lines at the boundary of runs of uninteresting lines", "now
show everything", etc.

That's another reason why I do not particularly find the proposed
feature interesting.

