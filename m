Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45FC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B74920774
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SS4u747K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgJEQrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 12:47:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58522 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgJEQrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 12:47:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F727FC539;
        Mon,  5 Oct 2020 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=15WA9VGfyW5WKoTXi8t+MxoJyGQ=; b=SS4u74
        7KVMa/jqNLEbPbGYUdAH9JJ+WAW3CXG1coTruSGAx6AmgbpnGHTi8hjOJylZApYF
        dXxMukPjXgGAt0+YLKJtpCOJ7hThy09wWctwV3N8ruHRvkaJeseiuMrQGANNGHUs
        RPeujUKtD8coYeZzCmR3F1JgbgU1S6hvUmBb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IT6Thd2RCKG4cv6FeSDohi80PPtv1SGO
        hn8pzM+dOfskOMJIuiAJ0bhBj+mderEa9gEbCADTmrVOa3fserC6wVV+t/3yrrtZ
        wmOqaP9UP6d3tep5jmB8sDgfZz5Bu1lKw00A0X7Ntk6OL371L4z1T/ucMZKpSGVh
        ZpzXFWvpmu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77D28FC538;
        Mon,  5 Oct 2020 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B32D0FC537;
        Mon,  5 Oct 2020 12:47:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ed Maste <emaste@freebsd.org>,
        Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH 0/7] subtree: Fix handling of complex history
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <CAPyFy2BsFLZZeEY=54evEJwed9q+Dc3TX3s1O+cr-nqwjCRHvg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010042124320.50@tvgsbejvaqbjf.bet>
Date:   Mon, 05 Oct 2020 09:47:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010042124320.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 4 Oct 2020 21:27:58 +0200 (CEST)")
Message-ID: <xmqqft6s7h77.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CB99642-072A-11EB-AC79-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 4 Oct 2020, Ed Maste wrote:
>
>> On Mon, 11 May 2020 at 01:50, Tom Clarkson via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> >
>> > Fixes several issues that could occur when running subtree split on large
>> > repos with more complex history.
>>
>> I've been using this patch set locally and would very much like to see it land.
>
> FWIW there have been more comments in favor of this patch in
> https://github.com/gitgitgadget/git/pull/493.
>
> I guess what this patch series needs to proceed further is an ACK by
> Avery?

Not necessarily by Avery, but by somebody who knows the code better
than us ;-).

