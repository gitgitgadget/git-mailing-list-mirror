Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FCA207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942175AbcJFPxc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 11:53:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62134 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942114AbcJFPxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 11:53:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48F6A41590;
        Thu,  6 Oct 2016 11:53:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=US+/ptbvt3dvLCAh2Yn/FxMzy1U=; b=mfSc3J
        3Jj5mg2xOAjgpJTarbZ5gajW6Z891G7vhSm077us39/usd3X98fgFDtxXqSmJKgf
        Pay4LnuOEiQBAStHaczh0vcU2/J6+dwWpLyt9pyaxuVjHuEUo8FQ59EFtTI7hA6R
        5nQzdRkRn5+DatsRjVYcnbirck0Z6LQ4UCU7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nd8wgOItHPYzjMLvuh6NfjXVXyRBQlEL
        TPp/y5i5EOIarT8icIYYUEJ2WQ0t7/NfvXi3OYUk6QKy/SGs3n+CEER7X0fYJZXO
        igY/A1AIMlehqlBBuU5hf1jeLpHUwmOUjwK8cZzRJm+1XTEgIXANCNIuMqLUuxdR
        TAj2CWnQOPg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 405F34158F;
        Thu,  6 Oct 2016 11:53:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B879A4158E;
        Thu,  6 Oct 2016 11:53:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        ramsay@ramsayjones.plus.com, jnareb@gmail.com, j6t@kdbg.org,
        tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 04/14] run-command: add wait_on_exit
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-5-larsxschneider@gmail.com>
        <xmqqh98rud20.fsf@gitster.mtv.corp.google.com>
        <1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com>
        <xmqqeg3uo5yt.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610061129430.35196@virtualbox>
Date:   Thu, 06 Oct 2016 08:53:26 -0700
In-Reply-To: <alpine.DEB.2.20.1610061129430.35196@virtualbox> (Johannes
        Schindelin's message of "Thu, 6 Oct 2016 11:32:47 +0200 (CEST)")
Message-ID: <xmqqk2dlmq2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0622653A-8BDD-11E6-AD35-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio & Lars,
>
> On Wed, 5 Oct 2016, Junio C Hamano wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>> > OK. Something like the patch below would work nicely.
>> 
>> Yeah, something along that line; it would eliminate the need to
>> worry about a field named "stdin" ;-)
>
> Not only a need to worry....

Thanks, but I (and more importantly Lars, too) knew that stdin is
problematic when I sent the message you are responding to, as raised
by Ramsay in a separate thread:

    <f9b6abf6-8305-4a32-29af-765f08fee94b@ramsayjones.plus.com>

