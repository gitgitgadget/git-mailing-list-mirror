Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E372C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF0F216FD
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GW4jcRkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHRxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:53:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65407 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHRxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:53:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94B854C44D;
        Fri,  8 May 2020 13:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/cCsdw/3HhBQ
        XMd7gpa+twC0CKE=; b=GW4jcRkxZhoFqCdXQk0I6rUwjW+WovRsQ6Rd/yJWLLe2
        gf7LaJfbDFf4anhBuOrSadABEr6JaA7djMS9F5UXqDR7da4NSoj9mrWqeOKpQBj9
        j74vr0i3R4qG8CGnghEfwm6pfbowelNusa7YPJkkwAb5g8kBSfW37h01KPxbSZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fvmM7v
        Bug/Nk3jAPDNaGzbC5tVQWUcUslebYRSt5x4ZgNLgCTH6LUZrnZZvi9163U+zb9z
        JOAOAmAVV7Q8aG0nKomB51njEv2e/Zrt6ZmuP0ZHHQjGx8/08IJVpv+rSBR3BO/s
        g1FMwAW0WX6uGmavttmO8gpS3FT+gNdvnFjtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B54C4C44C;
        Fri,  8 May 2020 13:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 046734C44A;
        Fri,  8 May 2020 13:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: how is maint-x.xx updated?
References: <20200508172444.GA38186@Carlos-MBP>
Date:   Fri, 08 May 2020 10:53:00 -0700
In-Reply-To: <20200508172444.GA38186@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 8 May 2020 10:24:44 -0700")
Message-ID: <xmqqzhaixqir.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C2D69446-9154-11EA-80A0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> While testing some potential fixes that would apply all the way to 2.17=
.5,
> noticed there was no official "maint-2.17" branch documented anywhere, =
and
> while I could obviously create my own based on the last released tag, i=
t
> was missing the following `make test` breaking fixes:
>
>   macOS: 89c0b113a0 (test: correct detection of UTF8_NFD_TO_NFC for APF=
S, 2018-04-30)
>   NetBSD: 5826b7b595 (test-lib: check Bash version for '-x' without usi=
ng shell arrays, 2019-01-03)
>
> which begs the question; is this something worth documenting?, should w=
e care
> about maint-2.16? where is the line in the sand? can whoever is the pow=
er to
> be make sure if we ever do a 2.17.6 release to cherry-pick those 2 fixe=
s?

I do not know where 89c0b113a0 came from; 742ae10e (test: correct
detection of UTF8_NFD_TO_NFC for APFS, 2018-04-30) smells similar.

We usually do not touch releases that old and only merge
security-relevant changes.  I do not think these two qualifies.

Distros of course are free to cherry-pick on top of what we release
as v2.17.6 or whatever.

