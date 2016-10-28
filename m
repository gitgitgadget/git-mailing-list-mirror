Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4E72035F
	for <e@80x24.org>; Fri, 28 Oct 2016 17:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034379AbcJ1Rr1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 13:47:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52654 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034374AbcJ1RrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 13:47:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC0864AA40;
        Fri, 28 Oct 2016 13:47:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+gn9flR8cNyl5Au+nTTvGTsZvVI=; b=DbPfrA
        0k1aUstX39EsQmwWlgfioDoNxiLNRIv5LniS1odziZusbMJydEE0FU7VsJUMWIy/
        B4jWuQoY2G3bwPks5yi8XnvndT3Bv0Sl6GUxhjx6m+AUZL/va/622B0gjZEzJeAY
        RlNVGV22kPnPyEyUK9tCupCON11gdOdF/s1b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ps+6ad7o63PWpiwxuTE+8EPVP4Z7Zo3+
        ZNkZm5D73mgA5yS06flgcGZE1aFf1UcaJg5mdCsqy/ilP24K0hBZxATZQ4DAPUUp
        xZlgO0wBiPk2YOCC7HBOFiqJkIWDk9WPBjql36JiDn2mGPPha/dcpLA0Fzn+mcmA
        Wvf6PTFTlvo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D38104AA3F;
        Fri, 28 Oct 2016 13:47:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5061E4AA3E;
        Fri, 28 Oct 2016 13:47:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
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
        <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
Date:   Fri, 28 Oct 2016 10:47:21 -0700
In-Reply-To: <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 28 Oct 2016 10:38:03 -0700")
Message-ID: <xmqq60oc1i3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94F2257E-9D36-11E6-9A06-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Oct 28, 2016 at 9:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Setting FD_CLOEXEC with fcntl(2) may be racy, but in what way
>> it is broken to open(2) with O_CLOEXEC?
>
> Apparently windows doesn't even support it, at least not mingw. So
> you'll have to have some supprt for just explicitly closing things at
> execve anyway. And if you do that for windows, then what's the point
> of using O_CLOEXEC on Linux, and having two totally different paths
> that will just mean maintenance headache.

Ah, that's where your reaction comes from.  If I understood Dscho
correctly, what he said was that I cannot set FD_CLOEXEC via fcntl()
emulation they have.  It wasn't an objection to O_CLOEXEC.  In fact,
since 05d1ed6148 ("mingw: ensure temporary file handles are not
inherited by child processes", 2016-08-22), we have been relying on
open(2) with O_CLOEXEC even on Windows (by emulating it with
O_NOINHERIT, which Windows has) on some codepaths.


