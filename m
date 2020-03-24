Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2BC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732252076E
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5b1hi+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCXSrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:47:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65484 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgCXSrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 14:47:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CF57CEEDB;
        Tue, 24 Mar 2020 14:47:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LltV6okVYwe+BGmnxsboRInkt1E=; b=L5b1hi
        +eabdaILLJnryM8l38US4i9gqfdy+z2Kl8gbdjMdirun9p9sVLSTmfGf/Vx7z5zY
        JjIsTJVYJSTvWhtiQgmiARuDLxdP3FTQUQi1a6gUiUQ9nHAidRGw8G7scteJ/Jqp
        pSw0e6k607NyBdtLm9ryfzfS5dx+QsNyHz1u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cQRwTfc9c5AO3jYeWQS0VxzziAYYsd1K
        76qLEP84fAhNfBs9X9FbVB0MhacvOVfdutN51SueRbS9EoUlox1ItZZ7KZb5ja1K
        7gMXGWUAyMwSFl2UihJF+JT4aN6NBdP7zX7wNGtLInOAhhBC0AWBpZ41XBf4Pv82
        v/sDTNl4SVI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 01771CEEDA;
        Tue, 24 Mar 2020 14:47:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A033CEED8;
        Tue, 24 Mar 2020 14:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
        <20200323150449.GC11801@danh.dev>
        <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
        <20200324034025.GE11801@danh.dev>
Date:   Tue, 24 Mar 2020 11:47:32 -0700
In-Reply-To: <20200324034025.GE11801@danh.dev> (Danh Doan's message of "Tue,
        24 Mar 2020 10:40:48 +0700")
Message-ID: <xmqqy2rp1tff.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECAEFA2E-6DFF-11EA-B859-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> Hence, if we're going to drop support for system that doesn't
> understand "diff -u", we're going to:
> - remove support for those variables:
>   + GIT_TEST_CMP_USE_COPIED_CONTEXT

Folks who prefer "-c" even their platforms all are capable of "-u"
may miss this, but I think that is a very small minority, and they
would be OK (it is after all only needed when diagnosing test
failures of our test suite, and by definition, those who are working
to improve Git would know how to read "-u" output).

>   + GIT_TEST_CMP

I am not sure why you need to drop this one?  This is more about
switching between "diff" and "cmp", and there are reasons why folks
prefer latter especially when they are not debugging the tests.

> - drop support for:
>   + Solaris 5.{6,7,8,} and AIX 5.3, which will be fine
>   + HP-UX: which needs to be discussed
>
> [1]: https://public.dhe.ibm.com/systems/power/docs/aix/61/aixcmds2_pdf.pdf page 133(143)
