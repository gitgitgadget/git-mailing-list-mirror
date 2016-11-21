Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F50F2022D
	for <e@80x24.org>; Mon, 21 Nov 2016 19:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbcKUTHn (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 14:07:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50473 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752889AbcKUTHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 14:07:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 305324ED87;
        Mon, 21 Nov 2016 14:07:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P8oBipPzmn7ipHcN9GuJXUNgiSA=; b=KEaoe7
        zCDmvMrfyDYFoDQ9mJw4FsipY7wSRXybU0dXtTX+lEK1FS0i70FST4X6ug1VhzkO
        HHLt3MwqHW8faV0pZFKGAPxl0mzv5bgdLOeXJ4NAkAw+nUgU79oNzizKtTjILums
        wp3rRyPXTuAR6kMpltQvKg7JnJO0Hdq18IB6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vKrtBdZTUKj8X41b6WWF/mrJ4Y0He+0h
        E91iyZO1P2UKMVphjC4gKME6v3WReI+jElOJ3EED+2NprnoO0ySfPF5fujIj1qla
        +DUfglYoMIqcpUjWKDXkIv8hpnraNmQ7Pspa1ku9aX6FHSvKRbQBhCpc13FGpqvh
        QLUvh2aBABk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 263B34ED86;
        Mon, 21 Nov 2016 14:07:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 942144ED85;
        Mon, 21 Nov 2016 14:07:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: handle core.commentChar=auto
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de>
        <975c0002-8afe-efa6-d967-72f2a0d21169@kdbg.org>
        <xmqq37ikk762.fsf@gitster.mtv.corp.google.com>
        <8b783f3d-8fda-b5cb-239f-895b10a22a73@kdbg.org>
Date:   Mon, 21 Nov 2016 11:07:40 -0800
In-Reply-To: <8b783f3d-8fda-b5cb-239f-895b10a22a73@kdbg.org> (Johannes Sixt's
        message of "Mon, 21 Nov 2016 19:58:41 +0100")
Message-ID: <xmqqy40circz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6C6FD28-B01D-11E6-A81A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.11.2016 um 19:40 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> It could be written without forking a process:
>>>
>>> 	comment_char=${comment_char%${comment_char#?}}
>>>
>>> (aka "remove from the end what remains after removing the first character")
>>
>> Hopefully nobody would include any glob metacharacters in there,
>> e.g. "core.commentchar='=*'", which would break that?
>
> Heh. I tested a few variations, but not this one. Make it
>
>  	comment_char=${comment_char%"${comment_char#?}"}

I tried a few implementations of shells, and decided that this is
not worth the portability hassle.

Setting comment-char to multi-letter sequence is not supported at
all, and this code is protecting itself from that nonsense---it does
not need to be fast, and Dscho already gives a fast path for a
single letter case in his patch.


