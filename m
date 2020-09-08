Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB6C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B03A207DE
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O1yH1qUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgIHSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:12:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59170 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbgIHSMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 14:12:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A991E50F0;
        Tue,  8 Sep 2020 14:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KHcwVpoFO3JLxjr2HjSItrhpEiU=; b=O1yH1q
        UvHdQTrI43VJ8zC6trjPhBh/DZEUpedfsFt/xdV8lGdL1LYMjjRfcatROuePeol2
        GAxL04pU4b2yUBGkFHMk0Wfpmas2NUmeTSTaX1nC1wz3f6cgXQbaqCtNaagLcBjX
        tYliBRzEIR2YOtu0ObGtIr7OwYqxeYzArX4sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jjq7w3ZcT9ViKVcmhvMz11wqXnumm4aZ
        OKC3SPWOpLJwWkdCyk06FZuOfQ5LpA6swPsg1hfG9u8fz6fn9GC+Fb7LreHEUFuV
        AmvukUmhz8eZx3mWEjEHlii7if3b/WASdHl8TffNuHdc/SvuXNZLNEAhElQ4WbtV
        51OdODtd/AY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02A4EE50EF;
        Tue,  8 Sep 2020 14:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B1F0E50EE;
        Tue,  8 Sep 2020 14:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Beat Bolli <dev+git@drbeat.li>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pretty: allow to override the built-in formats
References: <20200905192406.74411-1-dev+git@drbeat.li>
        <20200905195218.GA892287@generichostname>
        <xmqqeene36t7.fsf@gitster.c.googlers.com>
        <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
        <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
        <20200908135303.GA2448968@coredump.intra.peff.net>
Date:   Tue, 08 Sep 2020 11:12:11 -0700
In-Reply-To: <20200908135303.GA2448968@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 8 Sep 2020 09:53:03 -0400")
Message-ID: <xmqqzh60xhms.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1B617F6-F1FE-11EA-AF9D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You could accomplish something similar by having gitk look up
> pretty.userReference, and defaulting to something sensible if it's not
> defined. For a big script like gitk that's not too much of an
> imposition. But it's awfully convenient to be able to just say
> --format=reference in any script and get the user's preferred format.

Or --format=userReference in any script, and then allow it to fall
back to pretty.reference that is otherwise ignored?  Ah, that indeed
is what you suggested with --format=loose:reference already.

> So of any of the formats, it seems like the most likely candidate for
> such a feature (setting "pretty.raw" would be a pretty big foot-gun, for
> instance). I don't like the inconsistency it introduces between formats,
> though.

Yes, the inconsistency was what primarily disturbed me.

> Here's a slightly different proposal. I'm not sure if I like it or not,
> but just thinking out loud for a moment. The issue is that we're worried
> the consumer of the output may be surprised by a user-configured pretty
> format. Can we give them a way to say "I don't care about the exact
> output; pick what the user configured for this name, or some sane
> default". I.e., something like:
>
>   git log --format=loose:reference

Yeah, that, or with s/loose/user/ or something.
