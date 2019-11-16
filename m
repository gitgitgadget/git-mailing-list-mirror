Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACE01F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 01:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKPBqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 20:46:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56154 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 20:46:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20FE5210B5;
        Fri, 15 Nov 2019 20:46:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jQITrf5eyo9G
        lvwRp4BsklROHao=; b=IKDk1jzxVca6V7UFiVmUo+5EUEwrsmfXDKxE2cvBoA2/
        0DLbzhsrjTghN7XYSzPo3E9fppAHQefwkEhNT3AfT6/PlSOM3wK2N9FGfSbmSOBV
        xwd3TQ7dGRN+Ijs158uNKZCAMSYnTw4p/L+BegTItvxyR7qMIyi7N94Eu6yetSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=own4Wh
        KLezvKBe4KL2RYsyVVWTR1zZENfdNHVczEI/zP3ezwy0TD2BolwTw9Z5WxPPQiED
        6i3eE/PwPpGlFeYXAT9xu2uUrSS+kzxqZnWDzjxtdWlAyR0Tuby5N3KeT841d8jC
        JnlkFaUZA6aUIV/zmLokiPsmXN6T9UgNPxV1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1856F210B4;
        Fri, 15 Nov 2019 20:46:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794D9210B3;
        Fri, 15 Nov 2019 20:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 09/10] pretty: implement 'reference' format
References: <cover.1573241590.git.liu.denton@gmail.com>
        <cover.1573764280.git.liu.denton@gmail.com>
        <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
        <xmqqbltd7juo.fsf@gitster-ct.c.googlers.com>
        <20191115131803.GU4348@szeder.dev>
Date:   Sat, 16 Nov 2019 10:46:51 +0900
In-Reply-To: <20191115131803.GU4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 15 Nov 2019 14:18:03 +0100")
Message-ID: <xmqqr228619w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F66FBFEC-0812-11EA-A6D6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Nov 15, 2019 at 03:07:59PM +0900, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>>=20
>> > +* 'reference'
>> > +
>> > +	  <abbrev hash> (<title line>, <short author date>)
>>=20
>> s/title line/title/ as you definitely do *not* want a line with a
>> title on it (and nothing else) in this context.
>
> Well, we just followed suit of the descriptions of other pretty
> formats, and they all say "<title line>".
>
> On a related note, the description of the '%s' format specifier in the
> same document is "subject", not "title".  Perhaps they should be made
> consistent, but I'm not sure.  I like that '%s' means "subject",
> because the first letter matches, but some man pages (commit,
> format-patch, am) make difference between a subject and a title.

Yeah, I think these are used more or less interchangeably, and we
may want to clarify the distinction.  Between the two, <title> is a
more appropriate "context neutral" name for the thing, i.e. one line
(technically, one paragraph) summary of what the commit is about.
Where <subject> becomes more relevant is when a commit is expressed
as a piece of patch e-mail, where <title> is used on the "Subject: "
header.

Thanks.
