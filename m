Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDD71FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 14:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760392AbdAIOYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 09:24:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932802AbdAIOXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 09:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 375295D0BD;
        Mon,  9 Jan 2017 09:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DE3bmM1RhDiW4XJ9RGc7yEHptAA=; b=vpDCT6
        GtWsAc+pXQNFdCcc3C4iRTm4yAoLv7wo+MV3qOhntc3HiIT+aga93A7mUou5f+0B
        5ZuN0a+PJ2NPKyik6sEKQeI+hea+ykbCyW2sGJ32eVK8vwPZd1hdUWUL7fpTw3hD
        OlmSC+C+u46HUzpGCF1dMiDelKMrQrZJRJJxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Na5kD/9D2sJEynZ4VrS0Kz97zOvElK6V
        5CfV30exz0rjjEaHqHAqm9KsFgziSz1xm2kYuWqehvOqJP9PY1FLZ1xSm1Dhbafi
        Oi+fT+PVie53xgaEzdmngBnkv9/hpdwZLU2kyvPqketBVwoGpMlaAsO0gjAGvD4M
        RDfJ9jmyTZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FCC15D0BC;
        Mon,  9 Jan 2017 09:23:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93B765D0BB;
        Mon,  9 Jan 2017 09:23:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] log --graph: customize the graph lines with config log.graphColors
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
        <20170108101333.26221-1-pclouds@gmail.com>
        <xmqq37gtyluf.fsf@gitster.mtv.corp.google.com>
        <20170109053047.sn75d6ynipgf4nur@sigill.intra.peff.net>
        <CACsJy8AjW1TrLO28mSUSTc6V+_0kuShf7V-=Pkw3Cw9t7ZRfyw@mail.gmail.com>
Date:   Mon, 09 Jan 2017 06:23:15 -0800
In-Reply-To: <CACsJy8AjW1TrLO28mSUSTc6V+_0kuShf7V-=Pkw3Cw9t7ZRfyw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 9 Jan 2017 17:30:23 +0700")
Message-ID: <xmqqfukswbvw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 297294DA-D677-11E6-80BC-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jan 9, 2017 at 12:30 PM, Jeff King <peff@peff.net> wrote:
>> I also wonder if it is worth just using argv_array. We do not care about
>> ...
>> It is not much shorter than ALLOC_GROW(), but IMHO it is easier to read.
>
> Indeed. My only complaint is it's "argv_array_" and not
> "string_array_" but we could think about renaming it later when we see
> another use like this.

Yup, when Peff said "argv-array", it took me a few breaths, until I
realized that argv-array was merely an array of strings, to convince
myself that the data structure can be used here.  If we are going to
use it in more places, we may want to rename it somehow.
