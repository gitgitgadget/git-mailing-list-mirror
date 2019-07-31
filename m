Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5901F731
	for <e@80x24.org>; Wed, 31 Jul 2019 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfGaQS7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 12:18:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57102 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGaQS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 12:18:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3090F7DAAF;
        Wed, 31 Jul 2019 12:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YQiIGLYX5GaX0ygXaSdEOIuoSjE=; b=YzxSa5
        mzcDmi7e4HeoS4QdbqVhKeaeNlsdYHmYlHHHK1b+uQW64eYud+Mps2YsEV2dImJ/
        aprE7/4ZU1v1q/ESc7bP+mneax5Jasx94k7JKngmeYHcuiKjCNMG7AOPR0ZSsRBT
        gaqoEyT9EjMEB1V1KIzyFTH13Oz/s1YDIWL6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZZJ7OnckVA8umZh9scmsGfvAEpXCjcFA
        Tw8FSSXWY6PXKuGEo9s8j+Dm8JcUR1jPfmOumV4D4J58EKh+j5p2ulH4NZkYet7h
        LRtcNcsNJX8+n2BhzqkmK7IKdgRrxWana/cENWzBHI2NEqr4F1f/SiQstb5yFCC1
        RK1V+/qLGCg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28D7F7DAAE;
        Wed, 31 Jul 2019 12:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E1C87DAAC;
        Wed, 31 Jul 2019 12:18:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, avarab@gmail.com,
        sandals@crustytoothpaste.net, dev+git@drbeat.li
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
References: <20190728235427.41425-1-carenas@gmail.com>
        <20190729105955.44390-1-carenas@gmail.com>
        <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de>
        <xmqqh874vikk.fsf@gitster-ct.c.googlers.com>
        <CAPUEspjo3Uo8KtSYQ=uh+_gPEjb+dBdSPgsEVE1j1bOMPF=0DA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907311434080.21907@tvgsbejvaqbjf.bet>
Date:   Wed, 31 Jul 2019 09:18:52 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907311434080.21907@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 31 Jul 2019 14:36:08 +0200
        (CEST)")
Message-ID: <xmqqlfweqis3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E40ED5BC-B3AE-11E9-B7EF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For the record, I read
> https://public-inbox.org/git/xmqqh8flkgs2.fsf@gitster-ct.c.googlers.com/
> as encouraging a slightly more powerful argument in favor. Junio seemed
> to hope that PCRE2's own `pcre2grep` would behave that way, and that
> would give us plenty reason to just imitate it.
>
> I don't know whether `pcre2grep` behaves that way, even if it does not,
> I think the benefits of the auto fallback to the end user are
> considerable.

Thanks for digging that up ;-)  I do agree with what was said there.

JIT is merely an optimization, and we should be able to work without
it and should not even bother the users with warning messages when
we have to choose non-JIT codepath.  Those who care about debugging
can use a "--debug" option or something to figure out if their build
on a particular pattern is or is not using JIT.

I think I read somebody (Carlo?) made that argument in the thread
earlier, and I agree with that sentiment.
