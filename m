Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17888EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 05:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGFFII (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 01:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGFFIH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 01:08:07 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A931BEB
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 22:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688620064; x=1689224864; i=l.s.r@web.de;
 bh=CVftyoQJENrIeA+seyCaHXsYdubeOy1XiCHFdTWtShc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ro8pjMO/0V2Yb7K58oBhxlBJK8+A2/R/1ig6rG38FtdLhRRdrim4BCqe676I19AX+dzXyfC
 4frUmUfcpBROaafUeBRE3XOfEq+0dhQrp7r+5pI9ylqHoeLYDITAPp+nPMUXDGfKblkImRZqY
 r9svvHh6UTfmZG5/V0R23oYuL57I4GqhS+cpe+jZxBaBM2GiaEL30x3ToDk4J93pH26GEECev
 Ciiun1hPefRO18a53zYw4y+qfbdWEvDzNBvZFO+KTe+fMr8AqigZjVnXYw5zcWCWVBSSZOJbH
 9fjT7qolyL5AN7Hccoz757y6MzFnRBcNt5mjglRiAFNz2rfXyAmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.50]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1qNc5520PT-007c39; Thu, 06
 Jul 2023 07:07:44 +0200
Message-ID: <a5acfab5-0133-b3d6-3efc-c3f107e78b58@web.de>
Date:   Thu, 6 Jul 2023 07:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pkt-line: don't check string length in packet_length()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
 <xmqqttui3nqn.fsf@gitster.g> <32f41065-a78c-aa60-0d78-4dbfa8827b1a@web.de>
 <xmqq4jmiyu7s.fsf@gitster.g> <6f984150-5a98-b2b8-1791-b101f5953b7a@web.de>
 <xmqqsfa2uh83.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsfa2uh83.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZRQZHMcLDN84AR3UVeGhdkmH6uvI5X4qN7H2OBLmfvWuF0McVfz
 hvSoOwARQ+UNmMiwbDrgyTf7P3hOWR9hJjdhSMzy9ze6l40q75eTYwBHrCRioOHCn4476lH
 j2Joz0wvjWkrprNXbNXU+mssP0R8C7MAnVtg7erXy50GvsGOHhmx01nue/jHKX6rS4TPLRA
 VjR2RXwRE1Ur+Mz4yMg6w==
UI-OutboundReport: notjunk:1;M01:P0:PCqIb3ue4mU=;bL68/X5CbIHZqgmLhnQ2p/RHtWs
 fG2Hg0c8Ewklgmkp9/TE4PDWCL1OXj0elg+mAVa6W5xZa2RjdBsSIO4I9fmxk+DkZKhugn6Y/
 78NawAgKn8CbAXvk9OnmkaxDETvya4b+ajo8OWT8m/CLbEXhh4WhqwG7gy17Y8/iXVdmYBjd1
 vEHuZP+jVBZe2UZMyrg+qj3VttN7VBe2U3+nW13UZKRuhVJVuBcqnYEdm1CNR5VlMFJbZDkZD
 RBh0ue/8TctxOSygxA2kA5apYm9Qb3sibxSCFfrFhcXgIkCn+QsJf5DGzFWJzM0Qq1lqlNSPy
 aAlEFqIt+Yv4eaNMpqkz1Slydtww3aKTcTwm9Rnyz3edlwZG1/Kv5RZXQt2/NoLhS7exRdJqw
 6EtNcBTXc2k7iTD/3vpfxeabQxRC7ivHym+t73y99ivxEZun497+TQ5iTPDO8i3hvJBYU6+aZ
 cmkUoAbV+ufmCRsDHHe6+1IP48/QpVouU1kU6YHFvwWt72qwKOJeYDzZIXCRw7TM8iRchpya2
 HoOJkxIutTlYfW1LHnDoZ+g2BxKdpWZpsRjOJ/fIfIbFwNJrgaQWeh9ribFCXSA3kT249m8/N
 hXT3Yk1LzBsu50U/QQkYeeqJpX4BRVGYSZvtzLPvksLYj6OUbI/pbFEIirLy1VeQdT9Pgywek
 1mx/vkGWWW2u65ZCVW01aV1eM40umAEAMkpMMqVlz6d69qERD5UQ5cHnMOx+T/2WYXUWceBXk
 lnd/lC8Nz+MyeK2TCBN6HMezrlzimk00OyXn0sxnTj9WvouHOfuhIDMMv/GqzSecC3h0nv2DO
 LLVBD5p4lKomcnp0fPLpaXBL3PRNeI2qYb7uyEoTi1En+9FAKvJ6ZMVc2/82gj6QU0FjyGL6Z
 TPUsu6zV+0Lq/UZ3izzwr8GuZSHY+oW0c8a9PU5G9JFiXGG0XSl/7pv9gWViLRD75tggiUu5j
 7feh/Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.07.23 um 00:27 schrieb Junio C Hamano:
> hex.h:hex2chr() says "don't run over the end of short strings", but
> as far as I can see it does not check any such thing; find a page of
> memory, whose next page is unmapped, and pointing *s at the last
> byte of that page and calling it will happily run over the end and
> would cause SIGBUS.  The function assumes that such a short string
> is always NUL terminated, which is not a great way to guarantee that
> we do not run over the end of strings.

Yes, hex2chr() works with C strings, i.e. those that end with a NUL
character.  An empty string is just a NUL byte, a string of length 1
is a non-NUL byte and a NUL.  The function reads one byte from the
former and otherwise two bytes -- no overrun.

If a C string loses its NUL, how could you detect its end?

Ren=C3=A9
