Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8051F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKNOuY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:50:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62007 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:50:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EF1A11CB71;
        Tue, 13 Nov 2018 23:48:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Afn/7uDOhBuB
        c1Y/qWNIYI7Wpj0=; b=WkJZCB8xwXI0q+X7drsSzLv9o2l3M0mixFEIuUPj1ahO
        sRJfMQBZaSattHZfIuNMqIzo4EbPGDamgkcbQi3C3/qM3VV8yiWCM4mYw2x4+lr+
        oIXdmlaESgPcjQmWPPD7woCb9TIfcZx6ksuZfk+SKcuajpS1/eFCwgxLMPzEDx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lXLUP5
        2y0P229yAGJcBkFIsulSHl/HT/93CehVV0ZHGeCr47Yn8PHNdoJOgAJhTNPzZnAL
        oCIbGLyJ71XYnQ3ZalFtBNIfXxXqRK/ECpp+I6XOwZGOX1npVrIvCObk6tXxYRvs
        76pf/XNV8EPm1jd9uDgIgHlT6xokshO92bWiU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 166D211CB70;
        Tue, 13 Nov 2018 23:48:50 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87AF611CB6F;
        Tue, 13 Nov 2018 23:48:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org, mduft@gentoo.org,
        stefano.lattarini@gmail.com, kusmabite@gmail.com
Subject: Re: [PATCH] git-compat-util: prefer poll.h to sys/poll.h
References: <20181114011043.27419-1-congdanhqx@gmail.com>
        <20181114014307.GM890086@genre.crustytoothpaste.net>
Date:   Wed, 14 Nov 2018 13:48:48 +0900
In-Reply-To: <20181114014307.GM890086@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 14 Nov 2018 01:43:07 +0000")
Message-ID: <xmqqr2fop8lr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 93E74586-E7C8-11E8-A72D-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Nov 14, 2018 at 08:10:43AM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>> POSIX specifies that <poll.h> is the correct header for poll(2)
>> whereas <sys/poll.h> is only needed for some old libc.
>>=20
>> Let's follow the POSIX way by default.
>>=20
>> This effectively eliminates musl's warning:
>>=20
>>     warning redirecting incorrect #include <sys/poll.h> to <poll.h>
>>=20
>> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@=
gmail.com>
>
> I think this patch is fine.  This was in SUSv2, and I don't feel bad
> about siding with a spec that's at least 17 years old.

Yup, I agree.  Thanks, both.
