Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8074A1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbcHaUdz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:33:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55741 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752600AbcHaUdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:33:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE4AD3823B;
        Wed, 31 Aug 2016 16:33:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PfcLG5mdt7vR
        PW1p0Tlm3pIHFKg=; b=UqljyeU1dQgdUdgSwFZThPcpX/SqGT1iTAXybpj81Z99
        0IrPbNYwH44VlZZHzQcjpDnhmbux/mrBd9gXo50nFIphqON2/zE9otbx7WG17pcB
        WRnkDwOtvIgpa9cNC79nZqezpTf2xGPK69VP4xKowG6jlIJ/qrU1pfy+xAEFovU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iaU5yx
        9bQhhORmN7Cbs9ZLqOsdJZ0CQfI+7PEcAJGWIsjoGzLD3GfnkIdWCZze5fRoGWMd
        bFwGN1s8uxZlRmIJ3FeLOWCufjCKjMS/MNCNKHagQjWx+Vk2nWK4r+EmaLRMF2fS
        8V9+TG+E6U6y1Mwy8H8akO98ABjVB6cvgSz6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4C493823A;
        Wed, 31 Aug 2016 16:33:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1967738239;
        Wed, 31 Aug 2016 16:33:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
        <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
        <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
        <a948ad4f-2145-bacb-0ec6-7edac14c4d4c@gmail.com>
Date:   Wed, 31 Aug 2016 13:33:50 -0700
In-Reply-To: <a948ad4f-2145-bacb-0ec6-7edac14c4d4c@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 31 Aug 2016 22:29:48
 +0200")
Message-ID: <xmqqeg54znip.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B51674A-6FBA-11E6-B1BD-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Though xstrdup(buf.buf + 2) followed by strbuf_release(&buf) would
> make free(opts->gpg_sign) possible without crash.  That is we can
> work without *_entrust() mechanism at the cost of strdups.

Absolutely.

It is not like entrust() thing is free of allocation cost (it needs
to allocate an array of pointers to keep track of what to free) or
programmer's mental burden (you need to be careful what to entrust()
and what not to), so "at the cost of strdup(3)" is reasonable cost
of doing business in the way normal people expect the code to work.

