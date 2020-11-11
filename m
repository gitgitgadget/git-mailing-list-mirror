Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF626C55ABD
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77ADC20791
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tHAtDH3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKKQjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:39:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53799 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbgKKQjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:39:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF795E6A69;
        Wed, 11 Nov 2020 11:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RX9HSTp/WOLNnoVyXLuvahN0+6U=; b=tHAtDH
        3FCGaz+hLy5LhcbHqmUdmB9NYMcLppCTm0EdoEP9ozdFa+Xe/PV1de0LrlV9wDC8
        ZmDFuQb9uCn5MrsQMMoCM9QxKhYSYmzgW4EJFBJOB3vvfil2YeZsXpbA4V8V58Ge
        FCp/1kMqT2bHg5Yhh0GRNu8PqbbwLTNhw7z+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DO75tCgvUaIWC0SNAm33/Q0argGjuSuS
        dxHp4U1qeaSELYNIrZ/Yv4413tN9sYrrXHyt1L5arnp0BO7AHZPF7zO3ikknzny4
        bIQeozVGFBNvYnPghUPCPA6rsYqHzAHne1VewcuImklddDiu8b+sqEM9ubEGZ3+Q
        vNVvImgnv2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7EAFE6A68;
        Wed, 11 Nov 2020 11:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01927E6A5E;
        Wed, 11 Nov 2020 11:39:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 06/26] test: completion: add run_func() helper
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
        <20201110212136.870769-7-felipe.contreras@gmail.com>
        <xmqq1rh05p6f.fsf@gitster.c.googlers.com>
        <CAMP44s0XA6QjOZTJaC5CK9Rp9ySfoH9_rJu-AoEGgprstzprfw@mail.gmail.com>
Date:   Wed, 11 Nov 2020 08:39:05 -0800
In-Reply-To: <CAMP44s0XA6QjOZTJaC5CK9Rp9ySfoH9_rJu-AoEGgprstzprfw@mail.gmail.com>
        (Felipe Contreras's message of "Wed, 11 Nov 2020 05:43:24 -0600")
Message-ID: <xmqqsg9f4zme.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A9C5CE0-243C-11EB-95BE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> But even with no other reason for it, the patch stands on its own.
>
>> > +run_func ()
>> > +{
>> > +     local -a COMPREPLY &&
>
> This is the line that was smuggled in. It should be part of a separate
> patch, since this is behavior change.
> ...
> Do you want me to add: "In two places we generate an output that
> didn't exist before, but nothing ever reads it." ?

That would be very friendly to readers who may later wonder why the
change was made, yes.

In any case, I am not a shell-completion person, so even if I said
"yes that would make the patch perfect", that would not count as
much ;-)
