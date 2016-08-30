Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD751F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 22:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbcH3WHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 18:07:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57594 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750800AbcH3WHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 18:07:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2F573AA63;
        Tue, 30 Aug 2016 18:07:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jOeKOzCvwu/uz2H2RY+iU5FEd2A=; b=M6X5WW
        +RbZMs2pmEu86YFaWUMeUpG5uI2MPg6jG+m9mBOP+hSZUWrnE19G9hnrPYBQMI4e
        xszO7pvEfKqZhClciVGAPIch0KZ/YBaoLLSy5tLqFNko0Ff3LIPWUZVWvsxzLx/Z
        5F40Q1m+3X+3PeAyDuh9ugOCzdB93wotW1JUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ESYZeEjSbDRnB33QIjIGnaGf/yx8GCuG
        GhDeiA65fL6dueod15Pxe3zK0sPx1t5J8oW72Q3mBjjhVEXhR28wnvHB/k/8raSY
        IZmQ1WT5Gl7FGyiVOqKRr1zhfEfbIaFaVUAAdYDv7/MXRH3T5p80+Use2Nzl0G6J
        M6uIpmKymkE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B0E43AA62;
        Tue, 30 Aug 2016 18:07:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26A953AA60;
        Tue, 30 Aug 2016 18:07:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when reading options
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
        <9797cb9e-115c-bbea-51d2-a5d686aca514@gmail.com>
        <alpine.DEB.2.20.1608301948310.129229@virtualbox>
        <e07303b5-028a-6804-7471-356e0b7293d0@kdbg.org>
Date:   Tue, 30 Aug 2016 15:07:05 -0700
In-Reply-To: <e07303b5-028a-6804-7471-356e0b7293d0@kdbg.org> (Johannes Sixt's
        message of "Tue, 30 Aug 2016 22:46:58 +0200")
Message-ID: <xmqqr3953o8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1738EFD4-6EFE-11E6-BC0E-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 30.08.2016 um 19:52 schrieb Johannes Schindelin:
>> Right, but that is exactly what I wanted to avoid, because it is rather
>> inelegant to strdup() strings just so that we do not have to record what
>> to free() and what not to free().
>
> Please, excuse, but when I have to choose what is more "elegant":
>
>  1. strdup() sometimes so that I can later free() always
>  2. use sequencer_entrust()
>
> I would choose 1. at all times.

Let's not bring elegance or aesthetics in.  It is like asking if
garbage collected systems are elegant.  I do not think it is a valid
question.  GC is a good pragmatic compromise after (1) declaring
that keeping track of allocation is too cumbersome and programmers'
time is better spent elsewhere, and (2) making sure hiccups caused
by GC can be minimized to keep the latency down to acceptable
levels.  There are good compromises and bad ones.

Does the proposed entrust() thing qualify as a good pragmatic
compromise like GC does?

> Particularly in this case: parsing options does not sound like a
> major drain of resources, neither CPU- nor memory-wise.

If entrust() does not have any CPU- or memory-cost, then comparing
it with having to strdup() sometimes might be a useful comparison.

But the entrust() thing has the allocation cost in order to track of
what needs to be done at runtime, and just like strdup() needs to be
done on things that are being borrowed, entrust() needs to be
avoided on things that are being borrowed (and the caller needs to
be sure not to entrust() the same piece of memory twice), so it does
not reduce the cost on programmers' and readers' mental burden--the
programmer always has to know which piece of memory is borrowed and
which are owned by the subsystem.

So...
