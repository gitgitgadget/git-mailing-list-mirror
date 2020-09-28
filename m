Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A90C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1157207E8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mY8eFNKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgI1Szf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:55:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56902 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1Szf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 14:55:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D72D8CE31;
        Mon, 28 Sep 2020 14:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fDr/UBskPssGHwH7eOYSToG43oA=; b=mY8eFN
        KpAoKut0RknmmRRPpF4Gb+sNxThSt1YlW5zznyVPECagiJCR/CZWXKKWk+AOdAhr
        Or1Z5iJPTDX0nolgw29tv1rPvabXbgqqPyFH9NHMUhosv/HczPvom/oTNAh6UUcy
        0pOuNiGONg5NIQbJhmpmkLUlhquYOkHsCFyng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vxC+6+y8FZupfFFZYsRhoIokO8KiMF+5
        ojE7+pbHOQm81IZGvBRZzZ+DhPRdOsqmVlwDtlEX0TlC8HQ8E71hfqHuvI86uXSU
        otttiO3dP5Pn9yjsv6yK9vczEWqMCwlyRKfJLpG/QYTe2+mnfVrJnl/A9TJujFR+
        hakMuh9D328=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21DD08CE30;
        Mon, 28 Sep 2020 14:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53AD68CE2F;
        Mon, 28 Sep 2020 14:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jrnieder@gmail.com
Cc:     Evan Gates <evan.gates@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Doc: note minimum scissors line length for mailinfo
References: <20200925191659.31375-1-evan.gates@gmail.com>
        <20200928183559.GA2285677@google.com>
Date:   Mon, 28 Sep 2020 11:55:29 -0700
In-Reply-To: <20200928183559.GA2285677@google.com> (jrnieder@gmail.com's
        message of "Mon, 28 Sep 2020 11:35:59 -0700")
Message-ID: <xmqq8sctn332.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E1FBBE2-01BC-11EB-B099-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jrnieder@gmail.com writes:

>> +	(dash "-") marks and is at least 8 bytes long ("-- >8 --") is
>
> nit: I think "characters" instead of "bytes" would focus a bit more on
> the intent.  It's true that characters and bytes coincide in this
> example, but using characters might be a bit more in the terms that
> the user is already thinking in.
>
> By the way, is this the right criterion?  Perhaps an alternative
> method would be to make "--8<--" count as a scissors like after all.
> What do you think?

Mildly negative.

It certainly was fun to declare that users can use anything that
look like perforation drawn on paper, and to pile more and more
heuristics to detect such a line.  But I think, instead of
describing all these details in the manual, telling the users to
always write "-- >8 --" and nothing else would be a better approach.

It would save them time.

Let's not waste people's time by encouraging them to be "creative"
in areas that do not make the world a better place.  How flexible
they can be when drawing the line to mark the part that recipent
can discard does not matter in the end result of their work.

Thanks.
