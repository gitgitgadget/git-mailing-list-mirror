Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2681F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 01:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKRBoo (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 20:44:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57981 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRBon (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 20:44:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F9DF2C93E;
        Sun, 17 Nov 2019 20:44:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NW/HSk0ESIDt
        w1FbQ4XabX0BaAI=; b=fGlnar1baRBErhAKSgIawz10ycEuw6r+WsgA2ckT8x1B
        Qe+V03bt09gMhvpYeg31d0UR23C8+P1lrGW/jXDmCoPxRT6paX5s3iTmoSE06j4X
        1znEqMIDeuZv8UCE0rDvU6NTUAG8V1YR7eFgAvn+GFFuBn1P3WedzcoRAUf+bqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Rib+cQ
        1pb9NLhVgctJmf4indk5anAN9Gn5L7RAxYWmpYTpjgkpyWPUweNOOSzcIIues8sm
        4tasdBTBvXzmqC7pbY8/samAk17qEVvKbEYvZh0ktpGt1I5SvtPsUcSm1KGIrtiB
        8PR7pWUuFW0MkWPE3+ZjXsMvG4YUojchBTVq0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96A6D2C93D;
        Sun, 17 Nov 2019 20:44:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F20632C936;
        Sun, 17 Nov 2019 20:44:40 -0500 (EST)
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
        <xmqqr228619w.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Nov 2019 10:44:39 +0900
In-Reply-To: <xmqqr228619w.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 16 Nov 2019 10:46:51 +0900")
Message-ID: <xmqq5zji3qm0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCE0B4A6-09A4-11EA-989A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> On Fri, Nov 15, 2019 at 03:07:59PM +0900, Junio C Hamano wrote:
>>> Denton Liu <liu.denton@gmail.com> writes:
>>>=20
>>> > +* 'reference'
>>> > +
>>> > +	  <abbrev hash> (<title line>, <short author date>)
>>>=20
>>> s/title line/title/ as you definitely do *not* want a line with a
>>> title on it (and nothing else) in this context.
>>
>> Well, we just followed suit of the descriptions of other pretty
>> formats, and they all say "<title line>".

Sorry I failed to respond to this point.  I think it is OK to leave
it <title line> in this series, then.  Updating them need to be done
for all at once together with other formats.

Thanks.
