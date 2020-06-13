Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03DBC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545DD2078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 16:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pcUM+X/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFMQvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:51:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50045 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQvf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 12:51:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15F7FD90C7;
        Sat, 13 Jun 2020 12:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YQJ1ellFUGbn
        GiUySd7C479SMH8=; b=pcUM+X/djix1sRsV2Wh8B32pl392u21+GInriBXN4zli
        IMVvYMCB8ip9+E+8NR4+pUQdfy2XE4fxZGYx4Yw81d4HNO2rkFEic+O8ksTk1vvr
        QGyJ66QWtrIQQbe39V6J2Jpe/MsOm130+hVsl+aHlKikkAYkc53PFJ3FV2AcM4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gUszaE
        yBesnD89184Bs+hnF/HTmso7jzlIYby/b3RkSLXFsOO9tB8BWVMiP5ZwQElzyuf4
        UFq07GlbNFQifEZBEmdUKxCzIJ6fSqi0LnJiT7sgPXBVXIBK0ZiQJdX/gJ55Uh7m
        cvTZdAE2F/0TmBdXGrd+VK7y8z0PtVCM6u+ok=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E634CD90C5;
        Sat, 13 Jun 2020 12:51:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 25BD9D90C4;
        Sat, 13 Jun 2020 12:51:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pkt-line: extract out PACKET_HEADER_SIZE
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
        <20200613142306.GA4680@danh.dev>
Date:   Sat, 13 Jun 2020 09:51:28 -0700
In-Reply-To: <20200613142306.GA4680@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Sat, 13 Jun 2020 21:23:06 +0700")
Message-ID: <xmqqimfuzz73.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 213004AC-AD96-11EA-AD23-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>>  void packet_flush(int fd)
>>  {
>> -	packet_trace("0000", 4, 1);
>> -	if (write_in_full(fd, "0000", 4) < 0)
>> +	packet_trace("0000", PACKET_HEADER_SIZE, 1);
>> +	if (write_in_full(fd, "0000", PACKET_HEADER_SIZE) < 0)
>
> I think the magic number 4 is easier to follow than some macro
> PACKET_HEADER_SIZE defined elsewhere. Because reader may judge that is
> the size of "0000"

I hate to admit it immensely, but I tend to agree with you.  In the
context of this single call,

	write_in_full(fd, "0000", 4)
	write_in_full(fd, "0000", PACKET_HEADER_SIZE)

I find the former vastly easier.

> How about (this ugly code):
>
> 	packet_trace("0000", sizeof "0000" - 1, 1);
> 	if (write_in_full(fd, "0000", sizeof "0000" - 1) < 0)

Yeah, that is ugly.  I was thinking more in the direction of
replacing these three-argument write_in_full with something like

#define write_constant(fd, constant_string) \
	write_in_full((fd), (constant_string), strlen(constant_string))

with some preprocessor magic to make the compilation break when the
second parameter to the macro is not a string constant.
