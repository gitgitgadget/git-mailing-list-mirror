Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140AC32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CB52073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BdgM9ZMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgAGBnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:43:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61699 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAGBnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 20:43:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 019B7A8F66;
        Mon,  6 Jan 2020 20:43:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tOqzwB7zBB7TqscgsOwSi1yUepw=; b=BdgM9Z
        MSUQfkzRpKPr/MNr4hQl5Cro2H2I+b+ayT+ScnxL+DZkRaszZvOgcFYVBPp8mgIy
        lu8L8fvnTYk43/LBH3dEqsNYAJGaN8F15DGMBJGpv7xUmiuni63TRY4d3ho4pq70
        VrCUkD0BYmtgsmwcZOdsSPOhe38vJL48uJKXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TyqPSMUVCxOiaXH31UbTQk4d/fJm9mxp
        DOfDD443XQUN8dhUX6UtaUjpOZCvyzr+JWZU+3dF9FrZfjteHsGZH6Bo4oIOxfmF
        SjO51qIInenousjOMxeidgTOcleiut6gD+QrSxkK392kEjiNBi18HtKaPE4BQTGO
        oa+tJeRaRdg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE655A8F65;
        Mon,  6 Jan 2020 20:43:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E0A6A8F62;
        Mon,  6 Jan 2020 20:43:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] bisect run: allow inverting meaning of exit code
References: <20200103043027.4537-1-stevie@qrpff.net>
        <xmqqftgvdhpz.fsf@gitster-ct.c.googlers.com>
        <CAD_xR9fUxDTvwmAsfH-6=buRP+UmwBHhQJSV+T3paUOy-S1CGw@mail.gmail.com>
        <xmqqy2ul9yg0.fsf@gitster-ct.c.googlers.com>
        <CAD_xR9dGNKdVNzFgFUaZCgJetpW5tXxb8wERovdjbc=1jS-KxA@mail.gmail.com>
Date:   Mon, 06 Jan 2020 17:42:58 -0800
In-Reply-To: <CAD_xR9dGNKdVNzFgFUaZCgJetpW5tXxb8wERovdjbc=1jS-KxA@mail.gmail.com>
        (Stephen Oberholtzer's message of "Mon, 6 Jan 2020 19:10:00 -0500")
Message-ID: <xmqqpnfw6nz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A011F6A-30EF-11EA-9E70-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Oberholtzer <stevie@qrpff.net> writes:

> ... a clean, portable way to create a single case statement that
> handles the final condition.

Hmm, don't we want to say (1) original 0 (success) maps to 1 (2)
original 125 maps to 125 (3) anything below 128 in the original maps
to 0 and (4) everything else is left intact?  Perhaps something as
simple like this, taking advantage of the fact that $? won't have
anything other than digits?

    ... do something ...
    status=$?

    case $status in
    0) status=1 ;;
    125) : as-is ;;
    ? | ?? | 1[01]? | 12[0-7]) status=0;;
    *) : as-is ;;
    esac

I am still unclear where the need for {SUCCESS_FAIL}_TERM magic
comes from, though.
