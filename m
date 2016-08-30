Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93CB1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbcH3SZ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:25:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751166AbcH3SZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:25:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DD513AFBD;
        Tue, 30 Aug 2016 14:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6GKrevNDJzix
        b7i4Mqxjb/tdIZc=; b=BmJp4r7QitXg3IRZ33dtKr3VaJd6VhA4UJ0V/2L2lrMU
        zGu9Up/IND/4XOfkJ5P1Gwb1Z+8Z1p8r4RYei5SPhBYsA1KlFqgvdaP3q0oFexqv
        rEIsIQCLIL56UobiJOnHsiU3/NWaVsn8a1obxfRdqrm/7JUU7c9ybeBq7bRiCq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SqIyqv
        yLd3E7hvQoNs1sjShgbBTsMRwETqfjfsFd1j1L9nb/6ygQFvGsiDELBy2eNzdrDl
        qt5ASezwdfEliIZ7tdlcyMCpy4FtM7L2PSOFExQ3a7Ls1NLrUUncbFoRzJJddh/H
        +/qLWMKWoYE44pnkjAsGvOWufCCuI2OD2b71c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6398A3AFBC;
        Tue, 30 Aug 2016 14:25:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E14F43AFBB;
        Tue, 30 Aug 2016 14:25:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of malloc()ed data
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de>
        <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
        <alpine.DEB.2.20.1608300915470.129229@virtualbox>
        <e1cebf74-1592-5ddc-9979-eeffcbf4d788@gmail.com>
Date:   Tue, 30 Aug 2016 11:25:53 -0700
In-Reply-To: <e1cebf74-1592-5ddc-9979-eeffcbf4d788@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 30 Aug 2016 13:08:12
 +0200")
Message-ID: <xmqqk2ey3yha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30F2E692-6EDF-11E6-9955-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> In my personal opinion 'set_me_free_after_use' is not the best name,
> but I unfortunately do not have a better proposal.  Maybe 'entrust_ptr'=
,
> or 'entrusted_data' / 'entrusted_ptr' / 'entrusted'?

Is this to accumulate to-be-freed pointers?

I think we often call a local variable that points at a piece of
memory to be freed "to_free", and that is an appropriate name for
what this function is trying to do.

It is a bit surprising that the careless memory management in this
codepath leaks only the dumb pieces of memory (as opposed to
pointers to structures like string list that needs _clear()
functions, in which case we cannot get away with list of
to-be-freed).  I guess we were somewhat lucky ;-)
