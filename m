Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152E6203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941740AbcJ1Qsx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 12:48:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56856 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933078AbcJ1Qsw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 12:48:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9D0A4A2FA;
        Fri, 28 Oct 2016 12:48:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J6fmRft5P7O0S9o9Bsrxlz37Gk8=; b=LDjExE
        esJGBS9czztPaWGD+my/7duyV9Tx2qUr6dQxgNbAoyX6BeEwEw2n8gMyd6pRx4LA
        sx/2iFJLRDs05RvOvmYVQi+yBuExyUzTRXcrcl2itaKqXz7fgHNmKH8QWzff40VI
        FKdcnvM1YkdBV02Lxi5vkrM+ad7xuJa+ZfN30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jtEZ4LRFbGNClSl7uw4/R0Yja8zmkMwr
        i2eBQH1O3C0/xcSc7s3PZIeZFzEfPFJMMHM3lebzZnByznxOiMFUefYgfoZNN8uZ
        RdqlG3rZAZEisQxtDw+WxaWoi2RM3aOFSWqBpTDBqIk2CZ0ni9IGyc7VH1hM2pCT
        ZqPJVOHiijY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A12094A2F9;
        Fri, 28 Oct 2016 12:48:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 152DF4A2F8;
        Fri, 28 Oct 2016 12:48:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
        <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
        <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
        <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
        <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
        <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
        <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610281306320.3264@virtualbox>
        <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
Importance: high
Date:   Fri, 28 Oct 2016 09:48:48 -0700
In-Reply-To: <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 28 Oct 2016 09:13:41 -0700")
Message-ID: <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66E4B71C-9D2E-11E6-BDDD-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Oct 28, 2016 at 4:11 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> You guys. I mean: You guys! You sure make my life hard. A brief look at
>> mingw.h could have answered your implicit question:
>
> So here's what you guys should do:
>
>  - leave O_NOATIME damn well alone. It works. It has worked for 10+
> years. Stop arguing against it, people who do.
>
>  - get rid of all O_CLOEXEC games. They don't work. If you want to
> close file descriptors at execve(), you - gasp - close the file
> descriptor before doing an execve.
>
> So O_CLOEXEC or FD_CLOEXEC is broken.
>
> DO NOT BREAK O_NOATIME JUST TO ADD COMPLETELY NEW BREAKAGE.

Excuse me, but care to elaborate a bit more?

Did I botch the way I ask fcntl(2) to set O_NOATIME in *1*?  Its
follow-up in *2* is optional and as peff said in *3*, I do not think
we mind dropping that step and keeping O_NOATIME.  It is not that
much code to keep.

Setting FD_CLOEXEC with fcntl(2) may be racy, but in what way
it is broken to open(2) with O_CLOEXEC?

If we want to close file descriptors we opened at execve() time
ourselves, we'd need to somehow keep track of which file descriptors
are meant to be closed upon execve() time, and one way to mark that
may be to use O_CLOEXEC, but once we mark a file descriptor with the
bit, execve() would take care of "closing" it for us---wouldn't that
be the whole point of that bit?


*1* http://public-inbox.org/git/xmqqh97w38gj.fsf@gitster.mtv.corp.google.com
*2* http://public-inbox.org/git/xmqqd1ik38f4.fsf@gitster.mtv.corp.google.com
*3* http://public-inbox.org/git/20161028075104.la24zydnr3ogb6qv@sigill.intra.peff.net
