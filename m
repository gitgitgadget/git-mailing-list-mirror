Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A8C433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C087C20674
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dbYOKhwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGMUE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:04:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54372 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMUE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:04:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D3F05D04B;
        Mon, 13 Jul 2020 16:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5kY5TYHqQCv+gFtpJykYopsJMSA=; b=dbYOKh
        wlJHc6dWJIhgh39OtOUu9F+v8pbb7TyOyd9Nu209hI3ufiDnSs0ZL1ZIaWwXmIBX
        FRbFTFo+gK17aUIiDn1ZDESYjDHPpuiClMJIn3cSJdKS57fss+mR7PS0cc6iwlUD
        tUwCc3iMXjDU/FdUi5xefSphnc99i4H54O06Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UkdPdsKkw6Dcf0U01WeaLZz/NSvK+/73
        FjUkKd9RhAucvxYBOdPjQpWouuFra2nQ9ZylMT4vG8Z2J5yEuxOBkd0c7JNdvEdG
        x1OFT3jdcYdj1rjzkB4OgnPLB0HFhI4Gma2diiHT0+go0nHz3Fiq2vRYL0DsWAtE
        hZGpCh9JHPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 856315D04A;
        Mon, 13 Jul 2020 16:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1D075D049;
        Mon, 13 Jul 2020 16:04:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
        <xmqqimetrcay.fsf@gitster.c.googlers.com>
        <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
        <xmqqblkkr63u.fsf@gitster.c.googlers.com>
        <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
        <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
        <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
        <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
        <20200713200049.6a22nek4xckwtpt6@chatter.i7.local>
Date:   Mon, 13 Jul 2020 13:04:54 -0700
In-Reply-To: <20200713200049.6a22nek4xckwtpt6@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Mon, 13 Jul 2020 16:00:49 -0400")
Message-ID: <xmqqtuybmba1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E9A5132-C544-11EA-8F0A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Does it make sense to add logic for whether this is done in a bare repo?  
> I can't imagine common cases where a FETCH_HEAD would be useful outside 
> of a checkout where a merge is likely to happen.

It is entirely valid to respond to a one-shot "My work is published
there; could you see if I am doing anything obviously wrong?" with

    git fetch git://k.org/somebody/linux.git check-me-please
    git log ..FETCH_HEAD
    git diff ...FETCH_HEAD

i.e. without touching any of our refs, and possibly in a bare
repository, no?





