Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C2C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8229A23741
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kMpED8LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgIXQjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:39:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59244 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIXQjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 12:39:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87D13E1184;
        Thu, 24 Sep 2020 12:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wGZA+AMOuGeeWDbFG+MO86SSgIs=; b=kMpED8
        LPI5UY+fs6udk29WPzuRGQPGhICWbEhuoVvil94U+Hb+EiDqhbCQcW6tPUNX+acG
        P0YF7d2hVtj9D+/M89QflZgj3ufnS9JzdnasLPJTlnDQbImWPhl1ZBKRqVbpI+EV
        OjMnkvKZwYPiq8lAW9zu74iWAKjVKs+epc7rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v8hCl/JVikaUFFrEKW9UCmBq92s8Pkn7
        ydpN274JzvN+AQxPYoLGNMBoAIWZYvM7FdOPqeO2aKHRMboczuXVcUUfy/FD/wOi
        NAuerr3SG4HE6olrBncBwcLG3y79qj3TZ55dGNOO7dkJ7ZJLqlE1wqBmwV3iH2w4
        wDKITaES0tc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80513E1182;
        Thu, 24 Sep 2020 12:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAE67E117F;
        Thu, 24 Sep 2020 12:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
        <xmqqa6xgi363.fsf@gitster.c.googlers.com>
        <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2009240950010.5061@tvgsbejvaqbjf.bet>
Date:   Thu, 24 Sep 2020 09:39:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009240950010.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 24 Sep 2020 09:51:17 +0200
        (CEST)")
Message-ID: <xmqqo8lvgmdw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79104A44-FE84-11EA-B7C7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Hopefully the V2 I just sent will be better anyway.
>
> FWIW I was working off of Miriam's `git-bisect-work-part2-v8` branch at
> https://gitlab.com/mirucam/git.git.
>
> I'm happy with Christian's v2 (with or without the indentation fixes I
> suggested).

Thanks, both of you.  The updated one does look good.


