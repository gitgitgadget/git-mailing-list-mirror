Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E2CC18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E222253D
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Etjbm+mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCJShs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:37:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54664 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJShr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:37:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEDA75AEE3;
        Tue, 10 Mar 2020 14:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6LejrJ8Fg0KZ2LS3pfAWqdyUgCg=; b=Etjbm+
        muPydh3YRtLw83cnCcOURFZoDsVmGR03YRDjCnRBHfs2N2GgrgTipgdv/fyYlfOw
        w4bMNkDJfVQlVrZGhmaqiuBH5OkaeVIAgGErZp+9xyY78HaDwu3o784gauCjrq0x
        VOOXisrlzOi4/6DKcHovJONiACIVCZQT5DIeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PgVbzGGQEScTjeDTcOZQLaFUuZuL1Cth
        nbR7lMQHxjRJ7PeQ0u2ns+1sKSqgv326lQbJZrmBSUo5GwSM1fx/xe0ZuMQof4Uf
        x5s7Dbo/0K+n1s6s0nxox5QQOILN6CjiK3P6kWX1cqucwyhfXKJcXVkijhFjUJy0
        hAfUBYQr9aA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D625AEE2;
        Tue, 10 Mar 2020 14:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A0BA5AEE1;
        Tue, 10 Mar 2020 14:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
        <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet>
        <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003092013090.46@tvgsbejvaqbjf.bet>
        <xmqq36ah1fao.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003101239000.46@tvgsbejvaqbjf.bet>
Date:   Tue, 10 Mar 2020 11:37:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003101239000.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 10 Mar 2020 12:42:03 +0100 (CET)")
Message-ID: <xmqq36agjbt3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BCAC37A-62FE-11EA-B41C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The right sense of relative importance between efficiently running
>> the rest of Git by not bloting the main binary and making sure not
>> to ship Git that does not run unless "git bugreport" runs (which
>> makes sure that "bugreport" runs) is what you are missing, I
>> suspect.
>
> By that reasoning, `git bugreport` should not be included in core Git.

The world does not have to be black-or-white.  "git bugreport" that
covers mainstream platforms in widely-used configurations may be
only an 80% solution, but that is better than nothing at all.

>> Another thing is that you are giving "git bugreport" too much weight
>> and too little credit to inexperienced users, by assuming that we
>> will never hear from them when "bugreport" is incapable to run for
>> them.  They will report, with or without "git bugreport", and the
>> more important thing you seem to be missing is that after the
>> initial contact it would become an interactive process---there is
>> no reason to prioritize to ensure that the initial contact has
>> everything that is needed to diagnose any issue without further
>> interaction.  "With my build, even 'bugreport' dumps core." is
>> perfectly good place to start.
>>
>> Besides, wouldn't the ones on platforms, on which "git bugreport"
>> may have trouble running, i.e. the ones on minority and exotic
>> platforms, tend to be self sufficient and capable (both diagnosing
>> the issue for themselves, and reaching out to us as appropriate)
>> ones in practice (e.g. I have NonStop folks in mind)?
>
> Yes, I can agree that inexperienced users will not give up and keep
> up the conversation until they see their problems fixed.

Inexperienced users won't be on minority platforms for which we do
not have enough resource to get "git bugreport" to run adequetly in
the first place.  Even if those on minority platforms whose userbase
are all technically incapable ones, if they do not help us help
them, what can "git bugreport" can do, and more importantly, how
would it make a difference between "bugreport" being a built-in vs a
standalone?

At this point, I'd have to say that your quibbling does not deserve
a serious response and it would be better use of my time to
disengage from this thread.

