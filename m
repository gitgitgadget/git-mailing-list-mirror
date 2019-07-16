Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777BD1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfGPTR7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 15:17:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50497 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 15:17:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF2AB8C1FF;
        Tue, 16 Jul 2019 15:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xlO6JacemYCd5ymcj9eokeDCdQw=; b=FM7vSf
        z4rtQ5zkd/qVCwnyaMc03HY0ThYnEdxvKeapTquFMEEZ15vmy73r/kTgbK8GqJRy
        DazN7+o9DrmlplUnvHNtx54tGNRHZ3OLyGmBlGOcVlJPTCuQPNV1NwTM+/pq8/kB
        ax9LBwyPurlpcfsZvzvHMNrMYN+u5prmIfW5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ItiaBLEqR89NcpLVZRbNvNV5nP5cC3EF
        NUYyw4YmGGNiBxcEYonklaYkUSITRp3mlQFetwYB59W6BEdSD6nFQvl8VmlGZW4G
        LpLzl9x/tBZJtmSo3TJhulsTs+vvRe7mmX45W00syH2bFj9xCguA5Gerko7qNo2C
        evnb5lHleYA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B80B08C1FE;
        Tue, 16 Jul 2019 15:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E929F8C1FD;
        Tue, 16 Jul 2019 15:17:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Steven Roberts <fenderq@gmail.com>, git@vger.kernel.org
Subject: Re: git segfault in tag verify (patch included)
References: <CAOGP0GoYviFHhFzhqEimEw+ebd=DJx9JucG4BNvSvPuDudoWxw@mail.gmail.com>
        <xmqqsgr53kov.fsf@gitster-ct.c.googlers.com>
        <20190716185835.GA24468@sigill.intra.peff.net>
Date:   Tue, 16 Jul 2019 12:17:51 -0700
In-Reply-To: <20190716185835.GA24468@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 16 Jul 2019 14:58:35 -0400")
Message-ID: <xmqqk1ch3i1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 692EC2D2-A7FE-11E9-B6AD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Something like:
>
>   for (line = buf; *line; line = next) {
> 	next = strchrnul(line, '\n');
>
> 	... do stuff ...
> 	/* find a space within the line */
> 	space = memchr(line, ' ', next - line);
>   }

I am not sure about the memchr() thing, but "prepare next that is
constant thru the iteration, and update line to it at the end of
each iteration" is a robust pattern to follow.  I like it.

