Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDED3C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D4120665
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tgDVrn/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFSZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:25:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63598 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFSZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 13:25:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84A42B1C8A;
        Fri,  6 Mar 2020 13:25:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZBI+9vo47lqLlA2sFt0yD4tiw+E=; b=tgDVrn
        /cEVVNyaPgIx/a734xba4CYQqEFH/bYAVbVsa789037YdD7IW46sBIm5iB0nSs9h
        DrwjyXaKp0nOX9R7x3EYOB4c2IX1F58deG5jmsmVRAljQBECpeF+ef0IMIKAUKaA
        x+vNidrZMpr3GrDA8RQ1OOD3xLUu/1LzFldpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l/1wlvPa0ChLuQzVl4gqe962O3xXSgiv
        Uixe+e2Sa7v/pdbeKaRXvZzjLk5Yyx5sSKV+5T5VV+OKfPhsPfJ9y4kmOqJ2F5qw
        blw2fUoooPn9IGON7TTIFifRQCEETUMjJXPcKxMI9q6u22MMRN/nTCdPwptsmbhm
        XPLQ/ogue7U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C477B1C89;
        Fri,  6 Mar 2020 13:25:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A3B17B1C85;
        Fri,  6 Mar 2020 13:25:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
        <nycvar.QRO.7.76.6.2003061453260.46@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Mar 2020 10:25:14 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2003061453260.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 6 Mar 2020 14:57:52 +0100 (CET)")
Message-ID: <xmqqmu8t2ved.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3F49376-5FD7-11EA-A1E8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If we want `bugreport` to be a first-class citizen, we should
> treat it as such.  That entails making it a built-in.

The question is, for "bugreport", if it is better to be standalone
or to be built-in, and I do not think 'first-class' has anything to
do with the question.  The transport based on curl-library are
separate binaries but they are of course first-class citizens.

Pushing and fetching will happen a lot less often than local
operations like "add", "commit", "show", and not paying start-up
latencies to load code and link libraries that are not necessary for
local operations in built-in, while paying the cost of having to
duplicate the memory and disk footprint necessary for libgit.a stuff
by making the transport binaries separate from the built-ins, was
conscious implementation decision we made earlier to prioritize the
reduction of overhead of subcommands for local operation.  Yes, the
decision de-prioritizes the transport, but that does not mean they
are not first-class citizens.  It just means that the start-up
latency for them (e.g. linking with libcurl) is not huge burden for
the overall time cost for the network transfer, and it is necessary
cost for them to perform what they need to do anyway, while it is
something subcommands for local operations should not have to pay.

> That entails teaching
> `git-remote-https` (and potentially other non-builtins) to sprout that
> option to enquire other information that should be included in the
> generated part of the bug report.

I think later rounds of "git bugreports" already did so.

As I mentioned in a separate message to JeffH, this is a good thing
to do, whether "git bugreport" is a built-in or a standalone.



