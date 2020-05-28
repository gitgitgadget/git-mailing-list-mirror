Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D297C433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B02F20814
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SmSc/Do8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbgE1OsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:48:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57772 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgE1OsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:48:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5E66D213A;
        Thu, 28 May 2020 10:48:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wNBVZM67a3UKbP+aVrGdWvuQFMA=; b=SmSc/D
        o80AwthZMPrdxTuRf4b+W6mxAZ+sc3JB3AolM7K66a1AwP2cra+R9Ndncb9SCcZP
        RmWdt0pjcGor9IK1IycgxVp5QsQzMxqiacEr3aRRrV4nCX+Yjv1J6RyNtEMLBCHV
        J8kYzMVKdnyjxZln2bjlChKJ7Ha4AD9DdJNec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ujf8/rQroYnE3Zyk9/4oE9NmVfsFZC8M
        8d4qbkM4aASaVsQ2vY2rqUS0hM5TG5ZnR3liwDUEmPNNBrTalxok2OLsXEpFU2i6
        O3iYxaP3JlrWAXcdVZ5P162zhgaTMz8OaRZisgYmdMgtrsZWL/g8ilA8whTCNjOL
        e2+OsBFt1t4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D690D2139;
        Thu, 28 May 2020 10:48:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCF28D2137;
        Thu, 28 May 2020 10:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
        <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
        <20200407014829.GL6369@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
        <20200408000149.GN6369@camp.crustytoothpaste.net>
        <20200527223907.GB65111@google.com>
        <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
Date:   Thu, 28 May 2020 07:48:04 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 27 May 2020 23:52:48 +0200 (CEST)")
Message-ID: <xmqq1rn45d5n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D4D5B68-A0F2-11EA-A034-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It exactly is what "git gc" was meant to be.  To put it differently,
>> if you asked any non-novice end-user if there is one single command
>> that s/he would use to keep a repository healthy, it is very likely
>> that the answer would be "git gc".
>
> The biggest problem with bringing up `git gc` in this context (and it is
> actually a quite big problem) is that "gc" stands for ...

Ah, no, I wasn't saying "the single command has to be called 'gc'".
I do not care too much about the name, as it will be hidden scripted
away.

I was responding to Josh's "We want a single point of entry for all
the housekeeping tasks" with "yes---it is not any controversial new
idea---we have had such a single entry point for housekeeping tasks
in 'gc' for a long time and we are receptive of having such a single
command".
