Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44647C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0553164F6C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhBBW4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:56:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:52121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232975AbhBBW4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612306478;
        bh=HNzosIAalgzU+dwP8cnEUlD5tkCeDQwvBjyy0I3q1tc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JtvuYqDwMRqrGdi6fk5rRZAyaz3HkWaOH/x6mLFIpu4GOZSd5126h4U/rcE32BrzR
         kXrP3rkrGN3TNwDPXpKx6cT9NfhXR6o01KoGBjJyAcGighRo8cLy605wOKOR3/67nE
         XxNebsOGjO5V87Pd1/HYl9eZ+BVNhlwLP8HcLhgs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1loPmy2IUo-00lzO2; Tue, 02
 Feb 2021 23:54:38 +0100
Date:   Tue, 2 Feb 2021 23:54:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 02/14] pkt-line: promote static buffer in
 packet_write_gently() to callers
In-Reply-To: <YBkeYSA5UfQP1m/x@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2102022340460.54@tvgsbejvaqbjf.bet>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com> <pull.766.v2.git.1612208747.gitgitgadget@gmail.com> <3b03a8ff7a72c101f82a685cc6f34a5dd37a9c4b.1612208747.git.gitgitgadget@gmail.com> <YBkeYSA5UfQP1m/x@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qFXuEo2+6CevHMHYMFy1TXI8WvLXAt3Z3yS9uXw3JY5VAUXnsGP
 CB80OGsknRMV2cyCKMqxPkNIrFY47J8guLI4CUyIimzKBpKtk1xLDxW7fwo9F7BLt2baCdX
 vg0hG6WC2O84AhclBeK50p4hx0cTJgcq3d43+alo4OqnUSCTM80u9j6rqJPip9rQVio8fbU
 EGzZbEANl9VA0n3Bc2YKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWem6pje130=:g4OpRmC2uT88QoacEwPWug
 dFIHKgXDW3O0qUP7b0V/r23FWbfMZLW5jRoW4Gjc9SplLzFYqTnRX/rjYDJns4Gx0z9g+veX5
 axHupw+AVTq6WUPoGliWXMKRy5mF3c8LWQjcBJadZvyGTOF8FcjOI+TMxXrdKpZMN9u+J+k0F
 4LhQ/ASOdRQrpFbeP1ROiTMRK2vFW+8gxRAtTw8r+e4bcnYLCLeUVKVWuBDOZakMtOZ7CUqjQ
 kANf7YX+2BTqsHhvpWC988GambgaU8kvRzCfeHDgCtoQhtvGxvQFVYoWnKto0OXUYq7USu9qT
 7BEmBRfqv+0ir/JiQ10A9MSjRyVyxbpC3+onuk/+z+wNb9g7pBL+cwEY3mz9DXG0leC6mFM+W
 GiaAMzTMFMtcjN1xMFhso3PS/D9RFSA9oqZ4fVD1Rvjbk3qlupa/l0+YSYWGofXTQNUueMVIZ
 5DfRuJLZxnvM7B3F3L/YkkF0HkjURi4tigBIMp2V/5lzDygVnQ3CzD/nZL9sv9Tu+fTTBqUI1
 w7iGrAnEltTFL8jJIWaUA9Sto7S0inFgQDuesVh1fhZVB5ZcF+trfMwF/noOD6T5wa0EsDUtC
 Sp7HOhQUoeXwdrkk5uoia0QdL0vEiYiAGh3tJAZooUEnDEpLBHcus//eg1hsTB9jk1JWesz53
 Oj5AeE0O8XWNl+P7RpDzQU8gX5T9OKQ7suiGSKRIWkDamsggtAdwD3vctOpPX3ykLUu2vJ4Eq
 bY+zyA3KqLsK3isgA+7VzqwIQ4iOvNdtCMeWFacaOreKiJ/dzhAbpwEXjlwcAVZtlJZLJlSKZ
 0q++QfrL7fNOnb3A/RaK31FoNP1MKx/iZ4tr+nV4FgCwcM+jM9Lx9iaVIgsLeBFWs+kk4p0BX
 eJwgWmVxQ5h6S9gO1SrV6z4EiCdPTAmpkQKM5equU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 2 Feb 2021, Jeff King wrote:

> On Mon, Feb 01, 2021 at 07:45:35PM +0000, Jeff Hostetler via GitGitGadge=
t wrote:
>
> > [in packet_write_gently]
> > -	set_packet_header(packet_write_buffer, packet_size);
> > -	memcpy(packet_write_buffer + 4, buf, size);
> > -	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
> > +
> > +	set_packet_header(scratch->buffer, packet_size);
> > +	memcpy(scratch->buffer + 4, buf, size);
> > +
> > +	if (write_in_full(fd_out, scratch->buffer, packet_size) < 0)
> >  		return error(_("packet write failed"));
>
> Would it really be so bad to do:
>
>   char header[4];
>   set_packet_header(header, packet_size);
>   if (write_in_full(fd_out, header, 4) < 0 ||
>       write_in_full(fd_out, buf, size) < 0)
>           return error(...);

There must have been a reason why the original code went out of its way to
copy the data. At least that's what I _assume_.

I could see, for example, that these extra round-trips just for the
header, really have a negative impact on network operations.

> I doubt that two syscalls is breaking the bank here, but if people are
> really concerned, using writev() would be a much better solution.

No, because there is no equivalent for that on Windows. And since Windows
is the primary target of our Simple IPC/FSMonitor work, that would break
the bank.

> Obviously we can't rely on it being available everywhere, but it's quite
> easy to emulate with a wrapper (and I'd be happy punt on any writev
> stuff until somebody actually measures a difference).
>
> The other direction is that callers could be using a correctly-sized
> buffer in the first place. I.e., something like:
>
>   struct packet_buffer {
>           char full_packet[LARGE_PACKET_MAX];
>   };
>   static inline char *packet_data(struct packet_buffer *pb)
>   {
> 	return pb->full_packet + 4;
>   }

Or we change it to

	struct packet_buffer {
		char count[4];
		char payload[LARGE_PACKET_MAX - 4];
	};

and then ask the callers to allocate one of those beauties
Not sure how well we can guarantee that the compiler won't pad this,
though.

And then there is `write_packetized_from_buf()` whose `src` parameter can
come from `convert_to_git()` that _definitely_ would not be of the desired
form.

So I guess if we can get away with the 2-syscall version, that's kind of
better than that.

Ciao,
Dscho

>
> That lets people work with the oversized buffer in a natural-ish way
> that would be hard to get wrong, like:
>
>   memcpy(packet_data(pb), some_other_buf, len);
>
> (though if we wanted to go even further, we could provide accessors that
> actually do the writing and sanity-check the lengths; the downside is
> that I'm not sure how callers typically get the bytes into these bufs in
> the first place).
>
> That's a much bigger change, of course, and I'd guess you'd much prefer
> to focus on the actual point of your series. ;)
>
> -Peff
>
