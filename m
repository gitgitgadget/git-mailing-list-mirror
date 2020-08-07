Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E6AC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9FA2177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RyVOJv/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGVyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:54:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58067 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGVyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:54:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D50B26C7FA;
        Fri,  7 Aug 2020 17:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=foFfoXLXErNq9yxeWfYTX/oUiyI=; b=RyVOJv
        /2NFxvxfe7aQfwwLHAY73ZRoL2jbOWQKw7D6jWI2GaoiZuAyLiYbGoUxRdSVWk8v
        ymB+VC634Mcl16347ZyzWYrr6EcSWKeksiWNb1jgaH5OD/VOjwaFrsa0AUlF/lHF
        WUj1vDg/p8JwDU1zJz6GXIJGXKe42zAqqtRoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lcNoPqwr7//9KVnGQxyJA1oD1hbbkHVT
        piJo/Id3LZ8luLrfZW0L4wXmD27DNV6V7/krai5DE/DiCZMTfSN5IgdvDvwMGyQ6
        eH2PUnbxVIk8zsovm+29g8rqhO+cfRQnYlD4Lh+36YrM0U9fMPQcdoWJosFEUxKT
        rxa6LDxQ65A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CDAE6C7F8;
        Fri,  7 Aug 2020 17:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 006E76C7F6;
        Fri,  7 Aug 2020 17:54:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com> <87tuxel17m.fsf@osv.gnss.ru>
        <xmqq8seqgrx3.fsf@gitster.c.googlers.com> <87a6z6kxmm.fsf@osv.gnss.ru>
        <xmqqv9hufaxc.fsf@gitster.c.googlers.com> <87y2mqjh9f.fsf@osv.gnss.ru>
Date:   Fri, 07 Aug 2020 14:54:04 -0700
In-Reply-To: <87y2mqjh9f.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        08 Aug 2020 00:08:44 +0300")
Message-ID: <xmqqft8yf7gj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 830A3CBE-D8F8-11EA-A125-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> The only question regarding it I then have for now is what are
> preferences for names selection inside single option? Abbreviated yet
> somewhat sensible, or verbose? I mean:
>
> --diff-merges=first vs --diff-merges=first-parent
>
> --diff-merges=comb vs --diff-merges=combined
>
> etc. What's better?

If we were to shoot for easy-to-type, we could go for ultra-short
abbreviations like 'no', 'c', 'cc', 'each' (the last one is the
traditional "-m" when used without "--first-parent"; diff with each
parent) and later add 'fp', but in a sense we are already lost the
easy-to-type goal by "--diff-merges" being sufficiently long.

I personally wouldn't choose "first" or "first-parent", but just use
"1", so that we could support "2" when viewing a merge that was done
in the wrong direction with "git show", though.  IOW, even though I
said that "use these parents but not those" (i.e. set of parents)
smells overkill, at least to me, I think specifying a single parent
that is not necessarily the first one would be a reasonable thing to
do.

So, if I were to vote, it would be

    "--diff-merges=" ( first-parent        | 1 |
		       combined            | c |
                       dense-combined      | cc |
                       each-parent         | m )
    "--no-diff-merges"

leaving some room to add '2' and  <any posInt> later.
