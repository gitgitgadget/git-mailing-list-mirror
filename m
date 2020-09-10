Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6322DC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DFA21D92
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZKGbjCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIJTox (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:44:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57709 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgIJPcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 11:32:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 962226AB89;
        Thu, 10 Sep 2020 11:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WVdYgRmtBSMB
        PV4rXg3lZ9SPI8c=; b=iZKGbjCfrq1aDJXdLtSk9DsGLQPNQefp2fCvBGReTU+i
        Oy4QFF/FKFRwY96G6jhTUVseZ5sB2knw4pfqEWuPLMifWmumC2vxqI/mxsgxYc3Q
        r2q/0nFcf2a4j5bLM7MWtupZ+JV3XBN52DF3wOyZGcGBCUdSVsrgOcg8yxUGz/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lOQegn
        zettXJh3dh2qfrb6ebnSqt0pQCYRAcG6ZzmYo0aLVxI6arD0juHWNrFtEVmeb4zA
        M8erHAJJW/FlI21u3hMuQ4SIf+y0is4yFnpMrS+G554uTiUGhbXh5hv0UWGq/X6D
        sXb7MV82x+vysvbmlT5iGV1kYm8saDy+MQZ2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D88A6AB88;
        Thu, 10 Sep 2020 11:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F7036AB87;
        Thu, 10 Sep 2020 11:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
        <20200908011756.GG241078@camp.crustytoothpaste.net>
        <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
        <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
        <3a72c5f2-35cc-a865-d5f2-02706c48d8ec@web.de>
        <xmqqa6xytwtn.fsf@gitster.c.googlers.com>
        <b48b2be0-c417-9140-54f1-73d0c59c40d5@web.de>
Date:   Thu, 10 Sep 2020 08:28:13 -0700
In-Reply-To: <b48b2be0-c417-9140-54f1-73d0c59c40d5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 Sep 2020 16:23:02 +0200")
Message-ID: <xmqq363pr6r6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E16A8C6-F37A-11EA-840C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> +	struct strbuf sb =3D STRBUF_INIT;
>>> +	const char *rel =3D relative_path(in, prefix, &sb);
>>> +	int need_quotes =3D *rel !=3D '"' && strchr(rel, ' ');
>>
>> relative_path() does not quote, so "begins with a dq" is not a good
>> test to see "if we were to pass this string to quote_c_style(), would
>> we get it back quoted already so we won't have to surround the
>> result with an extra pair of dq ourselves?".
>
> Ha!, that's true.  Makes me wonder how it was still able to pass the
> test suite, though..

The logic to refrain from ading extra dq-pair around the output from
quote-c-style is "if it is already in a dq-pair, don't bother".  The
bug will trigger only when the input string has a character that
needs to be quoted *and* SP in it.  In such a case, relative_path()
is likely to return *rel !=3D '"' and you declare "we need to add a
dq-pair ourselves", quote-c-style would give us a result in a
dq-pair, and you add one extra layer. =20

But without a test with a path with both '"' and ' ' in it, such a
bug would not trigger.  Brian's test only checks what happens to a
path with SP in it, without any other funny characters that need
quoting with quote-c-style.


