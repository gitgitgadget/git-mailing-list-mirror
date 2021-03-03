Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECAEC43142
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD58564E6C
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbhCDAXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59739 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387902AbhCCTe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:34:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8399CBD2B0;
        Wed,  3 Mar 2021 14:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ivaAsbUjw5+lehF6K47apihi5JE=; b=EeGlUB
        c4aBPr7f/SiKulGCu6OtzSV2YrOGBA9AMwKjUSi2pGSVOjDmtZP5iPeCfGP/J6Ic
        ovCEhDnFomr2Y1jTQtMv9Slhl7J2lT3a3FhYxZepa3zQmrrEJAecZEj5uqD8GwZh
        uYw35sj+/T2OkBLTuUZsa0E5C5Rgqk8OZctNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MluIJoFS5gIKZM8hnBH37OEDrTjfmoc/
        u+MIxKgNVT5t/sYKk57cVubPtHipSBV8J5CSCvwD4cyzuN9NpZPZZX9H0mywUtCu
        Xm2uMmyQQ0Wu5aRdjfIFIrQGASPgm+wN7m/42o1syLn4ZAjVJc/BlEeNgTKrExao
        dNky7wjA8zQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77888BD2AF;
        Wed,  3 Mar 2021 14:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E181CBD2AE;
        Wed,  3 Mar 2021 14:29:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/12] Simple IPC Mechanism
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <xmqq8s7cuebo.fsf@gitster.g>
        <YDiqeaNX/BeROFGf@coredump.intra.peff.net>
        <ff2eb93c-9b96-6fec-961b-adbe0fbda6fb@jeffhostetler.com>
        <YDlfDZcMkcfJ8N7e@coredump.intra.peff.net>
Date:   Wed, 03 Mar 2021 11:29:08 -0800
In-Reply-To: <YDlfDZcMkcfJ8N7e@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Feb 2021 15:50:21 -0500")
Message-ID: <xmqq8s74jat7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9B28382-7C56-11EB-A96E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And by "not interested" I don't mean that I think the topic is without
> value. Far from it; I think this is an important area to be working in.
> But it's complex and time-consuming to review. So I was hoping somebody
> with more expertise and interest in the problem space would do that part
> of the review, and I could continue to focus on other stuff. That may be
> wishful thinking, though. :)

I was not paying close attention to this series, and was planning to
visit it before merging it to 'next' but only to ensure that changes
to any existing code would not regress existing callers, so it seems
that we two have been with pretty much the same attitude;-)
