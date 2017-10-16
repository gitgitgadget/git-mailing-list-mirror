Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496AD20372
	for <e@80x24.org>; Mon, 16 Oct 2017 01:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdJPBwf (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 21:52:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51649 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751801AbdJPBwe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 21:52:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F73FA0CDE;
        Sun, 15 Oct 2017 21:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4nXt6iZj1oDd81Uv6VsqhHXGBiw=; b=KQ2ntu
        meQ3snIoi/Ii6E64TljdaDSZSnctHUW1LM/EdsVZrmMFNRCctBm1vYa5oiBhSaVJ
        9swtkRi7r7XlmUMhkmnaWt5qYjnjBcOeGNM7KE6mlNFmXDqlpXBXs+q6lpT0mPz8
        PpdxRA2X79cLFoDObcqSSF3dNsLeODdDtWBag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pAnw2LculrmCHSJhwT6fTX1Y3H2rZWCX
        tgZ7M8phA6BWDcStF0GmosFCxEHskRi0YnK2BIJI8wQmvjLc1hNBjRl7kQIQhBXi
        uQCSXV0f6vXVc6IR/Kq/O5A2Prgaz+2qKi6YvIMcEwEe+Bj4PhPG+EL/kEGdyGed
        vcFwuCbUFUM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87456A0CDD;
        Sun, 15 Oct 2017 21:52:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4CFCA0CDC;
        Sun, 15 Oct 2017 21:52:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] sequencer.c: fix and unify error messages in rearrange_squash()
References: <20171013175157.13634-1-ralf.thielow@gmail.com>
        <20171015170742.8395-1-ralf.thielow@gmail.com>
Date:   Mon, 16 Oct 2017 10:52:31 +0900
In-Reply-To: <20171015170742.8395-1-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Sun, 15 Oct 2017 19:07:42 +0200")
Message-ID: <xmqqfuajuae8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACE9FAF0-B214-11E7-B6EE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> When the write opertion fails, we write that we could
> not read. Change the error message to match the operation
> and remove the full stop at the end.
>
> When ftruncate() fails, we write that we couldn't finish
> the operation on the todo file. It is more accurate to write
> that we couldn't truncate as we do in other calls of ftruncate().

Wouldn't it be more accurate to say we couldn't ftruncate, though?

>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e258bb646..75f5356f6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2948,9 +2948,9 @@ int rearrange_squash(void)
>  		if (fd < 0)
>  			res = error_errno(_("could not open '%s'"), todo_file);
>  		else if (write(fd, buf.buf, buf.len) < 0)
> -			res = error_errno(_("could not read '%s'."), todo_file);
> +			res = error_errno(_("could not write '%s'"), todo_file);
>  		else if (ftruncate(fd, buf.len) < 0)
> -			res = error_errno(_("could not finish '%s'"),
> +			res = error_errno(_("could not truncate '%s'"),
>  					   todo_file);
>  		close(fd);
>  		strbuf_release(&buf);
