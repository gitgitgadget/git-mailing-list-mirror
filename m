Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CAB1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfGXQSq (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 12:18:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51333 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfGXQSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 12:18:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FF97162068;
        Wed, 24 Jul 2019 12:18:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lim6EN6eM9nX
        pblJI/J3OFphmUE=; b=RiUPHO2z1jgdG/NKckdi5pHRK9q72QM8JJMF/ysnJL8T
        DFF1W9NAd87AmWfdJS4FhV5lnUGZtVukceUpmdjtRryb+0yLnNYKxzJbHIGuiNAQ
        zSajNPj+2PPivGX5wf+bUZnUH7T8PLAUVXzlqWv+k5pxX7o3F2lOZ4ySUNrMQbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L3juHv
        1RhfqIkoC8oD9Vo5RE+pWE0Dy0mDX6Vb2l8VCVohXmIPArXLaDcV7JI5U3/UQpXd
        n3pCkPbOYJXcvg2dt0drFBisdhlWLg5JcqP2d5oIf0JVg3NWsHkUEe8XcTmXuSjz
        RXLeEwoA0SQKTbpqmhojc/kjcnrXJdbs/xdFI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17895162067;
        Wed, 24 Jul 2019 12:18:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BBC8162066;
        Wed, 24 Jul 2019 12:18:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] grep: PCRE JIT fixes
References: <20190721194052.15440-1-carenas@gmail.com>
        <20190724151415.3698-1-avarab@gmail.com>
Date:   Wed, 24 Jul 2019 09:18:43 -0700
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 24 Jul 2019 17:14:12 +0200")
Message-ID: <xmqq1ryfs8ws.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B5514442-AE2E-11E9-B7AE-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> There's a couple of patches fixing mistakes in the JIT code I added
> for PCRE in <20190722181923.21572-1-dev+git@drbeat.li> and
> <20190721194052.15440-1-carenas@gmail.com>
>
> This small series proposes to replace both of those. In both cases I
> think we're better off just removing the relevant code. The commit
> messages for the patches themselves make the case for that.

I am not sure about the BUG() that practically never triggered so
far (AFAICT, the check that guards the BUG() would trigger only if
we later introduced a bug, calling the code to compile when we are
not asked to do so)---wouldn't it be better to leave it in while
there still are people who are touching the vicinity?

The other two I am perfectly OK with.  It is easy to resurrect the
support for v1 (which may not even be needed for long) and resurrect
the support for v2 with Carlo's fix, if it later turns out that some
users may need to use a more complex pattern.

Thanks.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   grep: remove overly paranoid BUG(...) code
>   grep: stop "using" a custom JIT stack with PCRE v2
>   grep: stop using a custom JIT stack with PCRE v1
>
>  grep.c | 46 ++++++----------------------------------------
>  grep.h |  9 ---------
>  2 files changed, 6 insertions(+), 49 deletions(-)
