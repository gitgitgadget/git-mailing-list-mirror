Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55A01F667
	for <e@80x24.org>; Wed, 16 Aug 2017 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdHPP6P (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 11:58:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55094 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752113AbdHPP6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 11:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A014A0621;
        Wed, 16 Aug 2017 11:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BOGvnQTzC0lUssywesw5klJUInI=; b=Qqt41y
        cv1iEJD4OrOK7PojRPE3pQzu0RkUdV9k8hqgwdBy8nW6mBV54lxrY60FnNM6+n2X
        f17AdKJsMnJUONm23uLyYukcFklVoM78tkjxnRBOsqWdyY5772f1fraCkBVx0nzb
        VW784jlM3JlRZQR/XgSD7ZzbMv6v0VTOqE6NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sdK3Ev7LgBj9lPPoy1bISlY0XpFst9S1
        MkRjIxVNkwFYuW+esV7fmwNxCCXDRMc0XJHglaoh7DFqXyKYcrA05rLv/eumqHfb
        g7Zfx6E9BIRHZWzWX8JvUdM9MyfXxfs0zws5noX8Rru0IWs8vBZ5JPAS2OOmYyJI
        7cmoY7z8Bq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01FB5A0620;
        Wed, 16 Aug 2017 11:58:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59F45A061F;
        Wed, 16 Aug 2017 11:58:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
        <20170815111725.5d009b66@twelve2.svl.corp.google.com>
        <20170816002257.GG13924@aiede.mtv.corp.google.com>
        <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com>
Date:   Wed, 16 Aug 2017 08:58:12 -0700
In-Reply-To: <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com>
        (Christian Couder's message of "Wed, 16 Aug 2017 14:37:01 +0200")
Message-ID: <xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B57C68FE-829B-11E7-B435-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>>> I am still wondering if protocol errors should be fatal,
>>
>> Yes, please.
>
> Unfortunately I think it would prevent new filters or new
> sub-processes to work with older versions of Git.
>
> For example if filters are upgraded company wide to support the new
> "delay" capability, that would force everyone using the filters to
> upgrade Git.

I must say that your filter is broken in that case, and it is much
more prudent to die than continuing.  Why is that upgraded filter
asking for "delay" to an older Git that does not yet know it in the
first place?

I just re-read the subprocess_handshake() codepath, and here is my
understand.  The handshake_capabilities() function first advertises
the set of capabilities it supports, so that the other side can pick
and choose which ones to use and ask us to enable in its response.

The code under discussion in this thread comes after that, where we
read the response that tells us what choice the other side made.  If
we saw something that we never advertised, that indicates one of two
things.  The other side, i.e. the "upgraded" filter, is not paying
attention of the capabilities advertisement, and asking something
its correct operation relies on, but we are not capable of giving
that unknown feature and operate without it, so after that point the
exchange of data is a garbage-in-garbage-out.  Or the other side
wanted to ask for one of the capabilities we advertised, but the
code has typo and their wish to enable a capability that its correct
operation relies on is not understood on this end.  The result is
the same garbage-in-garbage-out.

So "program X asked capability C, which we cannot handle" is a good
diagnosis to give and it is a good change to spell out the name of
the offending program that needs to be fixed, but at the same time,
I do not think it is safe to continue without the other side knowing
that one of the capabilities they need to correctly operate cannot
be turned on.
