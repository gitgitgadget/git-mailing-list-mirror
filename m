Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459BBC4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCEA235F7
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rrCmeyD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgIXGss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:48:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63657 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIXGsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:48:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 896E8E3FE4;
        Thu, 24 Sep 2020 02:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ndbA0zHuQP6yXoroR3y61kBl8uI=; b=rrCmey
        D3ntckEoKn4m5xpxti7X3B7ioKDTsNXjLUcppOzkiqSGKhHnvaLsZXOyIwDIsMdB
        ym6aQSoOe3bgJqa8N7x30ISqANPCVLQFqwisZk5NhMd9O47pngUXe1Jj4VvfjmTN
        xPgZHf7vpcHj6K0kLrxqHd9IzULbhhsf+RaOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wC9tJ5myz/BGKgBZmtvqwPwgm7trzFNH
        Gxa8bQpN6qkfjJSutUozU20a8zNdTUHhxz22dJqAywF7rgjKhe4Nzn+NfCZFrdS+
        QvJevpT49F+m5W55XVM03FoPp4UEYf6dOdpYIqHbHjWukcfh1LRz06Hd9xnDCrKo
        izioN/yIwy8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82762E3FE3;
        Thu, 24 Sep 2020 02:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD6C9E3FE2;
        Thu, 24 Sep 2020 02:48:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
        <xmqqa6xgi363.fsf@gitster.c.googlers.com>
        <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
Date:   Wed, 23 Sep 2020 23:48:43 -0700
In-Reply-To: <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
        (Christian Couder's message of "Thu, 24 Sep 2020 08:10:31 +0200")
Message-ID: <xmqqsgb7hdpw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD872106-FE31-11EA-8187-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Sep 23, 2020 at 11:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > From f673cea53e046774847be918f4023430e56bf6cb Mon Sep 17 00:00:00 2001
>> > From: Christian Couder <christian.couder@gmail.com>
>> > Date: Wed, 23 Sep 2020 19:09:15 +0200
>> > Subject: [PATCH] bisect: don't use invalid oid as rev when starting
>> > ...
>> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> > index 93e855271b9..d11d4c9bbb5 100644
>> > --- a/builtin/bisect--helper.c
>> > +++ b/builtin/bisect--helper.c
>>
>> Unfortunately this does not apply to the broken commit or 'master'
>> or anywhere else, it seems (no such blob as 93e855271b9 found at the
>> path).
>>
>> It is better to make it applicable at least to 'master'.  Making it
>> also apply to 'maint' is optional, I would say, as the bug it fixes
>> is not so critical.
>
> Sorry, I don't know what happened. It seemed to me that my branch was
> based on master, but maybe I did something wrong.

Oh, you didn't do anything wrong.  What was queued was your patch
which applied cleanly to maint, master and the old version that
brought the breakage into the codebase.  I think I queued it on
maint-2.25 or something sufficiently old, but as I said, a patch
that applies to 'master' would be good enough.

What I had trouble applying to see how it improves upon yours was
the one from Dscho.

Thanks.
