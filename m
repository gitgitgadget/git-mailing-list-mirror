Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CAA1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGaP5Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:57:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50178 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaP5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:57:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF49A16CF2C;
        Wed, 31 Jul 2019 11:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qYHcnygXyycwDq1RphP8G4cT6kA=; b=cRsLfM
        Q+3m4leM0qfhrjoUeewtPQKRWWTeP3QoFp/utOMoBcBC2pbCZvt0qwCxuxLfa0Wx
        a2FUCrpseO0LDaQi9eeZwvO2Zlt4/596qNatoC8hJ+nlWWbRtGxgQruEBZFIxGiC
        jwFsdIpUKeyfcRRfWJuOCGQk1doc+4h2CdRGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TcNvHrIKelce7BBtutilapyqHhFeEn/v
        abHZtjzasEvcKtuQm1e4yoWHTz2OyNYssBPrKXCbARJtjEtDuPD8qCUpnaJAVevn
        QyTROCeJ8cbwSsDjpn7bRkBM41oYdf9EB8ZbYT+ChhBPD2YEi5gEM/YyGPBZDvZw
        0XsAsryn7w4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5F3916CF2B;
        Wed, 31 Jul 2019 11:57:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27D8216CF29;
        Wed, 31 Jul 2019 11:57:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, jackdanielz@eyomi.org,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [GSoC][PATCH] grep: fix worktree case in submodules
References: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
        <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
        <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0bH7ZNWFt3MfkAQf2tkF6CAgFj5FsZyc9zechg7MkCUw@mail.gmail.com>
Date:   Wed, 31 Jul 2019 08:57:20 -0700
In-Reply-To: <CAP8UFD0bH7ZNWFt3MfkAQf2tkF6CAgFj5FsZyc9zechg7MkCUw@mail.gmail.com>
        (Christian Couder's message of "Wed, 31 Jul 2019 00:02:44 +0200")
Message-ID: <xmqqwofyqjrz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E146A02E-B3AB-11E9-8698-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jul 30, 2019 at 10:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
>> > @@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>> >                       free(data);
>> >               } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
>> >                       hit |= grep_submodule(opt, pathspec, &entry.oid,
>> > -                                           base->buf, base->buf + tn_len);
>> > +                                           base->buf, base->buf + tn_len,
>> > +                                           1); /* ignored */
>>
>> The trailing comment is misleading.  In the context of reviewing
>> this patch, we can probably tell it applies only to that "1", but
>> if you read only the postimage, the "ignored" comment looks as if
>> the call itself is somehow ignored by somebody unspecified.  It is
>> not clear at all that it is only about the final parameter.
>>
>> If you must...
>>
>>                 hit |= grep_submodule(opt, pathspec, &entry.oid,
>>                                       base->buf, base->buf + tn_len,
>>                                       1 /* ignored */);
>
> Yeah, I suggested adding an "/* ignored */" comment, but I was indeed
> thinking about something like this.
>
>> ... is a reasonable way to write it.

Thanks.  In this case, I am not sure if the comment here really
helps.  If anything, shouldn't there be a comment near the top of
grep_submodule() that says 'cached bit is meaningful only when you
feed an empty oid, aka "not grepping inside a tree object"'?

