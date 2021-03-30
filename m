Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF71C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BE361996
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC3AWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:22:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57732 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC3AVj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:21:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05F06B9AE6;
        Mon, 29 Mar 2021 20:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FnmxfPQcUo8W
        RflswP0ajDbQnpU=; b=GyAQeWWlXgOrd89ZfkXf5ATM4R9A4qCsQRiZosE8mlgQ
        JzjWShN8SwFZo/pBt7pByIzY9bCbL5Z2mY6/ioPvXop1RUridBf5T1rPDVqiyOiL
        dSbYZreJISllyGfy/sPOQLTgnsvx+TcLwR89HX/iqPORTL6Z2CLb97XSLluhLdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n2PPhq
        iXMj1iI+YeMyk36k/yqi5cCkmeDVWj18heH5H+hQ03G9996YPJEThGyEG776mHWx
        Pfl3qNKSsMAOfjkZ3RUGZM/kwUDGXM8YLpOS+hUbq2knrydY1s/CxQbzBp+qbah/
        sItKstm+1qiRy+u2CvoWK2hXY64QB5XC6mVg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBD6DB9AE5;
        Mon, 29 Mar 2021 20:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 582D9B9AE1;
        Mon, 29 Mar 2021 20:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
        <xmqqy2e5kegv.fsf@gitster.g> <87ft0dmtkw.fsf@evledraar.gmail.com>
Date:   Mon, 29 Mar 2021 17:21:37 -0700
In-Reply-To: <87ft0dmtkw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 30 Mar 2021 01:24:47 +0200")
Message-ID: <xmqqh7ktfq3y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4B7A0DE-90ED-11EB-AA77-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Really, does anybody else use "$(CC) -o $@" in such a way in their
>> Makefile?  Having to do this smells simply crazy (I am not saying
>> you are crazy---the platform that forces you to write such a thing
>> is crazy).
>
> Yes, if you do say a Google search for "Cannot open or remove a file
> containing a running program" you'll find that there's 15k results of
> people basically (re)discovering this problem in porting their software
> to AIX, and the solutions being some variant of "yes AIX sucks, just us=
e
> this 'cmd >x+ && mv x+ x' trick".

What I meant was if there are well known upstream projects whose
Makefile actually use

	$(CC) -o $@+ ...
	mv $@+ $@

I wouldn't be surprised if AIX community maintained collections of
patches to many projects to turn

	$(CC) -o $@ ...

in the Makefiles taken from upstream projects into

	$(CC) -o $@+ ...
	mv $@+ $@

to work AIX around.  As an upstream, however, I am not interested in
forcing that pattern on users of other platforms.

In any case, I do not care too much about the "I am building a new
binary while running, without installing, the one I built" use case
and do not agree with the idea of making the Makefile ugly only to
support such a use case.  That is where my comments are coming from
on this topic.  FWIW, AIX developers who do not do the "build, run
without installing, and rebuild while the old one is still running"
will not need the "$(CC) -o $@+ && mv $@+ $@" either, right?



