Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F394EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGEVLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGEVLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 17:11:23 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A7819AA
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688591476; x=1689196276; i=l.s.r@web.de;
 bh=3th6pmM1QFa6W8KugDWlyhT/eFv4ry3MaWtUHZhtufI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dIxFN69nJ+D4yYYphm25Ac0/RFJPdm8AslY4H6oa8eb4eDY0OQD3O/6yoIjEPl9af759rub
 n/kfU6DgKLEJdwilLwhM0k+12Ig+aJlIymrxGFZcDr+xDmHGXhBlu8JFkl5fsmd0yCDtu518p
 mUao95vuNdkG6OEJPQckLY5zluDUT4YuFnt82CNYgaPwvlIdBNW4W3VbDGaj2MGL9qn2BrzpP
 w8he6HL17dJa+mUPCoNtOhUzaOFK/rREsVLHkhRdqVmwOzZeYm+8qdZu/6uPppVJcNFKvOPou
 E8RVRieSoZeIZlGjIyuhnnhJDOA2ur8nWJoCtbccAfLCYHhSTdDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.50]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1qHR1k3kI7-0010TE; Wed, 05
 Jul 2023 23:11:15 +0200
Message-ID: <6f984150-5a98-b2b8-1791-b101f5953b7a@web.de>
Date:   Wed, 5 Jul 2023 23:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pkt-line: don't check string length in packet_length()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
 <xmqqttui3nqn.fsf@gitster.g> <32f41065-a78c-aa60-0d78-4dbfa8827b1a@web.de>
 <xmqq4jmiyu7s.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4jmiyu7s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:seL9mHRF6pXc9Hb5g0hl+HliLh6H/AHYB6B9MaWVGb1iblaNZ8K
 k/02MbOU/xa+/O9MdzdQr1PBbMzpw29gecC5nG6mXrO4iN+FtEpAGinj9cKM4R+2o8GT8CE
 EAAUWpuvNkmimO/2vGDApgN5xc9ykKLrySOOwE8eoXnLt9m4a3dvCYfymFZjqtXoVMkVA78
 KMgElfjAvSoWWf1HhYEjQ==
UI-OutboundReport: notjunk:1;M01:P0:egWXUBdlK2k=;q2A+vki4jWj+JchU3PYUz9ow7rz
 AaQoFSSKznbL1fs/Bx6yRVbQIjCbWaIbGS793EfIqsByNgW2T45DPZulZ8AWMFSBn7eo3StaY
 Uk6WBdUTmKFfKtWtTKc6YtkYf8vF8hMwmnZpBXYGmBs6hB2o1m1eorwh1htoVEkcSjdrkOcXk
 YInK9wiiihD6MHtrYkNsyhtwTbg0UbjVJGGVCeGhgjN1ydLW1NWribtGp3RwcwvbzZTSfe0dS
 kEYc08mhrUDnzMJ6SYbgjPRpuX3NNCoacoE9nzmS+n2gkMSpQrEksqJM3sHzQ1sz64iDJT3ab
 Y/QlbxqbZ/XeaeLyWQ+N9Lmhs4ZA3bw+laE3dMi/D+X3jTTOckzfzjNtJMS8MKUgiMvx6t66J
 yYz9T96xbGJiFPnrz1R+kjsWSstQY98s5M+mPfXADbc44bRQ0Az3ulyb1+RxUMMPzXcronWM0
 w2ZdaARgLvAWA184cZ4l9m+futxs6g/8INcviuQBzE/DHDsBuIEjMZkwk4mofD1KTAT9bv14E
 gLmjU0V9/KMsykK43r2t3kbQdTbLvQimH1yIJrGFI7BYlNmZ/fwufJVS+5scb2bjkUUaK5BKU
 A9IP7tL+KDEGXwPcmJa7VjNGwoZ2BlSnAC7peso+u5uvmbLVwHYbNlvVUi526Upsuv/OZNELN
 VSy5aRg/Cp6kRZpmiq2EKlglaR1etyny1NsGes0f8n8xOz2Ya4q0t7KKU4VNkOuTAIx9l/ZG8
 STR8KiK3FH0VaRq44uwFMwALV8D0PAOU0RnCBXOqTa7XMY3Y56Z/glTHTBg/RVLKgc5oHmHu0
 R20CFJ0hd3VdggDkVup7QqtrW3nchAUYXjZ4OS6lg290PUrHOAYHpt+euBqMw8dM6Gr1v5roO
 bwrCCA/lA2vqNJIY7izNG+2DpWjtjNOyPFAsj2jijGwcOFM4oCUoOHGSspKOkZDn0ZRCrR7I4
 zxbYFEC12f5l9mTJ40OCEphrcnQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.07.23 um 22:33 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> I do like the resulting code, but I feel a bit uneasy to sell this
>>> change as "the code becomes more streamlined without losing safety".
>>> It looks more like "this change is safe for our two callers; those
>>> adding more callers in the future are better be very careful", no?
>>
>> With no way to enforce passing an array of a certain size to a function
>> the only safe options I see are keeping the length check, using a macro
>> or inlining the calculation.  Hmm.

Three more ideas: Wrap the buffer in a custom struct, pass the four
bytes as a uint32_t or as four separate char parameters.  I better
stop now..

> We keep repeating "length check" because that is what the comment in
> the function says, but even if the caller has 4-byte, that 4-byte
> substring at the beginning is what it read from the untrusted side
> over the network.  We should be checking if we have 4 hexadecimal
> length even if we are not running beyond the end of the buffer, no?

Sure, that's done.  If any of the four characters is not a hexadecimal
digit then packet_length() returns a negative value, before and after
the change.

> So it may be that the comment needs to be fixed more than the code.

Which comment specifically?  The one in pkt-line.h doesn't mention
what happens if you pass in a short buffer -- leaving it undefined is
OK, I think.  And in and around pkt-line.c::packet_length() I don't
see any comment?

Ren=C3=A9
