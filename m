Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE59201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbdKPF3O (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 00:29:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61726 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934721AbdKPF3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 00:29:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A238A61D5;
        Thu, 16 Nov 2017 00:29:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h/nPS9U3cI3k
        PuGohbSXyNfUYJo=; b=LL+nBidgLEboqTB5zTRqFD47fJKEQfe3fDWN5ms54qlP
        R0N88HJcL55ZZ8HizauKS2NseewmLqEzuJMDThWIcx5m1hl79GIfVfFsnBAp5tCU
        vcut7aA9G7a1krjvXCV1OPjnvutZ6ZzH1rZxIsWVe48ZZ29rcTo1vfWqg2vYBoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wht+LW
        POlqh98c5PcUmx6lWEq4V795Vfa9X7fJxId11Skb5OfS2ck/NUo8rjg2ol6uDb5P
        E1O+RWh4DEMQm4L6ZtFBtthzl9GQDX9nGcgdkCb7Bclp8O5N1aaUvYKRLQLpf2PW
        akDW22XNV8Tqz2jdklPNfgxzQ4o7Ww/al133k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3146AA61D4;
        Thu, 16 Nov 2017 00:29:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0291A61D3;
        Thu, 16 Nov 2017 00:29:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH] config: avoid "write_in_full(fd, buf, len) != len" pattern
References: <20171115124043.17147-1-phillip.wood@talktalk.net>
Date:   Thu, 16 Nov 2017 14:29:09 +0900
In-Reply-To: <20171115124043.17147-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 15 Nov 2017 12:40:43 +0000")
Message-ID: <xmqqo9o2x04a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 130B2F60-CA8F-11E7-B2E5-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As explained in commit 06f46f237 (avoid "write_in_full(fd, buf, len)
> !=3D len" pattern, 2017=E2=80=9309=E2=80=9313) the return value of writ=
e_in_full() is
> either -1 or the requested number of bytes. As such comparing the
> return value to an unsigned value such as strbuf.len will fail to
> catch errors. Change the code to use the preferred '< 0' check.

Thanks, queued.  This seems to have come from 9a5abfc7 ("After
renaming a section, print any trailing variable definitions",
2009-07-24), which is rather ancient, but was made worse by getting
duplicated by 52d59cc6 ("branch: add a --copy (-c) option to go with
--move (-m)", 2017-06-18) recently.

