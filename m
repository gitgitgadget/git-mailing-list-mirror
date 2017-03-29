Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1203320958
	for <e@80x24.org>; Wed, 29 Mar 2017 21:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933087AbdC2VNo (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 17:13:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53938 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933024AbdC2VNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 17:13:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D270283A85;
        Wed, 29 Mar 2017 17:13:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GAP9DUHKHiDc
        Tkmsg/xLTHkpsJI=; b=nNcKKRRa3tCh0YkUiR+In+V+81x1reGiIEDKlc+pqr4/
        aItiJJ4g+qGJ0HZSukpvLSpIEEk2eW97XBK3E1jXyro3Kb2HtD7LS0ldosnApVLB
        vMegOR31jQ3BCCAvHNZRE/6UBiwjCdHxZJs6k2jbAfgjaoWLCNe+j+2jz6H0lIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ptUjKc
        fdbuSMSXFuAb26OMjgibbAY/sNFOJxyMxVAUAZvBVuM/UZ2qfFEsRHM3/DVJ+kZ8
        9m0vNIyQ3Nppy8w2DsmiD5bavEbWEm5QW3IzhNpf9KUMPIHlktMF5k1SHyTeXp6Q
        m0Y2RaIPe5250QXOfoN9S88TrA4KaMmxs2BUo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB4BE83A84;
        Wed, 29 Mar 2017 17:13:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2605C83A5D;
        Wed, 29 Mar 2017 17:13:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jeffrey Walton <noloader@gmail.com>,
        stefan.naewe@atlas-elektronik.com
Subject: Re: [PATCH v3] perl: regenerate perl.mak if perl -V changes
References: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
        <20170329135703.18860-1-avarab@gmail.com>
        <20170329181228.n4t77pashdnirl3a@sigill.intra.peff.net>
        <CACBZZX70oXn7McjavzvK5S30EXjXQhLixhb=WYbKCKYXVo1KBA@mail.gmail.com>
Date:   Wed, 29 Mar 2017 14:13:32 -0700
In-Reply-To: <CACBZZX70oXn7McjavzvK5S30EXjXQhLixhb=WYbKCKYXVo1KBA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 29 Mar
 2017 23:09:28
        +0200")
Message-ID: <xmqq7f37airn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9152947A-14C4-11E7-AA7A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We'll also redundantly trigger if you upgrade to a minor new perl
> version, but I think that's squarely in "who cares" territory.
> ...
> But I think overall leaning on the side of busting the cache more
> often to avoid cryptic errors is the right choice, and we should use
> "perl -V".

I'd throw it into "better safe than sorry" category.  I think we all
like the approach this patch takes.  Let's queue it and merge it
down soonish.

Thanks.

