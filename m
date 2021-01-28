Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D6CC433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F115464DF5
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhA1UTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:19:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52954 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhA1USu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 15:18:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03318F9C7E;
        Thu, 28 Jan 2021 15:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bVVLh192TiNJqCSsd6TWqX+2DkQ=; b=A83jrN
        uY09xZfAqefoKtRumAPANT+dvPITby9W2/ENyrf4lSvB447l7+z/qfuDGW94o4DD
        7cFGbTTyEafII0Sz0G2LqI9Huyi+Z2VlP4jtbF77dTBV77Rny2SzeMBWKfS2XEf6
        Z/CFE31Q3Ou1VV+Ox57MB2SnjYAANruEGTlXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AigwDqoVTCjTAE2t4tow2vdWf9BACW5d
        Q6p3c825ML0HmBITbVpqTNUgKXesAGjUC9NMvn4hTCB5hTD5w8P/veBXdtDJsHZg
        DPtz7iEnEqas/DmH7qHTtKqHFQ7yym6hYVKeSFyirXjOpi9fnUq187aUFxUNyrXD
        pgzhGtc7Hms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF8E3F9C7C;
        Thu, 28 Jan 2021 15:18:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DA58F9C7A;
        Thu, 28 Jan 2021 15:18:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Vojt=C4=9Bch?= Knyttl <vojtech@knyt.tl>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] rebase -i: do leave commit message intact in fixup!
 chains
References: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
        <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
        <xmqqwnwhzr54.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101281724130.54@tvgsbejvaqbjf.bet>
Date:   Thu, 28 Jan 2021 12:18:04 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101281724130.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 28 Jan 2021 17:24:31 +0100 (CET)")
Message-ID: <xmqq4kj0x1c3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE6F003A-61A5-11EB-98E4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >  #define CLEANUP_MSG (1<<3)
>> >  #define VERIFY_MSG  (1<<4)
>> >  #define CREATE_ROOT_COMMIT (1<<5)
>> > +#define VERBATIM_MSG (1<<6)
>>
>> It somewhat bothers me that these pretend to be orthogonal options
>> that can be mixed and matched, but ...
>
> I did something similar in spirit in the latest iteration.

Looks good.  We do not expect for the BUG() to trigger as long as
programmers are careful, but it is better to be careful.

Another possibility would have been, as VERBATIM is what only we set
programmatically when we do not want any clean-up to happen, make it
override CLEANUP, but what is written in the updated patch is safer,
I would think.

Will queue v3.

Thanks.

