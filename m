Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6AAC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E907206A1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vT+7Vbyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405810AbgE1SaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:30:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53372 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405803AbgE1SaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:30:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B508CD1C8;
        Thu, 28 May 2020 14:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rNLlNinwWcypjfvWoXz0HurPPLc=; b=vT+7Vb
        yqbme7pd+EYN/UMwLXHHN2obJAuorQqWtPDJZEXEis3x7CUGkdZrt2eZ0cLu5oT/
        OZ74UtfeiYcmeYafwccgrVniTMkWpmpV5yRMukywtzMQH9wooa/EA8LDzj9LQt16
        aJMB8ltdfG6lIOhtbRs0TLbX19bAjnpjn8eEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QMx1bss67Q1S2rr9FxQXTdqsOAWdj2Lq
        QjqW5OHlLOeK+3JkqLTqk64S+RSYKm+t9DdyLeM/mpFBym4M8DjKIRXcIVlH5Cn+
        np0VFd3vupG4+OaUQKR9SWRCV+/HYTuOxhZmecJns/r18Op3aZ9XX5OTDopy1KwQ
        /wxei1EFJ7M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93483CD1C7;
        Thu, 28 May 2020 14:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4BD4CD1C3;
        Thu, 28 May 2020 14:30:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
References: <20200525215751.1735-1-philipoakley@iee.email>
        <20200527072318.GA4006199@coredump.intra.peff.net>
        <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
        <20200528164533.GA1223132@coredump.intra.peff.net>
Date:   Thu, 28 May 2020 11:30:16 -0700
In-Reply-To: <20200528164533.GA1223132@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 28 May 2020 12:45:33 -0400")
Message-ID: <xmqq4krz52vb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47C5BEFE-A111-11EA-9239-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 27, 2020 at 11:24:54AM +0100, Philip Oakley wrote:
>
>> > I'm not convinced this is a useful thing to do in general. Lines don't
>> > always stand on their own, and you'd lack context for deciphering them.
>> > So a real example from "git blame -b --since=1.year.ago Makefile", for
>> > example (pardon the long lines):
>> 
>> My contention is that there is a lot of effort needed _beforehand_ to
>> reach that point. We've already had to page down 2700 line to get there,
>> and then had to carefully select the differing before and after context
>> lines.
>
> I think:
>
>   git blame -b --since=1.year.ago ... | less "+/^[^ ]"
>
> works pretty well to get you to the right spot, with context (and then
> "/<enter>" within less takes you to the next line).

Yup.  I think this is mostly about knowing how to use the tools that
already exist.  I am not interested in this new "feature", either.

Thanks.
