Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DB52047F
	for <e@80x24.org>; Tue, 19 Sep 2017 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdISAId (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 20:08:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750886AbdISAIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 20:08:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6446FA839B;
        Mon, 18 Sep 2017 20:08:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=86tawLVUw5cvJzHSnt9GBFDna60=; b=pan0q1
        sv6S8c+iGQJske9u8qc7OBMdGiNijNNkoiqziCqdA9cvOtw2AmlohKbwKoQOmA3L
        i6MBKoyW1d5WcRPaqS0ZXLMV24PmP8F2v/Dlw01ABte0IFKgoiKT3LwKMGl+Ci7f
        HIis+9CIlrBfMXeJkp/yNxyyfhthLZKd6dWXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OOmjHhOEPSyUXa9ux/p4lInnDVuUi0oo
        p5qbv5FiPwZRbTJDDVT32iZqVolaPGhf21n6Gd8fEFd6jhn/aXtwWKck+lNC0Bj7
        TcRZipMjxZ4kKxgg9QQOzbBtg2GFhGZNP6Kynj3BGshmeopDUR7qErtmeMmnLY6M
        fLakkARZbps=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D1DAA839A;
        Mon, 18 Sep 2017 20:08:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7320A8399;
        Mon, 18 Sep 2017 20:08:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] read_info_alternates: read contents into strbuf
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
        <20170918155429.hgql4ngayun5nbyd@sigill.intra.peff.net>
Date:   Tue, 19 Sep 2017 09:08:30 +0900
In-Reply-To: <20170918155429.hgql4ngayun5nbyd@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 18 Sep 2017 11:54:29 -0400")
Message-ID: <xmqqvakfsg75.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABD737E6-9CCE-11E7-8708-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We could also just make a NUL-terminated copy of the input
> bytes and operate on that. But since all but one caller
> already is passing a string, instead let's just fix that
> caller to provide NUL-terminated input in the first place,
> by swapping out mmap for strbuf_read_file().
> ...
> Let's also drop the "len" parameter entirely from
> link_alt_odb_entries(), since it's completely ignored. That
> will avoid any new callers re-introducing a similar bug.

Both design decisions make perfect sense to me.

>  sha1_file.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

And diffstat also agrees that it is a good change ;-)
