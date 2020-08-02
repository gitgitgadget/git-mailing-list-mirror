Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84650C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364EE2054F
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sgtGvsQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHBRf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 13:35:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61030 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgHBRf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 13:35:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B99F16EDCC;
        Sun,  2 Aug 2020 13:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q//8XkBRMYjYUM8Y79TzkIX9mX8=; b=sgtGvs
        Qt1bb1EzKWgct17FqTWI2+MT5oUc/XZXGLLecfRK6TbAXtA4O379G+gR/RtjpDrO
        xauvjVbup/wQ8KrZgbJPBcDemdFL7oNHNVhuZMdx6WABezQyk3U+RtmProLXpJN2
        IlujhvOhuDlZujwmkmY9utLcKKJET5uJ5rIzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dS8MnXQc9iD66ZqEnngouDygi2Y9MelA
        BPGWuRrWMpvq/CNO2wf6TlmPSJapNS5+FbeKaZyRON5h9PPDxpm20YPGrcx/tWVW
        gEXxbUuScXClE353mUXdtv680U3VSQ9FgWerXTTwANxLpNpDMyK4Xt0CzAhaEUYA
        tUUE56nGTBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC6516EDC9;
        Sun,  2 Aug 2020 13:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12ACC6EDC8;
        Sun,  2 Aug 2020 13:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru>
Date:   Sun, 02 Aug 2020 10:35:25 -0700
In-Reply-To: <87mu3drynx.fsf@osv.gnss.ru> (Sergey Organov's message of "Sun,
        02 Aug 2020 15:59:46 +0300")
Message-ID: <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CF990F0-D4E6-11EA-9422-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> What I in fact have in mind is something like:
>
>   --diff-merges[=<parent-number>|c|cc|all]
>
> to have a single point of definition of the needed format of merges
> representation.

A command line option that takes _optional_ argument is evil; it
hurts teachability (e.g. "why does this option always require
"--opt=val" and refuses '--opt val'?").  Making the optional value
configurable is even more so (e.g. "teacher said to use '--opt', but
it does not behave the way she taught---ah, I have this config").

> Then comes the question of the default. "all" is what'd make it behave
> as "-m" behaves now. If it's too late for --diff-merges to have
> different default, could the default possibly be a configuration
> option rather than yet another command-line option?

Introduce --diff-parent=(none|<parent-number>|c|cc|all) that is
different from --diff-merges, and -m and --[no-]diff-merges can be
defined in terms of that, at which point we can gradually deprecate
them if we wanted to, no?

