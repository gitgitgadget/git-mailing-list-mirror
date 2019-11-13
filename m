Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C193F1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 02:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfKMCLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 21:11:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54853 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbfKMCLm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 21:11:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAB622AB5D;
        Tue, 12 Nov 2019 21:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2BY6AvY39/8o
        madyOaTLL16U2jE=; b=G7b6JmYLLr6o9DMW627gHKqO8zhqL8pINulk6RoflLGw
        wFyElkhdbpGvnxMOD9d1SXiAclmGEUfB3FmOUyk/uAZR5SmnyMXyKoeqvSPX158g
        Va2DPcm5Ldr44L0h5byGrB7eFaepupCTv1q0E2OJ5YbiBaio/ZDN3cdZs0k7ZIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fiefGI
        /8b268Yg1KPII1OdNOZchS9QhCL6DgYEPnSkJ3bTi2L/d7lDz0qsKOLqS5bETVwz
        W0lYKp0w9X2u+a1QDEHij5UR+iy/66wrQfTEtirhtpKjKPgYWG586KVWxe5DJBEc
        JC1piMYkuFPkdcKxu2Kx8XJaz5PW8WBNmpA7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D36DB2AB5C;
        Tue, 12 Nov 2019 21:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 452CA2AB5B;
        Tue, 12 Nov 2019 21:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
Subject: Re: coccinelle: adjustments for array.cocci?
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
        <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
Date:   Wed, 13 Nov 2019 11:11:38 +0900
In-Reply-To: <5189f847-1af1-f050-6c72-576a977f6f12@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 12 Nov 2019 19:37:23 +0100")
Message-ID: <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED6384E2-05BA-11EA-A067-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> This reduces duplication in the semantic patch, which is nice.  I think
> I tried something like that at the time, but found that it failed to
> produce some of the cases in 921d49be86 ("use COPY_ARRAY for copying
> arrays", 2019-06-15) for some reason.

Thanks for mentioning.

I too recall that seemingly redundant entries were noticed during
the review and at least back then removing the seemingly redundant
ones caused failures in rewriting.

That is why I am hesitant to touch any patch that says "simplify
cocci rule" making it sound as if simplification is a good thing on
its own.  I have no problem with "we change the rule this way, which
eliminates this false positive / negative, that is demonstrated in
the added tests in t/ directory", though.

Thanks.



