Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF29A208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdHJS4y (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:56:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752552AbdHJS4x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:56:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98F24918D7;
        Thu, 10 Aug 2017 14:56:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7nLjgH28EM2N
        /WFDKFXXNV9Yp68=; b=xQmD7gCHLq06xX3Gk8eMKB/CdAfEEJqciFeDZoErcgkX
        RxrcXKh6EXExLkiBOdbs8yI0J1bkaT3CbvoXv9FReu4wUhTG0OG0IMPkUb0cUjGG
        dz6nDIbkPp2Zxc7KJnhLb6SQCa8W9sybKlrEY/F7IhDgNYctwH5jo43Ycbz13sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j7/ZWY
        /mpu7d1NglHp9uYHSfWu3PVMu6JZTrNNWXhnWMcvXpOTY1xxKo7nBq4jV2RzwL/G
        cqyzsu1buGWQSmbfrKc2BfUV71jhDWhMfAYqz4AEdzRnCTOcWxfUYCxVNS1h4W/s
        9+3vBYnwBDl/7dzuKJiQUsUWu6yTE8wDzoiAM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91610918D6;
        Thu, 10 Aug 2017 14:56:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00200918D4;
        Thu, 10 Aug 2017 14:56:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
        <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
Date:   Thu, 10 Aug 2017 11:56:39 -0700
In-Reply-To: <8e307474-d180-6d98-2c6b-062f2181bd14@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 Aug 2017 15:27:29 +0200")
Message-ID: <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A53735DE-7DFD-11E7-A594-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I doubt the type of file system matters.  The questions are: How much
> main memory do you have, what is git trying to cram into it, is there
> a way to reduce the memory footprint or do you need to add more RAM?
>
>> any recommendations on how to pin point the "offender"? ;)
> Running "GIT_TRACE=3D1 git pull --ff-only origin master" would be a
> good start, I think, to find out which of the different activities
> that pull is doing causes the out-of-memory error.
>
> "free" and "ulimit -a" can help you find out how much memory you can
> use.
>
> Also: What does "wc -L .git/FETCH_HEAD .git/packed-refs" report?
> getdelim() is used mostly to read lines from files like these and in
> the admittedly unlikely case that they are *really* long such an
> error would be expected.

There is only one getdelim() call, which was introduced in v2.5.0
timeframe, and it is used like this:

	r =3D getdelim(&sb->buf, &sb->alloc, term, fp);

	if (r > 0) {
		sb->len =3D r;
		return 0;
	}
	assert(r =3D=3D -1);

	/*
	 * Normally we would have called xrealloc, which will try to free
	 * memory and recover. But we have no way to tell getdelim() to do so.
	 * Worse, we cannot try to recover ENOMEM ourselves, because we have
	 * no idea how many bytes were read by getdelim.
	 *
	 * Dying here is reasonable. It mirrors what xrealloc would do on
	 * catastrophic memory failure. We skip the opportunity to free pack
	 * memory and retry, but that's unlikely to help for a malloc small
	 * enough to hold a single line of input, anyway.
	 */
	if (errno =3D=3D ENOMEM)
		die("Out of memory, getdelim failed");

So the function is returning -1 and leaving ENOMEM in errno on
Yaroslav's system. =20

I wonder if we are truly hitting out of memory, though.  The same
symptom could bee seen if getdelim() does not touch errno when it
returns -1, but some other system call earlier set it to ENOMEM,
for example.

If the same version of Git is recompiled there without HAVE_GETDELIM
defined, would it still die with out of memory (presumably inside
the call to strbuf_grow() in the strbuf_getwholeline() function)?
