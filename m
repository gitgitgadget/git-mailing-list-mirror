Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7A71F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSOuI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:50:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51600 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:50:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF4FB15E4C1;
        Wed, 19 Jun 2019 10:50:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HhlSXIGmriUHoyPvyS/V+sCFkQw=; b=uPHCf7
        SOagTVfvz6jR7UqNaTpuzd+qaspB0I6SnCEoL1f4moszhRm3+szIXSRMqHmUat38
        9Uq59uaayNwEw19mXxiGTY4x2UmeJEEDAKq3JnD+p51qWkRoubsTLt6MRhDfvIZw
        OtubrkEu534f+BWY8tkGXxh4p2gaNKBwSCdhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UsVT67TLlAayF0yEgdzj/UmKVw6hfhM9
        4gcKwk8qbODg2xTXACUGGCLI+prKGg79dTFDVwvH0JsmUJGAGxvTc0twyNW21EDl
        +vu8bh+/vRFfuiIi3pndOyByv+Ja88hYWZ/RfZyBBuYUOSn07vLwrj70Y1WyXg9s
        mmm5pzgs7mQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FEC715E4BF;
        Wed, 19 Jun 2019 10:50:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9660D15E4BC;
        Wed, 19 Jun 2019 10:50:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Boxuan Li <liboxuan@connect.hku.hk>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
        <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
        <20190619034929.GA515@sigill.intra.peff.net>
Date:   Wed, 19 Jun 2019 07:50:00 -0700
In-Reply-To: <20190619034929.GA515@sigill.intra.peff.net> (Jeff King's message
        of "Tue, 18 Jun 2019 23:49:29 -0400")
Message-ID: <xmqqfto5r5nr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 855CBE2C-92A1-11E9-A02F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it _could_ actually just be part of the system /etc/gitconfig,
> though it is kind of big, and Git has a tendency to parse the config
> more than necessary. I wonder if would add a noticeable slowdown.

Yeah, that was what I was wondering too when somebody made a casual
mention of the "why do we want to pile these settings hardcoded in
the code for each and every language?", which I think led to this
patch.  I was actually imagining that this would be totally outside
the normal config mechanism (there is no strong reason to even share
the syntax, but there is no need to come up with a different syntax,
either), treated like other fixed data files (like *.mo files), and
is read lazily only when diff driver needs to be instantiated.

I also agree with you that changing how multiply-defined variables
are handled with the patch is a no-go, if we are going to share the
parser.

Thanks for a patch and a review.

