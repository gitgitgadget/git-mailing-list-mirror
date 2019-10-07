Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0531F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 01:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfJGBRH (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 21:17:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60564 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfJGBRH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 21:17:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CF6A8D8C7;
        Sun,  6 Oct 2019 21:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WahWZ78QggzqZ8o1pe3cYqCMOIg=; b=XGbL7k
        TlVyun1lLDe6DK/uQmlLuMbaSzAKyy5qFTCMsI/w5t+l5XW7d+OMxk1k7vq1N/vd
        +pqhvToF0JWjFLbzRYdm0Rd++DJNW7DPlnFVgQhz5H+9u6pgcf6aZA+kR7oNqLZC
        zU9BuFao3PAoSmZ/m6XjfPe2bdbmIhGUdestQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s7lFKeajPmfTnNxjKk+/EjebeSHpaC8H
        CWOFPx81it/vJPAleDBeVP+qjC2vpkogt4QnlekTmkjVoJoDZ5IhaeERpr4vbrw6
        XZDsSP/88RDwh+4eL0GN78k3I7C+HZsPWZH21Lu33yC0q5vPxGdDcnNzfa2RyEXT
        SVqP+bjcrhE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23D728D8C5;
        Sun,  6 Oct 2019 21:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52E0C8D8C4;
        Sun,  6 Oct 2019 21:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/1] fetch: let --jobs=<n> parallelize --multiple, too
References: <pull.369.git.gitgitgadget@gmail.com>
        <pull.369.v2.git.gitgitgadget@gmail.com>
        <93a155a000571df3f3f3a63cd8d886d68fbe8403.1570301198.git.gitgitgadget@gmail.com>
        <xmqqftk67r6j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910061151440.46@tvgsbejvaqbjf.bet>
Date:   Mon, 07 Oct 2019 10:17:00 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910061151440.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 6 Oct 2019 11:53:54 +0200 (CEST)")
Message-ID: <xmqqwodh4ann.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AE4EADC-E8A0-11E9-9792-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
> ...
>> Thanks.  I think it is much better to prepare these tests like this
>> patch does to be broken when phrasing changes---that would give
>> feedback and confidence to the person who is changing the message
>> and/or the logic to emit the message.
>>
>> Where does the constant 128 come from, by the way?  If it is from errno.h
>> then we will soon hear breakage report from NonStop folks, I predict
>> ;-)
>
> It comes from `die()`:
> ...
> 	exit(128);

OK, so hopefully we wouldn't see any platform specific variations.
Good.

Thanks for digging.

