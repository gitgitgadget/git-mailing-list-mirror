Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4EF1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfFMQFZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:05:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62267 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbfFMQFY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:05:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB18B7691A;
        Thu, 13 Jun 2019 12:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Ek2cmtyPpN96MAqJzod+LSN+2w=; b=x1DG/y
        n+jKEptNu9fpSE1/REiVMAydSntkbXDCSAen5n3aezgobYFD/X8JOINfsw+kq1iA
        UZD4conumzAzRVHU0+bQjFDcOWdFHoL+4vv6k1UPS5LExT2FA/+1GbEmfM6X07Tv
        zIsiys3aRlQEnlCqXaWnluqGG/D5vdx4dsFak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M5XVTvXcvnEG0HRqhfdo9w0CFXTSi49z
        RD5Mjwq/vXBmi1bLYRts0U+vG4169bghuSQluXz6h7SypewO6TGXuzRAGpJ5UTk5
        haK1/WKl1uCFJ/D8JN1QewhhVP9BDvCQ69h92hVGOEXEhLODaXyktTqo5DA+bnyR
        I5MzO/cZ2mI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C219D76919;
        Thu, 13 Jun 2019 12:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9F2476917;
        Thu, 13 Jun 2019 12:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     aleksandrs@ledovskis.lv
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
        <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
        <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
        <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
        <20190613093023.GA3919@ariake.ledovskis.lv>
Date:   Thu, 13 Jun 2019 09:05:16 -0700
In-Reply-To: <20190613093023.GA3919@ariake.ledovskis.lv>
        (aleksandrs@ledovskis.lv's message of "Thu, 13 Jun 2019 12:30:23
        +0300")
Message-ID: <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A3249E8-8DF5-11E9-AC26-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

aleksandrs@ledovskis.lv writes:

> My repo indeed contains a ".git/sequencer/todo" file which
> contains references to commits long-gone (i.e., rebased).
> Renaming or deleting this file stops whines about "error: could
> not parse".

Interesting.  So in short, when the repository has leftover
sequencer state file that is not in use, "git status parse" thing
(whatever it is---are you getting it when you run "git status"
command???)---is not careful enough to notice that it does not
matter even if that leftover file is unusable.

Two issues "the sequencer" folks may want to address are

 (1) make the one that reads an irrelevant/stale 'todo' file more
     careful to ignore errors in such a file;

 (2) make the sequencer machinery more careful to clean up after it
     is done or it is aborted  (for example, "git reset --hard"
     could remove these state files preemptively even when a rebase
     is not in progress, I would think).

I think we already had some patches toward the latter recently.

Thanks for a report.
