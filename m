Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B83C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AFB206D7
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pE2TjsSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgGXUS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:18:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61249 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXUS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:18:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B84DDD6DB;
        Fri, 24 Jul 2020 16:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yrzWFkpaXjfC08qV1EZQHdjjkzo=; b=pE2Tjs
        SgEQVkQFz6yqGIvC0c8Xetf03r9X1waotC3fefeYVaVfblNj94dwuZaZjl2CTAkE
        wjdmp7ZXXC+/nWCibXuU0r6tLo41BVz+D4BzCE2tcBpSnfwAfh7LFneY9PENl54E
        ddtIktfqyaEtRDSJGIxf4GM1tos/Y2yIQsfLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqLXwHyT3LbuASzpsRkD+nUY4Os1dZhs
        iWXVyRFENexKKyi1Afb7TdztbDaYoHo08X0kF6///kmvhlJTqUXfz0kN8UmiKTm/
        WsyOx2htW6fg1+WUuQ6w6bodDmife7CYJl9Q/J9bXWwV7RB19LCnjFvwyIz1CFZ5
        SZS1KaW6v+M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8562FDD6DA;
        Fri, 24 Jul 2020 16:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE705DD6D9;
        Fri, 24 Jul 2020 16:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <20200722074530.GB3306468@coredump.intra.peff.net>
        <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
        <20200723182549.GB3975154@coredump.intra.peff.net>
        <xmqqk0ytn208.fsf@gitster.c.googlers.com>
        <20200724194840.GA4013174@coredump.intra.peff.net>
Date:   Fri, 24 Jul 2020 13:18:21 -0700
In-Reply-To: <20200724194840.GA4013174@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Jul 2020 15:48:40 -0400")
Message-ID: <xmqqblk4ll9u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3424A96-CDEA-11EA-8148-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My big challenge now will be remembering to try to use this next time I
> run into a conflict that could be helped by it. :)

Yup, I installed it in ~/bin so that I can pipe diff3 result to it
for the next time.  Thanks.
